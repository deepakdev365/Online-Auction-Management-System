<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us - Online Auction</title>
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
            max-width: 530px;
            border-radius: 30px;
            box-shadow: 0 8px 28px rgba(99,102,241,0.12), 0 1.5px 10px rgba(0,0,0,0.09);
            padding: 48px 44px;
            animation: fadeIn 1.2s;
        }
        h1 {
            color: #34495e;
            font-size: 2.1rem;
            margin-bottom: 20px;
            font-weight: 600;
            text-align: center;
        }
        label {
            display: block;
            margin-top: 20px;
            color: #263247;
            font-weight: 600;
            font-size: 1.04rem;
            text-align: left;
        }
        input, textarea {
            width: 100%;
            margin-top: 9px;
            padding: 13px 16px;
            border-radius: 11px;
            border: 1px solid #dde0e4;
            background: #f5f8fc;
            font-family: inherit;
            font-size: 1rem;
            transition: border 0.3s;
        }
        input:focus, textarea:focus {
            border: 1.5px solid #6366f1;
            outline: none;
        }
        button {
            margin-top: 28px;
            width: 100%;
            padding: 14px;
            background: linear-gradient(90deg, #6366f1 70%, #60dfcd 100%);
            border: none;
            border-radius: 13px;
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            letter-spacing: 1.1px;
            box-shadow: 0 2px 8px rgba(99,102,241,0.08);
            transition: background 0.3s;
        }
        button:hover {
            background: #34495e;
        }
        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(40px);}
            to {opacity: 1; transform: translateY(0);}
        }
    </style>
</head>
<body>
<div class="card">
    <h1>Contact Us</h1>
    <form action="ContactServlet" method="post" autocomplete="off">
        <label for="name">Name:</label>
        <input type="text" name="name" id="name" required>

        <label for="email">Email:</label>
        <input type="email" name="email" id="email" required>

        <label for="message">Message:</label>
        <textarea name="message" id="message" rows="5" required></textarea>

        <button type="submit">Send Message</button>
    </form>
</div>
</body>
</html>
