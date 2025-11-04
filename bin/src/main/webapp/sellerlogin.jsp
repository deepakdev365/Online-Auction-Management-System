<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Seller Login | NextAuction</title>
    <style>
        body {
            background: linear-gradient(135deg, #0a1222, #050914);
            color: #fff;
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-container {
            background: rgba(255,255,255,0.1);
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 170, 255, 0.2);
            width: 350px;
            text-align: center;
        }
        h2 {
            color: #00aaff;
            margin-bottom: 20px;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border-radius: 6px;
            border: none;
            outline: none;
            background: rgba(255,255,255,0.2);
            color: #fff;
        }
        button {
            background: linear-gradient(135deg, #00aaff, #0088cc);
            border: none;
            color: #fff;
            padding: 10px 20px;
            border-radius: 6px;
            width: 100%;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover {
            background: #00ccff;
        }
        p {
            margin-top: 10px;
        }
        a {
            color: #00ccff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Seller Login</h2>
    <!-- ✅ Use context path to always hit correct servlet -->
    <form action="<%= request.getContextPath() %>/SellerLoginServlet" method="post">
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>

    <% if (request.getAttribute("error") != null) { %>
        <p style="color: #ff4444;"><%= request.getAttribute("error") %></p>
    <% } %>

    <p>Don't have an account? <a href="<%= request.getContextPath() %>/SellerSignup.jsp">Register</a></p>
</div>

</body>
</html>
