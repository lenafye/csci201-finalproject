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
		</script>
	</head>
	<body onload="ifError()">
		<div id="nav">
			<nav class="navbar navbar-light bg-light">
				<div class="logo"><a href="HomePage.jsp">TrojanEats</a></div>
			  	<form class="form-inline">
			  	<% String loggedIn = (String) request.getSession().getAttribute("loggedIn");
			  	if(loggedIn == null || loggedIn == "false") { %>
			    <button class="btn btn-outline-success" type="submit">Register</button>
			    <button class="btn btn-success" type="submit">Login</button>
			    <% } else if (loggedIn.equals("true")){ %>
			    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Profile</button>
			    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Sign Out</button>
			    <% } %>
			  </form>
			</nav>
		</div>
		<div class="myformclass">
			<div class="alert alert-light" role="alert">
				<h1 style="font-weight:normal;text-align:center; padding:30px;">TrojanEats: Find a place to eat near campus!</h1><br>
				<div class="input-group mb-3">
			  		<input type="text" class="form-control" placeholder="Enter search terms" aria-label="Query" aria-describedby="button-addon2">
				  	<div class="input-group-append">
				    	<button class="btn btn-outline-secondary" type="button" id="button-addon2">Search</button>
				  	</div>
				</div><br>
				<div class="row">
					<div class="column">
						<fieldset class="form-group">
							<div class="row">
								<legend class="col-form-label col-sm-2 pt-0"></legend>
							    <div class="col-sm-10">
							    	<div class="form-check">
							        	Price <select name="price">
											<option value="none"></option>
											<option value="one">$</option>
											<option value="two">$$</option>
											<option value="three">$$$</option>
										</select>
							        </div>
							        <div class="form-check">
							        	Cuisine <select name="cuisine">
											<option value="none"></option>
											<option value="american">American</option>
											<option value="asian">Asian</option>
											<option value="mexican">Mexican</option>
										</select>
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
		<!-- <script src="js/main.js"></script> -->
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	</body>
</html>
