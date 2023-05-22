<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="bootheader.jsp" />
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<h1>Hahaha Sucker give us all you money</h1>

	<c:choose>
		<c:when test="${not empty sessionScope.loggedInUser}">
			<h2>Your Account Details</h2>
			<h3>
				<c:out value="${loggedInUser.username}"></c:out>
			</h3>
			<ul>
				<li>ID: ${loggedInUser.id }</li>
				<li>role: ${loggedInUser.role }</li>
			</ul>
			
			<c:if test="${notnew == true}">
				<div class="alert alert-danger" role="alert">
					<p>Space object is already out there</p>
				</div>
		</c:if>
			
			<label for="selectClassification">Add a new Celestial Body</label>
			<form action="addbody.do" id="selectClassification">
				<select name="classificationId">
					<option selected value="1">Nebula</option>
					<option selected value="2">Solar System</option>
					<option selected value="3">Star</option>
					<option selected value="4">Planet</option>
					<option selected value="5">Comet</option>
					<option selected value="6">Asteroid</option>
				</select>
				<input type="submit" value="Select Classification">
			</form>


			<form action="logout.do">
				<input type="submit" value="logout">
			</form>
		</c:when>
		<c:otherwise>
			<p>Not Logged In.</p>
		</c:otherwise>
	</c:choose>


	<jsp:include page="bootfooter.jsp" />
</body>
</html>