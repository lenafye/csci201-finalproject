<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import='java.util.ArrayList' %>
<%@ page import='lenaye_CSCI201L_TrojanEats.Restaurant' %>
<% //ArrayList<Restaurant> restaurants = (ArrayList<Restaurant>) session.getAttribute("restaurants"); %>
<% //int resNum = Integer.parseInt(request.getParameter("resNum")); %>
<% //Restaurant currRes  = //restaurants.get(resNum); %>
<% int[][] pandaHours = new int[7][2]; %>
<% pandaHours[0][0]  = 10;
   pandaHours[0][1]  = 8;
   pandaHours[1][0]  = 10;
   pandaHours[1][1]  = 8;
   pandaHours[2][0]  = 10;
   pandaHours[2][1]  = 8;
   pandaHours[3][0]  = 10;
   pandaHours[3][1]  = 8;
   pandaHours[4][0]  = 10;
   pandaHours[4][1]  = 5;
   pandaHours[5][0]  = -1;
   pandaHours[5][1]  = -1;
   pandaHours[6][0]  = -1;
   pandaHours[6][1]  = -1;
%>
<%  Restaurant currRes = new Restaurant(1, "Panda Express", "Chinese", false, true, 2, pandaHours, "3607 Trousdale Parkway Los Angeles, CA 90089", 2.0); %>
<% String resName = currRes.getName(); %>
<title><%=resName%> Details | TrojanEats</title>
<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:100,100i,300,300i,400,400i,600,600i,700,700i&display=swap" rel="stylesheet">
<link href='main.css' rel='stylesheet'>
<link href='header.css' rel='stylesheet'>
<link href='results.css' rel='stylesheet'>
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
	}
	#resMap {
		width: 300px;
		display: block;
		float: left;
		margin-left: 100px;
		
	}
	#hours {
		width: 150px;
		float: left;
		margin-top: 1em;
		margin-left: 10px;
	}
	#resInfo {
		float: left;
		width: 700px;
		margin-bottom: 20px;
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
</head>
<body>
	<div id="header">
		<div class="logo">
			<a href="HomePage.jsp">TrojanEats</a>
		</div>
		<div class="links">
			<div class="search">
				<div class="bar">
					<form name="myform" onsubmit="return isValid();" action="Results.jsp" method="GET">
					<input type="search" name="input" id="box" placeholder="Enter search terms">
					<button id="button" type="button" onclick="validate()" style="float: right;">Search</button>
					<p>
					<!-- <div id="error"></div> -->
				</div>
				<div class="row">
					<div class="column">
						<input type="radio" name="filter" value="Price"> Price Range<br>
						<input type="radio" name="filter" value="Cuisine"> Cuisine Type<br>
						<input type="radio" name="filter" value="Hours"> Hours Open
					</div>
					<div class="column">
						<input type="radio" name="filter" value="Dollars"> Dining Dollars<br>
						<input type="radio" name="filter" value="Swipes"> Dining Swipes
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
	<% String currUser = (String) session.getAttribute("currUser"); %>
	<% if(currUser == null) { currUser = "";} %>
	<h1>Details</h1>
	<div id='restaurant'>
			<div id='resInfo'>
			
			
			
				<h1><%=currRes.getName()%></h1>
				<p>Address: <%= currRes.getAddress() %></p>
				<% int cost = currRes.getCost(); %>
				<p>Cost: <%for(int i=0; i<cost; i++) { %> $ <%} %> </p>
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
				<p style='float: left'>Hours: </p><div id='hours'><%=currRes.hoursToString()%></div>
				<div class='clearfloat'></div>
			</div> <!-- #resInfo -->
			<div id='resMap' > </div> <!-- #resMap -->
				<script>
				// Initialize and add the map
				function initMap() {
				  // The location of Uluru
				  var uluru = {lat: -25.344, lng: 131.036};
				  // The map, centered at Uluru
				  var map = new google.maps.Map(
				      document.getElementById('resMap'), {zoom: 4, center: uluru});
				  // The marker, positioned at Uluru
				  var marker = new google.maps.Marker({position: uluru, map: map});
				}
				</script>
				<script async defer src="https://maps.googleapis.com/maps/api/js?key=<took_out_for_security>&callback=initMap" type="text/javascript"></script>
			
			
			<div class='clearfloat'></div>
		</div> <!-- #restaurant -->
	
	
	
	</div>
</body>
</html>
