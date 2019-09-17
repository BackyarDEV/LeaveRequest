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
    	 		<h4><b>The page you requested doesn't exist.</b></h4>
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
							<input class="form-control"  readonly id="manager" value="<%=obj.getProjectManager()%>""  type="text" name="manager" placeholder="Project Manager" />
						</div>
					</div>
				</div>
				<div class="form-row">
					<div class="col-sm-6">
						<div class="form-group">
							<label for="leave-start">Leave Start Date</label>
							<input class="form-control"  readonly  class="date-format"  id="leave-start"   required type="text"  name="leave-start"  onclick="cal()"  value="<%=obj.getStartDate()%>" autocomplete="off" />
						</div>
					</div>
					<div class="col-sm-6">
						<div class="form-group">
							<label for="leave-end">Leave End Date</label>
							<input class="form-control " readonly  class="date-format"  id="leave-end"    required type="text"  name="leave-end" onchange="cal()"  value="<%=obj.getEndDate()%>" autocomplete="off" />
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
			</form>
		    <% } else{%>
		    	<h4><b>You are not authorised to visit this page.</b></h4>
		    <% }}%>
		    
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
    

	<script src="/LeaveRequest/static/formJs.js"></script>

	</body>
</html>