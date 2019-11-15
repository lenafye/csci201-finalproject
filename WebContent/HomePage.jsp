<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Home Page</title>
		<!-- <link rel="stylesheet" type="text/css" href="style.css" /> -->
	</head>
	<script type="text/javascript">
		function validate(){
			// document.getElementById('error').innerHTML = "";
			// var query = document.getElementById('query').value;
			
			// var xhttp = new XMLHttpRequest();
		 //    xhttp.open("GET", 
		 //    			"hw2servlet?query="+document.getElementById("query").value,
		 //    			false);
		 //    xhttp.send();
			// if (xhttp.responseText.trim().length > 0) {
			// 	sessionStorage.setItem("error", xhttp.responseText);
			// 	location.href = "HomePage.jsp"
			// 	return false;
		 //    }
			
			// var filter_val = $("input[name='filter']:checked").val();
			// location.href = "SearchResults.jsp"
			// sessionStorage.setItem("book", query);
			// sessionStorage.setItem("filter", filter_val);
		}	
		function ifError(){
			var error = sessionStorage.getItem("error")
			document.getElementById("error").innerHTML = error;
			error = "";
			sessionStorage.setItem("error", "");
		}
	</script>
	<body onload="ifError()">
		<div class="header">
			<div class = "row" style="width: 100%; margin-left: 40px;">
				<div class = "column" id="left" style="width: 70%; margin-right: 20px;">
					<img src="images/bookworm.png" alt="TrojanEats" style="width:100px;">
				</div>
				<div class = "column" id="right" style="width: 20%; margin-left: 90px;">
					<% String loggedIn = (String) request.getSession().getAttribute("loggedIn");
					if(loggedIn == null || loggedIn == "false") { %>
						<br /><a href="Login.jsp">Login</a><span>   </span><a href="Register.jsp">Register</a>
					<% } else if (loggedIn.equals("true")){ %>
						<br /><a href="Profile.jsp">Profile</a><span>   </span><a href="logout">Sign Out</a> 
					<% } %>
				</div>
			</div>
		  
		  
		</div>
		<div class="myformclass">
			<h1 style="font-weight:normal">TrojanEats: Find a place to eat near campus!</h1><br>
			<input type="text" id="query" name="query" placeholder="Enter search terms"><br>
			<div class="row">
				  <div class="column">
				  	<input type="radio" name="filter" value="Price"> Price Range<br>
				  	<input type="radio" name="filter" value="Cuisine"> Cuisine Type<br>
					<input type="radio" name="filter" value="Hours"> Hours Open</div>
				  <div class="column">sd
				  	<input type="radio" name="filter" value="Dollars"> Dining Dollars<br>
					<input type="radio" name="filter" value="Swipes"> Dining Swipes</div>
			</div>
			<button id="button" type="button" onclick="validate()" style="float: right;">Search</button>
			<div id="error">
			</div>
		</div>
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<!-- <script src="js/main.js"></script> -->
	</body>
</html>