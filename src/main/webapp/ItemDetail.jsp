<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="nextauction.model.AuctionItem" %>
<%
AuctionItem item = (AuctionItem) request.getAttribute("item");
if (item == null) {
response.sendRedirect("LiveAuctionServlet");
return;
}
double currentBid = item.getCurrentBid() > 0 ? item.getCurrentBid() : item.getStartPrice();
double minBid = currentBid + 1;
%>
<!DOCTYPE html>
<html>
<head>
<title><%= item.getTitle() %> | NextAuction</title>
<style>
body { font-family: Arial; margin: 0; background: #f4f4f4; }
.header { background: #007bff; color: white; padding: 15px 20px; }
.container { padding: 20px; max-width: 1000px; margin: 0 auto; }
.item-detail { display: flex; gap: 30px; background: white; padding: 20px; border-radius: 8px; }
.item-image { flex: 1; max-width: 400px; }
.item-image img { width: 100%; border-radius: 8px; }
.item-info { flex: 2; }
.item-title { font-size: 24px; font-weight: bold; margin: 0 0 15px 0; }
.bid-section { background: #f8f9fa; padding: 20px; border-radius: 8px; margin-top: 20px; }
.current-bid { font-size: 28px; color: #28a745; font-weight: bold; margin: 10px 0; }
.bid-form input { padding: 10px; width: 200px; margin-right: 10px; border: 1px solid #ddd; border-radius: 4px; }
.btn-bid { background: #dc3545; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 4px; font-size: 16px; font-weight: bold; }
.btn-bid:hover { background: #c82333; }
.error { color: #dc3545; margin: 10px 0; }
.success { color: #28a745; margin: 10px 0; }
</style>
<script>
function placeBid(itemId) {
var bidAmount = document.getElementById('bidAmount').value;
var minBid = <%= minBid %>;
if (bidAmount < minBid) {
alert('Bid amount must be at least ₹' + minBid);
return;
}
var formData = new FormData();
formData.append('item_id', itemId);
formData.append('bid_amount', bidAmount);
fetch('placeBid', {
method: 'POST',
body: formData
})
.then(response => response.json())
.then(data => {
if (data.success) {
alert('Bid placed successfully!');
location.reload();
} else {
alert('Error: ' + data.error);
}
})
.catch(error => {
console.error('Error:', error);
alert('An error occurred while placing bid.');
});
}
</script>
</head>

<body>
<div class="header">
<a href="LiveAuctionServlet" style="color: white;">← Back to Live Auctions</a>
<h1>Item Details</h1>
</div>

<div class="container">
<div class="item-detail">
<div class="item-image">
<% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
<img src="<%= item.getImagePath() %>" alt="<%= item.getTitle() %>">
<% } %>
</div>

<div class="item-info">
<div class="item-title"><%= item.getTitle() %></div>
<p><strong>Description:</strong> <%= item.getDescription() %></p>
<p><strong>Category:</strong> <%= item.getCategory() %></p>
<p><strong>Seller ID:</strong> <%= item.getSellerId() %></p>
<p><strong>Auction Ends:</strong> <%= item.getEndTime() %></p>

<div class="bid-section">
<h3>Place Your Bid</h3>
<div class="current-bid">
Current Highest Bid: ₹<%= currentBid %>
</div>

<div class="bid-form">
<input type="number" id="bidAmount" step="0.01" min="<%= minBid %>" placeholder="Enter your bid amount" required>
<button type="button" class="btn-bid" onclick="placeBid(<%= item.getItemId() %>)">PLACE BID</button>
</div>

<p style="color: #666; margin-top: 10px; font-size: 14px;">
Minimum bid: ₹<%= minBid %>
</p>
</div>
</div>
</div>
</div>
</body>
</html>
