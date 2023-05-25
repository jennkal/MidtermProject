<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>${encounter.celestialBody.name }Encounter</title>

<jsp:include page="bootheader.jsp" />

</head>
<body style="background-image: url('https://media1.giphy.com/media/aRZ4vTsHnyW6A/giphy.gif'); background-repeat: no-repeat; background-size: cover; background-position: center;">
	<jsp:include page="navbar.jsp" />
		<c:if test="${not empty sessionScope.loggedInUser}">
			<c:if test="${not empty encounter}">
				
					<div class="table-responsive">


						<table class="table table-dark table-hover"
							style="width: 80%; margin: 50px auto;">
							<thead>
								<tr>
									<th colspan="5">${encounter.user.username}'s <a href="singleview.do?id=${encounter.celestialBody.id}">${encounter.celestialBody.name}</a> Encounter</th>
								</tr>
								<tr>
									<th>UserName</th>
									<th>Title</th>
									<th>Posted</th>
									<th>About</th>
									<th>Average Rating</th>
								</tr>
							</thead>
							<tbody>
		
									<tr>
										<td>${encounter.user.username }</td>
										<td><a href="viewencounter.do?userId=${loggedInUser.id }&encounterId=${encounter.id}">${encounter.title }</a></td>
										<td>${encounter.createdAt }</td>
										<td >${encounter.description }</td>
										
											<c:choose>
												<c:when test="${averageRating != 0}">
													<td>${averageRating}/5</td>
												</c:when>
												<c:otherwise>
													<td>No ratings yet</td>
												</c:otherwise>
											</c:choose>
											
									</tr>
									
										<tr>
											<c:choose>
												<c:when test="${empty loggedInUserRating}">
													<td colspan="5">
														<form action="rateEncounter.do?userId=${loggedInUser.id }&encounterId=${encounter.id}"
															method="POST">
															<p>Please Rate This Encounter</p>
															<label for="one">1</label> 
															<input id="one" type=radio value="1" name="ratingValue"> 
															<label for="two">2</label>
															<input id="two" type=radio value="2" name="ratingValue">
															<label for="three">3</label> 
															<input id="three" type=radio value="3" name="ratingValue"> 
															<label for="four">4</label>
															<input id="four" type=radio value="4" name="ratingValue">
															<label for="five">5</label> 
															<input id="five" type=radio value="5" name="ratingValue"> 
															<input type=submit class="btn btn-outline-primary" />
														</form>
													</td>
													</c:when>
													<c:otherwise>
														<td colspan="5">Your rating: ${loggedInUserRating.ratingValue}</td>
													</c:otherwise>
											</c:choose>
										</tr>

							</tbody>
							<tfoot>
								<c:if test="${loggedInUser.role == 'ADMIN' || loggedInUser.id == encounter.user.id}">
									<tr>
										<td><a
											href="editencounterform.do?encounterId=${encounter.id}&bodyId=${body.id}"><button
													type="button" class="btn btn-outline-primary">Edit this Encounter</button></a></td>
										<td><a
											href="deleteencounter.do?encounterId=${encounter.id}&bodyId=${body.id}"><button
													type="button" class="btn btn-outline-primary">Delete this Encounter</button></a></td>
									</tr>
								</c:if>
							</tfoot>
						</table>
					</div>
					<div
						class=" d-flex p-2 min-vh-100 flex-column align-self-center justify-content-around flex-fill">
						<div class="d-flex p-2 align-self-center"
							style="margin-top: 10px;">

							<c:if test="${! empty encounter.images }">
								<div id="carouselExample" class="carousel slide">
									<div class="carousel-inner">
										<c:forEach varStatus="i" var="image" items="${encounter.images}">
											<c:choose>
												<c:when test="${i.index == 0 }">
													<div class="carousel-item active">
														<img class="d-block w-100" src="${image.imageUrl}"
															alt="picture of the ${encounter.celestialBody.name }"
															style="max-width: 600px; max-height: auto; border-radius: 5%; margin-top: -20px;">
													</div>
												</c:when>
												<c:otherwise>
													<div class="carousel-item">
														<img class="d-block w-100" src="${image.imageUrl}"
															alt="picture of the ${encounter.celestialBody.name }"
															style="max-width: 600px; max-height: auto; border-radius: 5%; margin-top: -10px;">
													</div>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</div>
									<button class="carousel-control-prev" type="button"
										data-bs-target="#carouselExample" data-bs-slide="prev">
										<span class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Previous</span>
									</button>
									<button class="carousel-control-next" type="button"
										data-bs-target="#carouselExample" data-bs-slide="next">
										<span class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Next</span>
									</button>
								</div>
							</c:if>
						</div>
					</div>

			</c:if>


		</c:if>
<jsp:include page="bootfooter.jsp" />
</body>
</html>