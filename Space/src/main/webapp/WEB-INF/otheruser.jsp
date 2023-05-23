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
		<img src="${otheruser.imageUrl}"
			class="img-fluid rounded-start card-img-top"
			alt="picture of the ${otheruser.username }">
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