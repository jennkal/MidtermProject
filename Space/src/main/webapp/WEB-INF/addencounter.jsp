<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Encounter</title>
</head>
<body>
<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
						<c:if test="${creationError == true}">
				<div class="alert alert-danger" role="alert">
					<p>Error adding encounter. Please try again.</p>
				</div>
			</c:if>
			<div class="container d-flex justify-content-center">
				<h1 style="margin-bottom: 50px;">Tell Us About Your Encounter</h1>
			</div>
			<div
				class="container min-vh-50 d-flex justify-content-center align-items-center">
				<form action="addencounter.do?userId=${loggedInUser.id}&bodyId=${bodyId}" method="POST"
					style="width: 600px; height: 400px; padding: 50px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">
					
					<input type="text" name="title" placeholder="Enter Title" required /> <br>
			 		<input type="text" name="description" placeholder="Enter Description" required /> <br> 
					<input type="text" name="behavior" placeholder="Describe Observed Behavior" required /> <br> 
					<label for="encounterDate">Date Encountered:</label>
					<input type="date" id="encounterDate" name="encounterDate" required><br>
					<label for="encounterTime">Time Encountered:</label>
					<input type="time" id="encounterTime" name="encounterTime" step="1"><br>
					<input type="text" name="captureMethod" placeholder="Capture Method" required /><br>
					
					<p><em>Optional:</em> Add Links to your Image(s)</p> <br> 
					<input type="url" name="imageUrl1" placeholder="Enter an Image URL" /> <br>
					<input type="url" name="imageUrl2" placeholder="Enter an Image URL" /> <br>
					<input type="url" name="imageUrl3" placeholder="Enter an Image URL" /> <br>
					<input type="url" name="imageUrl4" placeholder="Enter an Image URL" /> <br>
					<input type="url" name="imageUrl5" placeholder="Enter an Image URL" /> <br>

					<input type="submit" value="Submit Encounter"> 
					
					<a href="viewsingle.do?id=${bodyId}"><button type="button"	class="btn btn-outline-primary">Cancel</button></a>
				</form>
			</div>
		</c:when>
	</c:choose>
</body>
</html>