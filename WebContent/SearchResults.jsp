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
		<style>
			.stars {
					float: left;
					margin-top: 10px;
					margin-bottom: 10px;
			}
			.ratingStar {
				height: 20px;
				float: left;
				margin-right: 5px;
			}
			#resMap {
				width: 500px;
				display: block;
				float: right;
				margin-left: 100px;
				height: 450px;
			}	
			</style>
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
								<option value="cafe">Cafe</option>
								<option value="cafeteria">Cafeteria</option>
								<option value="mexican">Mexican</option>
								<option value="pizza">Pizza</option>
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
		<%@ page import='java.util.ArrayList' %>
		<%@ page import='lenaye_CSCI201L_TrojanEats.Restaurant' %>
		
		<% Integer numResults = (Integer) request.getAttribute("numResults"); %>
		<%ArrayList<Restaurant> r = (ArrayList<Restaurant>) request.getAttribute("restaurantList");%>
		<div id="title"> 
			<h1>Results for "<%= request.getParameter("search") %>"</h1>
		</div>
		<div id="main">
			<div class="results">
			
			<%for(int i=0; i<r.size(); i++) { %>
				<div class='restaurant'>
					<%Restaurant currRes = r.get(i); %>
					<h2><%=i%>. <%=currRes.getName()%></h2>
					<h4><%=currRes.getCuisine() %></h4>
					<% int cost = currRes.getCost(); %>
					<p>Cost: <%for(int i=0; i<cost; i++) { %>$<%} %> </p>
					<div  class='stars'>
						<% double avgRating =currRes.getRating();
						
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
							
							}%>
							</div> <!-- .stars -->
				</div><!-- .restaurant -->
			<%} %>
			<%if(r.size()==0)
				{%>
				<div>Your search yielded no results.</div>
				<%} %>
				<table id="searchResults">
				</table>
			</div>
			<div id="resMap">
			</div>
		</div>
		
		<script>
		var map, infoWindow;
	      function initMap() {
	    	  map = new google.maps.Map(document.getElementById('resMap'), {
		          center: {lat: 34.022288, lng: -118.285344},
		          zoom: 15
		        });
	        infoWindow = new google.maps.InfoWindow;
	        
	     
		        for(var i=0; i<<%=numResults%>; i++)  {
		        	var lat = <%=r.get(i).getLatitude()%>;
		        	var lng = <%=r.get(i).getLongitude()%>;
					var resCoord = new google.maps.LatLng(lat, lng);
					
					var marker = new google.maps.Marker({position: resCoord, map: map, label:i});
					 var infowincontent = document.createElement('div');
			            var strong = document.createElement('strong');
			            strong.textContent = <%r.get(i).getName()%>;
			            infowincontent.appendChild(strong);
			            infowincontent.appendChild(document.createElement('br'));
	
			            var text = document.createElement('text');
			            text.textContent = <%=r.get(i).getAddress()%>;
			            infowincontent.appendChild(text);
			            google.maps.event.addListener(map, 'click', function() {
				       		infoWindow.setContent(infowincontent);
				        	infoWindow.open(map, marker);
				             
				         });
				
				}
			
	        
	      }
	      

		</script>
		<script async defer src="https://maps.googleapis.com/maps/api/js?key=&callback=initMap" type="text/javascript"></script>
		
	</body>
</html>
