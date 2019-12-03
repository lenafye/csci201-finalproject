<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="lenaye_CSCI201L_TrojanEats.Notification"%>
<%@ page import="lenaye_CSCI201L_TrojanEats.DatabaseJDBC"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Notifications</title>
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
			.textContainer {
				height: 55vh;
				overflow: auto;
			}
			.text {
				overflow: auto;
				width: 70%;
				margin: auto;
			}
			body {
				margin: 0;
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
			  	xhttp.open("GET", "SearchRestaurant?searchInput="+document.myform.input.value
			  			+"&swipes="+document.myform.swipes.value+"&dollars="+document.myform.dollars.value
			  			+"&cuisine="+document.myform.cuisine.value+"&price="+document.myform.price.value
			  			+"&hours="+document.myform.hours.value, false);
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
						<form name="myform" onsubmit="return isValid();" action="SearchResults.jsp" method="GET">
						<input type="search" name="input" id="box" placeholder="Enter search terms">
						<button id="button" type="button" onclick="validate()" style="float: right;">Search</button>
						<p>
						<div id="error"></div>
					</div>
					<div class="row">
						<div class="column">
							<input type="checkbox" name="swipes"> Dining Swipes<br>
							<select name="cuisine">
								<option value="none"></option>
								<option value="american">American</option>
								<option value="asian">Asian</option>
								<option value="mexican">Mexican</option>
							</select> Cuisine
							Hours <input type="time" name="hours" id="time" step="900">
						</div>
						<div class="column">
							<input type="checkbox" name="dollars"> Dining Dollars <br>
							<select name="price">
								<option value="none"></option>
								<option value="one">$</option>
								<option value="two">$$</option>
								<option value="three">$$$</option>
							</select> Price
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
					<div class="textContainer">
					<h1><% out.println(username); %>'s Notifications</h1>
					<hr>
					<%ArrayList<Notification> notifications = DatabaseJDBC.getNotifications(username);
						for(int i =0; i < notifications.size(); i++)
						{%>
							<div class="text">
							<% out.println(notifications.get(i).checkRead()); %> 
							<span style="float: right;"><% out.println(notifications.get(i).getTime()); %><p>
							Review for <% out.println(notifications.get(i).getRestaurant()); %> received a 
							<% out.println(notifications.get(i).getUpvote()); %>
							</div>
							<hr>
					<%} %>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
