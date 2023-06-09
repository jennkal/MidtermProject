<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add a Celestial Body</title>
<jsp:include page="bootheader.jsp" />
</head>
<body class="bg-image"
	style="background-image: url('https://apod.nasa.gov/apod/image/2304/Trottier_M31SW_APOD_Re1024.jpg'); background-repeat: no-repeat; background-size: cover; background-position: center;">
	<jsp:include page="navbar.jsp" />

	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<div class="container d-flex justify-content-center">
				<h1 style="margin-bottom: 50px; color: white;">Tell Us About Your Discovery</h1>
			</div>
			<div
				class="container min-vh-50 d-flex justify-content-center align-items-center">
				<form action="viewbody.do?userId=${loggedInUser.id}" method="POST"
					style="width: 300px; height: 400px; padding: 50px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">
					<input type="text" name="name" placeholder="Enter Name" required />
					<select name="categoryId" required>
						<c:forEach var="categ" items="${categories}">
							<option selected value="${categ.id}">${categ.name}</option>
						</c:forEach>
					</select><br> <input type="text" name="description"
						placeholder="Enter Description" required /> <br> <input
						type="url" name="imageUrl" placeholder="Enter an Image" /> <br>
					<input type="url" name="trackingUrl"
						placeholder="Enter a Tracking Link" /> <br> <input
						type="submit" class="btn btn-outline-primary" value="Create Celestial Body"> <a
						href="home.do"><button type="button"
							class="btn btn-outline-primary">Cancel</button></a>
				</form>
			</div>
		</c:when>
	</c:choose>
	s
	<jsp:include page="bootfooter.jsp" />
</body>
</html>