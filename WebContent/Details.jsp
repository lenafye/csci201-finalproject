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
				background-color: white;
				border-radius: 15px;
				overflow: hidden;
				margin-top: 50px;
			}
			#resMap {
				width: 500px;
				display: block;
				float: right;
				margin-left: 100px;
				height: 490px;
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
				height: 450px;
				padding: 20px;
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
			.stars {
				margin-top: 10px;
				margin-bottom: 10px;
			}
			.ratingStar {
				height: 20px;
				float: left;
				margin-right: 5px;
			}
			#reviews {
				margin-left: auto;
				margin-right: auto;
				background-color: white;
				border-radius: 15px;
				overflow: hidden;
				margin-top: 50px;
				padding: 20px;
				margin-bottom: 20px;
			}
			.review h3{
				margin-top: 5px;
				margin-bottom: 5px;
			}
			.review {
				width: 600px;
				margin-right: auto;
				margin-left: auto;
				padding: 20px;
				border-radius: 15px;
				background-color: rgb(239, 246, 238);
				margin-top: 20px;
			}
			#addReview{
				height: 5%;
				padding-left: 5px;
				width: 8%;
				background-color: rgb(156,201,186);
				color: white;
				border-radius: 10px;
				display: block;
			}
			.interact {
				float: right;
				padding-right:5px;
			
			}
			.score{
			float:right;
			padding-right: 10px;
		}
		.revText{
		float: left;
		
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
			function Like(reviewId) {
				var xhttp = new XMLHttpRequest();
				console.log(reviewId);
			  
			  	xhttp.open("GET", "LikeDislike?value=like&id=" + reviewId, true);
				xhttp.onreadystatechange = function() {
					
					if(xhttp.readyState == 4) {
						if(xhttp.responseText.trim() == "Must sign in to vote."){
							document.getElementById("error"+reviewId).innerHTML = xhttp.responseText;
						}
						else {
							document.getElementById("score"+reviewId).innerHTML = xhttp.responseText;
						}
					}
				}
				
			  	
			  	xhttp.send();
			  
			}
			function Dislike(reviewId) {
				var xhttp = new XMLHttpRequest();
				xhttp.open("GET", "LikeDislike?value=dislike&id=" + reviewId, true);
				xhttp.onreadystatechange = function() {
					
					if(xhttp.readyState == 4) {
						if(xhttp.responseText.trim() == "Must sign in to vote."){
							document.getElementById("error"+reviewId).innerHTML = xhttp.responseText;
						}
						else {
							document.getElementById("score"+reviewId).innerHTML = xhttp.responseText;
						}
					}
				}
			  	
			  	xhttp.send();
			  
			  	
			  	
			}
		</script>
	</head>
	<body>
		
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
		
		<div id='main'>
		<div id='restaurant'>
		
				<div id='resInfo'>
				<h1>Details</h1>
				
				
					<h2><%=currRes.getName()%></h2>
					<p>Address: <%= currRes.getAddress() %></p>
					<% int cost = currRes.getCost(); %>
					<p>Cost: <%for(int i=0; i<cost; i++) { %>$<%} %> </p>
					<div class='stars'>
						<% double avgRating =currRes.getRating();
						
						for(int i=0; i<5; i++)
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
							<div class='clearfloat'></div>
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
				        
				      }
						
				      </script>
					<script async defer src="https://maps.googleapis.com/maps/api/js?key=&callback=initMap" type="text/javascript"></script>
				
				<div class='clearfloat'></div>
			</div> <!-- #restaurant -->
			<%@ page import='java.util.ArrayList' %>
			<%@ page import='lenaye_CSCI201L_TrojanEats.Review' %>
			<%ArrayList<Review> reviews = DatabaseJDBC.getReviewsForRes(resId, resName); %>
			<div id='reviews'>
			<h1>Reviews</h1>
				<a id='addReview' href='AddReview.jsp?restaurantId=<%=resId%>'>Add Review</a>
				<%for(int i=0; i<reviews.size(); i++) { 
					Review currRev = reviews.get(i);
					%>
					<div class='review'>
						<h3><%=currRev.getUsername()%></h3>
						<div class='stars'>
							<%int rating = currRev.getRating(); 
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
						%>
						</div> <!--  .star -->	
						<div class='clearfloat'></div>
						<div class='revText'><%=currRev.getText() %></div>
						
						<button class='interact' onclick="Like(<%=currRev.getId() %>)" id="like" value="like">▲</button>	
						
						<div class='clearfloat'></div>
						
						<button class='interact' id="dislike" onclick="Dislike(<%=currRev.getId() %>)" value="dislike">▼</button>
						
						<div class='clearfloat'></div>
						<div class='score' id='score<%=currRev.getId()%>'><%=DatabaseJDBC.getScore(currRev.getId()) %></div>
						<div id='error<%=currRev.getId()%>'></div>
				</div> <!-- .review -->
				<%} %>
				
			</div> <!--  #reviews -->
		</div> <!--  #main -->
	</body>
</html>
