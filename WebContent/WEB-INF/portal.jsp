<jsp:include page="/WEB-INF/layout.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	</body>
</html>