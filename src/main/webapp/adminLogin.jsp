<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<link rel="stylesheet" href="../style.css">
</head>
<body class="admin-login-body">

<div class="admin-login-container">
<h2>Admin Login</h2>

<form action="AdminLoginServlet" method="post">
<input type="email" name="email" placeholder="Admin Email" required><br>
<input type="password" name="password" placeholder="Password" required><br>
<input type="submit" value="Login">
</form>
</div>

</body>
</html>
