<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Body</title>
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
					<p>Error adding a body. Please try again.</p>
				</div>
			</c:if>
			<div class="container d-flex justify-content-center">
			<h1 style="margin-bottom: 50px; color: white;">Update Your Celestial Body</h1>
			</div>
			<div
				class="container min-vh-50 d-flex justify-content-center align-items-center">
				<form action="updatebody.do?bodyId=${bodyId}" method="POST"
					style="color: white; width: 300px; height: 400px; padding: 50px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">
				
					
					<input type="hidden" name="bodyId" value="${bodyId}"> 
					
					<label for="body" class="form-label">Celestial Body :</label> 
					<input placeholder="Enter Name" type="text" value="${body.name}" class="form-control" name="name" required> 
					<input placeholder="Enter Image URL" type="text" value="${body.imageUrl}" class="form-control" name="imageUrl"> 
					<input placeholder="Enter Description" type="text" value="${body.description}" class="form-control" name="description" required> 
					<input placeholder="Enter Tracking URL" type="text" value="${body.trackingUrl}" class="form-control" name="trackingUrl"> 
					
					<input class="btn btn-outline-primary" type="submit" value="Update Celestial Body">
					<a href="userprofile.do" class="btn btn-outline-primary">Cancel</a>
				</form>
				
				</div>
		</c:when>
		<c:otherwise>
			<h2>logged in to be able to body</h2>
		</c:otherwise>
	</c:choose>
	</div>
	<jsp:include page="bootfooter.jsp"></jsp:include>
</body>
</html>