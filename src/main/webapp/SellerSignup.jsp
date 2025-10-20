<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seller SignUp Page</title>
</head>
<body>

<div class="">
<form action="SignupServlet" method="post">
<input type="hidden" name="role" value="seller">

<input type="text" name="fullname" placeholder="Enter your Full Name" required>
<br><br>
<input type="email" name="email" placeholder="Email" required>
<br><br>
<input type="password" name="password" placeholder="Password">
<span style="cursor: pointer;">👁️</span>
<br><br>
<input type="submit" value="Signup">
</form>
</div>

</body>
</html>