<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>SIGNIN</title>
		<script>
			function validate()
			{
				var un = document.loginForm.username.value;
				var pw = document.loginForm.password.value;
				if(un == "" || pw == "")
				{
					document.getElementById("error").innerHTML = "Error! Please enter a username and matching passwords.";
					return false;
				}
				return true;
			}
		</script>
	</head>
	<body>
		<div id = "header">
			<p id = "headerText"> TrojanEats </p>
			<img src = "ASSETS/profilePic.png" alt = "profilePic" id = "profilePic" onclick = "window.location = 'Profile.jsp'">
		</div>
		
		<div id = "loginTab">
			<img src = "ASSETS/register.png" alt = "Register" id = "registerTab" onclick = "window.location = 'Register.jsp'">
		</div>
		
		<form name = "loginForm" method = "GET" action = "Login" onsubmit = "return validate();">
			<p id = "un">Username</p>
			<input type = "text" name = "username" class = "usernameInput">
			<br>
			<p id = "pw">Password</p>
			<input type = "text" name = "password" class = "passwordInput">
			<br>
			<input type = "submit" name = "submit" value = "Login" class = "registerButton">
		</form>
		
		<div id = "error"> <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %> </div>

	</body>
</html>
