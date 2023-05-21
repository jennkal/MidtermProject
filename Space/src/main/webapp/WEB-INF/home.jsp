<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Space Station</title>
<jsp:include page="bootheader.jsp" />
</head>
<body
	style="background-image: url('https://imageio.forbes.com/specials-images/imageserve/6127b2920d67d45e8a181602/0x0.jpg?format=jpg&amp;width=1200'); background-repeat: no-repeat; background-size: cover;">
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
		<h1 style="margin-bottom: 50px; color: white;">Sign In</h1>
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
	<div
		class="container min-vh-75 d-flex justify-content-center align-items-center">
		<div id="div" class="container-fluid">

			<table class="table table-hover" style="width: 800px; margin-left: 250px; margin-top: 200px; background-color: rgba(18, 18, 18, .7); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; color: white;">
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
				<!-- 	we might put this in a foreach -->
				<tbody style="text-align: center;">
					<tr>
						<td>username</td>
						<td>encounter name</td>
						<td>encounter info</td>
						<td><a href="sample.do"><button type="button"
									class="btn btn-outline-primary">Explore</button></a></td>
					</tr>

				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="bootfooter.jsp" />
</body>
</html>