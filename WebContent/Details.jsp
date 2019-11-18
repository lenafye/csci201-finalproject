<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import='java.util.ArrayList' %>
<%@ page import='trojaneats.Restaurant' %>
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
<link href='results.css' rel='stylesheet'>
<style>
	#main {
		width: 1200px;
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
	#error {
		color: #F00;
		background-color: #FFF;
		float: left;
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
<div id='header'>
		<div id='h-content'>
			<a href='HomePage.jsp'><h1>TrojanEats</h1></a>
			<form action='Results.jsp' name='resSearch' onsubmit="return validate();" method="GET">
				<input type='text' placeholder='Enter search terms' name='searchPhrase' id='searchbar'>
				<button type='submit' name='submit' id='submit'><img id='search-button-img' src='img/search.png'></button>
				<div id='search-by-container'>
					<div class='searchBy'>
						<label>
							<input type='radio' name='filter' value='Price'>
							Price
						</label>
					</div>
					<div class='searchBy'>
						<label>
							<input type='radio' name='filter' value='Cuisine'>
							Cuisine
						</label>
					</div>
					<div class='searchBy'>
						<label>
							<input type='radio' name='filter' value='Hours'>
							Hours Open
						</label>
					</div>
					<div class='searchBy'>
						<label>
							<input type='radio' name='filter' value='Dollars'>
							Dining Dollars
						</label>
					</div>
					<div class='searchBy'>
						<label>
							<input type='radio' name='filter' value='Swipes'>
							Dining Swipes
						</label>
					</div>
				</div>
			</form>
			<a href='Profile.jsp'><img src='img/user.png' alt='user'></a>
			
		</div> <!--  #h-content -->
		
	</div><!-- #header -->
	
	<div class='clearfloat'></div>
	
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
				<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBV0wV1lmOOC_9OPfNjG0ZZoXeMp1YkE8Q&callback=initMap" type="text/javascript"></script>
			
			
			<div class='clearfloat'></div>
		</div> <!-- #restaurant -->
	
	
	
	</div>
</body>
</html>