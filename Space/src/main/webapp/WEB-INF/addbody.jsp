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
	<form action="viewbody.do" method="POST">
		<input type="text" name="name" placeholder="Enter Name" required /> <select
			name="categoryId" required>
			<c:forEach var="X" items="${categories}">
				<option selected value="${X.id}">${X.name}</option>
			</c:forEach>
		</select><br>
		<input type="text" name="description" placeholder="Enter Description"
			required /> <br>
			<input type="url" name="imageUrl"
			placeholder="Enter an Image" /> <br>
			<input type="url" name="trackingUrl"
			placeholder="Enter a Tracking Link" /> <br>
			<input type="submit"
			value="Create Celestial Body">

	</form>
	<jsp:include page="bootfooter.jsp" />
</body>
</html>