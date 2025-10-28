<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${item.title} | Online Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .item-image { max-height: 300px; object-fit: cover; border-radius: 10px;}
        .card { margin-top: 10px;}
    </style>
</head>
<body>
<div class="container my-4">
    <a href="AuctionList.jsp" class="btn btn-sm btn-outline-primary mb-3">&larr; Back to All Auctions</a>

    <div class="row">
        <!-- Item Image and Info -->
        <div class="col-md-6">
            <div class="card p-3">
                <c:if test="${not empty item.imagePath}">
                    <img src="${item.imagePath}" class="item-image w-100 mb-3" alt="Item image"/>
                </c:if>
                <h3>${item.title}</h3>
                <p>${item.description}</p>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item"><strong>Category:</strong> ${item.category}</li>
                    <li class="list-group-item"><strong>Start Price:</strong> ₹${item.startPrice}</li>
                    <li class="list-group-item"><strong>Current Bid:</strong> 
                        <c:choose>
                            <c:when test="${not empty item.currentBid}">
                                ₹${item.currentBid}
                            </c:when>
                            <c:otherwise>
                                No bids yet
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li class="list-group-item"><strong>Status:</strong> ${item.status}</li>
                    <li class="list-group-item"><strong>Auction Ends:</strong> ${item.endTime}</li>
                </ul>
            </div>
        </div>

        <!-- Bidding Section -->
        <div class="col-md-6">
            <div class="card p-3">
                <h5>Place Your Bid</h5>
                <form action="${pageContext.request.contextPath}/placeBid" method="post"> 
                    <input type="hidden" name="item_id" value="${item.id}">
                    <div class="mb-3">
                        <label for="bid_amount" class="form-label">Bid Amount (₹)</label>
                        <input type="number" step="0.01"
                               min="<c:out value='${item.currentBid != null ? item.currentBid + 1 : item.startPrice}'/>"
                               class="form-control" name="bid_amount" id="bid_amount" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Place Bid</button>
                </form>
                <c:if test="${not empty param.bid_error}">
                    <div class="alert alert-danger mt-3">${param.bid_error}</div>
                </c:if>
                <c:if test="${not empty param.bid_success}">
                    <div class="alert alert-success mt-3">Bid placed successfully!</div>
                </c:if>
            </div>

            <div class="card p-3 mt-3">
                <h6 class="mb-2">Bid History</h6>
                <c:choose>
                    <c:when test="${empty bids}">
                        <div class="text-muted">No bids yet.</div>
                    </c:when>
                    <c:otherwise>
                        <ul class="list-group">
                            <c:forEach items="${bids}" var="bid">
                                <li class="list-group-item">
                                    ₹${bid.bidAmount} by ${bidderName(bid.bidderId)} 
                                    <span class="text-muted float-end">${bid.bidTime}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
</body>
</html>
