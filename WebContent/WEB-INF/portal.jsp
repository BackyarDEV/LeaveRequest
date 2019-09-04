<%@page import="com.backyardev.util.TableClass"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import=" java.util.ArrayList"%>
<%@page import=" com.backyardev.util.LeaveReqObject"%>
<jsp:include page="/WEB-INF/layout.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <table class="table">
      <thead>
         <tr>
            <th scope="col">Ecode</th>
            <th scope="col">Name</th>
            <th scope="col">Project</th>
            <th scope="col">TL</th>
            <th scope="col">Manager</th>
            <th scope="col">Start Date</th>
            <th scope="col">End Date</th>
            <th scope="col">Total Days </th>
            <th scope="col">Type </th>
            <th scope="col">Desc </th>
           	<%  if(session.getAttribute("desg").equals("Developer")){  %>
            <th scope="col">Status </th>
   			 <% } else { %>
   			  <th scope="col">Action </th>
		      <% } %>
         </tr>
      </thead>
      <tbody>
         <% 
            TableClass tc = new TableClass();
         	String ecode = (String) session.getAttribute("ecode");
         	String desg = (String) session.getAttribute("desg");
         	String name = (String) session.getAttribute("name");
            ArrayList<LeaveReqObject> resultSet = tc.getTable(ecode,desg,name);
            %>
         <% for(int i = 0; i < resultSet.size();  i+=1) { %>
         <tr>
           
            <td><%=resultSet.get(i).getEcode() %></td>
            <td><%=resultSet.get(i).getName() %></td>
            <td><%=resultSet.get(i).getProjectName() %></td>
            <td><%=resultSet.get(i) .getTeamLead()%></td>
            <td><%=resultSet.get(i).getProjectManager()  %></td>
            <td><%=resultSet.get(i).getStartDate() %></td>
            <td><%=resultSet.get(i).getEndDate()  %></td>
            <td><%=resultSet.get(i).getNumberOfDays()  %></td>
            <td><%=resultSet.get(i).getLeaveType()  %></td>
            <td><%=resultSet.get(i).getLeaveDesc()%></td>
           	
           	<!-- changes action/status column  view based on designation --> 
             <%  if(session.getAttribute("desg").equals("Developer")) {  %>      	<!-- designation is developer -->
           
				<% if ((resultSet.get(i).getStatus()).equals("Pending")) { %>        		
	             <td class="text-info"><b><%=resultSet.get(i).getStatus()%></b></td>
			    <% } %>
			    <% if((resultSet.get(i).getStatus()).equals("Approved")) { %>
	             <td class="text-primary"><b><%=resultSet.get(i).getStatus()%></b></td>
			    <% } %>
			    <% if ((resultSet.get(i).getStatus()).equals("Rejected")) { %>
	             <td class="text-danger"><b><%=resultSet.get(i).getStatus()%></b></td>
	             
		    <% } %>
		    
		     <% } else { %>		<!-- designation is !developer-->			
	     			    <!--  changes action/status column  view based on status-->																																																	
	     				<% if ((resultSet.get(i).getStatus()).equals("Approved")) { %>				<!-- status == approved -->	                 
     				 				<td class="rm-border text-primary"><b>Approved</b></td>
						<% } else if ((resultSet.get(i).getStatus()).equals("Rejected")) { %>	<!-- status == rejected -->	
									<td class="rm-border text-danger"><b>Declined</b></td>
	     				  <% } else { %>																													<!-- status == pending -->																			  
							    	 <td class="">
							    	 		<button type="button" class=" btn-check"  id="<%=resultSet.get(i).getId()%>"><i class="fas fa-check"></i></button>
								     		 <button type="button" class=" btn-reject"  id="<%=resultSet.get(i).getId()%>"><i class="fas fa-times"></i></button>
							    	 </td>
	    	 				<% } %>
	    	 				
		  	 <% } %>
         </tr>
         <% } %>
      </tbody>
   </table>
<script src="./static/portalJsp.js"></script>
<script>
$('.btn-reject').click(function(s){
	
	var url = "ActionLeaveServlet";
	var method = "post";
	var id = $(this).attr("id")
	console.log(id);
	
	$.ajax({
		type: method,
		url: url,
		data: {
			'id': id,
			'action' : 'reject'
		} ,
		success: function(data){
			if (data == "true"){
				window.location.replace('portal');
			} else {
				alert('Error!');
			}
		}
	});
});

$('.btn-check').click(function(s){
	
	var url = "ActionLeaveServlet";
	var method = "post";
	var id = $(this).attr("id")
	console.log(id);
	
	$.ajax({
		type: method,
		url: url,
		data: {
			'id': id,
			'action' : 'approve'
		} ,
		success: function(data){
			if (data == "true"){
				window.location.replace('portal');
			} else {
				alert('Error!');
			}
		}
	});
});
</script>
</body>
</html>