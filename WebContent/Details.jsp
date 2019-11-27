<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<%@ page import='lenaye_CSCI201L_TrojanEats.DatabaseJDBC' %>
		<%@ page import='lenaye_CSCI201L_TrojanEats.Restaurant' %>
		<% int resId = Integer.parseInt(request.getParameter("restaurantId"));%>
		<% Restaurant currRes  = DatabaseJDBC.getRestaurant(resId); %>
		<% String resName = currRes.getName(); %>
		<title><%=resName%> Details | TrojanEats</title>
		<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:100,100i,300,300i,400,400i,600,600i,700,700i&display=swap" rel="stylesheet">
		<link href='main.css' rel='stylesheet'>
		<link href='header.css' rel='stylesheet'>
		<link href='details.css' rel='stylesheet'>
		<style>
			#main {
				width: 1200px;
				height: 78vh;
				margin-left: auto;
				margin-right: auto;
			}
			#restaurant {
				margin-left: auto;
				margin-right: auto;
				background-color: rgb(239, 246, 238);
				border-radius: 15px;
				overflow: hidden;
			}
			#resMap {
				width: 500px;
				display: block;
				float: right;
				margin-left: 100px;
				height: 440px;
			}
			#hours {
				width: 170px;
				float: left;
				margin-top: 1em;
				margin-left: 10px;
			}
			#resInfo {
				float: left;
				width: 500px;
				padding: 20px;
				height: 400px;
			}
			#favRem{
				float: left;
				margin-top: 15px;
				margin-left: 15px;
				padding: 5px;
				border: 1px solid #BFBFBF;
				border-radius: 3px;
				width: 10%;
				background-color: #A1A1A1;
			}
		</style>
		<script>
			function isValid() {
		  		var hasError = false;
		  		document.getElementById("error").innerHTML = "";
			  	var xhttp = new XMLHttpRequest();
			  	xhttp.open("GET", "SearchRestaurant?searchInput="+document.myform.input.value
			  			+"&swipes="+document.myform.swipes.value+"&dollars="+document.myform.dollars.value
			  			+"&cuisine="+document.myform.cuisine.value+"&price="+document.myform.price.value
			  			+"&hours="+document.myform.hours.value, false);
			  	xhttp.send();
			  	if(xhttp.responseText.trim().length > 0) {
			  		document.getElementById("error").innerHTML = xhttp.responseText;
			  		hasError = true;
			  	}
			  	if(hasError) {
			  		window.location.href = "HomePage.jsp?error=" + xhttp.responseText;
		  		}
		  		return !hasError;
		  	}
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
			}
		</script>
	</head>
	<body>
		<%@ page import='lenaye_CSCI201L_TrojanEats.DatabaseJDBC' %>
		<% String username = (String)session.getAttribute("username");
		if(username != null) {
			if(username.length() >= 0) { %>
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
				<a href="HomePage.jsp">TrojanEats</a>
			</div>
			<div class="links">
				<div class="search">
					<div class="bar">
						<form name="myform" onsubmit="return isValid();" action="SearchResults.jsp" method="GET">
						<input type="search" name="input" id="box" placeholder="Enter search terms">
						<button id="button" type="button" onclick="validate()" style="float: right;">Search</button>
						<p>
						<!-- <div id="error"></div> -->
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
		
		<div id='main'>
		<h1>Details</h1>
		<div id='restaurant'>
				<div id='resInfo'>
				
				
				
					<h1><%=currRes.getName()%></h1>
					<p>Address: <%= currRes.getAddress() %></p>
					<% int cost = currRes.getCost(); %>
					<p>Cost: <%for(int i=0; i<cost; i++) { %>$<%} %> </p>
					<% boolean dollars = currRes.getDD(); 
						String acceptsDD = "No";
						if(dollars)
						{
							acceptsDD = "Yes";
						}
					
					%>
					<p>Accepts Dining Dollars: <%=acceptsDD%></p>
					<% boolean swipes = currRes.getSwipes(); 
						String acceptsSwipes = "No";
						if(swipes)
						{
							acceptsSwipes = "Yes";
						}
					
					%>
					<p>Accepts Swipes: <%=acceptsSwipes%></p>
					<p>Cuisine: <%=currRes.getCuisine()%></p>
					<p style='float: left'>Hours: </p><div id='hours'><%=currRes.getHours()%></div>
					<div class='clearfloat'></div>
				</div> <!-- #resInfo -->
				<div id='resMap' > </div> <!-- #resMap -->
					<script>
					var map, infoWindow;
				      function initMap() {
				        map = new google.maps.Map(document.getElementById('resMap'), {
				          center: {lat: 34.022288, lng: -118.285344},
				          zoom: 15
				        });
				        infoWindow = new google.maps.InfoWindow;
						var resCoord = new google.maps.LatLng(<%=currRes.getLatitude()%>, <%=currRes.getLongitude()%>);
						var marker = new google.maps.Marker({position: resCoord, map: map});
				        // Try HTML5 geolocation.
				        if (navigator.geolocation) {
				          navigator.geolocation.getCurrentPosition(function(position) {
				            var pos = {
				              lat: position.coords.latitude,
				              lng: position.coords.longitude
				            };

				            infoWindow.setPosition(pos);
				            infoWindow.setContent('Location found.');
				            infoWindow.open(map);
				            map.setCenter(pos);
				          }, function() {
				            handleLocationError(true, infoWindow, map.getCenter());
				          });
				        } else {
				          // Browser doesn't support Geolocation
				          handleLocationError(false, infoWindow, map.getCenter());
				        }
				      }

				      function handleLocationError(browserHasGeolocation, infoWindow, pos) {
				        infoWindow.setPosition(pos);
				        infoWindow.setContent(browserHasGeolocation ?
				                              'Error: The Geolocation service failed.' :
				                              'Error: Your browser doesn\'t support geolocation.');
				        infoWindow.open(map);
				      }
						
				      </script>
					<script async defer src="https://maps.googleapis.com/maps/api/js?key=&callback=initMap" type="text/javascript"></script>
				
				<div class='clearfloat'></div>
			</div> <!-- #restaurant -->
		</div> <!--  #main -->
	</body>
</html>
