<%@page import="com.backyardev.TableClass"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import=" java.util.ArrayList"%>
<%@page import=" com.backyardev.util.LeaveReqObject"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
   
    <link rel="stylesheet"  href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" >
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.css" >
    <link rel="stylesheet"  href="style.css" >
 
 

    <title>See all your leaves</title>
    <style>
     	.btn-check{
     		background:white;
     		color: #1c9be8;
     		border: none;
     		}
     	
     	  .btn-reject{
     		background:white;
     		color: #7323dc;
     		border: none;
     		}
    </style>
  </head>
  <body>
  <div class="ml-1 mr-1 mt-3">
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
		   </tr>
			<% 
			TableClass tc = new TableClass();
			ArrayList<LeaveReqObject> resultSet = tc.getTable();
			
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
		      <button type="button" class=" btn-check"><i class="fas fa-check"></i></button>
		      <button type="button" class=" btn-reject"><i class="fas fa-trash-alt"></i></button>
		      </td> 
	    	</tr>
 			<% } %>

		  </tbody>
		</table>
</div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  </body>
</html>