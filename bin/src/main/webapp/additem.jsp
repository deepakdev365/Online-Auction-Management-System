<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Auction Item | NextAuction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #0d1117, #161b22);
            color: #fff;
            font-family: 'Poppins', sans-serif;
        }

        .container {
            max-width: 600px;
            margin-top: 70px;
            background: rgba(255,255,255,0.08);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0,0,0,0.3);
        }

        h2 {
            text-align: center;
            color: #00bfff;
            font-weight: 600;
            margin-bottom: 25px;
        }

        label {
            color: #ddd;
        }

        .btn-submit {
            background-color: #00bfff;
            color: #fff;
            border: none;
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
        }

        .btn-submit:hover {
            background-color: #0099cc;
        }

        a.back {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #00bfff;
            text-decoration: none;
        }

        a.back:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Add New Auction Item</h2>

    <form action="AddItemServlet" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label>Item Title</label>
            <input type="text" name="title" class="form-control" placeholder="Enter item title" required>
        </div>

        <div class="mb-3">
            <label>Starting Price (₹)</label>
            <input type="number" name="start_price" class="form-control" placeholder="Enter starting price" required>
        </div>

        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control" rows="3" placeholder="Enter item description" required></textarea>
        </div>

        <div class="mb-3">
            <label>End Time</label>
            <input type="datetime-local" name="end_time" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Upload Image</label>
            <input type="file" name="image" class="form-control" accept="image/*" required>
        </div>

        <button type="submit" class="btn-submit">Add Item</button>
    </form>

    <a href="SellerDashboard.jsp" class="back">⬅ Back to Dashboard</a>
</div>

</body>
</html>
