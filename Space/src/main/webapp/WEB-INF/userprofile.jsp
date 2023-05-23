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
		<h1>Your Adventure So Far!</h1>
	</div>
	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<div class="container d-flex justify-content-center">
				<h2>${loggedInUser.username }</h2>
			</div>

			<div class="card mb-3"
				style="max-width: 200px; , max-height: 90px; margin-left: 30px; margin-top: -30px">
				<img src="${loggedInUser.imageUrl}"
					class="img-fluid rounded-start card-img-top"
					alt="picture of the ${loggedInUser.username }">
				<div class="card-body">
					<h5 class="card-title">${loggedInUser.username}</h5>
					<p class="card-text">${loggedInUser.about}</p>
					<p class="card-text">
						<small class="text-body-secondary">${loggedInUser.role } </small>
					</p>
				</div>
			</div>

			<a href="bodylist.do">View all</a>

			<c:if test="${notnew == true}">
				<div class="alert alert-danger" role="alert">
					<p>Space object is already out there</p>
				</div>
			</c:if>

			<label for="selectClassification">Add a new Celestial Body</label>
			<form action="addbody.do" id="selectClassification">
				<select name="classificationId">
					<option selected value="1">Nebula</option>
					<option selected value="2">Solar System</option>
					<option selected value="3">Star</option>
					<option selected value="4">Planet</option>
					<option selected value="5">Comet</option>
					<option selected value="6">Asteroid</option>
				</select> <input type="submit" value="Select Classification">
			</form>


			<form action="logout.do">
				<input type="submit" value="logout">
			</form>
		</c:when>
		<c:otherwise>
			<p>Not Logged In.</p>
		</c:otherwise>
	</c:choose>


	<jsp:include page="bootfooter.jsp" />
</body>
</html>