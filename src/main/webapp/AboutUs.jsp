<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>About Us - Online Auction</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(120deg, #a8edea, #fed6e3);
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            background: #fff;
            width: 60%;
            max-width: 700px;
            border-radius: 30px;
            box-shadow: 0 8px 28px rgba(99,102,241,0.12), 0 1.5px 10px rgba(0,0,0,0.09);
            padding: 48px 44px;
            text-align: center;
            animation: fadeIn 1.2s;
        }
        .card h1 {
            color: #34495e;
            font-size: 2.4rem;
            margin-bottom: 24px;
            font-weight: 600;
        }
        .card p {
            font-size: 1.18rem;
            color: #374151;
            margin-bottom: 18px;
            line-height: 1.7;
        }
        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(40px);}
            to {opacity: 1; transform: translateY(0);}
        }
    </style>
</head>
<body>
<div class="card">
    <h1>About Online Auction</h1>
    <p>
        Welcome to <strong>Online Auction</strong> — your trusted platform for buying and selling unique items with security and transparency.
    </p>
    <p>
        Our goal is to deliver seamless auctions powered by real-time bidding, safe transactions, and a user-friendly interface.
    </p>
    <p>
        This project is crafted using Java, JSP, and Servlets, showcasing essential web development and database principles.
    </p>
</div>
</body>
</html>
