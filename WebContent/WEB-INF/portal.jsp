<%@page import="com.backyardev.TableClass"%>
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
          
			<% if ((resultSet.get(i).getStatus()).equals("Pending")) { %>
             <td class="bg-warning text-dark"><%=resultSet.get(i).getStatus()%></td>
		    <% } %>
		    <% if((resultSet.get(i).getStatus()).equals("Approved")) { %>
             <td class="bg-primary text-white"><%=resultSet.get(i).getStatus()%></td>
		    <% } %>
		    <% if ((resultSet.get(i).getStatus()).equals("Rejected")) { %>
             <td class="bg-danger text-white"><%=resultSet.get(i).getStatus()%></td>
		    <% } %>
		    
         </tr>
         <% } %>
      </tbody>
   </table>
</div>
<script>
	$(function(){
		$('#all-req').css('color', '#f1f1f1');
	});
</script>
</body>
</html>