<%@ page import="nextauction.model.Seller" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Seller Profile</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #e9eafc 0%, #c4e0e5 100%);
            margin: 0;
            padding: 0;
        }
        .profile-card {
            max-width: 420px;
            margin: 70px auto;
            padding: 36px 44px 32px 44px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(197, 202, 233, 0.39);
            text-align: center;
        }
        .profile-icon {
            font-size: 65px;
            color: #3949ab;
            background: #e3e3fa;
            border-radius: 50%;
            padding: 18px;
            margin-bottom: 15px;
        }
        .profile-title {
            color: #283593;
            font-weight: 700;
            font-size: 29px;
            margin-bottom: 16px;
        }
        .profile-details {
            text-align: left;
            font-size: 18px;
            color: #444;
            margin-top: 15px;
        }
        .profile-details label {
            color: #283593;
            font-weight: 600;
            width: 120px;
            display: inline-block;
        }
        .back-link {
            display: block;
            margin-top: 30px;
            text-align: center;
            font-size: 16px;
            text-decoration: none;
            color: #3949ab;
            font-weight: 600;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="profile-card">
        <span class="material-icons profile-icon">person</span>
        <div class="profile-title">Seller Profile</div>
        <%
            Seller seller = (Seller) request.getAttribute("sellerProfile");
            if (seller != null) {
        %>
        <div class="profile-details">
            <div><label>Name:</label> <%= seller.getName() %></div>
            <div><label>Email:</label> <%= seller.getEmail() %></div>
            <div><label>Contact:</label> <%= seller.getContact() %></div>
            <div><label>Address:</label> <%= seller.getAddress() %></div>
        </div>
        <% } else { %>
            <div>Profile data not found.</div>
        <% } %>
        <a href="SellerDashboard" class="back-link">← Back to Dashboard</a>
    </div>
</body>
</html>
