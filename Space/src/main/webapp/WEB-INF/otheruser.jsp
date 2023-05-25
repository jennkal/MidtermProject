<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${otheruser.username }</title>
<jsp:include page="bootheader.jsp" />
</head>
<body class="bg-image"
	style="background-image: url(''); background-repeat: no-repeat; background-size: cover; background-position: center;">
	<jsp:include page="navbar.jsp" />
	<div class="container d-flex justify-content-center">
		<h1>Their Adventure So Far!</h1>
	</div>
	<div class="container d-flex justify-content-center">
		<h2>${otheruser.username }</h2>
	</div>
	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<div class="container d-flex justify-content-center">
				<h3>Their Previously Entered Encounters</h3>
			</div>

			<div class="card mb-3"
				style="max-width: 200px; , max-height: 90px; margin-left: 30px; margin-top: -30px">
				<c:choose>
					<c:when test="${not empty otheruser.imageUrl}">
						<img src="${otheruser.imageUrl}"
							class="img-fluid rounded-start card-img-top"
							alt="picture of ${otheruser.username }">
					</c:when>
					<c:otherwise>
						<img
							src="https://static.vecteezy.com/system/resources/previews/000/700/639/original/astronaut-cartoon-floating-with-balloon-planets-in-space-vector.jpg"
							class="img-fluid rounded-start card-img-top"
							alt="picture of ${otheruser.username }">
					</c:otherwise>
				</c:choose>
				<div class="card-body">
					<h5 class="card-title">${otheruser.username}</h5>
					<p class="card-text">${otheruser.about}</p>
					<p class="card-text">
						<small class="text-body-secondary">${otheruser.role } </small>
					</p>
<!-- 					<a href="editprofile.do" style="color: grey; pointer-events: none;"><button
							type="button" class="btn btn-outline-primary"
							style="color: grey;">Update Profile</button></a> -->
				</div>
			</div>
			<c:if test="${notnew == true}">
				<div class="alert alert-danger" role="alert">
					<p>Space object is already out there</p>
				</div>
			</c:if>

			<div style="width: 260; height: 170; margin-left: 15px">
				<form action="addbody.do"
					style="width: 250px; height: 160px; padding-left: 15px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">
					<p style="">Add Your New Discovery</p>
					<select name="classificationId">
						<option selected value="1">Nebula</option>
						<option selected value="2">Solar System</option>
						<option selected value="3">Star</option>
						<option selected value="4">Planet</option>
						<option selected value="5">Comet</option>
						<option selected value="6">Asteroid</option>
					</select> <input class="btn btn-outline-primary" type="submit"
						value="Select Classification"> <label for="or">Or:</label>
					<a href="bodylist.do">
						<button id="or" type="button" class="btn btn-outline-primary">View
							All</button>
					</a>
				</form>
			</div>
			
			<c:if test="${not empty otheruser.encounters}">
				<div class="d-flex p-2 align-self-center"
					style="max-height: 350px; width: 800px; margin-left: 320px; margin-top: -450px;">
					<div class="table-responsive" style="width: 800px;">
						<c:forEach var="encounter" items="${otheruser.encounters}">
							<c:if test="${not empty encounter}">

								<table class="table table-dark table-hover"
									style="width: 1300px;">
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



										<%-- 										<tr>
											<td>${encounter.user.username }</td>
											<td><a href="singleview.do?title=${encounter.title }" style="color: grey; pointer-events: none;">${encounter.title }</a></td>
											<td>${encounter.createdAt }</td>
											<td>${encounter.description }</td>
											<td>
												<form
													action="rateEncounter.do?userId=${otheruser.id }&encounterId=${encounter.id}"
													method="POST">
													<p>Please Rate This Encounter</p>
													<label for="one">1: </label> <input id="one" type=radio
														value="1" name="ratingValue">
													<label for="two">2: </label> <input id="two" type=radio
														value="2" name="ratingValue"> 
													<label for="three">3:</label> <input id="three" type=radio
														value="3" name="ratingValue"> 
													<label for="four">4:</label> <input id="four" type=radio
														value="4" name="ratingValue"> 
													<label for="five">5:</label> <input id="five" type=radio
														value="5" name="ratingValue"> <br> <br>
													<input type=submit class="btn btn-outline-primary" style="color: grey; pointer-events: none;" />
												</form>
											</td>
										</tr> --%>



									</tbody>
									<tfoot>
										<c:if
											test="${loggedInUser.role == 'ADMIN' || loggedInUser.id == encounter.user.id}">
											<tr>
												<td><a
													href="editencounterform.do?encounterId=${encounter.id}&bodyId=${body.id}"><button
															type="button" class="btn btn-outline-primary">Edit
															this Encounter</button></a></td>
												<td><a
													href="deleteencounter.do?encounterId=${encounter.id}&bodyId=${body.id}"><button
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