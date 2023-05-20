<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form class="input" action="newuser.do" method="POST">
	<input type="text" name="username" placeholder="Create a Username" required/><br>
	<input type="text" name="password" placeholder="Create a Password" required/><br>
	<input type="url" name="imageUrl" placeholder="Optional: Add a Profile Picture"/><br>
	<textarea class="input" name="about" rows="5" cols="20" >Optional: Tell About Yourself</textarea><br>
	<input type="submit" value="Create Account">
</form>
</body>
</html>