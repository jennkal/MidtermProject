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

<form class="input" action="newuser.do">
	<input type="text" name="username" placeholder="enterusername" required/>
	<input type="text" name="password" placeholder="enterpassword" required/>
	<input type="url" name="imageURL" placeholder="pictureurl"/>
	<input type="submit" value="account" />
</form>
	<textarea class="input" rows="5" cols="5" >About Yourself</textarea>

</body>
</html>