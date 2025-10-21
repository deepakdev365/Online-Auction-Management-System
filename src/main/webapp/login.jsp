<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
</head>
<body>
<div>
<h2>Bidder Login</h2>

<form action="LoginServlet" method="post">
<input type="email" name="email" placeholder="Bidder Email" required><br>
<input type="password" name="password" placeholder="Password" required><br>
<input type="submit" value="Login">
</form>

</div>

</body>
</html>