<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link rel="stylesheet" href="/LeaveRequest/static/style.css">
		
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <style>
      .error{
        display: none;
        color: red;
      }
    </style>
    <script type="text/javascript">
      var ecode = '${ecode}';
      if (ecode != ''){
        window.location.replace('portal');
      }
    		
    </script>
		<title>Login</title>
	</head>
	<body>

      <div class="login-container login" >
         <div class="row row-login">
            <div class='col-md-12 form-col'>
            	<form class="form form-login" action="login" method="post">
                	<div class="alert" style="display: none; margin-left: auto; margin-right: auto;" role="alert">
                  		<span class="alert-msg"></span>
                  		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				  			<span aria-hidden="true">&times;</span>
			      		</button>
                  	</div>
	             	<h2>Login</h2>
	                <br>
	                <div class="form-group">
	                	<label for="mail-login">Email address</label>
	                    <input type="email" required class="form-control text-field" id="mail-login" name="email" placeholder="Enter email">
	                </div>
	                <div class="form-group">
	                	<label for="pass-login">Password</label>
	                	<input type="password" required class="form-control text-field" id="pass-login" name="password" placeholder="Password">
	                </div>
	                <div class="auth-btn">
						<br><button type="submit" id="btn-login" class="btn btn-primary">Login</button>
	                	<span class="btn span-forgot">Forgot Password?</span>
	                </div>
               </form>
            </div>
         </div>
      </div>
      <script>
      	// ajax post request
      	$('.form-login').submit(function(e){
      		e.preventDefault();
      		$('.alert').css('display', 'none');
			$('#btn-login').attr('disabled', true);
      		var form = $(this);
      		var url = form.attr('action');
      		var method = form.attr('method');
      		
   			$.ajax({
       		    type: method,
       		    url: url,
       		    data: form.serialize(),
       		    success: function(s) {
       		    	$('#btn-login').attr('disabled', false), "true" == s ? window.location.replace('portal') : showAlert('Invalid Credentials!','alert-danger'), $('#mail-login').focus();
       		    }
       		});
      	});
      	
      //alert method
		function showAlert(msg, type){
			$('.alert').addClass(type);
			$('.alert-msg').html(msg);
			$('.alert').css('display', 'block');
			$('html, body').animate({scrollTop: 0});
		}
      </script>
	</body>
</html>