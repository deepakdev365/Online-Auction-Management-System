<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>Seller Details</title>
<style>
body { font-family: Arial; margin: 20px; background: #f4f4f4; }
.container { background: white; padding: 20px; border-radius: 5px; }
.detail { margin: 10px 0; padding: 10px; background: #f8f9fa; }
.btn { padding: 8px 15px; margin: 5px; text-decoration: none; color: white; border: none; cursor: pointer; }
.approve { background: green; }
.reject { background: red; }
.back { background: blue; }
.remove { background: orange; }
</style>
</head>

<body>
<div class="container">
<h2>Seller Details</h2>

<div class="detail">
<p><strong>ID:</strong> ${seller.id}</p>
<p><strong>Name:</strong> ${seller.name}</p>
<p><strong>Email:</strong> ${seller.email}</p>
</div>

<c:choose>
<c:when test="${type != 'verified'}">
<form action="ApproveSellerServlet" method="post" style="display: inline;">
<input type="hidden" name="sellerId" value="${seller.id}">
<button type="submit" class="btn approve">Approve Seller</button>
</form>

<form action="RejectSellerServlet" method="post" style="display: inline;">
<input type="hidden" name="sellerId" value="${seller.id}">
<button type="submit" class="btn reject">Reject Seller</button>
</form>
</c:when>

<c:otherwise>
<form action="RemoveSellerServlet" method="post" style="display: inline;">
<input type="hidden" name="sellerId" value="${seller.id}">
<button type="submit" class="btn remove" onclick="return confirm('Remove this seller?')">Remove Seller</button>
</form>
</c:otherwise>
</c:choose>

<br><br>
<a href="AdminDashboardServlet" class="btn back">Back to Dashboard</a>
</div>
</body>
</html>
