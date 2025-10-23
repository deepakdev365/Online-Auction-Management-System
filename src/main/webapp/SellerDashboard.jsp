<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="nextauction.model.AuctionItem" %>
<!DOCTYPE html>
<html>
<head>
    <title>Seller Dashboard</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Arial, Helvetica, sans-serif;
            background: linear-gradient(135deg, #e9eafc 0%, #c4e0e5 100%);
        }
        .sidebar {
            height: 100vh;
            width: 220px;
            position: fixed;
            background: #1a237e;
            color: #fff;
            display: flex;
            flex-direction: column;
            align-items: center;
            box-shadow: 2px 0 12px #9fa8da90;
        }
        .profile {
            margin: 40px 0 24px 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .profile-icon {
            font-size: 70px;
            color: #c5cae9;
            background: #fff;
            border-radius: 50%;
            padding: 16px;
            border: 3px solid #7986cb;
        }
        .profile-name {
            margin-top: 12px;
            font-size: 20px;
            font-weight: 700;
            color: #fff;
        }
        .sidebar-menu {
            margin-top: 36px;
            width: 100%;
        }
        .sidebar-menu a {
            display: flex;
            align-items: center;
            font-size: 17px;
            padding: 14px 20px;
            color: #d1c4e9;
            text-decoration: none;
            transition: background 0.2s, color 0.2s;
        }
        .sidebar-menu a .material-icons {
            margin-right: 10px;
            font-size: 24px;
        }
        .sidebar-menu a:hover, .sidebar-menu a.active {
            background: #3949ab;
            color: #fff;
        }
        .main {
            margin-left: 240px;
            padding: 40px 50px 30px 50px;
        }
        .dashboard-title {
            font-size: 32px;
            letter-spacing: 1px;
            color: #1a237e;
            margin-bottom: 26px;
        }
        .auction-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 32px;
        }
        .auction-card {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 10px #c5cae963;
            padding: 28px 26px 18px 26px;
            width: 310px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .auction-card:hover {
            transform: translateY(-3px) scale(1.025);
            box-shadow: 0 8px 36px #5c6bc08c;
        }
        .item-title {
            font-size: 22px;
            color: #283593;
            font-weight: bold;
            margin-bottom: 6px;
        }
        .item-desc {
            color: #616161;
            font-size: 15px;
            margin-bottom: 12px;
        }
        .item-info {
            color: #37474f;
            font-size: 16px;
            margin-bottom: 5px;
        }
        .item-status {
            display: inline-block;
            font-size: 13px;
            padding: 4px 10px;
            border-radius: 10px;
            background: #fbc02d;
            color: #222;
            font-weight: bold;
            margin-bottom: 8px;
        }
        .item-status.closed { background: #cfd8dc; color: #607d8b; }
        .item-status.active { background: #81c784; color: #256029; }
        .no-items {
            color: #9e9e9e;
            font-size: 20px;
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="profile">
            <span class="material-icons profile-icon">person</span>
            <span class="profile-name">Seller</span>
        </div>
        <div class="sidebar-menu">
            <a href="profileDetails.jsp"><span class="material-icons">account_circle</span> Profile</a>
            <a href="addItem.jsp"><span class="material-icons">add_box</span> Add Item</a>
            <a href="bids.jsp"><span class="material-icons">gavel</span> Bids</a>
        </div>
    </div>
    <div class="main">
        <div class="dashboard-title">Your Auction Items</div>
        <%
            List<AuctionItem> sellerItems = (List<AuctionItem>) request.getAttribute("sellerItems");
            if (sellerItems != null && !sellerItems.isEmpty()) {
        %>
        <div class="auction-grid">
        <% for (AuctionItem item : sellerItems) { %>
            <div class="auction-card">
                <div class="item-title"><%= item.getName() %></div>
                <div class="item-desc"><%= item.getDescription() %></div>
                <div class="item-info">Start: ₹<%= item.getStartingPrice() %></div>
                <div class="item-info">Current Bid: ₹<%= item.getCurrentBid() %></div>
                <div class="item-info">Ends: <%= item.getEndDate() %></div>
                <div class="item-status <%= item.getStatus().toLowerCase() %>">
                    <%= item.getStatus() %>
                </div>
            </div>
        <% } %>
        </div>
        <% } else { %>
        <div class="no-items">You have not added any items yet.</div>
        <% } %>
    </div>
</body>
</html>
