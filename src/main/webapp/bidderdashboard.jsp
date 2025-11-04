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
    <title>Bidder Dashboard | NextAuction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: #ffffff;
            color: #333;
            display: flex;
        }

        /* Sidebar */
        .sidebar {
            width: 230px;
            background: #f7f9fc;
            height: 100vh;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            padding: 20px;
            position: fixed;
            left: 0;
            top: 0;
        }

        .logo {
            font-size: 22px;
            font-weight: bold;
            color: #007bff;
            text-align: center;
            margin-bottom: 40px;
        }

        .nav-links {
            display: flex;
            flex-direction: column;
        }

        .nav-links a, .nav-links button {
            color: #333;
            text-decoration: none;
            margin: 10px 0;
            font-weight: 500;
            padding: 10px 15px;
            border-radius: 6px;
            transition: 0.3s;
            text-align: left;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .nav-links a:hover, .nav-links button:hover {
            background: #007bff;
            color: #fff;
        }

        .logout-btn {
            background: #ff4d4d;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            margin-top: 20px;
        }

        .logout-btn:hover {
            background: #e63e3e;
        }

        /* Main content */
        .main-content {
            margin-left: 250px;
            padding: 40px;
            width: calc(100% - 250px);
        }

        h2 {
            color: #007bff;
            margin-bottom: 10px;
        }

        .cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            gap: 20px;
            margin-top: 40px;
        }

        .card {
            background: #f9f9f9;
            padding: 25px;
            width: 280px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-6px);
        }

        .card h3 {
            color: #007bff;
            margin-bottom: 10px;
        }

        .card a {
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
            cursor: pointer;
        }

        .card a:hover {
            text-decoration: underline;
        }

        /* Profile section */
        .profile-section {
            display: none;
            background: #f7f9fc;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 400px;
        }

        .profile-section.active {
            display: block;
        }

        .info {
            font-size: 16px;
            margin-bottom: 12px;
        }

    </style>

    <script>
        function showSection(section) {
            // Hide all sections
            document.querySelectorAll('.section').forEach(sec => sec.style.display = 'none');

            // Show selected
            document.getElementById(section).style.display = 'block';
        }
    </script>
</head>

<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">NextAuction</div>
        <div class="nav-links">
            <a href="#" onclick="showSection('homeSection')">🏠 Home</a>
            <a href="#" onclick="showSection('liveSection')">🔥 Live Auctions</a>
            <a href="#" onclick="showSection('bidsSection')">💰 My Bids</a>
            <a href="#" onclick="showSection('profileSection')">👤 Profile</a>

            <form action="logout.jsp" method="post">
                <button type="submit" class="logout-btn">🚪 Logout</button>
            </form>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">

        <!-- Home Section -->
        <div id="homeSection" class="section" style="display:block;">
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
            </div>
        </div>

        <!-- Live Auctions Section -->
        <div id="liveSection" class="section" style="display:none;">
            <h2>🔥 Live Auctions</h2>
            <p>Coming soon... show your live auction list here.</p>
        </div>

        <!-- My Bids Section -->
        <div id="bidsSection" class="section" style="display:none;">
            <h2>💰 My Bids</h2>
            <p>View and track all your bids here.</p>
        </div>

        <!-- Profile Section -->
        <div id="profileSection" class="section profile-section" style="display:none;">
            <h2>👤 My Profile</h2>
            <div class="info"><strong>Name:</strong> <%= bidderName %></div>
            <div class="info"><strong>Email:</strong> <%= bidderEmail != null ? bidderEmail : "Not Available" %></div>
            <div class="info"><strong>Mobile:</strong> <%= bidderMobile != null ? bidderMobile : "Not Available" %></div>
            <div class="info"><strong>Account Type:</strong> Bidder</div>
        </div>

    </div>

</body>
</html>
