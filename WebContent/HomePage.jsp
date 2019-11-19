<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HomePage</title>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" type="text/css" href="style.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Josefin+Sans&display=swap" rel="stylesheet">

	<script type="text/javascript">
		function validate(){
			// document.getElementById('error').innerHTML = "";
			// var query = document.getElementById('query').value;
			
			// var xhttp = new XMLHttpRequest();
		 //    xhttp.open("GET", 
		 //    			"hw2servlet?query="+document.getElementById("query").value,
		 //    			false);
		 //    xhttp.send();
			// if (xhttp.responseText.trim().length > 0) {
			// 	sessionStorage.setItem("error", xhttp.responseText);
			// 	location.href = "HomePage.jsp"
			// 	return false;
		 //    }
			
			// var filter_val = $("input[name='filter']:checked").val();
			// location.href = "SearchResults.jsp"
			// sessionStorage.setItem("book", query);
			// sessionStorage.setItem("filter", filter_val);
		}	
		function ifError(){
			var error = sessionStorage.getItem("error")
			document.getElementById("error").innerHTML = error;
			error = "";
			sessionStorage.setItem("error", "");
		}
	</script>
</head>
<body onload="ifError()">
		<nav class="navbar navbar-light bg-light">
		  <a class="navbar-brand" style="font-size:30px;">TrojanEats</a>
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
		
		<div class="myformclass">
			<div class="alert alert-light" role="alert">
				<h1 style="font-weight:normal;text-align:center; padding:30px;">TrojanEats: Find a place to eat near campus!</h1><br>
				
				<div class="input-group mb-3">
			  <input type="text" class="form-control" placeholder="Enter search terms" aria-label="Query" aria-describedby="button-addon2">
				  <div class="input-group-append">
				    <button class="btn btn-outline-secondary" type="button" id="button-addon2">Search</button>
				  </div>
				</div>
				
				<br>
				
				<div class="row">
					  <div class="column">
						  <fieldset class="form-group">
						    <div class="row">
						      <legend class="col-form-label col-sm-2 pt-0"></legend>
						      <div class="col-sm-10">
						        <div class="form-check">
						          <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1">
						          <label class="form-check-label" for="gridRadios1">
						            Price Range
						          </label>
						        </div>
						        <div class="form-check">
						          <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="option2">
						          <label class="form-check-label" for="gridRadios2">
						            Cuisine Type
						          </label>
						        </div>
						        <div class="form-check disabled">
						          <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios3" value="option3">
						          <label class="form-check-label" for="gridRadios3">
						           	Hours Open
						          </label>
						        </div>
						      </div>
						    </div>
						  </fieldset>
					  	</div>
					  <div class="column">
						<div class="custom-control custom-switch">
						  <input type="checkbox" class="custom-control-input" id="customSwitch1">
						  <label class="custom-control-label" for="customSwitch1">Dining Dollars</label>
						</div>
						
						<div class="custom-control custom-switch">
						  <input type="checkbox" class="custom-control-input" id="customSwitch2">
						  <label class="custom-control-label" for="customSwitch2">Dining Swipes</label>
						</div>					  	
				</div>
				
				<div id="error">
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