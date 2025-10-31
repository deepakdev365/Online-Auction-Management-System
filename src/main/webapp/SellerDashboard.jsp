<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("sellerName") == null) {
        response.sendRedirect("SellerLogin.jsp");
        return;
    }
    String sellerName = (String) sessionObj.getAttribute("sellerName");
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
            background: linear-gradient(135deg, #0d1117, #161b22);
            color: #fff;
            font-family: 'Poppins', sans-serif;
        }

        .navbar {
            background: #007bff;
            padding: 15px;
        }

        .navbar-brand {
            font-weight: 600;
            color: #fff !important;
        }

        .nav-link {
            color: #eaeaea !important;
            font-weight: 500;
            margin-right: 15px;
        }

        .nav-link:hover {
            color: #fff !important;
            text-decoration: underline;
        }

        .logout-btn {
            background: #ff4d4d;
            color: #fff;
            border: none;
            padding: 7px 15px;
            border-radius: 6px;
            font-weight: 500;
        }

        .logout-btn:hover {
            background: #e63e3e;
        }

        .container {
            max-width: 1100px;
            margin-top: 50px;
        }

        h2 {
            color: #00bfff;
            font-weight: 600;
            text-align: center;
        }

        .card {
            background: rgba(255,255,255,0.08);
            border: none;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 0 12px rgba(0,0,0,0.2);
            transition: transform 0.3s ease;
            text-align: center;
        }

        .card:hover {
            transform: translateY(-6px);
            background: rgba(255,255,255,0.12);
        }

        .card h4 {
            color: #00bfff;
            margin-bottom: 10px;
        }

        .card p {
            color: #ccc;
        }

        .btn-primary {
            background: #00bfff;
            border: none;
        }

        .btn-primary:hover {
            background: #0099cc;
        }
    </style>
</head>

<body>
    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">NextAuction</a>
            <div class="d-flex align-items-center ms-auto">
                <span class="me-3">Welcome, <strong><%= sellerName %></strong></span>
                <form action="logout.jsp" method="post" class="m-0">
                    <button type="submit" class="logout-btn">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <div class="container text-center">
        <h2>Seller Dashboard</h2>
        <p class="mt-3">Manage your auction items, track live bids, and view winners.</p>

        <div class="row mt-5 g-4">
            <div class="col-md-4">
                <div class="card">
                    <h4>🛒 Add Item</h4>
                    <p>Upload your products for auction.</p>
                    <a href="additem.jsp" class="btn btn-primary">Add New</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card">
                    <h4>🔥 Live Auctions</h4>
                    <p>See all your active auctions in real time.</p>
                    <a href="liveauctions.jsp" class="btn btn-primary">View Live</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card">
                    <h4>🏆 Winners</h4>
                    <p>Check the auction results and winners.</p>
                    <a href="winners.jsp" class="btn btn-primary">View Winners</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
