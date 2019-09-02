<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		<style>
			.sidenav {
			  height: 100%;
			  width: 240px;
			  position: fixed;
			  left: 0;
			  background-color: #343a40;
			  overflow-x: hidden;
			  padding-top: 80px;
			  box-shadow:  10px 0 10px -10px #333;
			}
			
			.sidenav a {
			  padding: 6px 8px 6px 16px;
			  text-decoration: none;
			  font-size: 20px;
			  color: #a1a1a1;
			  display: block;
			}
			
			.sidenav a:hover {
			  color: #f1f1f1;
			}
		</style>
        <title>Welcome</title>
    </head>
    <body style="overflow-x: hidden;">
		<nav class="navbar navbar-expand-sm navbar-dark bg-dark" style="box-shadow: 0 10px 10px -10px #333;;">
		    <a class="navbar-brand" href="portal">Frys Web Leave Management</a>
		    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		        <span class="navbar-toggler-icon"></span>
		    </button>
			
		    <div class="collapse navbar-collapse" id="navbarSupportedContent">
		        <ul class="navbar-nav ml-auto">
		            <li class="nav-item active">
		                <a class="nav-link" href="portal">Home <span class="sr-only">(current)</span></a>
		            </li>	            
		            <li class="nav-item active">
		                <a class="nav-link" href="setting">Settings </a>
		            </li>	            
		               <li class="nav-item logout-item">
		                <a class="nav-link" href="logout">Logout</a>
		            </li>
		        </ul>
		    </div>
		</nav>
		<div class="row">
			<div class="sidenav">
			  <a href="#">My Leave Requests</a>
			  <a href="leave">New Leave Request</a>
			</div>	
			<div style="padding: 4%; margin-left: 240px;">	
				<div class="container" style="margin-top: 5%;">
					<c:set var = "desg" scope = "session" value = "${desg}"/>
					<c:choose>
						<c:when test = "${desg == 'Super_Admin'}">
							<jsp:include page="superAdminPortal.jsp"></jsp:include>
						</c:when>
						
						<c:when test = "${desg == 'Admin'}">
							<jsp:include page="adminPortal.jsp"></jsp:include>
						</c:when>
						
						<c:when test = "${desg == 'TeamLead'}">
							<jsp:include page="teamLeadPortal.jsp"></jsp:include>
						</c:when>
						 	
						<c:otherwise>
							<jsp:include page="empPortal.jsp"></jsp:include>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</body>
</html>