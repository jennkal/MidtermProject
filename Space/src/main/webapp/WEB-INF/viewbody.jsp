<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Space chat room</title>
<jsp:include page="bootheader.jsp" />

</head>
<body style="background-color: #343a40;">
	<jsp:include page="navbar.jsp" />
	<div class="d-flex  min-vh-100 justify-content-between p-2">
		<c:if test="${not empty sessionScope.loggedInUser}">
			<c:choose>
				<c:when test="${! empty body }">


					<div class="d-flex p-2 align-self-end flex-shrink-1"
						style="max-width: 240px; max-height: 200px; background-color: rgba(18, 18, 18, .5); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid black; border-radius: 10px; margin-bottom: 100px; margin-left: 15px;">
						<div class="table-responsive">
							<ul style="list-style: none; text-align: left; color: white;">
								<li>${body.category.classification}</li>
								<li>${body.category.name}</li>
								<li>${body.name}</li>
								<li>${body.description}</li>
							</ul>
						</div>
					</div>


					<div
						class=" d-flex p-2 min-vh-100 flex-column align-self-center justify-content-around flex-fill">
						<div class="d-flex p-2 align-self-center"
							style="margin-top: -53px;">

							<div id="carouselExample" class="carousel slide">
								<div class="carousel-inner">
									<div class="carousel-item active">
										<img class="d-block w-100" src="${body.imageUrl}"
											alt="picture of the ${body.name }"
											style="max-width: 600px; max-height: auto; border-radius: 5%; margin-top: -10px;">
									</div>
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
						</div>
						<div class="d-flex p-2 align-self-center"
							style="max-height: 150px; max-width: 800px; margin-bottom: 80px;">
							<div class="table-responsive">
								<table class="table table-dark table-hover">
									<thead>
										<tr>
											<td>Username</td>
											<td>Posted At</td>
											<td>Comment</td>
										</tr>
									</thead>
									<tbody>
										<c:if test="${! empty body.comments }">
											<c:forEach var="comment" items="${body.comments }">
												<tr>
													<td><a href="singleuser.do?username=${user.username}">${comment.user.username }</a></td>
													<td>${comment.createdAt }</td>
													<td>${comment.body }</td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
							</div>
						</div>
					</div>


					<div class=" d-flex p-2 align-self-end flex-shrink-1"
						style="max-width: auto; max-height: 340px; margin-bottom: 100px; margin-right: 10px;">

						<a href="${body.trackingUrl}"> <img alt="star map"
							src="https://in-the-sky.org/data/charts/constellations_map_equ1110112_icon.png"
							style="max-height: 300px; max-width: auto; border-radius: 50%;">
						</a>

					</div>





					<%-- 	
				<c:if test="${! empty body.encounters }">
					<c:forEach var="encounter" items="${body.encounters }">
								
										${encounter.user.username }
										${encounter.createdAt }
									
					

										${encounter.description }<
									
											<form
							action="rateEncounter.do?userId=${loggedInUser.id }&encounterId=${encounter.id}"
							method="POST">
							<p>Please Rate This Encounter</p>
							<label for="one">1</label> <input id="one" type=radio value="1"
								name="ratingValue"> <br> <br> <label for="two">2</label>
							<input id="two" type=radio value="2" name="ratingValue">
							<br> <br> <label for="three">3</label> <input
								id="three" type=radio value="3" name="ratingValue"> <br>
							<br> <label for="four">4</label> <input id="four" type=radio
								value="4" name="ratingValue"> <br> <br> <label
								for="five">5</label> <input id="five" type=radio value="5"
								name="ratingValue"> <br> <br> <input
								type=submit class="btn btn-outline-primary" />
						</form>
					</c:forEach>
				</c:if>

				<a href="encounterform.do?bodyId=${body.id}"><button
						type="button" class="btn btn-outline-primary">Add an
						Encounter</button></a> --%>
				</c:when>
				<c:otherwise>
					<div class="alert alert-danger" role="alert">
						<p>Celestial bodies does not exist in database</p>
					</div>
				</c:otherwise>

			</c:choose>
		</c:if>
	</div>
	<jsp:include page="bootfooter.jsp" />
</body>
</html>


<jsp:include page="bootfooter.jsp" />
</body>
</html>