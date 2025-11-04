<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Winners | NextAuction</title>
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
            color: #ffc107;
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
            color: #ffc107;
        }

        .back-btn:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>🏆 Auction Winners</h2>

    <div class="row g-3">
        <!-- Example static cards (replace with DB data later) -->
        <div class="col-md-4">
            <div class="card">
                <img src="https://via.placeholder.com/300x180?text=Phone" alt="Item">
                <div class="card-body">
                    <h5>iPhone 14 Pro</h5>
                    <p>Winner: <strong>Rajendra Pahan</strong></p>
                    <p>Final Bid: ₹1,20,000</p>
                    <p>Ended: 28 Oct 2025</p>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card">
                <img src="https://via.placeholder.com/300x180?text=Painting" alt="Item">
                <div class="card-body">
                    <h5>Vintage Painting</h5>
                    <p>Winner: <strong>Jyoti Kumari</strong></p>
                    <p>Final Bid: ₹75,000</p>
                    <p>Ended: 27 Oct 2025</p>
                </div>
            </div>
        </div>
    </div>

    <a href="SellerDashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>
</div>

</body>
</html>
