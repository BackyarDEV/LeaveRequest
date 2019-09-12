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
      <tr>
         <td><%=al.get(i).getEcode() %></td>
         <td><%=al.get(i).getName() %></td>
         <td><%=al.get(i) .getTeamLead()%></td>
         
      </tr>
      <% } %>
   </tbody>
</table>
<script src="/LeaveRequest/static/portalJs.js"></script>
<script>
	$(document).ready(function() {
		$('#all-req').css('color', '#f1f1f1');
		$('#all-req').css('font-size', '1.2rem');
		$('#data-table').DataTable({
			"ordering": false
		},
		{
			"pagingType": "scrolling"
		});
	});
</script>
</body>
</html>