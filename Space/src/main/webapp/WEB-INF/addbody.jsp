<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="galaxy.do">


		<select name="category">
			<c:forEach var="category" items="${categories }">
				<option name="${category.name }">${category.name }</option>
			</c:forEach>
		</select> <input type="text" name="name">


	</form>

</body>
</html>