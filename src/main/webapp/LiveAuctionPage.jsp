<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>Live Auctions | NextAuction</title>
<style>
body { font-family: Arial; margin: 0; background: #f4f4f4; }
.header { background: #007bff; color: white; padding: 15px 20px; }
.container { padding: 20px; }
.items-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
.item-card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
.item-image { width: 100%; height: 200px; object-fit: cover; }
.item-info { padding: 15px; }
.item-title { font-size: 18px; font-weight: bold; margin: 0 0 10px 0; }
.item-desc { color: #666; margin: 0 0 10px 0; }
.bid-info { background: #f8f9fa; padding: 10px; border-top: 1px solid #eee; }
.current-bid { font-size: 20px; color: #28a745; font-weight: bold; }
.btn-bid { background: #dc3545; color: white; border: none; padding: 10px 15px; width: 100%; cursor: pointer; font-size: 16px; font-weight: bold; }
.btn-bid:hover { background: #c82333; }
</style>
</head>

<body>
<div class="header">
<h1>🔥 Live Auctions</h1>
<p>Bid on amazing items in real-time!</p>
</div>

<div class="container">
<div class="items-grid">
<c:forEach items="${liveItems}" var="item">
<div class="item-card">
<c:if test="${not empty item.imagePath}">
<img src="${item.imagePath}" class="item-image" alt="${item.title}">
</c:if>
<div class="item-info">
<div class="item-title">${item.title}</div>
<div class="item-desc">${item.description}</div>
</div>
<div class="bid-info">
<div class="current-bid">
Current Bid: ₹${item.currentBid > 0 ? item.currentBid : item.startPrice}
</div>
<form action="ItemDetailServlet" method="get">
<input type="hidden" name="itemId" value="${item.itemId}">
<button type="submit" class="btn-bid">BID NOW</button>
</form>
</div>
</div>
</c:forEach>
</div>

<c:if test="${empty liveItems}">
<div style="text-align: center; padding: 40px;">
<h3>No live auctions at the moment</h3>
<p>Check back later for exciting new items!</p>
</div>
</c:if>
</div>
</body>
</html>
