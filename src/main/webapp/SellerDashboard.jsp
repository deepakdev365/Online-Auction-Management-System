<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.net.*" %>
<%
    // ✅ Logout handler
    if (request.getParameter("logout") != null) {
        session.invalidate();
        response.sendRedirect("login.jsp");
        return;
    }

    // ✅ Ensure seller is logged in
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    int sellerId = (int) session.getAttribute("sellerId");

    // ✅ Auto update auction status
    try {
        URL url = new URL(request.getScheme() + "://" + 
                request.getServerName() + ":" + request.getServerPort() + 
                request.getContextPath() + "/UpdateAuctionStatusServlet");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.getResponseCode(); // triggers silently
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Seller Dashboard | Online Auction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar {
            background: linear-gradient(90deg, #007bff, #00b4d8);
        }
        .navbar-brand {
            font-weight: 700;
            color: white !important;
        }
        .nav-link {
            color: white !important;
            font-weight: 500;
        }
        .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 8px;
        }
        .card {
            background: #fff;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .section {
            display: none;
        }
        .visible {
            display: block;
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
            border-radius: 6px;
        }
        .btn-custom:hover {
            background-color: #0069d9;
        }
        .badge {
            font-size: 0.9em;
            padding: 6px 10px;
        }
    </style>
</head>
<body>

<!-- ===== NAVBAR ===== -->
<nav class="navbar navbar-expand-lg navbar-dark px-3">
    <a class="navbar-brand" href="#">💼 Online Auction</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navMenu">
        <ul class="navbar-nav ms-auto">
            <li class="nav-item"><a href="#" class="nav-link active" onclick="showSection('profileSection', this)">Profile</a></li>
            <li class="nav-item"><a href="#" class="nav-link" onclick="showSection('addItemSection', this)">Add Item</a></li>
            <li class="nav-item"><a href="#" class="nav-link" onclick="showSection('myAuctionSection', this)">My Auctions</a></li>
            <li class="nav-item"><a href="#" class="nav-link" onclick="showSection('winnerSection', this)">Winners</a></li>
            <li class="nav-item">
                <form method="post" style="display:inline;">
                    <button type="submit" name="logout" class="btn btn-link nav-link text-warning" style="text-decoration:none;">🚪 Logout</button>
                </form>
            </li>
        </ul>
    </div>
</nav>

<!-- ===== PAGE CONTENT ===== -->
<div class="container py-4">

    <!-- PROFILE SECTION -->
    <div id="profileSection" class="section visible">
        <div class="card p-4">
            <h3 class="text-primary mb-3">👤 My Profile</h3>
            <p><b>Name:</b> <%= name %></p>
            <p><b>Email:</b> <%= email %></p>
            <p><b>Role:</b> <%= role %></p>
        </div>
    </div>

    <!-- ADD ITEM SECTION -->
    <div id="addItemSection" class="section">
        <h3 class="text-success mb-3">🛒 Add New Auction Item</h3>
        <form action="AddItemServlet" method="post" enctype="multipart/form-data" class="card p-4">
            <div class="row">
                <div class="col-md-6 mb-2">
                    <label class="form-label">Title</label>
                    <input type="text" class="form-control" name="title" required>
                </div>

                <!-- ✅ CATEGORY DROPDOWN -->
                <div class="col-md-6 mb-2">
                    <label class="form-label">Category</label>
                    <select class="form-select" name="category" required>
                        <option value="">-- Select Category --</option>
                        <option value="Electronics">Electronics</option>
                        <option value="Furniture">Furniture</option>
                        <option value="Fashion">Fashion</option>
                        <option value="Books">Books</option>
                        <option value="Vehicles">Vehicles</option>
                        <option value="Art">Art & Collectibles</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label">Starting Price</label>
                    <input type="number" class="form-control" name="start_price" required step="0.01">
                </div>

                <div class="col-12 mb-2">
                    <label class="form-label">Description</label>
                    <textarea class="form-control" name="description" rows="3"></textarea>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label">Start Time</label>
                    <input type="datetime-local" class="form-control" name="start_time">
                </div>
                <div class="col-md-6 mb-2">
                    <label class="form-label">End Time</label>
                    <input type="datetime-local" class="form-control" name="end_time" required>
                </div>

                <div class="col-12 mb-3">
                    <label class="form-label">Upload Image</label>
                    <input type="file" class="form-control" name="image" accept="image/*">
                </div>

                <div class="text-end">
                    <button type="submit" class="btn btn-custom px-4">Add Item</button>
                </div>
            </div>
        </form>
    </div>

    <!-- MY AUCTIONS SECTION -->
    <div id="myAuctionSection" class="section">
        <h3 class="mb-3 text-info">📦 My Auctions</h3>

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_auction", "root", "RJP279");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM auction_items WHERE seller_id=? ORDER BY id DESC");
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();

            boolean hasItems = false;
            while (rs.next()) {
                hasItems = true;
        %>
            <div class="card mb-3 p-3">
                <h5><%= rs.getString("title") %></h5>
                <p><b>Category:</b> <%= rs.getString("category") %></p>
                <p><b>Description:</b> <%= rs.getString("description") %></p>
                <p><b>Start Price:</b> ₹<%= rs.getDouble("start_price") %></p>
                <p><b>Status:</b>
                    <% String status = rs.getString("status");
                       if("Active".equalsIgnoreCase(status)){ %>
                           <span class="badge bg-success">Active</span>
                    <% } else if("Pending".equalsIgnoreCase(status)){ %>
                           <span class="badge bg-warning text-dark">Pending</span>
                    <% } else { %>
                           <span class="badge bg-danger">Ended</span>
                    <% } %>
                </p>
            </div>
        <%
            }
            if (!hasItems) {
        %>
            <p class="text-secondary">You haven’t added any items yet.</p>
        <%
            }
            rs.close();
            ps.close();
            con.close();
        %>
    </div>

    <!-- WINNERS SECTION -->
    <div id="winnerSection" class="section">
        <h3 class="text-danger mb-3">🏆 Auction Winners</h3>
        <iframe src="WinnersServlet" width="100%" height="500" style="border:none; border-radius:10px;"></iframe>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Section switching
    function showSection(id, el) {
        document.querySelectorAll('.section').forEach(s => s.classList.remove('visible'));
        document.getElementById(id).classList.add('visible');
        document.querySelectorAll('.nav-link').forEach(a => a.classList.remove('active'));
        el.classList.add('active');
        localStorage.setItem("activeSection", id);
    }

    // Keep last opened section active
    window.onload = () => {
        const savedSection = localStorage.getItem("activeSection");
        if (savedSection && document.getElementById(savedSection)) {
            document.querySelectorAll('.section').forEach(s => s.classList.remove('visible'));
            document.getElementById(savedSection).classList.add('visible');
            document.querySelectorAll('.nav-link').forEach(a => a.classList.remove('active'));
            document.querySelector(`.nav-link[onclick*="${savedSection}"]`).classList.add('active');
        }
    };
</script>
</body>
</html>
