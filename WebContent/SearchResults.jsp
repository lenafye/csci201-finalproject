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
			}
			function noUser() {
				document.getElementById("profile").style.display = "none";
				alert("getSearchResults");
			}
		</script>
		<style>
		#resMap {
				width: 600px;
				display: block;
				float: left;
				margin-left: 100px;
				height: 63vh;
				border-radius: 25px;
			}
		
		</style>
	</head>
	<body>
		<% String username = (String)session.getAttribute("username");
		if(username != null) {
			if(username.length() >= 0) { %>
				<body onload="hasUser();">
			<% }
			else { %>
				<body onload="noUser();">
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
			<div id="resMap">
			</div>
			<script>
		var map, infoWindow;
	      function initMap() {
	    	  map = new google.maps.Map(document.getElementById('resMap'), {
		          center: {lat: 34.022288, lng: -118.285344},
		          zoom: 15
		        });
	        infoWindow = new google.maps.InfoWindow;
	        
	     	var labels =['1','2','3','4','5','6','7','8,','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'];
		        <%for(int i=0; i<r.size(); i++)  { %>
		        	var lat = <%=r.get(i).getLatitude()%>;
		        	var lng = <%=r.get(i).getLongitude()%>;
		        	console.log(lat);
		        	console.log(lng);
					var resCoord = new google.maps.LatLng(lat, lng);
					
					var marker = new google.maps.Marker({position: resCoord, map: map, label : labels[<%=i%>]});
					attachAddress(marker, "<%=r.get(i).getAddress()%>");
					
				
				<%}%>
			
	        
	      }
	      
	      function attachAddress(marker, address) {
	    	  var infowindow = new google.maps.InfoWindow({
	    		  content: address
	    	  });
	    	  
	    	  marker.addListener('click', function() {
	    		  infowindow.open(marker.get('map'), marker);
	    	  });
	      }
	      
		</script>
		<script  defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC1AgSzWcKOu5Tnm_XTgM6VipMtxS-efsk&callback=initMap" type="text/javascript"></script>
		</div>
		<%@ page import='java.util.ArrayList' %>
		<%@ page import='lenaye_CSCI201L_TrojanEats.Restaurant' %>
	</body>
</html>
