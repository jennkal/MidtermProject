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

${test}


<form action="login.do" method="POST">
<input type="text" name="username" placeholder="Enter Username"/>
<input type="password" name="password" placeholder="Enter Password" />
<input type="submit" value="Sign In" >
</form>

</body>
</html>