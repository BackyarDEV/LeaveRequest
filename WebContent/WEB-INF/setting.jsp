<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		
        <title>Welcome</title>
    </head>
    <body>

		<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
		    <a class="navbar-brand" href="portal">Leave Management</a>
		    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		        <span class="navbar-toggler-icon"></span>
		    </button>
			
		    <div class="collapse navbar-collapse" id="navbarSupportedContent">
		        <ul class="navbar-nav ml-auto">
		            <li class="nav-item active">
		                <a class="nav-link" href="portal">Home <span class="sr-only">(current)</span></a>
		            </li>	            
		            <li class="nav-item active">
		                <a class="nav-link" href="setting">Settings </a>
		            </li>	            
		               <li class="nav-item logout-item">
		                <a class="nav-link" href="logout">Logout</a>
		            </li>
		            
		        </ul>
		    </div>
		</nav>
		<div class="container" style="min-width: 300px; max-width: 500px; width: 60%; margin-left: auto; margin-right: auto; margin-bottom: 4%; margin-top: 4%; background:#fff;">
			<div class="row">
				<div class="col-sm-12">
					 <form class="form-horizontal form-pass" method="POST" action="">
					 	<h4>${name}</h4>
			            <label class="control-label"><strong>Update Password:</strong></label>
			            <div class="form-group">
			                <input class="form-control" placeholder="Password" autocomplete="false" required type="password" name="setpass" id="setpass" />
			            </div>
			            <div class="form-group">
			                <div>
			                    <input class="form-control" placeholder="Confirm Password" autocomplete="off" required type="password" id="confpass" name="confpass"/>
			                </div>
			            </div>
			            <div class="form-group">
			                <button type="button" class="btn btn-primary" id="updatepass">Submit</button>
			            </div>
			        </form>
				</div>
			</div>
		</div>
		<script>
			$('.form-pass').submit(function(e){
				e.preventDefault();
				
				var form = $(this);
	      		var url = form.attr('action');
	      		var method = form.attr('method');
	      		console.log("check")
	   			$.ajax({
	       		    type: method,
	       		    url: url,
	       		    data: form.serialize(),
	       		    success: function(s) {
	       		    	console.log(s);
	       		        if(s == 'true'){
	       		        	alert("Password Updated Successfully!");
	       		        } else if (s == "pass_no_match"){}
	   						alert("Passwords do not match!");
	       		    }
	       		});
			});
		</script>
	</body>
</html>