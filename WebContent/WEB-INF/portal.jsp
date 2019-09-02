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
		
        <title>Welcome</title>
    </head>
    <body>

		<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
		    <a class="navbar-brand" href="portal">Leave Management</a>
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
		<div class="container">
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
		<script>
		console.log('${ecode}');
		</script>
	</body>
</html>