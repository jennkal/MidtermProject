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
<body style="background-color: #343a40;">
	<jsp:include page="navbar.jsp" />
	<div class="d-flex  min-vh-100 justify-content-between p-2">
		<c:if test="${not empty sessionScope.loggedInUser}">
			<c:if test="${not empty encounter}">
				<div class="d-flex p-2 align-self-center"
					style="max-height: 350px; max-width: 80%; margin-bottom: 80px; border: 2px solid red;">
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
								<c:if test="${not empty encounter}">


									<tr>
										<td>${encounter.user.username }</td>
										<td><a href="viewencounter.do?encounterId=${encounter.id}">${encounter.title }</a></td>
										<td>${encounter.createdAt }</td>
										<td>${encounter.description }</td>
										<td>
											<form
												action="rateEncounter.do?userId=${loggedInUser.id }&encounterId=${encounter.id}"
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
									</tr>
								</c:if>
							</tbody>
							<tfoot>
								<c:if test="${loggedInUser.id == encounter.user.id}">
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
				</div>
			</c:if>


		</c:if>
	</div>
	<jsp:include page="bootfooter.jsp" />
</body>
</html>


<jsp:include page="bootfooter.jsp" />
</body>
</html>