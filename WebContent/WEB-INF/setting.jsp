  	<%@ include file="layout.jsp" %>
	<div class="main-div">	  	
		<div class="container" style="min-width: 300px; max-width: 500px; width: 60%; margin-left: auto; margin-right: auto; margin-bottom: 4%; margin-top: 4%; background:#fff;">
			<div class="row">
				<div class="col-sm-12">
					<div class="alert" style="display: none; margin-left: auto; margin-right: auto;" role="alert">
						<span class='alert-msg'></span>
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						    <span aria-hidden="true">&times;</span>
					    </button>	
					</div>
							
					<form class="form-horizontal form-pass" method="POST" action="setting">
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
		                <button type="submit" class="btn btn-primary">Submit</button>
			        </form>
				</div>
			</div>
		</div>
	</div>
		<script>
			// ajax post request
			$('.form-pass').submit(function(e){
				e.preventDefault();
				$('.alert').css('display','none');
				var pass = $('#setpass').val();
				var conf = $('#confpass').val();
				if(pass == conf){
					var form = $(this);
		      		var url = form.attr('action');
		      		var method = form.attr('method');
		      		$.ajax({
		       		    type: method,
		       		    url: url,
		       		    data: form.serialize(),
		       		    success: function(s) {
		       		        if(s == 'true'){
		       		        	$('#setpass').val('');
		       		        	$('#confpass').val('');
		       		        	showAlert("Password Updated Successfully!", 'alert-success');
		       		        } else {
		       		        	showAlert('Password update error!', 'alert-danger');
		       		        }
		       		    }
		       		});	
				} else {
					showAlert('Passwords do not match','alert-warning');
				}
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