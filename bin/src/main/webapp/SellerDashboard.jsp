<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("sellerName") == null) {
        response.sendRedirect("sellerlogin.jsp");
        return;
    }

    String sellerName = (String) sessionObj.getAttribute("sellerName");
    String profileImage = (String) sessionObj.getAttribute("profileImage");

    // Default placeholder if no image uploaded
    if (profileImage == null || profileImage.isEmpty()) {
        profileImage = "https://via.placeholder.com/100";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Seller Dashboard | NextAuction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
        }

        /* Sidebar */
        .sidebar {
            height: 100vh;
            width: 240px;
            background-color: #0d6efd;
            color: white;
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .profile-pic {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            border: 3px solid #fff;
            object-fit: cover;
            margin-bottom: 10px;
        }

        .seller-name {
            font-weight: 600;
            color: #fff;
            margin-bottom: 15px;
        }

        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            width: 90%;
            border-radius: 8px;
            margin: 5px 0;
            text-align: left;
            transition: 0.3s;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: #0b5ed7;
        }

        .logout-btn {
            margin-top: auto;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 10px 20px;
            width: 90%;
            margin-bottom: 30px;
            transition: 0.3s;
        }

        .logout-btn:hover {
            background: #c82333;
        }

        .content {
            margin-left: 260px;
            padding: 40px;
        }

        .card {
            background: #fff;
            border: 1px solid #dee2e6;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            text-align: center;
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }

        .card h4 {
            color: #0d6efd;
            font-weight: 600;
        }
    </style>
</head>

<body>

    <!-- 🔹 SIDEBAR -->
    <div class="sidebar">
        <img src="<%= profileImage %>" class="profile-pic" alt="Profile Image">
        <p class="seller-name">👋 <%= sellerName %></p>
        <hr style="width:80%; opacity:0.3;">

        <a href="SellerProfile.jsp">👤 My Profile</a>
        <a href="additem.jsp">🛒 Add Item</a>
        <a href="liveauctions.jsp">🔥 Live Auctions</a>
        <a href="winners.jsp">🏆 Winners</a>

        <form action="logout.jsp" method="post" class="w-100 d-flex justify-content-center">
            <button type="submit" class="logout-btn">🚪 Logout</button>
        </form>
    </div>

    <!-- 🔹 MAIN CONTENT -->
    <div class="content">
        <h2 class="text-primary mb-3">Seller Dashboard</h2>
        <p class="text-muted mb-4">Manage your auctions, monitor live bids, and view winners easily.</p>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="card">
                    <h4>🛒 Add Item</h4>
                    <p>Upload and manage items for auction.</p>
                    <a href="additem.jsp" class="btn btn-primary w-100">Add Item</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card">
                    <h4>🔥 Live Auctions</h4>
                    <p>View and track your active auctions.</p>
                    <a href="liveauctions.jsp" class="btn btn-primary w-100">View Live Auctions</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card">
                    <h4>🏆 Winners</h4>
                    <p>Check your completed auction results.</p>
                    <a href="winners.jsp" class="btn btn-primary w-100">View Winners</a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
