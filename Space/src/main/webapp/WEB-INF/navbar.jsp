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

	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<nav class="navbar navbar-expand-lg bg-body-tertiary bg-dark"
				data-bs-theme="dark">
				<div class="container-fluid">
					<h1 class="navbar-brand">Stacktrace Space Station</h1>
					<ul class="navbar-nav me-auto mb-2 mb-lg-0"></ul>
				<a href="home.do"><button type="button" class="btn btn-outline-primary">Home</button></a>
					<form class="d-flex" role="search" action="otheruser.do" method="GET">
						<input type="text" name="username"  placeholder="Search By Keyword" /> <input
							class="btn btn-outline-success" type="submit"
							value="Search Universe" />
					</form>
				</div>
			</nav>
		</c:when>
		<c:otherwise>
			<nav class="navbar navbar-expand-lg bg-body-tertiary bg-dark"
				data-bs-theme="dark">
				<div class="container-fluid">
					<h1 class="navbar-brand">Stacktrace Space Station</h1>
					<ul class="navbar-nav me-auto mb-2 mb-lg-0"></ul>
					<form class="d-flex" action="register.do" method="GET">
					 <input class="btn btn-outline-success" type="submit"
							value="Sign Up" />
					</form>
				</div>
			</nav>
		</c:otherwise>
	</c:choose>
	<jsp:include page="bootfooter.jsp" />
</body>
</html>