<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register | Online Auction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #0d1117;
            color: #c9d1d9;
            font-family: 'Segoe UI', sans-serif;
        }
        .register-container {
            max-width: 480px;
            margin: 60px auto;
            background-color: #161b22;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.4);
            border: 1px solid #30363d;
        }
        .btn-register {
            background-color: #238636;
            color: white;
        }
        .btn-register:hover {
            background-color: #2ea043;
        }
        a {
            color: #58a6ff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .text-error {
            color: #ff6b6b;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="register-container">
    <h3 class="text-center mb-4">📝 Register Account</h3>

    <form action="Register" method="post">
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" class="form-control" name="name" placeholder="Enter full name" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="email" placeholder="Enter email" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" class="form-control" name="password" placeholder="Enter password" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Role</label>
            <select class="form-select" name="role" required>
                <option value="seller">Seller</option>
                <option value="bidder">Bidder</option>
            </select>
        </div>

        <% if (request.getParameter("error") != null) { %>
            <p class="text-error">⚠️ Registration failed: <%= request.getParameter("error") %></p>
        <% } else if (request.getParameter("success") != null) { %>
            <p class="text-success">✅ Registration successful! <a href="login.jsp">Login now</a></p>
        <% } %>

        <div class="d-grid mt-3">
            <button type="submit" class="btn btn-register">Register</button>
        </div>
    </form>

    <hr class="my-4" style="border-color:#30363d;">
    <p class="text-center small">Already have an account? <a href="login.jsp">Login</a></p>
</div>

</body>
</html>
