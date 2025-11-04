<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="nextauction.model.AuctionItem" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Auctions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f9f9f9; }
        .card { margin-bottom: 24px; }
        .search-bar, .filters { margin-bottom: 20px; }
        .card-img-top { object-fit: cover; max-height: 200px; border-radius: 8px; }
    </style>
</head>
<body>
<div class="container my-4">

    <h2 class="mb-4">Browse Auctions</h2>

    <!-- Search/Filter form -->
    <form class="row g-3 search-bar" method="get" action="AuctionListServlet">
        <div class="col-md-4">
            <input type="text" class="form-control" name="keyword" placeholder="Search by name or description" value="${param.keyword}">
        </div>
        <div class="col-md-3">
            <select name="category" class="form-select">
                <option value="">All Categories</option>
                <option value="Electronics" ${param.category == 'Electronics' ? 'selected' : ''}>Electronics</option>
                <option value="Vehicles" ${param.category == 'Vehicles' ? 'selected' : ''}>Vehicles</option>
                <option value="Home & Garden" ${param.category == 'Home & Garden' ? 'selected' : ''}>Home & Garden</option>
                <option value="Collectibles" ${param.category == 'Collectibles' ? 'selected' : ''}>Collectibles</option>
                <option value="Art" ${param.category == 'Art' ? 'selected' : ''}>Art</option>
                <!-- add more categories as needed -->
            </select>
        </div>
        <div class="col-md-3">
            <select name="sort" class="form-select">
                <option value="">Sort by</option>
                <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Newest</option>
                <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                <!-- add more sorting options as needed -->
            </select>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Search</button>
        </div>
    </form>

    <div class="row">
        <c:choose>
            <c:when test="${empty auctionList}">
                <div class="col-12">
                    <div class="alert alert-warning mt-4">No auction items found.</div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${auctionList}" var="item">
                    <c:url var="itemUrl" value="ItemDetailServlet">
                        <c:param name="id" value="${item.id}"/>
                    </c:url>
                    <div class="col-md-4">
                        <div class="card">
                            <c:if test="${not empty item.imagePath}">
                                <a href="${itemUrl}">
                                    <img src="${item.imagePath}" class="card-img-top" alt="item image"/>
                                </a>
                            </c:if>
                            <div class="card-body">
                                <h5 class="card-title">${item.title}</h5>
                                <p class="card-text">${item.description}</p>
                                <p><b>Category:</b> ${item.category}</p>
                                <p><b>Current Bid:</b> ₹${item.currentBid != null ? item.currentBid : 'No bids yet'}</p>
                                <a href="${itemUrl}" class="btn btn-success w-100">View Item</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

</div>
</body>
</html>
