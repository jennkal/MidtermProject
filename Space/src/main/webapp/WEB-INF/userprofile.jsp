<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${loggedInUser.username }</title>
<jsp:include page="bootheader.jsp" />
</head>
<body class="bg-image"
	style="background-image: url('https://apod.nasa.gov/apod/image/2304/Barnard-150_LRGB_HIGH-RES1024.jpg'); background-repeat: no-repeat; background-size: cover; background-position: center;">
	<jsp:include page="navbar.jsp" />
	<div class="container d-flex justify-content-center">
		<h1 style="color: white;">Your Adventure So Far!</h1>
	</div>
	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<div class="container d-flex justify-content-center">
				<h2 style="color: white;">${loggedInUser.username }</h2>
			</div>
			<div class="container d-flex justify-content-center">
				<h3 style="color: white;">Here Are You're Previously Entered Encounters</h3>
			</div>

			<div class="card mb-3"
				style="max-width: 200px; , max-height: 90px; margin-left: 30px; margin-top: -30px">
				<c:choose>
					<c:when test="${not empty loggedInUser.imageUrl}">
						<img src="${loggedInUser.imageUrl}"
							class="img-fluid rounded-start card-img-top"
							alt="picture of ${loggedInUser.username }">
					</c:when>
					<c:otherwise>
						<img
							src="https://static.vecteezy.com/system/resources/previews/000/700/639/original/astronaut-cartoon-floating-with-balloon-planets-in-space-vector.jpg"
							class="img-fluid rounded-start card-img-top"
							alt="picture of ${loggedInUser.username }">
					</c:otherwise>
				</c:choose>
				<div class="card-body">
					<h5 class="card-title">${loggedInUser.username}</h5>
					<p class="card-text">${loggedInUser.about}</p>
					<p class="card-text">
						<small class="text-body-secondary">${loggedInUser.role } </small>
					</p>
					<a href="editprofile.do"><button type="button"
							class="btn btn-outline-primary">Update Profile</button></a>
				</div>
			</div>



			<c:if test="${notnew == true}">
				<div class="alert alert-danger" role="alert">
					<p>Space object is already out there</p>
				</div>
			</c:if>



			<div style="width: 260; height: 170; margin-left: 15px">
				<form action="addbody.do"
					style="color: white; width: 250px; height: 160px; padding-left: 15px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">
					<a href="bodylist.do" class="btn btn-outline-primary">View All Celestial Body</a>
					<br>
					<p>Or Add Your New Discovery</p>
					<select name="classificationId">
						<option selected value="1">Nebula</option>
						<option selected value="2">Solar System</option>
						<option selected value="3">Star</option>
						<option selected value="4">Planet</option>
						<option selected value="5">Comet</option>
						<option selected value="6">Asteroid</option>
					</select> <input class="btn btn-outline-primary" type="submit"
						value="Select Classification">
					
				</form>
			</div>

			<c:if test="${not empty loggedInUser.encounters}">
				<div class="d-flex p-2 align-self-center"
					style="max-height: 350px; width: 80%; margin-left: 320px; margin-top: -450px;">
					<div class="table-responsive" style="width: 900px;">
						<c:forEach var="encounter" items="${loggedInUser.encounters}">
							<c:if test="${not empty encounter}">

								<table class="table table-dark table-hover"
									style="width: 800px;">
									<thead>
										<tr>
											<th colspan="5"><a
												href="singleview.do?id=${encounter.celestialBody.id}">${encounter.celestialBody.name}</a>
												Encounter</th>
										</tr>
										<tr>
											<th>UserName</th>
											<th>Title</th>
											<th>Posted</th>
											<th colspan="2">About</th>
										</tr>
									</thead>
									<tbody>

										<tr>
											<td>${encounter.user.username }</td>
											<td><a
												href="viewencounter.do?encounterId=${encounter.id}&userId=${loggedInUser.id}">${encounter.title }</a></td>
											<td>${encounter.createdAt }</td>
											<td colspan="2">${encounter.description }</td>
										</tr>

									</tbody>
									<tfoot>
										<c:if
											test="${loggedInUser.role == 'ADMIN' || loggedInUser.id == encounter.user.id}">
											<tr>
												<td><a
													href="editencounterform.do?encounterId=${encounter.id}&bodyId=${encounter.celestialBody.id}"><button
															type="button" class="btn btn-outline-primary">Edit
															this Encounter</button></a></td>
												<td><a
													href="deleteencounter.do?encounterId=${encounter.id}&bodyId=${encounter.celestialBody.id}"><button
															type="button" class="btn btn-outline-primary">Delete
															this Encounter</button></a></td>
											</tr>
										</c:if>
									</tfoot>
								</table>

							</c:if>
						</c:forEach>
					</div>
				</div>
			</c:if> 
		</c:when>
		<c:otherwise>
			<p>Not Logged In.</p>
		</c:otherwise>
	</c:choose>
	<jsp:include page="bootfooter.jsp" />
</body>
</html>