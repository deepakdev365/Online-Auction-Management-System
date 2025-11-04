<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Project Documentation - Online Auction</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #a8edea, #fed6e3);
            margin: 40px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #2c3e50;
        }
        .doc-container {
            background: rgba(255, 255, 255, 0.85);
            padding: 50px;
            border-radius: 20px;
            max-width: 750px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            transform: translateY(20px);
            animation: slideUp 1s ease forwards;
        }
        h2 {
            color: #34495e;
            font-size: 2.4rem;
            text-align: center;
            margin-bottom: 30px;
            letter-spacing: 2px;
        }
        ul {
            list-style: none;
            padding: 0;
            margin-bottom: 30px;
        }
        li {
            background: #f7f7f7;
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        li:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }
        p {
            font-size: 1.2rem;
            line-height: 1.8;
        }
        @keyframes slideUp {
            from {opacity: 0; transform: translateY(50px);}
            to {opacity: 1; transform: translateY(0);}
        }
    </style>
</head>
<body>
<div class="doc-container">
    <h2>Project Documentation</h2>
    <p>This project is built using Java, JSP, Servlets, and MySQL.</p>
    <ul>
        <li><strong>Frontend:</strong> HTML, CSS, JSP</li>
        <li><strong>Backend:</strong> Java Servlets</li>
        <li><strong>Database:</strong> MySQL</li>
        <li><strong>Server:</strong> Apache Tomcat</li>
    </ul>
    <p>This application demonstrates CRUD operations, user authentication, real-time bidding, and secure data handling. The design emphasizes usability, security, and scalability for an optimal user experience.</p>
</div>
</body>
</html>
