<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>View Review</title>
		<link href="https://fonts.googleapis.com/css?family=Josefin+Sans&display=swap" rel="stylesheet">
		<link href='header.css' rel='stylesheet'>
		<link href='view.css' rel='stylesheet'>
		<style type="text/css">
			#like {
				width: 64%;
				float: left;
				font-size: 25px;
				padding-left: 5%;
			}
			#dislike {
				width: 26%;
				float: right;
				font-size: 25px;
				padding-right: 5%;
			}
		</style>
		<script>
			function isValid() {
		  		var hasError = false;
		  		document.getElementById("error").innerHTML = "";
			  	var xhttp = new XMLHttpRequest();
			  	xhttp.open("GET", "SearchRestaurant?searchInput="+document.myform.input.value
			  			+"&searchOption="+document.myform.filter.value, false);
	
			  	xhttp.send();
			  	if(xhttp.responseText.trim().length > 0) {
			  		document.getElementById("error").innerHTML = xhttp.responseText;
			  		hasError = true;
			  	}
			  	if(hasError) {
			  		window.location.href = "HomePage.jsp?error=" + xhttp.responseText;
		  		}
		  		return !hasError;
		  	}
			function hasUser() {
				document.getElementById("profile").style.display = "block";
			}
			function noUser() {
				document.getElementById("profile").style.display = "none";
			}
		</script>
	</head>
	<body>
		<%@ page import='lenaye_CSCI201L_TrojanEats.DatabaseJDBC' %>
		<% String username = (String)session.getAttribute("username");
		if(username != null) {
			if(username.length() >= 0) { %>
				<body onload="hasUser()">
			<% }
			else { %>
				<body onload="noUser()">
			<% }
		}
		else { %>
			<body onload="noUser()">
		<% } %>
		<div id="header">
			<div class="logo">
				<a href="HomePage.jsp">TrojanEats</a>
			</div>
			<div class="links">
				<div class="search">
					<div class="bar">
						<form name="myform" onsubmit="return isValid();" action="Results.jsp" method="GET">
						<input type="search" name="input" id="box" placeholder="Enter search terms">
						<button id="button" type="button" onclick="validate()" style="float: right;">Search</button>
						<p>
						<div id="error"></div>
					</div>
					<div class="row">
						<div class="column">
							<input type="radio" name="filter" value="Price"> Price Range<br>
							<input type="radio" name="filter" value="Cuisine"> Cuisine Type<br>
							<input type="radio" name="filter" value="Hours"> Hours Open
						</div>
						<div class="column">
							<input type="radio" name="filter" value="Dollars"> Dining Dollars<br>
							<input type="radio" name="filter" value="Swipes"> Dining Swipes
							</form>
						</div>
					</div>
				</div>
				<div id="profile">
					<a href="Profile.jsp"><img src="img/user.png" height="100px"></a>
				</div>
			</div>
		
		</div>
		<div id="main">
			<div id="container">
				<div id="text">
					<h1>Panda Express</h1>
					<p align="center">By: User<br>
					Rating: 5/5 <p>
					I love the food! <p>
					<div id="like">
						▲ 5 likes
					</div>
					<div id="dislike">
						▼ 5 dislikes
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
