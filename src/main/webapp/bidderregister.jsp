<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Bidder Registration | NextAuction</title>
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #0a1222, #050914);
        color: #fff;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .register-container {
        background: rgba(255,255,255,0.1);
        padding: 35px 40px;
        border-radius: 12px;
        width: 400px;
        box-shadow: 0 0 25px rgba(0,170,255,0.25);
        text-align: center;
    }

    h2 {
        color: #00aaff;
        margin-bottom: 20px;
        font-weight: 600;
    }

    input {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        border: none;
        border-radius: 6px;
        background: rgba(255,255,255,0.15);
        color: #fff;
        font-size: 15px;
    }

    input::placeholder {
        color: #ccc;
    }

    button {
        background: linear-gradient(135deg, #00aaff, #007acc);
        border: none;
        color: #fff;
        padding: 10px 20px;
        border-radius: 6px;
        width: 100%;
        font-weight: bold;
        cursor: pointer;
        transition: 0.3s;
    }

    button:hover {
        background: #00ccff;
        transform: scale(1.03);
    }

    p {
        margin-top: 10px;
        font-size: 14px;
    }

    a {
        color: #00ccff;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    .error {
        color: #ff4444;
        font-size: 14px;
        margin-top: 5px;
    }

    .success {
        color: #00ff99;
        font-size: 14px;
    }
</style>
</head>
<body>

<div class="register-container">
    <h2>Bidder Registration</h2>

    <form action="BidderRegisterServlet" method="post">
        <input type="text" name="fullname" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="tel" name="phone" placeholder="Phone Number" pattern="[0-9]{10}" maxlength="10" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="password" name="confirm_password" placeholder="Confirm Password" required>
        <button type="submit">Register</button>
    </form>

    <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } else if (request.getAttribute("success") != null) { %>
        <p class="success"><%= request.getAttribute("success") %></p>
    <% } %>

    <p>Already have an account? <a href="bidderlogin.jsp">Login</a></p>
</div>

</body>
</html>
