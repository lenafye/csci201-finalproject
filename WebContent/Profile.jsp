<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="lenaye_CSCI201L_TrojanEats.*"
    import="java.util.ArrayList" %>
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
			#otherContainer {
				background-color: white;
				height: 8%;
				width: 12%;
				margin-top: 3%;
				margin-left: 2%;
				border-radius: 5px;
				text-align: center;
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
			.ratingStar {
				width: 20px;
			}
			body {
				background-image: url("img/bg.jpeg");
				background-size: cover;
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
				document.getElementById("otherContainer").style.display="block";
			}
			function noUser() {
				document.getElementById("profile").style.display = "none";
				document.getElementById("content").style.display = "none";
				document.getElementById("noUserError").innerHTML = "Error: No user logged in.";
				document.getElementById("askLogin").innerHTML = "Login now?";
				document.getElementById("otherContainer").style.display="none";
			}
		</script>
	</head>
	<body>
		<%@ page import='lenaye_CSCI201L_TrojanEats.DatabaseJDBC'
		import='lenaye_CSCI201L_TrojanEats.Review'%>
		<% String username = (String)session.getAttribute("username");
		if(username != null) {
			if(username.length() > 0) { %>
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
					<h1><% out.println(username); %>'s Reviews</h1>
					<hr><p>
						<%ArrayList<Review> reviews = DatabaseJDBC.getReviewsForUser(username);
						for(int i =0; i < reviews.size(); i++)
						{%>
						<div class="text">
						<h2><a href="Details.jsp?restaurantId=<%=reviews.get(i).getRestaurantId()%>"><%=reviews.get(i).getRestaurantName()%></a></h2>
						Rating: <%int rating = reviews.get(i).getRating(); 
							for(int j=0; j<5; j++)
							{
								if(rating >0){
									if(rating-1 >= 0)
									{
										%><img class='ratingStar' src='img/star.png'><%
									}
									else
									{
										%><img class='ratingStar' src='img/emptystar.png'><%	
									}
									rating--;
								}
								else
								{
									%><img class='ratingStar' src='img/emptystar.png'><%
								}
							
							}
						%><br>
						Rating text: <%=reviews.get(i).getText()%><p>
						</div>
						<hr>
						<%} %>
					</div>
				</div>
			</div>
			<a href="Notifications.jsp">
			<div id="otherContainer"><br>View notifications?
			</div></a>
		</div>
	</body>
</html>
