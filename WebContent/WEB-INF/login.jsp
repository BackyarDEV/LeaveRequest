<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
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
		<title>Login</title>
	</head>
	<body>
      <div class="login-container login" style="min-width: 300px; max-width: 500px; width: 60%; margin-left: auto; margin-right: auto; margin-bottom: 4%; margin-top: 4%; background:#fff;">
         <div class="row row-login">
            <div class='col-md-12 form-col'>
               <form class="form form-login" action="login" method="post" style="border-radius: 0.5rem; box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19); border: solid 1px e0e0e0; padding: 6%;">
                  <h2>Login</h2>
                  <br>
                  <div class="form-group">
                     <label for="mail-login">Email address</label>
                     <input type="email" required class="form-control text-field" id="mail-login" name="email" placeholder="Enter email">
                     <small class="error" id="login-email-error"> Invalid Email!</small>
                     <small class="error" id="null-email-error"> * Required Field!</small>
                  </div>
                  <div class="form-group">
                     <label for="pass-login">Password</label>
                     <input type="password" required class="form-control text-field" id="pass-login" name="password" placeholder="Password">
                     <small class="error" id="login-pass-error"> Wrong Password!</small>
                     <small class="error" id="null-pass-error"> * Required Field!</small>
                     <small class="error" id="user-locked-error"> Account locked! Try 24 hours later.</small>
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
      
      	$('.form-login').submit(function(e){
      		e.preventDefault();
      		$('.error').css('display', 'none');

      		var form = $(this);
      		var url = form.attr('action');
      		var method = form.attr('method');
      		
   			$.ajax({
       		    type: method,
       		    url: url,
       		    data: form.serialize(),
       		    success: function(s) {
       		        "true" == s ? window.location.replace('portal') : "invalid_mail" == s ? ($("#login-email-error").css("display", "block"), $("#mail-login").focus()) : "wrong_pass" == s && ($("#login-pass-error").css("display", "block"), $("#mail-pass").focus())
       		    }
       		});
      	});
      </script>
	</body>
</html>