<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Comment</title>
<jsp:include page="bootheader.jsp"></jsp:include>
</head>
<body class="bg-image"
	style="background-image: url('https://apod.nasa.gov/apod/image/2304/Trottier_M31SW_APOD_Re1024.jpg'); background-repeat: no-repeat; background-size: cover; background-position: center;">
	<jsp:include page="navbar.jsp" />
	<div class="container">

		<c:choose>
			<c:when test="${not empty sessionScope.loggedInUser}">
				<c:if test="${creationError == true}">
					<div class="alert alert-danger" role="alert">
						<p>Error adding a comment. Please try again.</p>
					</div>
				</c:if>

				<div class="container d-flex justify-content-center">
					<h1 style="margin-bottom: 50px; color: white;">Edit Your Comment</h1>
				</div>

				<div
					class="container min-vh-50 d-flex justify-content-center align-items-center">
					<form
						action="performUpdate.do?userId=${loggedInUser.id}&commentId=${commentId}&bodyId=${comment.celestialBody.id}"
						method="POST"
						style=" color: white; width: 300px; height: 400px; padding: 50px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">

						<input type="hidden" name="commentId" value="${commentId}">
						<input type="hidden" name="bodyId"
							value="${comment.celestialBody.id}"> <label for="comment"
							class="form-label">Comment :</label> <input type="text"
							value="${comment.body}" class="form-control" name="body" required>

						<input class="btn btn-outline-primary" type="submit"
							value="Update Comment">
					</form>

				</div>
			</c:when>
			<c:otherwise>
				<h2>logged in to be able to comment</h2>
			</c:otherwise>
		</c:choose>
	</div>
	<jsp:include page="bootfooter.jsp"></jsp:include>
</body>
</html>