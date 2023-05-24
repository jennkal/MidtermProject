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
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container d-flex justify-content-center">
		<h1>Your Adventure So Far!</h1>
	</div>
	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<div class="container d-flex justify-content-center">
				<h2>${loggedInUser.username }</h2>
			</div>
			<div class="container d-flex justify-content-center">
				<h3>Here Are You're Previously Entered Encounters</h3>
			</div>

			<div class="card mb-3" style="max-width: 200px; , max-height: 90px; margin-left: 30px; margin-top: -30px">
					<c:choose>
						<c:when test="${not empty loggedInUser.imageUrl}">				
							<img src="${loggedInUser.imageUrl}" class="img-fluid rounded-start card-img-top" alt="picture of ${loggedInUser.username }">
						</c:when>
						<c:otherwise>
							<img src="https://static.vecteezy.com/system/resources/previews/000/700/639/original/astronaut-cartoon-floating-with-balloon-planets-in-space-vector.jpg" class="img-fluid rounded-start card-img-top" alt="picture of ${loggedInUser.username }">
						</c:otherwise>
					</c:choose>
				<div class="card-body">
					<h5 class="card-title">${loggedInUser.username}</h5>
					<p class="card-text">${loggedInUser.about}</p>
					<p class="card-text">
						<small class="text-body-secondary">${loggedInUser.role } </small>
					</p>
					<a href="editprofile.do" ><button type="button" class="btn btn-outline-primary">Update Profile</button></a>
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

			<c:if test="${not empty loggedInUser.encounters}">
				<div class="d-flex p-2 align-self-center"
					style="max-height: 350px; max-width: 800px; margin-bottom: 80px; border: 2px solid red;">
					<div class="table-responsive">

						<table class="table table-dark table-hover"
							style="margin-left: 550px; margin-top: -300px; margin-bottom: 100px;">
							<thead>
								<tr>
									<th>UserName</th>
									<th>Title</th>
									<th>Posted</th>
									<th>About</th>
									<th>Rate/Rating</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="encounter" items="${loggedInUser.encounters}">
									<c:if test="${not empty encounter}">

										<tr>
											<td>${encounter.user.username }</td>
											<td><a href="singleview.do?title=${encounter.title }">${encounter.title }</a></td>
											<td>${encounter.createdAt }</td>
											<td>${encounter.description }</td>
											<td>
												<form
													action="rateEncounter.do?userId=${loggedInUser.id }&encounterId=${encounter.id}"
													method="POST">
													<p>Please Rate This Encounter</p>
													<label for="one">1</label> <input id="one" type=radio
														value="1" name="ratingValue"> <br> <br>
													<label for="two">2</label> <input id="two" type=radio
														value="2" name="ratingValue"> <br> <br>
													<label for="three">3</label> <input id="three" type=radio
														value="3" name="ratingValue"> <br> <br>
													<label for="four">4</label> <input id="four" type=radio
														value="4" name="ratingValue"> <br> <br>
													<label for="five">5</label> <input id="five" type=radio
														value="5" name="ratingValue"> <br> <br>
													<input type=submit class="btn btn-outline-primary" />
												</form>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="5"><a
										href="encounterform.do?bodyId=${body.id}"><button
												type="button" class="btn btn-outline-primary">Add
												an Encounter</button></a></td>
								</tr>
							</tfoot>
						</table>
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