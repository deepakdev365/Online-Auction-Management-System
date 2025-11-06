<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bidder Login | NextAuction</title>
    <style>
        body {
            background: linear-gradient(135deg, #0a1222, #050914);
            color: #fff;
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background: rgba(255,255,255,0.1);
            padding: 35px 40px;
            border-radius: 12px;
            box-shadow: 0 0 25px rgba(0, 170, 255, 0.25);
            width: 350px;
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
            border-radius: 6px;
            border: none;
            outline: none;
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
            margin-top: 12px;
            font-size: 14px;
        }

        a {
            color: #00ccff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .error-msg {
            color: #ff4d4d;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Bidder Login</h2>

    <!-- ✅ Corrected: Form points to servlet via context path -->
    <form action="<%= request.getContextPath() %>/BidderLoginServlet" method="post">
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>

    <!-- ✅ Error Message Display -->
    <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg"><%= request.getAttribute("error") %></p>
    <% } %>

    <p>Don't have an account? <a href="bidderregister.jsp">Register</a></p>
</div>

</body>
</html>
