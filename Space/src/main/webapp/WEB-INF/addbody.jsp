<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="bootheader.jsp" />
</head>
<body>
<jsp:include page="navbar.jsp" />
	<form action="galaxy.do">


		<select name="category">
			<c:forEach var="category" items="${categories }">
				<option name="${category.name }">${category.name }</option>
			</c:forEach>
		</select> 
		
		<input type="submit" value="Select Category">

	
	</form>
<jsp:include page="bootfooter.jsp" />
</body>
</html>