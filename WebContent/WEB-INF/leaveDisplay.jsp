<%@page import="com.backyardev.util.LeaveRequestService"%>
<%@page import=" java.util.ArrayList"%>
<%@page import=" java.sql.ResultSet" %>
<%@page import=" com.backyardev.util.LeaveReqObject"%>
<jsp:include page="/WEB-INF/layout.jsp"></jsp:include>
      	<% 
      		String desg = (String)session.getAttribute("desg");
	    	String url = (String)request.getAttribute("javax.servlet.forward.request_uri");
      		String newUrl = url.replace("/LeaveRequest/leave/","");
      		String updatedUrl = newUrl.replace("static/loading.gif", "");
      		LeaveReqObject obj = LeaveRequestService.getLeave(updatedUrl);
      		boolean no_comp = false;
    	 	if(obj.getName() == null){%>
    	 		<h4 class="text-center"><b>The page you requested doesn't exist.</b></h4>
    	 	<% } else {
    	 	boolean check = false;
      		if (desg.equals("TeamLead")){
      			check = (obj.getTeamLead()).equals(session.getAttribute("name"));
      		} else if (desg.equals("Manager")){
      			check = (obj.getProjectManager()).equals(session.getAttribute("name"));
      		} else if (desg.equals("Super_Admin")){
      			check = true;
      		} else if(desg.equals("Admin")){
      			check = true;
      		} else {
      			check = obj.getEcode().equals(session.getAttribute("ecode"));
      		}
         %>
         
         <% if(check) { %>
		<form class="form leave-form" method="post" action="leave">
				<h3>Leave Request</h3><br>
				<div class="form-group">
					<label for="name">Name of the Employee</label>
					<input class="form-control" id="name" required type="text" readonly value="<%=obj.getName()%>"  name="name" placeholder="Name" />
				</div>
				<div class="form-row">
					<div class="col-sm-6">
						<div class="form-group">
							<label for="ecode">Ecode</label>
							<input class="form-control" id="ecode" required type="text"  readonly name="ecode" value="<%=obj.getEcode()%>" placeholder="Ecode"/>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="form-group">
							<label for="project">Project</label>
							<input class="form-control"  readonly id="project" value="<%=obj.getProjectName()%>" type="text" name="project" placeholder="Project" />
						</div>
					</div>
				</div>
				<div class="form-row">
					<div class="col-sm-6">
						<div class="form-group">
							<label for="tLead">Team Lead</label>
							<input class="form-control"  readonly id="tLead"  value="<%=obj.getTeamLead()%>" type="text" name="tLead" placeholder="Team Lead" />
						</div>
					</div>
					<div class="col-sm-6">
						<div class="form-group">
							<label for="manager">Project Manager</label>
							<input class="form-control"  readonly id="manager" value="<%=obj.getProjectManager()%>" type="text" name="manager" placeholder="Project Manager" />
						</div>
					</div>
				</div>
				<div class="form-row">
					<div class="col-sm-6">
						<div class="form-group">
							<label for="leave-start">Leave Start Date</label>
							<input class="form-control"  readonly  class="date-format"  id="leave-start"   required type="text"  name="leave-start"  value="<%=obj.getStartDate()%>" autocomplete="off" />
						</div>
					</div>
					<div class="col-sm-6">
						<div class="form-group">
							<label for="leave-end">Leave End Date</label>
							<input class="form-control " readonly  class="date-format"  id="leave-end"    required type="text"  name="leave-end"  value="<%=obj.getEndDate()%>" autocomplete="off" />
						</div>
					</div>
				</div>
				<div class="form-row">
					<div class="col-sm-6">
						<div class="form-group">
							<label for="number-days">No. of working days</label>
							<input class="form-control"  readonly required id="number-days" type="number" value="<%=obj.getNumberOfDays()%>" name="number-days"/>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="form-group">
							<label for="leave-type">Leave Type</label>
							<input class="form-control"  readonly required id="number-days" type="text" value="<%=obj.getLeaveType()%>" name="Leave Type"/>
						</div>
					</div>
				</div>
				<div>
					
				<label for="day-leave">Half Day/ Full Day</label>
				<input class="form-control"  readonly type="text" value="<%= obj.getDayLeave() %>" name="day-leave"/>
				</div>
				<br>
				<div class="form-group">
					<label for="leave-desc">Leave Description/Reason</label>
					<textarea class="form-control" readonly name="leave-desc"  id="leave-desc"  placeholder="<%=obj.getLeaveDesc() %>" rows="3"></textarea>
				</div>
				<br>
				<% if(obj.getStatus().equals("0") && (desg.equals("TeamLead") || desg.equals("Manager"))){ %>
					<div class="text-center">
						<button class="btn btn-primary mr-3 check" type="button" id="<%out.print(obj.getId());%>" style="width: 100px">Approve</button>
						<button class="btn btn-danger  reject" type="button" id="<%out.print(obj.getId());%>" style="width: 100px">Decline</button>
					</div>
			</form>
		    <% }} else{%>
		    	<h4 class="text-center"><b>You are not authorised to visit this page.</b></h4>
		    <% }}%>
		    <script>
				$('.check').click(function(e){
					var url = "/LeaveRequest/ActionLeaveServlet";
				    var method = "post";
				    var id = $(this).attr("id")
				    console.log(id);

				    $.ajax({
				        type: method,
				        url: url,
				        data: {
				            'id': id,
				            'action': 'approve'
				        },
				        success: function(data) {
				            if (data == "true") {
				                window.location.replace('/LeaveRequest/portal');
				            } else {
				                alert('Error!');
				            }
				        }
				    });
				});
				$('.reject').click(function(){
					var url = "/LeaveRequest/ActionLeaveServlet";
				    var method = "post";
				    var id = $(this).attr("id")
				    console.log(id);

				    $.ajax({
				        type: method,
				        url: url,
				        data: {
				            'id': id,
				            'action': 'reject'
				        },
				        success: function(data) {
				            if (data == "true") {
				                window.location.replace('/LeaveRequest/portal');
				            } else {
				                alert('Error!');
				            }
				        }
				    });
				});
			</script>
	</body>
</html>