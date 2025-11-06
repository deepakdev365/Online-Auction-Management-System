<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="nextauction.model.AuctionItem" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results | NextAuction</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f9fafc;
            margin: 40px;
        }
        h2 {
            color: #007bff;
        }
        .auction-card {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .auction-card h3 {
            margin: 0;
            color: #333;
        }
        .auction-card p {
            margin: 8px 0;
            color: #666;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 16px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }
        .back-btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

<h2>Search Results for "<%= request.getAttribute("query") %>"</h2>

<%
    List<AuctionItem> results = (List<AuctionItem>) request.getAttribute("searchResults");

    if (results == null || results.isEmpty()) {
%>
        <p>No auction items found matching your search.</p>
<%
    } else {
        for (AuctionItem a : results) {
%>
            <div class="auction-card">
                <h3><%= a.getTitle() %></h3>
                <p><strong>Category:</strong> <%= a.getCategory() %></p>
                <p><strong>Description:</strong> <%= a.getDescription() %></p>
                <p><strong>Starting Price:</strong> ₹<%= a.getStartPrice() %></p>
                <p><strong>Current Bid:</strong> ₹<%= a.getCurrentBid() %></p>
            </div>
<%
        }
    }
%>

<a href="bidderdashboard.jsp" class="back-btn">← Back to Dashboard</a>

</body>
</html>
