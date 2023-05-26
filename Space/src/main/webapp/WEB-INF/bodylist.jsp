<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Our Community Galaxy</title>
<jsp:include page="bootheader.jsp" />
</head>
<body
	style="background-image: url('https://media1.giphy.com/media/aRZ4vTsHnyW6A/giphy.gif'); background-repeat: no-repeat; background-size: cover; background-position: center;">
	<jsp:include page="navbar.jsp" />
	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">


			<c:if test="${! empty bodies }">
				<div
					class="container min-vh-50 d-flex justify-content-center align-items-center">
					<div id="div" class="container-fluid">
						<table class="table table-dark table-hover"
							style="margin-top: 50px">
							<thead>
								<tr>
									<th>Object in Space</th>
									<th>Description</th>
									<th>Classification</th>
									<th>Category</th>
									<th>Update</th>
							</thead>
							<tbody>
								<c:forEach var="body" items="${bodies}">
									<tr>
										<td><a href="singleview.do?id=${body.id}">${body.name}</a></td>
										<td>${body.description}</td>
										<td>${body.category.classification}</td>
										<td>${body.category.name}</td>
										<c:if test="${loggedInUser.role == 'ADMIN' || loggedInUser.id == body.id}">
										<td><a href="updatecelestialbody.do?bodyId=${body.id}" class="btn btn-outline-primary">Update ${body.name}</a></td>
										</c:if>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</div>
			</c:if>
			<c:if test="${! empty otheruser }">
				<div
					class="container min-vh-50 d-flex justify-content-center align-items-center">
					<div id="div" class="container-fluid">
						<table class="table table-dark table-hover"
							style="margin-top: 50px">
							<thead>
								<tr>
									<th>Username</th>
									<th>Active Status</th>
									<th>Role</th>
							</thead>
							<tbody>
								<c:forEach var="user" items="${otheruser}">
									<tr>
										<td><a href="singleuser.do?username=${user.username}">${user.username}</a></td>
										<td>${user.enabled}</td>
										<td>${user.role}</td>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</c:if>
		</c:when>
		<c:otherwise>
			<div
				class="container min-vh-50 d-flex justify-content-center align-items-center">
				<div id="div" class="container-fluid">
					<table class="table table-dark table-hover"
						style="margin-top: 50px">
						<thead>
							<tr>
								<th>Object in Space</th>
								<th>Description</th>
								<th>Classification</th>
								<th>Category</th>
						</thead>
						<tbody>
							<c:forEach varStatus="i" var="body" items="${bodies}">
								<c:choose>
									<c:when test="${i.index == 0 }">
										<tr>
											<td><a href="sampleview.do?id=${body.id}">${body.name}</a></td>
											<td>${body.description}</td>
											<td>${body.category.classification}</td>
											<td>${body.category}</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<td><a href="sampleview.do?id=${body.id}" style="color: grey; pointer-events: none">${body.name}</a></td>
											<td>${body.description}</td>
											<td>${body.category.classification}</td>
											<td>${body.category}</td>
										</tr>

									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	<jsp:include page="bootfooter.jsp" />
</body>
</html>