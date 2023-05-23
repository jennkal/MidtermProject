<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${body.name} Chat Room</title>
<jsp:include page="bootheader.jsp" />
</head>
<body>
	<jsp:include page="navbar.jsp" />


	you're here
	
<c:if test="${not empty sessionScope.loggedInUser}">
	<c:choose>
		<c:when test="${! empty body }">

			

				<div
					class="container min-vh-75 d-flex justify-content-center align-items-center">
					<div id="div" class="container-fluid">
						<table class="table table-dark table-hover"
				style="width: 800px; margin-left: 250px; margin-top: 65px;">
							<thead>
								<tr>
									<th>${body.category.classification}</th>
									<th>${body.category.name}</th>
									<th>${body.name}</th>
									<th>${body.description}</th>
									<c:if test="${! empty body.imageUrl }">
									<th><img src="${body.imageUrl}" class="img-fluid rounded-start card-img-top" 
							alt="picture of the ${body.name }"></th>
									
									</c:if>
									<c:if test="${! empty body.trackingUrl }">
									<th>${body.trackingUrl}</th>
									</c:if>
								</tr>
							</thead>
							<tbody>
							<c:if test="${! empty body.comments }">
								<c:forEach var="comment" items="${body.comments }">
									<tr>
										<td>${comment.user.username }</td>
										<td>${comment.createdAt }</td>
									</tr>
									<tr>

										<td>${comment.body }</td>

									</tr>

							</c:forEach>
							</c:if>
							<c:if test="${! empty body.encounters }">
								<c:forEach var="encounter" items="${body.encounters}">
									<tr>
										<td>${encounter.user.username}</td>
										<td>${encounter.createdAt}</td>
									</tr>
									<tr>
										<td>Description: ${encounter.description}</td>
									</tr>
									<tr>
										<td>Behavior: ${encounter.behavior}</td>
									</tr>
									<c:if test="${not empty encounter.images}">
										<tr>
										<c:forEach var="image" items="encounter.images">
											<c:if test="${not empty image}">
												<td>
													<img src="${image.imageUrl}" alt="Image of ${body.name}">
												</td>
											</c:if>
										</c:forEach>
										<tr>
									</c:if>
									<c:if test="${loggedInUser.id == encounter.user.id}">
										<tr>
											<td><a href="editencounterform.do?encounterId=${encounter.id}&bodyId=${body.id}"><button type="button"
									class="btn btn-outline-primary">Edit this Encounter</button></a></td>
											<td><a href="deleteencounter.do?encounterId=${encounter.id}"><button type="button"
									class="btn btn-outline-primary">Delete this Encounter</button></a></td>
										</tr>
									</c:if>

								</c:forEach>
							</c:if>
							<tr>
								<td><a href="encounterform.do?bodyId=${body.id}"><button type="button"
									class="btn btn-outline-primary">Add an Encounter</button></a></td>
							</tr>
							</tbody>
						</table>
					</div>
				</div>
		
		</c:when>
		<c:otherwise>
			<div class="alert alert-danger" role="alert">
				<p>Celestial bodies does not exist in database</p>
			</div>
		</c:otherwise>

	</c:choose>
</c:if>


	<jsp:include page="bootfooter.jsp" />
</body>
</html>


	<jsp:include page="bootfooter.jsp" />
</body>
</html>