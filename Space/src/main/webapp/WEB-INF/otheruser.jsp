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
	<jsp:include page="navbar.jsp" />


	<div class="container d-flex justify-content-center">
		<h1>Their Adventure So Far!</h1>
	</div>
	<div class="container d-flex justify-content-center">
		<h2>${otheruser.username }</h2>
	</div>

	<div class="card mb-3"
		style="max-width: 200px; , max-height: 90px; margin-left: 30px; margin-top: -30px">
		<c:choose>
						<c:when test="${not empty otheruser.imageUrl}">				
							<img src="${otheruser.imageUrl}" class="img-fluid rounded-start card-img-top" alt="picture of ${otheruser.username }">
						</c:when>
						<c:otherwise>
							<img src="https://static.vecteezy.com/system/resources/previews/000/700/639/original/astronaut-cartoon-floating-with-balloon-planets-in-space-vector.jpg" class="img-fluid rounded-start card-img-top" alt="picture of ${loggedInUser.username }">
						</c:otherwise>
					</c:choose>
		<div class="card-body">
			<h5 class="card-title">${otheruser.username}</h5>
			<p class="card-text">${otheruser.about}</p>
			<p class="card-text">
				<small class="text-body-secondary">${other.role } </small>
			</p>
		</div>
	</div>
	<jsp:include page="bootfooter.jsp" />
</body>
</html>