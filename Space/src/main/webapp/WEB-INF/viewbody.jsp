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
<body>
	<jsp:include page="navbar.jsp" />
	<c:if test="${not empty sessionScope.loggedInUser}">
		<c:choose>
			<c:when test="${! empty body }">

					<div>
					
							<a href="${body.trackingUrl}">${body.trackingUrl}</a>		
								
					</div>

				<div>
						<img src="${body.imageUrl}" alt="picture of the ${body.name }"
							style="max-width: 300px; max-height: 250px; margin-left: 400px; margin-top: 130px;">
				</div>
				
				
				

				<div style="margin-top: 260px; margin-left: 20px;  max-width: 240px; max-height:auto; background-color: rgba(18, 18, 18, .5); 
				background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid black; 
				border-radius: 10px ">
					<ul style="list-style: none; text-align: left;">
						<li>${body.category.classification}</li>
						<li>${body.category.name}</li>
						<li>${body.name}</li>
						<li>${body.description}</li>
					</ul>				
                </div>




				<%-- 	<c:if test="${! empty body.comments }">
					<c:forEach var="comment" items="${body.comments }">
								
										${comment.user.username }
										${comment.createdAt }
									

										${comment.body }


								</c:forEach>
				</c:if>
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
	<jsp:include page="bootfooter.jsp" />
</body>
</html>


<jsp:include page="bootfooter.jsp" />
</body>
</html>