<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="nextauction.model.Bid" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bids | NextAuction</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f7f9fc;
            margin: 40px;
        }

        h2 {
            color: #007bff;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 14px;
            border-bottom: 1px solid #e0e0e0;
            text-align: left;
        }

        th {
            background: #007bff;
            color: white;
            text-transform: uppercase;
            font-size: 14px;
        }

        tr:hover {
            background: #f1f3f6;
        }

        .no-bids {
            color: #888;
            font-size: 16px;
            margin-top: 20px;
        }

        .back-btn {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 18px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: background 0.3s;
        }

        .back-btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

    <h2>💰 My Bids</h2>

    <%
        List<Bid> bids = (List<Bid>) request.getAttribute("bids");

        if (bids == null || bids.isEmpty()) {
    %>
        <p class="no-bids">You haven’t placed any bids yet.</p>
    <%
        } else {
    %>
        <table>
            <tr>
                <th>Item</th>
                <th>Bid Amount (₹)</th>
                <th>Bid Time</th>
            </tr>
    <%
            for (Bid b : bids) {
    %>
            <tr>
                <td><%= b.getItemTitle() %></td>
                <td>₹<%= b.getBidAmount() %></td>
                <td><%= b.getBidTime() %></td>
            </tr>
    <%
            }
        }
    %>
        </table>

    <a href="bidderdashboard.jsp" class="back-btn">← Back to Dashboard</a>

</body>
</html>
