<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, intial-scale=1.0">
<title>Add a comment</title>
<jsp:include page="bootheader.jsp" />
</head>
<body>
	<jsp:include page="navbar.jsp" />

<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
						<c:if test="${creationError == true}">
				<div class="alert alert-danger" role="alert">
					<p>Error adding a comment. Please try again.</p>
				</div>
			</c:if>
			<div
				class="container min-vh-50 d-flex justify-content-center align-items-center">
				<form action="addcomment.do?userId=${loggedInUser.id}&bodyId=${bodyId}" method="POST"
					style="width: 600px; height: 400px; padding: 50px; background-color: rgba(2, 62, 138, .3); background-blend-mode: overlay; background-repeat: no-repeat; background-size: contain; border: 2px solid #023e8a; border-radius: 8px;">
					
			 		<input type="text" name="body" placeholder="Enter Comment" required /> <br> 
					
					<input value="Submit" type="submit" class="btn btn-outline-success"/>
					
					<a href="home.do"><button type="button"	class="btn btn-outline-danger">Cancel</button></a>
				</form>
			</div>
		</c:when>
		<c:otherwise>
			<h2>logged in to be able to comment</h2>
		</c:otherwise>
	</c:choose>
	
	<jsp:include page="bootfooter.jsp" />

</body>
</html>