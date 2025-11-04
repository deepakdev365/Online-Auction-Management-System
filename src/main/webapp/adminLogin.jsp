<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login - NextAuction</title>
<style>
body {
font-family: Arial, sans-serif;
background: #f0f2f5;
display: flex;
justify-content: center;
align-items: center;
height: 100vh;
margin: 0;
}
.login-box {
background: white;
padding: 30px;
border-radius: 5px;
box-shadow: 0 2px 10px rgba(0,0,0,0.1);
width: 300px;
text-align: center;
}
h2 {
color: #dc3545;
margin-bottom: 20px;
}
input {
width: 100%;
padding: 10px;
margin: 8px 0;
border: 1px solid #ddd;
border-radius: 3px;
box-sizing: border-box;
}
button {
background: #dc3545;
color: white;
border: none;
padding: 10px 20px;
border-radius: 3px;
width: 100%;
cursor: pointer;
margin-top: 10px;
}
button:hover {
background: #c82333;
}
.error {
color: #dc3545;
margin-top: 10px;
}
</style>
</head>

<body>
<div class="login-box">
<h2>Admin Login</h2>
<form action="AdminLoginServlet" method="post">
<input type="email" name="email" placeholder="Admin Email" required>
<input type="password" name="password" placeholder="Password" required>
<button type="submit">Login</button>
</form>

<div class="error">
${error}
</div>

<p style="color: #666; margin-top: 15px; font-size: 12px;">
Single admin access only
</p>
</div>
</body>
</html>
