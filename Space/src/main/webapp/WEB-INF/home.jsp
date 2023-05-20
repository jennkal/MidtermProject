<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Space Station</title>
</head>
<body>


<h1>Fly Away</h1>
<c:if test="${loggedOut == true}"><h2>Fail, epic fail go to login</h2></c:if>

	<c:if test="${not empty created }">
		<c:choose>
			<c:when test="${created == true }">
			<h3>SUCCESS, login NOW</h3>
			</c:when>
			<c:otherwise>
				<h3>Registration Failed!!!!!!!</h3>
			</c:otherwise>
		</c:choose>
	</c:if>

${test}


<form action="login.do" method="POST">
<input type="text" name="username" placeholder="Enter Username"/>
<input type="password" name="password" placeholder="Enter Password" />
<input type="submit" value="Sign In" >
</form>

<form action="register.do">
	<input type="submit" value="Sign Up"/>
</form>

</body>
</html>