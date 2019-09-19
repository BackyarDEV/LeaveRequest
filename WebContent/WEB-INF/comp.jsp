<%@page import="com.backyardev.util.LeaveRequestService"%>
<%@page import="com.backyardev.util.CompoffReqObject"%>
<%@page import=" java.util.ArrayList"%>
<jsp:include page="/WEB-INF/layout.jsp"></jsp:include>

<table class="table hover nowrap  mt-5"  id="data-table">
   <thead>
      <tr>
         <th scope="col" >Ecode <i class="fas fa-sort ml-1" onclick="sort()"></i></th>
         <th scope="col">Name <i class="fas fa-sort ml-1" onclick="sort()"></i></th>
         <th scope="col">TL <i class="fas fa-sort ml-1" onclick="sort()"></i></th>
         <th scope="col">Ticket/Scr <i class="fas fa-sort ml-1" onclick="sort()"></i></th>
         <th scope="col">Date <i class="fas fa-sort ml-1" onclick="sort()"></i></th>
         <th scope="col">Night Shift <i class="fas fa-sort ml-1" onclick="sort()"></i></th>
        
		     <% if(session.getAttribute("desg").equals("Developer")){ %>
            <th scope="col">Status <i class="fas fa-sort ml-1" onclick="sort()"> </i></th>
         <% } else { %>
            <th scope="col">Action <i class="fas fa-sort ml-1" onclick="sort()"> </i></th>
         <% } %>

      </tr>
   </thead>
   <tbody>
      <%
      	String ecode = (String) session.getAttribute("ecode");
        String desg = (String) session.getAttribute("desg");
        String name = (String) session.getAttribute("name");
        ArrayList<CompoffReqObject> al = LeaveRequestService.populateCompoffTable(desg,name,ecode);
      %>
      <% for(int i = 0; i < al.size(); i+=1) { %>
      <tr  id=" <%=al.get(i).getId()%>" class="targetRow">
         <td><%=al.get(i).getEcode() %></td>
         <td><%=al.get(i).getName() %></td>
         <td><%=al.get(i) .getTeamLead()%></td>
         <td><%=al.get(i) .getTicket()%></td>
         <td><%=al.get(i) .getCompDate()%></td>
         <td><%=al.get(i) .getNightShift()%></td>
    
    	<!-- changes action/status column view based on designation --> 
         <% if(session.getAttribute("desg").equals("Developer")) { %> <!-- designation is developer -->
		         <% if ((al.get(i).getStatus()).equals("Pending")) { %> 
		         <td class="text-warning font-weight-bold"><%=al.get(i).getStatus()%></td>
		         <% } %>
		         <% if((al.get(i).getStatus()).equals("Approved")) { %>
		         <td class="text-primary  font-weight-bold"><%=al.get(i).getStatus()%></td>
		         <% } %>
		         <% if ((al.get(i).getStatus()).equals("Rejected")) { %>
		         <td class="text-danger font-weight-bold"><%=al.get(i).getStatus()%></td>
		         <% } %>
         <% } else { %>	<!-- designation is !developer-->	
         <!-- changes action/status column view based on status-->
		         <% if ((al.get(i).getStatus()).equals("Approved")) { %>	<!-- status == approved -->	
		   			<td class="text-primary font-weight-bold" > Approved </td>
				<% } else if ((al.get(i).getStatus()).equals("Rejected")) { %>	<!-- status == rejected -->	
		         <td class="text-danger font-weight-bold" > Rejected </td>
		         <% } else { %>	<!-- status == pending -->	
		         <td class="">
		            <button type="button" class=" btn-check" id="<%=al.get(i).getId()%>"><i class="fas fa-check "></i></button>
		            <button type="button" class=" btn-reject" id="<%=al.get(i).getId()%>"><i class="fas fa-times"></i></button>
		         </td>
		         <% } %>
            <% } %>
      </tr>
      <% } %>
   </tbody>
</table>
<script src="/LeaveRequest/static/portalJs.js"></script>
<script src="/LeaveRequest/static/compDisplayJs.js"></script>
</body>
</html>