<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="nextauction.model.Bidder" %>
<%
    // ✅ Session validation
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("bidder") == null) {
        response.sendRedirect("bidderlogin.jsp");
        return;
    }

    Bidder bidder = (Bidder) sessionObj.getAttribute("bidder");
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
        .profile-wrapper {
            background: #fff;
            max-width: 500px;
            margin: 50px auto;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            font-family: 'Poppins', sans-serif;
            text-align: center;
        }

        .profile-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #007bff;
        }

        .edit-btn {
            position: relative;
            top: -35px;
            left: 40px;
            background: #007bff;
            color: white;
            border-radius: 50%;
            padding: 5px 8px;
            cursor: pointer;
            font-size: 14px;
        }

        .profile-form input, .profile-form select {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
        }

        .save-btn {
            background: #007bff;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 10px;
            margin-top: 20px;
            width: 100%;
            cursor: pointer;
            font-weight: 600;
            transition: 0.3s;
        }

        .save-btn:hover {
            background: #0056b3;
        }

        .profile-form label {
            display: block;
            text-align: left;
            font-weight: 600;
            margin-top: 10px;
        }
    </style>

    <script>
        function showSection(section) {
            document.querySelectorAll('.section').forEach(sec => sec.style.display = 'none');
            document.getElementById(section).style.display = 'block';
        }

        function previewImage(event) {
            const img = document.getElementById('profilePreview');
            img.src = URL.createObjectURL(event.target.files[0]);
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
    
            <!-- 🔍 Search Bar -->
        <form class="search-bar" action="SearchAuctionServlet" method="get">
            <input type="text" name="query" placeholder="Search auction items..." required>
            <button type="submit">Search</button>
        </form>
    

        <!-- Home Section -->
        <div id="homeSection" class="section" style="display:block;">
            <h2>Welcome, <%= bidder.getFullName() %> 👋</h2>
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
        <div id="profileSection" class="section" style="display:none;">
            <div class="profile-wrapper">
                <form action="ProfileUploadServlet" method="post" enctype="multipart/form-data" class="profile-form">
                    <div style="position: relative; display: inline-block;">
                        <img id="profilePreview"
                            class="profile-img"
                            src="<%= bidder.getDisplayProfileImage() %>"
                            alt="Profile Picture">
                        <label for="profileImage" class="edit-btn">✎</label>
                        <input type="file" name="profileImage" id="profileImage" accept="image/*" style="display:none;" onchange="previewImage(event)">
                    </div>

                    <h2 style="color:#007bff;">Edit Profile</h2>

                    <label>Full Name</label>
                    <input type="text" name="firstName" value="<%= bidder.getFullName() %>" placeholder="Full Name">

                    <label>Email</label>
                    <input type="email" name="email" value="<%= bidder.getEmail() %>" required>

                    <label>Phone</label>
                    <input type="tel" name="phone" value="<%= bidder.getPhone() %>" required>

                    <label>Birth Date</label>
                    <input type="date" name="birthDate" value="<%= bidder.getBirthDate() != null ? bidder.getBirthDate().toString() : "" %>">

                    <label>Gender</label>
                    <select name="gender">
                        <option value="">Select Gender</option>
                        <option value="Male" <%= "Male".equalsIgnoreCase(bidder.getGender()) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equalsIgnoreCase(bidder.getGender()) ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= "Other".equalsIgnoreCase(bidder.getGender()) ? "selected" : "" %>>Other</option>
                    </select>

                    <label>Address</label>
                    <input type="text" name="address" value="<%= bidder.getAddress() != null ? bidder.getAddress() : "" %>" placeholder="Your Address">

                    <button type="submit" class="save-btn">💾 Save Changes</button>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
