<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us - Online Auction</title>
    <style>
        body { font-family: Arial, sans-serif; background: #eef2f3; }
        .container {
            width: 50%;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px #bbb;
        }
        input, textarea {
            width: 100%; padding: 10px; margin: 8px 0;
            border: 1px solid #ccc; border-radius: 5px;
        }
        button {
            padding: 10px 20px; background: #007bff;
            color: white; border: none; border-radius: 5px;
            cursor: pointer;
        }
        button:hover { background: #0056b3; }
    </style>
</head>
<body>
<div class="container">
    <h2>Contact Us</h2>
    <form action="ContactServlet" method="post">
        <label>Name:</label>
        <input type="text" name="name" required>

        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Message:</label>
        <textarea name="message" rows="5" required></textarea>

        <button type="submit">Send Message</button>
    </form>
</div>
</body>
</html>
