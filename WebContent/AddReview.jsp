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
		<div id="main">
			<div id="noUserError"></div>
			<div id="askLogin"></div>
			<div id="text">
				<div id="title">
					<h1>Panda Express</h1>
				</div>
				<div id="profile">
					<a href="Profile.jsp"><img src="img/user.png"></a>
				</div>
				<% for(int i = 0; i < 5; i++) { %>
					<img src="img/star.png" height="50px" style="align: left;">
				<% } %>
				<div id="reviewText">
					<textarea id="enterText" placeholder="Type your review here"></textarea>
				</div>
				<p><br><div id="error">Hello</div><br><p>
				<button id="button" type="button" onclick="validate()" style="float: right;">Submit</button>
			</div>
		</div>
	</body>
</html>
