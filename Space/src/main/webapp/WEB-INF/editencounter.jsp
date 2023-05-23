<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Encounter</title>
</head>
<body>
<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
						<c:if test="${editError == true}">
				<div class="alert alert-danger" role="alert">
					<p>Error editing encounter. Please try again.</p>
				</div>
			</c:if>
			<div class="container d-flex justify-content-center">
				<h1 style="margin-bottom: 50px;">Overwrite any Encounter Fields that you Want to Update</h1>
			</div>
			<div
				class="container min-vh-50 d-flex justify-content-center align-items-center">
				<form action="editencounter.do?encounterId=${existingEncounter.id}&bodyId=${bodyId}" method="POST"
					style="width: 600px; height: 400px; padding: 50px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">
					
					<input type="text" name="title" value="${existingEncounter.title}" /> <br>
			 		<input type="text" name="description" value="${existingEncounter.description}" /> <br> 
					<input type="text" name="behavior" value="${existingEncounter.behavior}" /> <br> 
					<label for="encounterDate">Date Encountered:</label>
					<input type="date" id="encounterDate" name="encounterDate" value="${existingEncounter.encounterDate}"><br>
					<label for="encounterTime">Time Encountered:</label>
					<input type="time" id="encounterTime" name="encounterTime" value="${existingEncounter.encounterTime}" step="1"><br>
					<input type="text" name="captureMethod" value="${existingEncounter.captureMethod}"/><br>
					
<!-- 					<p><em>Optional:</em> Add Links to your Image(s)</p> <br> 
					<input type="url" name="imageUrl1" placeholder="Enter an Image URL" /> <br>
					<input type="url" name="imageUrl2" placeholder="Enter an Image URL" /> <br>
					<input type="url" name="imageUrl3" placeholder="Enter an Image URL" /> <br>
					<input type="url" name="imageUrl4" placeholder="Enter an Image URL" /> <br>
					<input type="url" name="imageUrl5" placeholder="Enter an Image URL" /> <br> -->

					<input type="submit" value="Update Encounter"> 
					
					<a href="viewsingle.do?id=${bodyId}"><button type="button"	class="btn btn-outline-primary">Cancel</button></a>
				</form>
			</div>
		</c:when>
	</c:choose>
</body>
</html>