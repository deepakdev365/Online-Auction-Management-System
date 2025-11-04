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
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile | NextAuction</title>
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #f7f9fc;
            color: #333;
        }

        nav {
            background-color: #ffffff;
            border-bottom: 1px solid #e0e0e0;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .logo {
            font-size: 22px;
            font-weight: bold;
            color: #007bff;
        }

        .nav-links a {
            color: #333;
            text-decoration: none;
            margin: 0 12px;
            font-weight: 500;
        }

        .nav-links a:hover {
            color: #007bff;
        }

        .logout-btn {
            background: #ff4d4d;
            color: white;
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
        }

        .logout-btn:hover {
            background: #e63e3e;
        }

        .container {
            max-width: 700px;
            margin: 60px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
        }

        h2 {
            color: #007bff;
            margin-bottom: 20px;
        }

        .info {
            font-size: 18px;
            margin-bottom: 15px;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            background: #007bff;
            color: #fff;
            padding: 10px 16px;
            border-radius: 6px;
            text-decoration: none;
        }

        .back-btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

    <nav>
        <div class="logo">NextAuction</div>
        <div class="nav-links">
            <a href="bidderdashboard.jsp">Home</a>
            <a href="liveauctions.jsp">Live Auctions</a>
            <a href="mybids.jsp">My Bids</a>
            <a href="profile.jsp" style="color:#007bff;">Profile</a>
        </div>
        <form action="logout.jsp" method="post" style="margin:0;">
            <button class="logout-btn">Logout</button>
        </form>
    </nav>

    <div class="container">
        <h2>👤 My Profile</h2>
        <div class="info"><strong>Name:</strong> <%= bidderName %></div>
        <div class="info"><strong>Email:</strong> <%= bidderEmail != null ? bidderEmail : "Not Available" %></div>
        <div class="info"><strong>Mobile:</strong> <%= bidderMobile != null ? bidderMobile : "Not Available" %></div>
        <div class="info"><strong>Account Type:</strong> Bidder</div>

        <a href="bidderdashboard.jsp" class="back-btn">← Back to Dashboard</a>
    </div>

</body>
</html>
