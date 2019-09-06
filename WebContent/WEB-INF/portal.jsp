<%@page import="com.backyardev.util.DatabaseQueries"%>
<%@page import=" java.util.ArrayList"%>
<%@page import=" com.backyardev.util.LeaveReqObject"%>
<jsp:include page="/WEB-INF/layout.jsp"></jsp:include>

<table class="table hover nowrap" id="data-table">
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
         <th scope="col" class="slide">Desc </th>
         <th scope="col">Desc </th>
         <% if(session.getAttribute("desg").equals("Developer")){ %>
         <th scope="col">Status </th>
         <% } else { %>
         <th scope="col">Action </th>
         <% } %>
      </tr>
   </thead>
   <tbody>
      <% 
         String ecode = (String) session.getAttribute("ecode");
         String desg = (String) session.getAttribute("desg");
         String name = (String) session.getAttribute("name");
         ArrayList<LeaveReqObject> resultSet = DatabaseQueries.getTable(desg,name,ecode);
         %>
      <% for(int i = 0; i < resultSet.size(); i+=1) { %>
      <tr>
         <td><%=resultSet.get(i).getEcode() %></td>
         <td><%=resultSet.get(i).getName() %></td>
         <td><%=resultSet.get(i).getProjectName() %></td>
         <td><%=resultSet.get(i) .getTeamLead()%></td>
         <td><%=resultSet.get(i).getProjectManager() %></td>
         <td><%=resultSet.get(i).getStartDate() %></td>
         <td><%=resultSet.get(i).getEndDate() %></td>
         <td class="text-center"><%=resultSet.get(i).getNumberOfDays() %></td>
         <td><%=resultSet.get(i).getLeaveType() %></td>
         <td><%=resultSet.get(i).getLeaveDesc()%></td>
         <!-- changes action/status column view based on designation --> 
         <% if(session.getAttribute("desg").equals("Developer")) { %> <!-- designation is developer -->
         <% if ((resultSet.get(i).getStatus()).equals("Pending")) { %> 
         <td class="text-warning font-weight-bold"><%=resultSet.get(i).getStatus()%></td>
         <% } %>
         <% if((resultSet.get(i).getStatus()).equals("Approved")) { %>
         <td class="text-primary font-weight-bold"><%=resultSet.get(i).getStatus()%></td>
         <% } %>
         <% if ((resultSet.get(i).getStatus()).equals("Rejected")) { %>
         <td class="text-danger font-weight-bold"><%=resultSet.get(i).getStatus()%></td>
         <% } %>
         <% } else { %>	<!-- designation is !developer-->	
         <!-- changes action/status column view based on status-->	
         <% if ((resultSet.get(i).getStatus()).equals("Approved")) { %>	<!-- status == approved -->	
         <td class="text-primary font-weight-bold" > Approved </td>
         <% } else if ((resultSet.get(i).getStatus()).equals("Rejected")) { %>	<!-- status == rejected -->	
         <td class="text-danger font-weight-bold" > Rejected </td>
         <% } else { %>	<!-- status == pending -->	
         <td class="">
            <button type="button" class=" btn-check" id="<%=resultSet.get(i).getId()%>"><i class="fas fa-check "></i></button>
            <button type="button" class=" btn-reject" id="<%=resultSet.get(i).getId()%>"><i class="fas fa-times"></i></button>
         </td>
         <% } %>
         <% } %>
      </tr>
      <% } %>
   </tbody>
</table>
<script src="static/portalJs.js"></script>
</body>
</html>