<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard | NextAuction</title>
<style>
body {
font-family: Arial, sans-serif;
margin: 0;
background: #f4f4f4;
}
.header {
background: #343a40;
color: white;
padding: 15px 20px;
display: flex;
justify-content: space-between;
}
.sidebar {
width: 250px;
background: white;
height: 100vh;
float: left;
padding: 20px;
box-shadow: 2px 0 5px rgba(0,0,0,0.1);
}
.content {
margin-left: 250px;
padding: 20px;
}
.menu-item {
display: block;
padding: 10px;
margin: 5px 0;
background: #f8f9fa;
text-decoration: none;
color: #333;
border-left: 3px solid transparent;
}
.menu-item:hover {
background: #e9ecef;
border-left-color: #007bff;
}
.card {
background: white;
padding: 20px;
margin: 15px 0;
border-radius: 5px;
box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}
table {
width: 100%;
border-collapse: collapse;
margin-top: 10px;
}
th, td {
padding: 10px;
text-align: left;
border-bottom: 1px solid #ddd;
}
th {
background: #f8f9fa;
}
.btn {
padding: 5px 10px;
text-decoration: none;
border-radius: 3px;
font-size: 14px;
}
.btn-info {
background: #17a2b8;
color: white;
}
.btn-danger {
background: #dc3545;
color: white;
border: none;
cursor: pointer;
}
.badge {
padding: 3px 8px;
border-radius: 10px;
font-size: 12px;
}
.badge-pending {
background: #ffc107;
color: black;
}
.badge-verified {
background: #28a745;
color: white;
}
.item-card {
border: 1px solid #ddd;
padding: 15px;
margin: 10px 0;
border-radius: 5px;
}
.no-data {
text-align: center;
padding: 20px;
color: #666;
}
.tab-content {
display: none;
}
.tab-content.active {
display: block;
}
</style>
</head>

<body>
<div class="header">
<h2>NextAuction Admin Panel</h2>
<div>
<span>Welcome, ${adminName}</span>
<a href="logout.jsp" style="color: white; margin-left: 15px;">Logout</a>
</div>
</div>

<div class="sidebar">
<h3>Admin Menu</h3>
<a href="AdminDashboardServlet?tab=pending" class="menu-item">Pending Sellers</a>
<a href="AdminDashboardServlet?tab=verified" class="menu-item">Verified Sellers</a>
<a href="AdminDashboardServlet?tab=items" class="menu-item">Manage Items</a>
</div>

<div class="content">
<div style="color: green;">${param.message}</div>
<div style="color: red;">${param.error}</div>

<div id="pending" class="card tab-content ${activeTab == 'pending' ? 'active' : ''}">
<h3>Pending Seller Requests</h3>
<table>
<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Status</th>
<th>Actions</th>
</tr>
<c:forEach items="${pendingSellers}" var="seller">
<tr>
<td>${seller.id}</td>
<td>${seller.name}</td>
<td>${seller.email}</td>
<td><span class="badge badge-pending">Pending</span></td>
<td><a href="SellerDetailServlet?id=${seller.id}" class="btn btn-info">View Details</a></td>
</tr>
</c:forEach>
</table>
<c:if test="${empty pendingSellers}">
<div class="no-data">No pending seller requests</div>
</c:if>
</div>

<div id="verified" class="card tab-content ${activeTab == 'verified' ? 'active' : ''}">
<h3>Verified Sellers</h3>
<table>
<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Status</th>
<th>Actions</th>
</tr>
<c:forEach items="${verifiedSellers}" var="seller">
<tr>
<td>${seller.id}</td>
<td>${seller.name}</td>
<td>${seller.email}</td>
<td><span class="badge badge-verified">Verified</span></td>
<td>
<a href="SellerDetailServlet?id=${seller.id}&type=verified" class="btn btn-info">View Details</a>
<form action="RemoveSellerServlet" method="post" style="display: inline;">
<input type="hidden" name="sellerId" value="${seller.id}">
<button type="submit" class="btn btn-danger" onclick="return confirm('Remove this seller?')">Remove</button>
</form>
</td>
</tr>
</c:forEach>
</table>
<c:if test="${empty verifiedSellers}">
<div class="no-data">No verified sellers</div>
</c:if>
</div>

<div id="items" class="card tab-content ${activeTab == 'items' ? 'active' : ''}">
<h3>All Auction Items</h3>
<c:forEach items="${allItems}" var="item">
<div class="item-card">
<h4>${item.title}</h4>
<p><strong>Category:</strong> ${item.category}</p>
<p><strong>Description:</strong> ${item.description}</p>
<p><strong>Start Price:</strong> ₹${item.startPrice}</p>
<p><strong>Status:</strong> ${item.status}</p>
<form action="RemoveItemServlet" method="post">
<input type="hidden" name="itemId" value="${item.itemId}">
<button type="submit" class="btn btn-danger" onclick="return confirm('Remove this item?')">Remove Item</button>
</form>
</div>
</c:forEach>
<c:if test="${empty allItems}">
<div class="no-data">No auction items found</div>
</c:if>
</div>
</div>
</body>
</html>
