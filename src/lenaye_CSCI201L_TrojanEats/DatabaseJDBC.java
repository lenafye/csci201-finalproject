<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta charset="UTF-8">
		<title>HomePage</title>
		<meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" type="text/css" href="homepage.css" />
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link href="https://fonts.googleapis.com/css?family=Josefin+Sans&display=swap" rel="stylesheet">
		<script type="text/javascript">
			function isValid() {
		  		var hasError = false;
		  		var searchQuery = document.getElementById('searchQuery').value;
		  		
		  		if (searchQuery == "Lemonade") {
		  			var xhttp = new XMLHttpRequest();
				  	xhttp.open("GET", "SearchServlet?searchQuery="+searchQuery, false);
				  	xhttp.send();
				  	location.href = "SearchResults.jsp"
				  	return true;
		  		}
		  		
		  		var swipes = $("#customSwitch2").is(":checked"); 
		  		var dollars = $("#customSwitch1").is(":checked"); 
		  		var cuisine = $("input[name='cuisine']:checked").val();
		  		var price = $("input[name='price']:checked").val();
		  		var hours = null /* $("input[name='time']:checked").val(); */
		  		
		  		console.log(hours);
		  		sessionStorage.setItem("searchQuery", searchQuery);
		  		sessionStorage.setItem("swipes", swipes);
		  		sessionStorage.setItem("dollars", dollars);
		  		sessionStorage.setItem("cuisine", cuisine);
		  		sessionStorage.setItem("price", price);
		  		sessionStorage.setItem("hours", hours);
		  		
		  		document.getElementById("error").innerHTML = "";
			  	
			  	var xhttp = new XMLHttpRequest();
			  	xhttp.open("POST", "SearchServlet?searchQuery="+searchQuery
		  			+"&swipes="+swipes+"&dollars="+dollars
		  			+"&cuisine="+cuisine+"&price="+price
		  			+"&hours="+hours, false);
			  	xhttp.send(); 
			  	location.href = "SearchResults.jsp"
			  	
			  	if(xhttp.responseText.trim().length > 0) {
			  		sessionStorage.setItem("error", xhttp.responseText);
			  		document.getElementById("error").innerHTML = "Please enter restaurant name or search requirements.";
					error = "";
					sessionStorage.setItem("error", "");
					return false;
			  	}
			  	
		  		return true;
		  	}
		</script>
		<script>
		function ifError(){
			var error = sessionStorage.getItem("error")
			document.getElementById("error").innerHTML = error;
			error = "";
			sessionStorage.setItem("error", "");
			
		}
		</script>
	</head>
	<body onload="ifError()"> 
		<div id="nav">
			<nav class="navbar navbar-light bg-light">
				<div class="logo"><a href="HomePage.jsp">TrojanEats</a></div>
			  	<form class="form-inline">
			  	<% String username = (String)session.getAttribute("username");
			  	if(username == null || username.trim().length() == 0) { %>
			  	<a href="Register.jsp" class="btn btn-outline-success" role="button">Register</a>
			  	<a href="Login.jsp" class="btn btn-success" role="button">Login</a>
			    <% } else{ %>
			    <a href="Profile.jsp" class="btn btn-outline-success" role="button">Profile</a>
			  	<a href="Logout" class="btn btn-success" role="button">Sign Out</a>
			    <% } %>
			  </form>
			</nav>
		</div>
		<div class="myform">
			<div class="alert alert-light" role="alert">
				<h1 style="font-weight:normal;text-align:center; padding:30px;">TrojanEats: Find a place to eat near campus!</h1><br>
				<div class="input-group mb-3">
			  		<input type="text" class="form-control" id="searchQuery" placeholder="Enter restaurant name" aria-label="Query" aria-describedby="button-addon2">
				  	<div class="input-group-append">
				  		<a href="#" class="btn btn-outline-secondary" onclick="isValid()" role="button">Search</a>
				    	
				  	</div>
				</div><br>
				<div class="row">
					<div class="column">
						<fieldset class="form-group">
							<div class="row">
								<legend class="col-form-label col-sm-2 pt-0"></legend>
							    <div class="col-sm-10">
							    	
							    	<div class="form-check">
							        	Price <!-- <select name="price"> -->
											<!-- <option name="price" value="none"></option>
											<option name="price" value="one">$</option>
											<option name="price" value="two">$$</option>
											<option name="price" value="three">$$$</option> -->
													<input type="radio" name="price" value="$"> $ 
												  	<input type="radio" name="price" value="$$"> $$ 
													<input type="radio" name="price" value="$$$"> $$$ 
									
										<!-- </select> -->
							        </div>
							        <div class="form-check">
							        	Cuisine <!-- <select name="cuisine"> -->
											<input type="radio" name="cuisine" value="american"> American 
										  	<input type="radio" name="cuisine" value="asian"> Asian 
										  	<input type="radio" name="cuisine" value="cafe">Cafe
										  	<input type="radio" name="cuisine" value="cafeteria">Cafeteria
											<input type="radio" name="cuisine" value="mexican"> Mexican 
											<input type="radio" name="cuisine" value="pizza"> Pizza
											<!-- <option value="none"></option>
											<option value="american">American</option>
											<option value="asian">Asian</option>
											<option value="cafe">Cafe</option>
											<option value="cafeteria">Cafeteria</option>
											<option value="mexican">Mexican</option>
											<option value="pizza">Pizza</option>
										</select>

											<option value="mexican">Mexican</option> -->
										<!-- </select> -->

							        </div>
							        <div class="form-check disabled">
							        	Hours <input type="time" name="hours" id="time" step="900">
							        </div>
								</div>
							</div>
						</fieldset>
					</div>
					<div class="column">
						
						<div class="custom-control custom-switch">
							<input type="checkbox" class="custom-control-input" id="customSwitch1" name="dollars">
						  	<label class="custom-control-label" for="customSwitch1">Dining Dollars</label>
						</div>
						<div class="custom-control custom-switch">
							<input type="checkbox" class="custom-control-input" id="customSwitch2" name="swipes">
						  	<label class="custom-control-label" for="customSwitch2">Dining Swipes</label>
						</div>					  	
					</div>
					<div id="error"></div>
				</div>
			</div>
		</div>
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	</body>
</html>
