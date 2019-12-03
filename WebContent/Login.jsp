<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" type="text/css" href="login.css" />
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="https://fonts.googleapis.com/css?family=Josefin+Sans&display=swap" rel="stylesheet">
		<meta charset="ISO-8859-1">
		<title>Login</title>
		<script>
			function validate()
			{
				var un = document.loginForm.username.value;
				var pw = document.loginForm.password.value;
				if(un == "" || pw == "")
				{
					document.getElementById("error").innerHTML = "Error! Please enter a username and a matching password.";
					return false;
				}
				return true;
			}
		</script>
	</head>
	<body>
		<div id="nav">
			<nav class="navbar navbar-light bg-light">
				<div class="logo"><a href="HomePage.jsp" style = "color: #008000">TrojanEats</a></div>
				<img src = "img/user.png" alt = "profilePic" id = "profilePic" onclick = "window.location = 'Profile.jsp'">
			</nav>
		</div>
		
		<div id = "box">
			<div id = "tabs">
				<div id = "loginTab"> Sign In </div>
				<div id = registerTab><a href="Register.jsp"> Sign Up </a> </div>
				<br>
				<form name = "loginForm" class = "loginForm" method = "GET" action = "Login" onsubmit = "return validate();">
					<br>
					<div id = "unfield"> <p id = "un">Username <input type = "text" name = "username" class = "usernameInput"> </p> <br> </div>
					<div id = "pwfield"> <p id = "pw">Password <input type = "password" name = "password" class = "passwordInput"> </p> <br> </div>
					<div id = "button"> <input type = "submit" name = "submit" value = "Enter" class = "loginButton" style="margin-left: 35%"> </div>
				</form>
			</div>
			
			<div id = "error"> <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %> </div>
		</div>		
		
		
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<!-- <script src="js/main.js"></script> -->
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	</body>
	
</html>
