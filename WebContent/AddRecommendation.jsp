<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Send a Recommendation</title>
	</head>
	<link href="https://fonts.googleapis.com/css?family=Josefin+Sans&display=swap" rel="stylesheet">
	<link href='interact.css' rel='stylesheet'>
	<style type="text/css">
		#box {
			font-family: 'Josefin Sans', sans-serif;
			padding-left: 10px;
			font-size: 20px;
			width: 40%;
			border-radius: 10px;
			height: 40px;
			background: transparent;
			background-color: #E9EEE7;
			background-size: cover;
    		border: none;
    		resize: none;
		}
	</style>
	<script>
		function isValid() {
	  		var hasError = false;
	  		document.getElementById("error").innerHTML = "";
		  	var xhttp = new XMLHttpRequest();
		  	xhttp.open("GET", "AddRecommendation?usernames="+document.myform.usernames.value
		  			+"&text="+document.myform.enterText.value, false);
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
		<div id="logo"><a href="HomePage.jsp">TrojanEats</a></div>
		<div id="main">
			<div id="noUserError"></div>
			<a href="Login.jsp"><div id="askLogin"></div></a>
			<div id="text">
				<div id="title">
					<h1>Panda Express</h1>
				</div>
				<div id="profile">
					<a href="Profile.jsp"><img src="img/user.png"></a>
				</div>
				<form name="myform" onsubmit="return isValid();" action="Profile.jsp" method="GET">
				<input type="text" name="usernames" id="box" placeholder="Enter usernames here">
				<div id="reviewText">
					<textarea id="enterText" name="enterText" placeholder="Type your message here"></textarea>
				</div>
				<p><div id="error"></div><br>
				<button id="button" type="submit" style="float: right;">Submit</button>
				</form>
			</div>
		</div>
	</body>
</html>
