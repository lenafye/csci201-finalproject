<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<style>

* {

	margin: 0;
	padding: 0;
	box-sizing: border-box;

}

body {

	background-image: url("backgroundImg.jpeg");
	background-size: cover;
	
}

.header {

	height: 100px;
	width: 100%;
	margin: 0 auto;
	background-color: white;
	top: 0;
	left: 0;
	right: 0;
	border-bottom: 1px solid lightgray;
	
}

#account {

	position: relative;
	top: 40%;
	right: 5%;
	float: right;
	text-align: center;
	color: gray;

}

 .header h1 a {

	position: relative;
	float: left;
	height: 10%;
	width: 12.5%;
	margin-top: 3%;
	text-decoration: none;
	color: gray;
	text-align: center;

}

.results {

	position: relative;
	margin-left: 5%;
	margin-top: 2%;

}

form {
	
	position: relative;
	top: 25%;
	display: block;
	text-align: center;
	right: 5%;

}

input[type=text] {

	width: 20%;
	border: 1px solid black;
	height: 20px;
	margin-top: 10px;
	margin-bottom: 10px;

}

.form {

	position: relative;
	float: right;
	right: 10%;
	Color: gray;
	width: 40%;
	text-align: left;
	
}

#searchResults {

	position: relative;
	float: left;
	width: 40%;
	color: gray;

}

#searchResults td {

	border-bottom: 1px solid lightgray;
	padding-top: 5px;
	padding-bottom: 5px;
	padding-left: 15px;
	text-align: left;
	
}

#mapResults {

	position: fixed;
	float: right;
	padding: 20% 10%;
	margin-top: 5%;
	right: 5%;
	width: 40%;
	height: 60%;
	border: 1px solid lightgray;
	text-align: center;

}

#map {

	float: right;
	border: 1px solid black;
	margin-top: 0%;
	margin-right: 10%;
	
}

h3 {
	
	color: black;
	
}



</style>


<script 
	src="http://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous">
</script>

<head>
<meta charset="UTF-8">
<title>Results</title>
</head>
<body onload="getSearchResults()">

<section class="header">
	
	<h1> <a href="HomePage.jsp"> Trojan Eats </a> </h1>

	<form name="searchForm" action="SearchServlet" method="GET" >
		<input type="text" name="search" placeholder="Enter Search Terms">
		<table class="form">
			<tr> 
				<td> <input type="radio" name="searchBy" value="name" checked> Name </td>
				<td> <input type="radio" name="searchBy" value="price"> Price Range </td>
			</tr>
			<tr>
				<td> <input type="radio" name="searchBy" value="hours"> Hours Open </td>
				<td> <input type="radio" name="searchBy" value="cuisine"> Cuisine Type </td>
			</tr>
			<tr>
				<td> <input type="radio" name="searchBy" value="diningDollars"> Dining Dollars Accepted </td>
				<td> <input type="radio" name="searchBy" value="swipes"> Swipes Accepted </td>
			</tr>
		</table>
	
		<input type="submit" name="submit" value="Search">

	</form>
	
	<div id="account">
		<% if(request.getParameter("login") == "true" || request.getAttribute("loggedIn") == "true") { %>
			<a style="text-decoration: none; color: gray; float: right;" href="Profile.jsp">Profile</a>
		<% } %>
	</div>
		
</section>

<section class="results">

<h2>Results for "<%= request.getParameter("search") %>"</h2> <br> <br>

<table id="searchResults">

</table>




</section>


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
		document.querySelector(".results").appendChild(image);
		
		
		
		
		
		
		
		//Use database search to display restaraunts
		
		//var arraylist;
		
		
		
		
		
		if(numResults == 0) {
			
			let row = document.createElement("tr");
			document.querySelector("#searchResults").appendChild(row);
			let name = document.createElement("td");
			name.classList.add("restaurant");
			name.innerHTML = "<h3>No Results Found</h3><br>";
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