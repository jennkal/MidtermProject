<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Your Account</title>
<jsp:include page="bootheader.jsp" />
</head>
<body class="bg-image"
	style="background-image: url('https://apod.nasa.gov/apod/image/2304/Trottier_M31SW_APOD_Re1024.jpg'); background-repeat: no-repeat; background-size: cover; background-position: center;">
	<jsp:include page="navbar.jsp" />
<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<c:if test="${editError == true}">
				<div class="alert alert-danger" role="alert">
					<p>Error editing profile. Please try again.</p>
				</div>
			</c:if>	
	
			<div class="container d-flex justify-content-center">
			<h1 style="margin-bottom: 50px; color: white;">Overwrite any profile fields that you want to update.</h1>
			</div>

			<div class="container min-vh-50 d-flex justify-content-center align-items-center">
				<form class="input" action="edituser.do?userId=${loggedInUser.id}" method="POST" style=" color: white; width: 300px; height: 400px; padding: 50px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">
					<label for="username">Username:</label><br>
					<input type="text" id="username" name="username" value="${loggedInUser.username}" disabled/><br> 
					<c:choose>
						<c:when test="${not empty loggedInUser.imageUrl}">
							<label for="imageUrl">Profile Picture URL:</label><br>
							<input type="url" id="imageUrl" name="imageUrl" value="${loggedInUser.imageUrl}" /><br>
						</c:when>
						<c:otherwise>
							<input type="url" name="imageUrl" placeholder="Optional: Add a Profile Picture" /><br>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${not empty loggedInUser.about}">
							<label for="about">
							<textarea id="about" class="input" name="about" rows="5" cols="20" placeholder="${loggedInUser.about}"></textarea>
							:Tell About Us Yourself</label> <br> 
						</c:when>	
						<c:otherwise>
							<label for="about">Tell About Us Yourself:</label>
							<textarea id="about" class="input" name="about" rows="5" cols="20" placeholder="Optional:"></textarea> <br> 
						</c:otherwise>
					</c:choose>		
					<input type="submit" class="btn btn-outline-primary" value="Update Account"> <br>
					<a href="userprofile.do?userId=${loggedInUser.id }"  class="btn btn-outline-primary">Cancel</a>
		</form>
	</div>
</c:when>
		<c:otherwise>
			<p>Not Logged In.</p>
		</c:otherwise>
</c:choose>
	<jsp:include page="bootfooter.jsp" />
</body>
</html>