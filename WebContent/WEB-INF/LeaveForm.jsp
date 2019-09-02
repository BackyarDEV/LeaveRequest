<jsp:include page="/WEB-INF/layout.jsp"></jsp:include>
		<div class="container leave-container">
			<div class="row">
				<div class="col-sm-12">
					<form class="form leave-form" method="post" action="leave">
						<h3>Leave Request</h3><br>
						<div class="form-group">
							<label for="name">Name of the Employee</label>
							<input class="form-control" id="name" required type="text" name="name" placeholder="Name"/>
						</div>
						<div class="form-row">
							<div class="col-sm-6">
								<div class="form-group">
									<label for="ecode">Ecode</label>
									<input class="form-control" id="ecode" required type="text" name="ecode" placeholder="Ecode"/>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="project">Project</label>
									<input class="form-control" id="project" required type="text" name="project" placeholder="Project"/>
								</div>
							</div>
						</div>
						<div class="form-row">
							<div class="col-sm-6">
								<div class="form-group">
									<label for="tLead">Team Lead</label>
									<input class="form-control" id="tLead" required type="text" name="tLead" placeholder="Team Lead"/>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="manager">Project Manager</label>
									<input class="form-control" id="manager" required type="text" name="manager" placeholder="Project Manager"/>
								</div>
							</div>
						</div>
						<div class="form-row">
							<div class="col-sm-6">
								<div class="form-group">
									<label for="leave-start">Leave Start Date</label>
									<input class="form-control" id="leave-start" required type="date" name="leave-start"/>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="leave-end">Leave End Date</label>
									<input class="form-control" id="leave-end" required type="date" name="leave-end"/>
								</div>
							</div>
						</div>
						<div class="form-row">
							<div class="col-sm-6">
								<div class="form-group">
									<label for="number-days">No. of working days</label>
									<input class="form-control" id="number-days" type="number" name="number-days"/>
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
							<label for="leave-desc">Leave Description</label>
							<input class="form-control" required id="leave-desc" type="text" placeholder="Brief Description" name="leave-desc"/>
						</div>
						<button type="submit" class="btn btn-primary">Submit</button>
					</form>
				</div>
			</div>
		</div>
		
		<script>
			$(".form").submit(function(s){
				s.preventDefault();
				
				var form = $(this);
				var url = form.attr("action");
				var method = form.attr("method");
				
				$.ajax({
					type: method,
					url: url,
					data: form.serialize(),
					success: function(data){
						if (data == "true"){
							alert("form submit successful!");
							window.location.replace(url);
						}
					}
				});
			})
		</script>
	</body>
</html>