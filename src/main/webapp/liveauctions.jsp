<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Live Auctions | NextAuction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #0d1117, #161b22);
            color: #fff;
            font-family: 'Poppins', sans-serif;
        }

        .container {
            max-width: 900px;
            margin-top: 50px;
        }

        h2 {
            text-align: center;
            color: #00bfff;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .card {
            background: rgba(255,255,255,0.08);
            border: none;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0,0,0,0.3);
            color: #fff;
        }

        .card img {
            border-radius: 10px 10px 0 0;
            height: 180px;
            object-fit: cover;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #00bfff;
        }

        .back-btn:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>🔥 Live Auctions</h2>

    <div class="row g-3">
        <!-- Example static cards (replace with dynamic DB data later) -->
        <div class="col-md-4">
            <div class="card">
                <img src="https://via.placeholder.com/300x180?text=Car" alt="Auction Item">
                <div class="card-body">
                    <h5>Luxury Car</h5>
                    <p>Starting Price: ₹2,00,000</p>
                    <p>Ends in: 2 hours</p>
                    <button class="btn btn-primary w-100">Place Bid</button>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card">
                <img src="https://via.placeholder.com/300x180?text=Laptop" alt="Auction Item">
                <div class="card-body">
                    <h5>Gaming Laptop</h5>
                    <p>Starting Price: ₹80,000</p>
                    <p>Ends in: 4 hours</p>
                    <button class="btn btn-primary w-100">Place Bid</button>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card">
                <img src="https://via.placeholder.com/300x180?text=Watch" alt="Auction Item">
                <div class="card-body">
                    <h5>Smart Watch</h5>
                    <p>Starting Price: ₹5,000</p>
                    <p>Ends in: 1 hour</p>
                    <button class="btn btn-primary w-100">Place Bid</button>
                </div>
            </div>
        </div>
    </div>

    <a href="SellerDashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>
</div>

</body>
</html>
