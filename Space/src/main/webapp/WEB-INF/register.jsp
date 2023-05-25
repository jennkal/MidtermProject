<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Create A New Account</title>
<jsp:include page="bootheader.jsp" />
</head>
<body class="bg-image"
	style="background-image: url('https://apod.nasa.gov/apod/image/2304/Trottier_M31SW_APOD_Re1024.jpg'); background-repeat: no-repeat; background-size: cover; background-position: center;">
	<jsp:include page="navbar.jsp" />
	
	
<div class="container d-flex justify-content-center">
		<h1 style="margin-bottom: 50px; color: white;">Create An Account</h1>
	</div>

	<div
		class="container min-vh-50 d-flex justify-content-center align-items-center">
		<form class="input" action="newuser.do" method="POST" style="width: 300px; height: 400px; padding: 50px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">
			<input type="text" name="username" placeholder="Create a Username" required /><br> 
			<input type="text" name="password"
				placeholder="Create a Password" required /><br> 
			<input type="url" name="imageUrl" placeholder="Optional: Add a Profile Picture" /><br>
			<label for="about">Tell About Us Yourself<textarea id="about" class="input" name="about" rows="5" cols="20" placeholder="Optional:">
			</textarea></label> <br> 
			<input type="submit" value="Create Account"><br>
			<a href="home.do" ><button type="button" class="btn btn-outline-primary">Cancel</button></a>
		</form>
	</div>
	<jsp:include page="bootfooter.jsp" />
</body>
</html>