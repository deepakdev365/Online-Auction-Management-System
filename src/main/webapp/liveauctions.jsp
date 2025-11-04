<%@ page import="java.util.*,nextauction.model.AuctionItem,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Live Auctions | NextAuction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #0d1117, #161b22);
            color: #fff;
            font-family: 'Poppins', sans-serif;
        }
        .container { max-width: 1000px; margin-top: 50px; }
        h2 { text-align: center; color: #00bfff; font-weight: 600; margin-bottom: 25px; }
        .card {
            background: rgba(255,255,255,0.08);
            border: none; border-radius: 10px;
            box-shadow: 0 0 12px rgba(0,0,0,0.3); color: #fff;
        }
        .card img {
            border-radius: 10px 10px 0 0;
            height: 180px; object-fit: cover;
        }
        .back-btn { display: inline-block; margin-top: 25px; text-decoration: none; color: #00bfff; }
        .back-btn:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="container">
    <h2>🔥 Live Auctions</h2>
    <div class="row g-4">
        <%
            List<AuctionItem> auctions = (List<AuctionItem>) request.getAttribute("liveAuctions");
            if (auctions != null && !auctions.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
                for (AuctionItem item : auctions) {
        %>
                    <div class="col-md-4">
                        <div class="card">
                            <img src="<%= item.getImagePath() != null ? item.getImagePath() : "https://via.placeholder.com/300x180?text=No+Image" %>" alt="Item Image">
                            <div class="card-body">
                                <h5><%= item.getTitle() %></h5>
                                <p><%= item.getDescription() %></p>
                                <p><b>Starting Price:</b> ₹<%= item.getStartPrice() %></p>
                                <p><b>Ends:</b> <%= sdf.format(item.getEndTime()) %></p>
                                <button class="btn btn-primary w-100">Place Bid</button>
                            </div>
                        </div>
                    </div>
        <%
                }
            } else {
        %>
            <div class="text-center">
                <p class="text-muted mt-4">😔 No live auctions available right now.</p>
            </div>
        <%
            }
        %>
    </div>

    <div class="text-center">
        <a href="SellerDashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>
    </div>
</div>

</body>
</html>
