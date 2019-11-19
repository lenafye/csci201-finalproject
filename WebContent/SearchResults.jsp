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
			<h1>Results for "<%= request.getParameter("search") %>"</h1>
		</div>
		<div id="main">
			<div class="results">
				<table id="searchResults">
				</table>
			</div>
			<div class="map"></div>
		</div>
		<script>
			function getSearchResults() {
			 	<% String searchTerm = request.getParameter("search"); %>
				<% String searchBy = request.getParameter("searchBy"); %>
				
				var placeholder = "<%= searchTerm %>";
				var searchBy = "<%= searchBy %>";
				var searchTerm = "";
				//assume this is the number of results from Array of results
				var numResults = 0;
				for(var i = 0; i < placeholder.length; i++) {
					if(placeholder.charAt(i) == " ") {
						searchTerm += "+";
					} else {
						searchTerm += placeholder.charAt(i);
					}
				}
				var suff = "https://maps.googleapis.com/maps/api/staticmap?center=University+Of+Southern+California,Los+Angeles,CA&zoom=15&size=350x450&maptype=roadmap";
				for(var i = 0; i < numResults; i++) {
					suff += "&markers=color:red%7Clabel:S%7C" + arraylist[i][3] + "," + arraylist[i][4];
				}
				suff += "&key=AIzaSyAxkitpbRuPGhv0Y4mHpVBfgNXU01wH7kw";
				
				let image = document.createElement("img");
				image.setAttribute("id", "map");
				image.setAttribute("src", suff);
				document.querySelector(".map").appendChild(image);
				
				//Use database search to display restaraunts
				//var arraylist;
				if(numResults == 0) {
					let row = document.createElement("tr");
					document.querySelector("#searchResults").appendChild(row);
					let name = document.createElement("td");
					name.classList.add("restaurant");
					name.innerHTML = "No results found";
					row.appendChild(name);
				} /* else {
					for(var i = 0; i < numResults; i++) {
						let row = document.createElement("tr");
						document.querySelector("#searchResults").appendChild(row);
					
						let numItem = document.createElement("td");
						numItem.classList.add("restaurant");
						let a = document.createElement("a");
						a.setAttribute("href", "Details.jsp?final=" arraylist[i][1] + "&search=" + searchTerm + "&searchBy=" + searchBy);
						a.innerHTML = "<h2>" + i + ")</h2>";
						numItem.appendChild(a);
						row.appendChild(numItem); 
						
						let name = document.createElement("td");
						name.classList.add("restaurant");
						name.innerHTML = "<h3>" + arraylist[i][1] + "</h3><br><br><i>" + arraylist[i][2] + "</i><br>";
						row.appendChild(name);
					}
				} */
			}
		</script>
	</body>
</html>
