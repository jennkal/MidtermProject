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
<body>
	<jsp:include page="navbar.jsp" />
<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<c:if test="${editError == true}">
				<div class="alert alert-danger" role="alert">
					<p>Error editing profile. Please try again.</p>
				</div>
			</c:if>	
	
			<div class="container d-flex justify-content-center">
			<h1 style="margin-bottom: 50px;">Overwrite any profile fields that you want to update.</h1>
			</div>

			<div class="container min-vh-50 d-flex justify-content-center align-items-center">
				<form class="input" action="edituser.do?userId=${loggedInUser.id}" method="POST" style="width: 300px; height: 400px; padding: 50px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">
					<input type="text" name="username" value="${loggedInUser.username}" disabled/><br> 
<!-- 					<input type="text" name="password" placeholder="Create a Password" required /><br>  -->
					<input type="url" name="imageUrl" value="${loggedInUser.imageUrl}" /><br>
					<label for="about">${loggedInUser.about}<textarea id="about" class="input" name="about" rows="5" cols="20">
					</textarea>	</label> <br> 
					<input type="submit" value="Update Account"> <br>
					<a href="userprofile.do" ><button type="button" class="btn btn-outline-primary">Cancel</button></a>
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