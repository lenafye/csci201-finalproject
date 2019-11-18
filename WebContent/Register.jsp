<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>SIGNUP</title>
		<script>
			function validate()
			{
				var un = document.registerForm.username.value;
				var pw = document.registerForm.password.value;
				var pwc = document.registerForm.passwordConfirmation.value;
			
				if(un == "" || pw == "" || pwc == "")
				{
					document.getElementById("error").innerHTML = "Error! Please enter a username and matching passwords.";
					return false;
				}
				if(pw != pwc)
				{
					document.getElementById("error").innerHTML = "Error! Passwords must match."
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
			<script>
				//if(document.cookie == "")
				//{
				//	document.getElementById("profilePic").style.display = "none";
				//}
			</script>
		</div>
		
		<div id = "loginTab">
			<img src = "ASSETS/login.png" alt = "Login" id = "loginTab" onclick = "window.location = 'Login.jsp'">
		</div>
		
		<form name = "registerForm" method = "GET" action = "Register" onsubmit = "return validate();">
			<p id = "un">Username</p>
			<input type = "text" name = "username" class = "usernameInput">
			<br>
			<p id = "pw">Password</p>
			<input type = "password" name = "password" class = "passwordInput">
			<br>
			<p id = "confirm_pw">Confirm Password</p>
			<input type = "password" name = "passwordConfirmation" class = "passwordConfirmationInput">
			<br>
			<input type = "submit" name = "submit" value = "Register" class = "registerButton">
		</form>
		
		<div id = "error"> <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %> </div>

	</body>
</html>
