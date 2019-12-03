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
		  		var searchQuery = document.getElementById('box').value;
		  		
		  		var swipes = document.getElementById("swipes").checked;
		  		var dollars = document.getElementById("dollars").checked;
		  		
		  		var c = document.getElementById("cuisine");
		  		if(c != null) {
		  			var cuisine = c.options[c.selectedIndex].value;
		  		}
		  		else {
		  			var cuisine = "";
		  		}
		  		var p = document.getElementById("price");
		  		if(p != null) {
		  			var price = p.options[p.selectedIndex].value;
		  		}
		  		else {
		  			p = "";
		  		}
		  		
		  		sessionStorage.setItem("searchQuery", searchQuery);
		  		sessionStorage.setItem("swipes", swipes);
		  		sessionStorage.setItem("dollars", dollars);
		  		sessionStorage.setItem("cuisine", cuisine);
		  		sessionStorage.setItem("price", price);
		  		
		  		document.getElementById("error").innerHTML = "";
			  	
			  	var xhttp = new XMLHttpRequest();
			  	xhttp.open("POST", "SearchServlet?searchQuery="+searchQuery
		  			+"&swipes="+swipes+"&dollars="+dollars
		  			+"&cuisine="+cuisine+"&price="+price, false);
			  	xhttp.send(); 
	
			  	if(xhttp.responseText.trim().length > 0) {
			  		sessionStorage.setItem("error", xhttp.responseText);
			  		document.getElementById("error").innerHTML = "Please enter restaurant name or search requirements.";
					error = "";
					sessionStorage.setItem("error", "");
					return false;
			  	}
			  	location.href = "SearchResults.jsp"
		  		return true;
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
				<a href="HomePage.jsp" style = "color: #008000">TrojanEats</a>
			</div>
			<div class="links">
				<div class="search">
					<div class="bar">
						<form name="myform" onsubmit="return isValid();" action="SearchResults.jsp" method="GET">
						<input type="search" name="input" id="box" placeholder="Enter search terms">
						<button id="button" type="submit" style="float: right;">Search</button>
						<p>
						<div id="error"></div>
					</div>
					<div class="row">
						<div class="column">
							<input type="checkbox" name="swipes" id="swipes"> Dining Swipes<br>
							<select name="cuisine" id="cuisine">
								<option value="none"></option>
								<option value="american">American</option>
								<option value="asian">Asian</option>
								<option value="mexican">Mexican</option>
								<option value="cafe">Cafe</option>
								<option value="cafeteria">Cafeteria</option>
								<option value="pizza">Pizza</option>
							</select> Cuisine
						</div>
						<div class="column">
							<input type="checkbox" id="dollars" name="dollars"> Dining Dollars <br>
							<select name="price" id="price">
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
							Notification
							<span style="float: right;"><% out.println(notifications.get(i).getTime()); %></span><p>
							Review for <a href="Details.jsp?restaurantId=<%=notifications.get(i).getRestaurantId()%>">
							<% out.println(notifications.get(i).getRestaurant()); %></a> received a 
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
