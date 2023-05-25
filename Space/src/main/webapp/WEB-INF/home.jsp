<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Space Station</title>
<jsp:include page="bootheader.jsp" />
</head>
<body class="bg-image"
	style="background-image: url('https://imageio.forbes.com/specials-images/imageserve/6127b2920d67d45e8a181602/0x0.jpg?format=jpg&amp;width=1200'); background-repeat: no-repeat; background-size: cover; background-position: center;">
	<jsp:include page="navbar.jsp" />
	<c:if test="${loggedOut == true}">

		<div class="alert alert-danger" role="alert">
			<p>Username or password incorrect, please try again</p>
		</div>
	</c:if>

	<c:if test="${not empty created }">
		<c:choose>
			<c:when test="${created == true }">
				<div class="alert alert-success" role="alert">
					<p>Welcome to our community, sign in and explore space</p>
				</div>
			</c:when>
			<c:otherwise>
				<div class="alert alert-warning" role="alert">
					<p>Username already in use. Please select a different username.
					</p>
				</div>
			</c:otherwise>
		</c:choose>
	</c:if>
	<div class="container d-flex justify-content-center">
		<h1 style="margin-bottom: 35px; color: white;">Sign In</h1>
	</div>
	<div
		class="container min-vh-50 d-flex justify-content-center align-items-center">
		<form action="login.do" method="POST"
			style="width: 300px; height: 200px; padding: 50px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">
			<input type="text" name="username" placeholder="Enter Username" /> <br>
			<br> <input type="password" name="password"
				placeholder="Enter Password" /> <br> <input type="submit"
				class="btn btn-outline-primary" value="Sign In">
		</form>

	</div>

	<div class="container d-flex justify-content-center">
		<div class="container d-flex justify-content-center"
			style="padding: 30px; border: 2px solid #023e8a; border-radius: 8px; width: 450px; margin-top: 50px; color: white; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain;">
			<p>Welcome to the Space Station where all our self proclaimed
				astronaut share their favorite space adventures. Join us and share
				pictures of your favorite planets, stars, galaxies and discuss with
				your fellow astronauts, and so much more.</p>
		</div>


	</div>



	<div class="d-flex p-2 align-self-center"
		style="max-height: 150px; max-width: 800px; margin-bottom: 80px;">
		<div class="table-responsive">
			<table class="table table-dark table-hover"
				style="width: 800px; margin-left: 250px; margin-top: 65px;">
				<thead style="text-align: center;">
					<tr>
						<th colspan="9">Explore Our Community</th>
					</tr>
					<tr>
						<th>User</th>
						<th>Title</th>
						<th>Description</th>
						<th>Explore</th>
					</tr>
				</thead>
				<tbody style="text-align: center;">
					<tr>
						<td>Buzz_Aldrin_2ndToNone</td>
						<td>The Eagle Nebula</td>
						<td>I was on my way to the moon when I saw saw this sick star
							factory to share with you guys</td>
						<td><a href="bodylist.do">
								<button type="button" class="btn btn-outline-primary">Explore</button>
						</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="bootfooter.jsp" />
</body>
</html>