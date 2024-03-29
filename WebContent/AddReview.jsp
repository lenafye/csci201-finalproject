<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Add a Review</title>
	</head>
	<link href="https://fonts.googleapis.com/css?family=Josefin+Sans&display=swap" rel="stylesheet">
	<link href='interact.css' rel='stylesheet'>
	<style type="text/css">
		.rating {
			display: inline-block;
			position: relative;
			height: 50px;
			line-height: 50px;
			font-size: 50px;
		}
		.rating label {
			position: absolute;
			top: 0;
			left: 0;
			height: 100%;
		  	cursor: pointer;
		}
		.rating label:last-child {
			position: static;
		}
		.rating label:nth-child(1) {
		  	z-index: 5;
		}
		.rating label:nth-child(2) {
		  	z-index: 4;
		}
		.rating label:nth-child(3) {
		  	z-index: 3;
		}
		.rating label:nth-child(4) {
		  	z-index: 2;
		}
		.rating label:nth-child(5) {
		  	z-index: 1;
		}
		.rating label input {
			position: absolute;
		  	top: 0;
		  	left: 0;
		  	opacity: 0;
		}
		.rating label .icon {
			float: left;
			color: transparent;
		}
		.rating label:last-child .icon {
			color: gray;
		}
		.rating:not(:hover) label input:checked ~ .icon,
		.rating:hover label:hover input ~ .icon {
		  	color: #ffc700;
		}
		.rating label input:focus:not(:checked) ~ .icon:last-child {
		  	color: #000;
		  	text-shadow: 0 0 5px #09f;
		}
	</style>
	<script>
		function isValid(restaurantId) {
	  		var hasError = false;
	  		document.getElementById("error").innerHTML = "";
		  	var xhttp = new XMLHttpRequest();
		  	xhttp.open("GET", "AddReview?rating="+document.myform.stars.value
		  			+"&text="+document.myform.enterText.value+"&restaurantId="+restaurantId, false);
		  	xhttp.send();
		  	if(xhttp.responseText.trim().length > 0) {
		  		document.getElementById("error").innerHTML = xhttp.responseText;
		  		hasError = true;
		  	}
	  		return !hasError;
	  	}
		function hasUser() {
			document.getElementById("text").style.display = "block";
			document.getElementById("noUserError").innerHTML = "";
			document.getElementById("askLogin").innerHTML = "";
		}
		function noUser() {
			document.getElementById("text").style.display = "none";
			document.getElementById("noUserError").innerHTML = "Error: No user logged in.";
			document.getElementById("askLogin").innerHTML = "Login now?";
		}
	</script>
	<body>
		<%@ page import='lenaye_CSCI201L_TrojanEats.DatabaseJDBC' %>
		<% String username = (String)session.getAttribute("username");
		 if(username != null) {
			if(username.length() > 0) { %>
				<body onload="hasUser();">
			<% }
			else { %>
				<body onload="noUser();">
			<% }
		 }
		 else { %>
			 <body onload="noUser();">
		 <% }
		int restaurantId = Integer.parseInt(request.getParameter("restaurantId")); 
		String restaurantName = DatabaseJDBC.getRestaurant(restaurantId).getName();
		%>
		<div id="logo"><a href="HomePage.jsp"  style = "color: #008000">TrojanEats</a></div>
		<div id="main">
			<div id="noUserError"></div>
			<a href="Login.jsp"><div id="askLogin"></div></a>
			<div id="text">
				<div id="title">
					<h1><%= restaurantName %></h1>
				</div>
				<div id="profile">
					<a href="Profile.jsp"><img src="img/user.png"></a>
				</div>
				<form name="myform" onsubmit="return isValid(<%= restaurantId %>);" action=
				"Profile.jsp" method="GET">
				<div class="rating">
					<label>
				    <input type="radio" name="stars" value="1" />
				    <span class="icon">★</span>
					</label>
					<label>
				    <input type="radio" name="stars" value="2" />
				    <span class="icon">★</span>
				    <span class="icon">★</span>
				  	</label>
				  	<label>
				    <input type="radio" name="stars" value="3" />
				    <span class="icon">★</span>
				    <span class="icon">★</span>
				    <span class="icon">★</span>   
				  	</label>
				  	<label>
				    <input type="radio" name="stars" value="4" />
				    <span class="icon">★</span>
				    <span class="icon">★</span>
				    <span class="icon">★</span>
				    <span class="icon">★</span>
				  	</label>
				  	<label>
				    <input type="radio" name="stars" value="5" />
				    <span class="icon">★</span>
				    <span class="icon">★</span>
				    <span class="icon">★</span>
				    <span class="icon">★</span>
				    <span class="icon">★</span>
				  	</label>
				</div>
				<div id="reviewText">
					<textarea id="enterText" name="enterText" placeholder="Type your review here"></textarea>
				</div>
				<p><div id="error"></div>
				<button id="button" type="submit" style="float: right;">Submit</button>
				</form>
			</div>
		</div>
	</body>
</html>
