<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<jsp:include page="bootheader.jsp" />
</head>
<body>
	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<nav class="navbar navbar-expand-lg sticky-top bg-body-tertiary bg-dark"
				data-bs-theme="dark">
				<div class="container-fluid">
					<h1 class="navbar-brand">Stacktrace Space Station</h1>
					<br>
					<br>
					<a href="home.do"><button type="button"
							class="btn btn-outline-primary">Home</button></a>
					<br> 
					<br>
					<a href="userprofile.do"><button type="button"
							class="btn btn-outline-primary">Profile</button></a>
					<ul class="navbar-nav me-auto mb-2 mb-lg-0"></ul>
					<form class="d-flex" role="search" action="otheruser.do"
						method="GET">
						<input type="text" name="username" placeholder="Search By Username" />
						<input class="btn btn-outline-success" type="submit"
							value="Search Astronauts" />
					</form>
					<br>
					<br>
					<form class="d-flex" role="search" action="viewbody.do">	
					<input type="text" name="name" placeholder="Search Celestial name" />
						<input class="btn btn-outline-success" type="submit"
							value="Search Universe" />
					</form>
					<br>
					<br>
					<form action="logout.do">
						<input class="btn btn-outline-danger"type="submit" value="logout">
					</form>
				</div>
			</nav>
		</c:when>
		<c:otherwise>
			<nav class="navbar navbar-expand-lg sticky-top bg-body-tertiary bg-dark"
				data-bs-theme="dark">
				<div class="container-fluid">
					<h1 class="navbar-brand">Stacktrace Space Station</h1>
					<ul class="navbar-nav me-auto mb-2 mb-lg-0"></ul>
					<form class="d-flex" action="register.do" method="GET">
					<a href="home.do"><button type="button"
							class="btn btn-outline-primary">Home</button></a>
					<br>
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