<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Profile</title>
		<link href="https://fonts.googleapis.com/css?family=Josefin+Sans&display=swap" rel="stylesheet">
		<link href='header.css' rel='stylesheet'>
		<style type="text/css">
			#main {
				font-family: 'Josefin Sans', sans-serif;
				font-color: gray;
				background-image: url("img/bg.jpeg");
				background-size: cover;
				height: 78vh;
				width: 100%;
				position: relative;
			}
			#container {
				padding-top: 20px;
				background-color: white;
				position: absolute;
  				top: 50%;
  				left: 50%;
  				height: 75%;
  				width: 50%;
  				border-radius: 25px;
  				transform: translate(-50%, -50%);
			}
			#noUserError {
				text-align: center;
			}
			#askLogin {
				text-align: center;
				line-height: 30px;
			}
			.text {
				width: 80%;
				float: right;
			}
			h1{
				text-align: center;
			}
			hr {
				width: 75%;
			}
			img {
    			max-width: 100%;
    			max-height: 100%;
			}
		</style>
		<script>
			function isValid() {
		  		var hasError = false;
		  		document.getElementById("error").innerHTML = "";
			  	var xhttp = new XMLHttpRequest();
			  	xhttp.open("GET", "ValidateSearch?searchInput="+document.myform.searchInput.value
			  			+"&searchOption="+document.myform.searchOption.value, false);
	
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
				document.getElementById("content").style.display = "block";
				document.getElementById("noUserError").innerHTML = "";
				document.getElementById("askLogin").innerHTML = "";
			}
			function noUser() {
				document.getElementById("profile").style.display = "none";
				document.getElementById("content").style.display = "none";
				document.getElementById("noUserError").innerHTML = "Error: No user logged in.";
				document.getElementById("askLogin").innerHTML = "Login now?";
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
				<div id="noUserError"></div>
				<a href="Login.jsp"><div id="askLogin"></div></a>
				<div id="content">
					<h1><% out.println(username); %>'s Reviews</h1>
					<hr><p>
					<div class="text">
					<h2>Panda Express</h2>
					Rating: 5/5 <br>
					Rating text: I liked it. <p>
					</div>
					<hr>
				</div>
			</div>
		</div>
	</body>
</html>
