<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Space chat room</title>
</head>
<body>
<jsp:include page="navbar.jsp" />
	<c:if test="${notnew == true}">
		<div class="alert alert-danger" role="alert">
			<p>Space object is already out there</p>
		</div>
	</c:if>

you're here

${post }



</body>
</html>