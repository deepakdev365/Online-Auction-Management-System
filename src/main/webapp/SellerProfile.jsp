<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="nextauction.model.Seller" %>
<%
    HttpSession sessionObj = request.getSession(false);
    Seller seller = (Seller) sessionObj.getAttribute("seller");

    if (seller == null) {
        response.sendRedirect("SellerLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile | NextAuction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
        }

        .sidebar {
            height: 100vh;
            width: 240px;
            background-color: #0d6efd;
            color: white;
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .sidebar h3 {
            font-weight: 700;
            margin-bottom: 40px;
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

        h2 {
            color: #0d6efd;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .profile-card {
            background: #fff;
            border: 1px solid #dee2e6;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            max-width: 750px;
            margin: auto;
        }

        .profile-pic {
            text-align: center;
            margin-bottom: 25px;
        }

        .profile-pic img {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #0d6efd;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        label {
            font-weight: 500;
        }

        .btn-save {
            background-color: #28a745;
            color: white;
            border: none;
        }

        .btn-save:hover {
            background-color: #218838;
        }

        .upload-label {
            color: #0d6efd;
            font-weight: 500;
            cursor: pointer;
        }

        input[type="file"] {
            display: none;
        }
    </style>
</head>

<body>

    <!-- 🔹 SIDEBAR -->
    <div class="sidebar">
        <h3>NextAuction</h3>
        <p>👋 Hello, <strong><%= seller.getFullName() %></strong></p>
        <hr style="width:80%; opacity:0.3;">

        <a href="SellerDashboard.jsp">🏠 Dashboard</a>
        <a href="SellerProfile.jsp" class="active">👤 My Profile</a>
        <a href="additem.jsp">🛒 Add Item</a>
        <a href="liveauctions.jsp">🔥 Live Auctions</a>
        <a href="winners.jsp">🏆 Winners</a>

        <form action="logout.jsp" method="post" class="w-100 d-flex justify-content-center">
            <button type="submit" class="logout-btn">🚪 Logout</button>
        </form>
    </div>

    <!-- 🔹 MAIN CONTENT -->
    <div class="content">
        <h2>My Profile</h2>
        <div class="profile-card">
            <form action="UpdateSellerServlet" method="post" enctype="multipart/form-data">

                <!-- 🔹 Profile Picture -->
                <div class="profile-pic">
                    <img id="profilePreview" src="<%= (seller.getProfileImage() != null && !seller.getProfileImage().isEmpty()) ? seller.getProfileImage() : "https://via.placeholder.com/130" %>" alt="Profile Picture">
                    <div class="mt-2">
                        <label for="profileImage" class="upload-label">📁 Upload New Picture</label>
                        <input type="file" id="profileImage" name="profile_image" accept="image/*" onchange="previewImage(event)">
                    </div>
                </div>

                <!-- 🔹 Profile Info -->
                <div class="row g-3">
                    <div class="col-md-6">
                        <label>Full Name</label>
                        <input type="text" class="form-control" name="full_name" value="<%= seller.getFullName() %>" required>
                    </div>

                    <div class="col-md-6">
                        <label>Father's Name</label>
                        <input type="text" class="form-control" name="father_name" value="<%= seller.getFatherName() %>">
                    </div>

                    <div class="col-md-6">
                        <label>Email</label>
                        <input type="email" class="form-control" name="email" value="<%= seller.getEmail() %>" readonly>
                    </div>

                    <div class="col-md-6">
                        <label>Phone Number</label>
                        <input type="text" class="form-control" name="phone" value="<%= seller.getPhone() %>">
                    </div>

                    <div class="col-md-6">
                        <label>Company Name</label>
                        <input type="text" class="form-control" name="company_name" value="<%= seller.getCompanyName() %>">
                    </div>

                    <div class="col-md-6">
                        <label>Company Location</label>
                        <input type="text" class="form-control" name="company_location" value="<%= seller.getCompanyLocation() %>">
                    </div>

                    <div class="col-12">
                        <label>Address</label>
                        <textarea class="form-control" name="address" rows="2"><%= seller.getAddress() %></textarea>
                    </div>
                </div>

                <div class="mt-4 text-end">
                    <button type="submit" class="btn btn-save">💾 Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // ✅ Preview uploaded profile image
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function(){
                document.getElementById('profilePreview').src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
</body>
</html>
