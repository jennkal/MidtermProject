<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Encounter</title>
<jsp:include page="bootheader.jsp"></jsp:include>
</head>
<body class="bg-image"
	style="background-image: url('https://apod.nasa.gov/apod/image/2304/Trottier_M31SW_APOD_Re1024.jpg'); background-repeat: no-repeat; background-size: cover; background-position: center;">
	<jsp:include page="navbar.jsp" />
	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<c:if test="${editError == true}">
				<div class="alert alert-danger" role="alert">
					<p>Error editing encounter. Please try again.</p>
				</div>
			</c:if>

			<div class="container d-flex justify-content-center">
				<h1 style="margin-bottom: 50px; color: white;">Overwrite any
					encounter fields that you want to update.</h1>
			</div>
			<div
				class="container min-vh-50 d-flex justify-content-center align-items-center">
				<form
					action="editencounter.do?encounterId=${existingEncounter.id}&bodyId=${bodyId}"
					method="POST"
					style="color: white; width: 300px; height: 400px; padding: 50px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">

					<input type="text" name="title" value="${existingEncounter.title}" />
					<br> <input type="text" name="description"
						value="${existingEncounter.description}" /> <br> <input
						type="text" name="behavior" value="${existingEncounter.behavior}" />
					<br> <label for="encounterDate"> <input type="date"
						id="encounterDate" name="encounterDate"
						value="${existingEncounter.encounterDate}"> :Date
				
					</label> <br> <label for="encounterTime"> <input type="time"
						id="encounterTime" name="encounterTime"
						value="${existingEncounter.encounterTime}" step="1"> :Time
				
					</label> <br> <input type="text" name="captureMethod"
						value="${existingEncounter.captureMethod}" /><br> <input
						type="submit" class="btn btn-outline-primary"
						value="Update Encounter"> <a
						href="viewsingle.do?id=${bodyId}"class="btn btn-outline-primary">
							Cancel</a>
				</form>
			</div>
		</c:when>
	</c:choose>
	<jsp:include page="bootfooter.jsp"></jsp:include>
</body>
</html>