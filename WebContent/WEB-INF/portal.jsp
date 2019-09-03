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
            <th scope="col">#</th>
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
            <th scope="col">Action </th>
            <th scope="col"></th>
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
            <th scope="row"><%= resultSet.get(i).getId()%></th>
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
            <td>
               <button type="button" class="btn-check"><i class="fas fa-check"></i></button>
               <button type="button" class="btn-reject"><i class="fas fa-trash-alt"></i></button>
            </td>
         </tr>
         <% } %>
      </tbody>
   </table>
</div>
<script>
	$(function{
		$('#all-req').css('color', '#f1f1f1');
	});
</script>
</body>
</html>