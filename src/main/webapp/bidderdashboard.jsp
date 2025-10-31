<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("bidderName") == null) {
        response.sendRedirect("bidderlogin.jsp");
        return;
    }
    String bidderName = (String) sessionObj.getAttribute("bidderName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bidder Dashboard | NextAuction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            color: #fff;
        }

        nav {
            background: rgba(0, 0, 0, 0.5);
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }

        .logo {
            font-size: 22px;
            font-weight: bold;
            color: #00bfff;
        }

        .nav-links a {
            color: #f5f5f5;
            text-decoration: none;
            margin: 0 12px;
            font-weight: 500;
        }

        .nav-links a:hover {
            color: #00bfff;
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
            max-width: 1000px;
            margin: 50px auto;
            padding: 0 20px;
            text-align: center;
        }

        h2 {
            color: #00bfff;
            margin-bottom: 10px;
        }

        .cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 40px;
        }

        .card {
            background: rgba(255,255,255,0.1);
            padding: 25px;
            width: 280px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.3);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-6px);
            background: rgba(255,255,255,0.15);
        }

        .card h3 {
            color: #00bfff;
            margin-bottom: 10px;
        }

        .card p {
            color: #ddd;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .card a {
            color: #00bfff;
            text-decoration: none;
            font-weight: 500;
        }

        .card a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

    <nav>
        <div class="logo">NextAuction</div>
        <div class="nav-links">
            <a href="#">Home</a>
            <a href="#">Live Auctions</a>
            <a href="#">My Bids</a>
            <a href="#">Profile</a>
        </div>
        <form action="logout.jsp" method="post" style="margin:0;">
            <button class="logout-btn">Logout</button>
        </form>
    </nav>

    <div class="container">
        <h2>Welcome, <%= bidderName %> 👋</h2>
        <p>Get ready to explore and win your favorite auctions!</p>

        <div class="cards">
            <div class="card">
                <h3>🔥 Live Auctions</h3>
                <p>Join ongoing auctions and start bidding now.</p>
                <a href="#">Explore →</a>
            </div>

            <div class="card">
                <h3>💰 My Bids</h3>
                <p>Track your bids and check your current standings.</p>
                <a href="#">View Bids →</a>
            </div>

            <div class="card">
                <h3>👤 Profile</h3>
                <p>Update your information and manage your account.</p>
                <a href="#">Edit Profile →</a>
            </div>
        </div>
    </div>

</body>
</html>
