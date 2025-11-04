<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>FAQ - Online Auction</title>
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
            width: 65%;
            max-width: 740px;
            border-radius: 30px;
            box-shadow: 0 8px 28px rgba(99,102,241,0.12), 0 1.5px 10px rgba(0,0,0,0.09);
            padding: 54px 48px;
            animation: fadeIn 1.2s;
        }
        h1 {
            color: #34495e;
            font-size: 2.3rem;
            margin-bottom: 28px;
            font-weight: 600;
            text-align: center;
        }
        .faq-item {
            background: #f5f8fc;
            border-radius: 13px;
            margin-bottom: 20px;
            padding: 18px 23px;
            box-shadow: 0 1.5px 7px rgba(99,102,241,0.055);
        }
        .faq-item h2 {
            color: #6366f1;
            font-size: 1.18rem;
            margin: 0 0 10px 0;
            font-weight: 600;
        }
        .faq-item p {
            font-size: 1rem;
            color: #374151;
            margin: 0;
        }
        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(40px);}
            to {opacity: 1; transform: translateY(0);}
        }
    </style>
</head>
<body>
<div class="card">
    <h1>Frequently Asked Questions</h1>
    <div class="faq-item">
        <h2>How do I participate in an auction?</h2>
        <p>Simply register, log in, browse auctions, and start bidding!</p>
    </div>
    <div class="faq-item">
        <h2>Is my payment information secure?</h2>
        <p>Yes, we use secure encryption and trusted payment gateways.</p>
    </div>
    <div class="faq-item">
        <h2>Can I sell my own items?</h2>
        <p>Of course! Once verified, you can list your products for auction.</p>
    </div>
</div>
</body>
</html>
