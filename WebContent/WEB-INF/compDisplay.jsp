<%@page import="com.backyardev.util.LeaveRequestService"%>
<%@page import=" java.util.ArrayList"%>
<%@page import="com.backyardev.util.CompoffReqObject"%>

<jsp:include page="/WEB-INF/layout.jsp"></jsp:include>
	<div style="margin-left: 240px; margin-top: 50px; padding: 40px;" class="main-div">
	  <%
	    String desg = (String)session.getAttribute("desg");
	    String url = (String)request.getAttribute("javax.servlet.forward.request_uri");
	    String updatedUrl = url.replace("/LeaveRequest/comp/","");
	    CompoffReqObject obj = LeaveRequestService.getCompoff(updatedUrl);
	 	
	 	boolean no_comp = false;
	 	if(obj.getName() == null)	{	%>
	 		<h4 class="text-center"><b>The page you requested doesn't exist.</b></h4>
	 	<%	}
	 	else {
	 	boolean check = false;
	 	
  		if (desg.equals("TeamLead")){
  			check = obj.getTeamLead().equals(session.getAttribute("name"));
  		}
  		else if (desg.equals("Manager")){
  			check = obj.getManager().equals(session.getAttribute("name"));
  		} 
  		else if (desg.equals("Super_Admin")){
  			check = true;
  		} 
  		else if(desg.equals("Admin")){
  			check = true;
  		}
  		else {
  			check = obj.getEcode().equals(session.getAttribute("ecode"));
  		}
      %>
       <% if(check) { %>
			<div class="alert" style="display: none; width: 65%; margin-left: auto; margin-right: auto;" role="alert"></div>
			<form class="form leave-form" method="post" action="compoff">
			<h3>Comp-Off Request</h3><br>
			<div class="form-group">
				<label for="name">Name of the Employee</label>
				<input class="form-control" id="name" required type="text" readonly value="<%=obj.getName()%>"   name="name" placeholder="Name"/>
			</div>
			<div class="form-row">
				<div class="col-sm-6">
					<div class="form-group">
						<label for="ecode">Ecode</label>
						<input class="form-control" id="ecode" required type="text" readonly name="ecode" value="<%=obj.getEcode()%>"   placeholder="Ecode"/>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group">
						<label for="project">Project</label>
						<input class="form-control"  id="project" value="<%=obj.getProject()%>"  readonly required type="text" name="project"   placeholder="Project"/>
					</div>
				</div>
			</div>
			<div class="form-row">
				<div class="col-sm-6">
					<div class="form-group">
						<label for="tLead">Team Lead</label>
						<input class="form-control" id="tLead" required value="<%=obj.getTeamLead()%>" readonly  type="text" name="tLead"  placeholder="Team Lead"/>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group">
						<label for="manager">Project Manager</label>
						<input class="form-control" id="manager" required value="<%=obj.getManager()%>"  readonly type="text" name="manager" placeholder="Team Lead"/>
					</div>
				</div>
			</div>
			<div class="form-row">
				<div class="col-sm-6">
					<div class="form-group">
						<label for="ticket">Ticket/SCR</label>
						<input class="form-control" id="ticket" required type="text"  value="<%=obj.getTicket()%>" readonly name="ticket" autocomplete="off"/>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group">
						<label for="comp-date">Date</label>
						<input class="form-control date-format" id="comp-date" required type="text"  value="<%=obj.getCompDate()%>" readonly  name="comp-date" value="yy-mm-dd" autocomplete="off"/>
					</div>
				</div>
			</div>
			<div>
				<div class="form-group">
					<label for="night-shift">Night Shift</label>
					<input class="form-control date-format" id="comp-date" required type="text"  value="<%=obj.getNightShift()%>" readonly  name="comp-date" autocomplete="off"/>
				</div>
			</div>
			<div class="form-group">
				<label for="comp-desc">Description</label>
				<textarea class="form-control" required name="comp-desc"  placeholder="<%=obj.getDesc()%>"  readonly rows="3" autocomplete="off"></textarea>
			</div>
			<br>
		<% if(obj.getStatus().equals("0") && (desg.equals("TeamLead") || desg.equals("Manager"))){ %>
				<div class="text-center">
					<button class="btn btn-primary mr-3 check" type="button" id="<%out.print(obj.getId());%>" style="width: 100px">Approve</button>
					<button class="btn btn-danger reject" type="button" id="<%out.print(obj.getId());%>" style="width: 100px">Decline</button>
				</div>
		</form>
		<% }	} else{	%>
			<h4 class="text-center"><b>You are not authorised to visit this page.</b></h4>
	    <% }	}	%>
		    
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-form-validator/2.3.26/jquery.form-validator.min.js"></script>
		<script>
			$('.check').click(function(e){
				var url = "/LeaveRequest/ActionCompLeaveServlet";
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
			                window.location.replace('/LeaveRequest/comp');
			            } else {
			                alert('Error!');
			            }
			        }
			    });
			});
			$('.reject').click(function(){
				var url = "/LeaveRequest/ActionCompLeaveServlet";
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
			                window.location.replace('/LeaveRequest/comp');
			            } else {
			                alert('Error!');
			            }
			        }
			    });
			});
		</script>
	</body>
</html>
		