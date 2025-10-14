<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <style>
        body { 
            background-color: #fff;
            font-family: Arial;
        }
        .login-container {
            width: 340px;
            margin: 130px auto;
            padding: 35px;
            background-color: white;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.2);
            border-radius: 8px;
        }
        h2 { text-align: center; margin-bottom: 25px; }
        input[type=text], input[type=password], select {
            width: 100%;
            padding: 10px;
            margin: 7px 0 15px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type=submit] {
            width: 100%;
            background-color: #0078d7;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 15px;
        }
        input[type=submit]:hover {
            background-color: #005ea3;
        }
    </style>
</head>

<body>

    <div class="login-container">
        <h2>Login</h2>

        <form action="LoginServlet" method="post">
            <label>Username</label>
            <input type="text" name="username" placeholder="Enter username" required>

            <label>Password</label>
            <input type="password" name="password" placeholder="Enter password" required>

            <label>Type of User</label>
            <select name="usertype" required>
                <option value="">-- Select --</option>
                <option value="Bidder">Bidder</option>
                <option value="Seller">Seller</option>
                <option value="Admin">Admin</option>
            </select>

            <input type="submit" value="Login">
        </form>

        <%
            String uname = request.getParameter("username");
            String pass = request.getParameter("password");
            String utype = request.getParameter("usertype");

            if (uname != null && pass != null && utype != null) {
                out.println("<br>Username: " + uname);
                out.println("<br>Password: " + pass);
                out.println("<br>User Type: " + utype);
            }
        %>

    </div>

</body>
</html>
