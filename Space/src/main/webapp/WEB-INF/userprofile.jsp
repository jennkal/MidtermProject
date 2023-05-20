<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>Hahaha Sucker give us all you money</h1>

	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<h2>Your Account Details</h2>
			<h3>
				<c:out value="${loggedInUser.username}"></c:out>
			</h3>
			<ul>
				<li>ID: ${loggedInUser.id }</li>
				<li>role: ${loggedInUser.role }</li>
			</ul>
		</c:when>
		<c:otherwise>
			<p>Not Logged In.</p>
		</c:otherwise>
	</c:choose>


</body>
</html>