<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Search Results</title>
		<link href="https://fonts.googleapis.com/css?family=Josefin+Sans&display=swap" rel="stylesheet">
		<link href='header.css' rel='stylesheet'>
		<link href='results.css' rel='stylesheet'>
		<script src="http://code.jquery.com/jquery-3.3.1.min.js" 
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous">
		</script>
		<script>
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
				alert("getSearchResults");
			}
		</script>
	</head>
	<body>
		<% String username = (String)session.getAttribute("username");
		if(username != null) {
			if(username.length() >= 0) { %>
				<body onload="getSearchResults(); hasUser();">
			<% }
			else { %>
				<body onload="getSearchResults(); noUser();">
			<% }
		}
		else { %>
			<body onload="getSearchResults(); noUser();">
		<% } %>
		<%@ page import='lenaye_CSCI201L_TrojanEats.DatabaseJDBC'
		import='lenaye_CSCI201L_TrojanEats.Restaurant'%>
		<% ArrayList<Restaurant> r = (ArrayList<Restaurant>)session.getAttribute("restaurantList"); %>
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
		<div id="title">
			<h1>Results for <%=request.getSession().getAttribute("searchQuery")%></h1>
		</div>
		<div id="main">
			<div class="results">
				<div class="text">
				<hr>
				<% for(int i =0; i < r.size(); i++) {%>
					<div class="textContainer">
					<h2><a href="Details.jsp?restaurantId=<%=r.get(i).getId()%>"><%=r.get(i).getName()%></a></h2>
					Rating: <% double avgRating = r.get(i).getRating(); 
					for(int j=0; j<5; j++)
					{
						if(avgRating >0){
							if(avgRating-1 >= 0)
							{
								%><img class='ratingStar' src='img/star.png'><%
							}
							else if(Math.abs(avgRating-1) > 0 && (Math.abs(avgRating-1)<1))
							{
								%><img class='ratingStar' src='img/halfstar.png'><%	
							}
							else
							{
								%><img class='ratingStar' src='img/emptystar.png'><%	
							}
							avgRating=  avgRating - 1;
						}
						else
						{
							%><img class='ratingStar' src='img/emptystar.png'><%
						}
					
					}%><p>
					Cost: <% for(int j = 0; j < r.get(i).getCost(); j++) { %>
						$
					<% } %>
						<p>
					Cuisine: <%= r.get(i).getCuisine() %><p>
					Takes Dining Dollars: 
					<% if(r.get(i).getDD()) {
						out.println("Yes");
					}
					else {
						out.println("No");
					}
					%><p>
					Takes Swipes: 
					<% if(r.get(i).getSwipes()) {
						out.println("Yes");
					}
					else {
						out.println("No");
					}
					%><p>
					</div>
					<hr>
				<%} %>
				</div>
			</div>
			<div class="map">
			</div>
		</div>
		<%@ page import='java.util.ArrayList' %>
		<%@ page import='lenaye_CSCI201L_TrojanEats.Restaurant' %>
		<script>
		</script>
	</body>
</html>
