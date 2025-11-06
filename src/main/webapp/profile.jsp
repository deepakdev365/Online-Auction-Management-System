<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("bidderName") == null) {
        response.sendRedirect("bidderlogin.jsp");
        return;
    }

    String bidderName = (String) sessionObj.getAttribute("bidderName");
    String bidderEmail = (String) sessionObj.getAttribute("bidderEmail");
    String bidderMobile = (String) sessionObj.getAttribute("bidderMobile");
    String bidderAddress = (String) sessionObj.getAttribute("bidderAddress");
    String bidderGender = (String) sessionObj.getAttribute("bidderGender");
    String bidderBirthDate = (String) sessionObj.getAttribute("bidderBirthDate");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile | NextAuction</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #007bff, #00c6ff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .profile-card {
            background: #fff;
            width: 470px;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            overflow: hidden;
            text-align: center;
            padding: 30px;
        }

        .profile-header {
            position: relative;
            margin-bottom: 20px;
        }

        .profile-header img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 5px solid #007bff;
            object-fit: cover;
        }

        .edit-icon {
            position: absolute;
            bottom: 10px;
            right: 140px;
            background: #007bff;
            color: #fff;
            border-radius: 50%;
            padding: 6px;
            cursor: pointer;
        }

        h2 {
            color: #007bff;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
            align-items: center;
        }

        input[type="text"], input[type="email"], input[type="tel"], select, input[type="date"] {
            width: 80%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
            transition: border-color 0.3s;
        }

        input:focus, select:focus {
            border-color: #007bff;
        }

        .save-btn {
            background: #007bff;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: 0.3s;
        }

        .save-btn:hover {
            background: #0056b3;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
        }

        .back-btn:hover {
            text-decoration: underline;
        }

        .success-message {
            color: #28a745;
            margin-bottom: 10px;
        }

        .error-message {
            color: #dc3545;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <div class="profile-card">
        <div class="profile-header">
            <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile Photo">
            <span class="edit-icon">✎</span>
        </div>

        <h2>👤 Edit Profile</h2>

        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="success-message"><%= request.getAttribute("successMessage") %></div>
        <% } %>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
        <% } %>

        <form action="UpdateProfileServlet" method="post">
            <input type="text" name="name" value="<%= bidderName %>" placeholder="Full Name" required>
            <input type="email" name="email" value="<%= bidderEmail %>" placeholder="Email Address" required>
            <input type="tel" name="mobile" value="<%= bidderMobile %>" placeholder="Mobile Number" required>
            <input type="text" name="address" value="<%= bidderAddress != null ? bidderAddress : "" %>" placeholder="Address">

            <!-- ✅ Gender Dropdown -->
            <select name="gender" required>
                <option value="">Select Gender</option>
                <option value="Male" <%= "Male".equalsIgnoreCase(bidderGender) ? "selected" : "" %>>Male</option>
                <option value="Female" <%= "Female".equalsIgnoreCase(bidderGender) ? "selected" : "" %>>Female</option>
                <option value="Other" <%= "Other".equalsIgnoreCase(bidderGender) ? "selected" : "" %>>Other</option>
            </select>

            <!-- ✅ Birth Date -->
            <input type="date" name="birthDate" value="<%= bidderBirthDate != null ? bidderBirthDate : "" %>">

            <button type="submit" class="save-btn">💾 Save Changes</button>
        </form>

        <a href="bidderdashboard.jsp" class="back-btn">← Back to Dashboard</a>
    </div>

</body>
</html>
