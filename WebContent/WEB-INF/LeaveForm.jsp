<jsp:include page="/WEB-INF/layout.jsp"></jsp:include>
		
		<form class="form leave-form" method="post" action="leave">
				<h3>Leave Request</h3><br>
				<div class="form-group">
					<label for="name">Name of the Employee</label>
					<input class="form-control" id="name" required type="text" readonly value="${name}" name="name" placeholder="Name"/>
				</div>
				<div class="form-row">
					<div class="col-sm-6">
						<div class="form-group">
							<label for="ecode">Ecode</label>
							<input class="form-control" id="ecode" required type="text" readonly name="ecode" value="${ecode}" placeholder="Ecode"/>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="form-group">
							<label for="project">Project</label>
							<input class="form-control" id="project" value="${project}" required type="text" name="project" placeholder="Project"/>
						</div>
					</div>
				</div>
				<div class="form-row">
					<div class="col-sm-6">
						<div class="form-group">
							<label for="tLead">Team Lead</label>
							<input class="form-control" id="tLead" required value="${lead}" type="text" name="tLead" placeholder="Team Lead"/>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="form-group">
							<label for="manager">Project Manager</label>
							<input class="form-control" id="manager" value="${manager}" required type="text" name="manager" placeholder="Project Manager"/>
						</div>
					</div>
				</div>
				<div class="form-row">
					<div class="col-sm-6">
						<div class="form-group">
							<label for="leave-start">Leave Start Date</label>
							<input class="form-control date1" id="leave-start"   required type="date" name="leave-start"  placeholder="DD/MM/YYYY"  />
						</div>
					</div>
					<div class="col-sm-6">
						<div class="form-group">
							<label for="leave-end">Leave End Date</label>
							<input class="form-control date1" id="leave-end"    required type="date" name="leave-end"  placeholder="DD/MM/YYYY" />
						</div>
					</div>
				</div>
				<div class="form-row">
					<div class="col-sm-6">
						<div class="form-group">
							<label for="number-days">No. of working days</label>
							<input class="form-control" required id="number-days" type="number" name="number-days"/>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="form-group">
							<label for="leave-type">Leave Type</label>
							<select class="form-control" id="leave-type" name="leave-type">
								<option selected value="">-Select an option-</option>
								<option value="Sick Leave">Sick Leave</option>
								<option value="Casual Leave">Casual Leave</option>
								<option value="Earned Leave">Earned Leave</option>
								<option value="Maternity Leave">Maternity Leave</option>
								<option value="On Office Duty">On Office Duty</option>
								<option value="Biometric Miss Out">Biometric Miss Out</option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-radio" style="display: inherit;">
					<input type="radio" name="day-leave" value="full-day" checked> Full Day Leave
					<input type="radio" style="margin-left:10%;" name="day-leave" value="half-day"> Half Day Leave
				</div>
				<br>
				<div class="form-group">
					<label for="leave-desc">Leave Description/Reason</label>
					<input class="form-control" required id="leave-desc" type="text" placeholder="Brief Description" name="leave-desc"/>
				</div>
				<button type="submit" class="btn btn-primary">Submit</button>
			</form>
			<div class="modal fade" id="submitFormModal" tabindex="-1" role="dialog" aria-labelledby="submitFormModalTitle" aria-hidden="true">
			    <div class="modal-dialog modal-dialog-centered" role="document">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h4 class="modal-title" id="ModalTitle">Request Leave?</h4>
			                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			                    <span aria-hidden="true">&times;</span>
		                    </button>
			            </div>
			            <div class="modal-body">
			                <p>Are you sure you want to request for leave?</p><br>
			                <div style="text-align: center; display: none;" id="progress">
			                    <img src="static/loading.gif" alt="loading..">
			                </div>
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
			                <button id="submitFormBtn" value="Add" class="btn btn-primary">Yes</button>
			            </div>
			        </div>
			    </div>
			</div>

		<script>
			$(function(){
				$('#new-req').css('color', '#f1f1f1');
				$('#submitFormModal').modal({ show: false});
			});
			$('.form').submit(function(s){
				s.preventDefault();
				$('#submitFormModal').modal('show');
				console.log('here');
				$('#submitFormBtn').click(function(){
					console.log('clickity click!');
					$('#progress').css('display', 'block');
					var form = $('.form');
					var url = form.attr("action");
					var method = form.attr("method");
					
					$.ajax({
						type: method,
						url: url,
						data: form.serialize(),
						success: function(data){
							if (data == "true"){
								window.location.replace('portal');
							} else if (data == "null") {
								alert('All fields are compulsory!');
							} else if (data == 'mail_not_sent') {
								alert('There was a problem sending a Leave Request Mail!');
							}
						}
					});
				});
			});
		</script>
		<script>
				var startDate
				function setStartDate(){
					var startDate  = $("#leave-start").val() ;
					console.log(startDate);
					
				}

				$(".date1").flatpickr({
				    enableTime: false,
				    dateFormat: "y-m-d",
				    "disable": [
				        function(date) {
				           return (date.getDay() === 0 || date.getDay() === 6);  // disable weekends
				        }
				    ],
				    "locale": {
				        "firstDayOfWeek": 1 // set start day of week to Monday
				    },
				 

				});
				$('#leave-end').flatpickr({
					dateFormat: "y-m-d",
				    "disable": [
				        function(date) {
				           return (date.getDay() === 0 || date.getDay() === 6);  // disable weekends
				        }
				    ]
				   
				});
				
		</script>
	</body>
</html>