<%@ page import="nextauction.model.AuctionItem, java.util.List" %>
<html>
<head>
<title>Attractive Auction Items</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
<style>
  body {
    background: #1f2937;
    font-family: 'Montserrat', sans-serif;
    color: #eee;
    margin: 0; padding: 20px 40px;
  }
  h2 {
    text-align: center;
    font-weight: 700;
    letter-spacing: 3px;
    margin-bottom: 30px;
    color: #f9fafb;
  }
  .item-list {
    display: flex;
    flex-wrap: wrap;
    gap: 30px;
    justify-content: center;
    max-width: 1250px;
    margin: 0 auto;
  }
  .item-card {
    background: #272f3f;
    border-radius: 12px;
    box-shadow: 0 12px 20px rgba(0, 0, 0, 0.5);
    width: 320px;
    padding: 15px 15px 25px 15px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .item-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 22px 40px rgba(33, 150, 243, 0.6);
  }
  .item-image {
    width: 280px;
    height: 190px;
    object-fit: cover;
    border-radius: 10px;
    box-shadow: 0 4px 17px rgba(0, 0, 0, 0.35);
    margin-bottom: 16px;
  }
  .item-title {
    font-size: 1.4rem;
    font-weight: 700;
    margin-bottom: 4px;
    color: #bbdefb;
    text-transform: capitalize;
  }
  .item-description {
    font-size: 0.95rem;
    color: #b0bec5;
    margin-bottom: 15px;
    min-height: 50px;
    text-align: center;
  }
  .item-details {
    font-size: 1rem;
    line-height: 1.25;
    color: #e3f2fd;
    width: 100%;
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
  }
  .status-badge {
    padding: 6px 15px;
    border-radius: 22px;
    font-weight: 700;
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 0.03em;
    color: white;
    box-shadow: 0 0 9px rgba(66, 165, 245, 0.75);
    user-select: none;
  }
  .status-live {
    background: linear-gradient(45deg, #64b5f6, #1976d2);
  }
  .status-ended {
    background: #c62828;
    box-shadow: none;
  }
  .timer {
    color: #ffeb3b;
    font-weight: 700;
    font-size: 1.1rem;
    margin-bottom: 14px;
    font-family: 'Courier New', monospace;
    user-select: none;
  }
  .bid-list {
    max-height: 100px;
    overflow-y: auto;
    list-style: none;
    padding-left: 0;
    font-size: 0.9rem;
    color: #90caf9;
    margin-bottom: 15px;
  }
  .bid-list li {
    margin-bottom: 4px;
  }
  form {
    width: 100%;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  input[type="text"],
  input[type="number"] {
    padding: 8px 12px;
    border-radius: 6px;
    border: none;
    font-size: 1rem;
    background: #455a64;
    color: #eceff1;
    box-shadow: inset 2px 2px 8px rgba(0,0,0,0.3);
  }
  input[type="text"]::placeholder,
  input[type="number"]::placeholder {
    color: #b0bec5;
  }
  input[type="submit"] {
    padding: 10px 18px;
    font-weight: 700;
    font-size: 1rem;
    border-radius: 14px;
    background: #42a5f5;
    color: #e3f2fd;
    cursor: pointer;
    transition: background-color 0.3s ease;
    border: none;
    box-shadow: 0 6px 12px rgba(66, 165, 245, 0.45);
  }
  input[type="submit"]:hover {
    background: #1e88e5;
  }
</style>
</head>
<body>
<h2>Active Auction Items</h2>

<div class="item-list">
<%
List<AuctionItem> items = (List<AuctionItem>) request.getAttribute("auctionItems");
if (items != null && !items.isEmpty()) {
    for (AuctionItem item : items) {
%>
<div class="item-card">
    <% if ("active".equalsIgnoreCase(item.getStatus())) { %>
      <div class="status-badge status-live">LIVE</div>
    <% } else { %>
      <div class="status-badge status-ended">ENDED</div>
    <% } %>
    <% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
      <img class="item-image" src="<%=request.getContextPath()+ "/" + item.getImagePath()%>" alt="Item Image"/>
    <% } else { %>
      <img class="item-image" src="default-auction.jpg" alt="No Image Available"/>
    <% } %>
    <div class="item-title"><%= item.getName() %></div>
    <div class="item-description"><%= item.getDescription() %></div>
    <div class="item-details">
      <div>Start: ₹<%=String.format("%.2f", item.getStartingPrice())%></div>
      <div>Current: ₹<%=String.format("%.2f", item.getCurrentBid())%></div>
    </div>
    <div class="timer" id="timer-<%=item.getId()%>">Loading...</div>
    <ul class="bid-list">
      <%
        List<String> bids = item.getBids();
        if(bids == null || bids.isEmpty()){ %>
          <li>No bids yet</li>
      <% } else {
          for(String bid : bids) { %>
          <li><%= bid %></li>
      <%  }  } %>
    </ul>
    <% if ("active".equalsIgnoreCase(item.getStatus())) { %>
      <form action="PlaceBidServlet" method="post">
        <input type="hidden" name="itemId" value="<%= item.getId() %>"/>
        <input type="text" name="bidderName" placeholder="Your Name" required />
        <input type="number" name="bidAmount" min="<%= item.getCurrentBid() + 1 %>" placeholder="Bid Amount" required />
        <input type="submit" value="Place Bid" />
      </form>
    <% } %>

<script>
(function(){
  var countDownDate = new Date('<%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm:ss").format(item.getBidEndTime()) %>').getTime();
  var timerId = 'timer-<%= item.getId() %>';
  var x = setInterval(function() {
    var now = new Date().getTime();
    var distance = countDownDate - now;
    var el = document.getElementById(timerId);
    if(distance < 0){
      clearInterval(x);
      if(el) {
        el.innerHTML = "ENDED";
        el.style.color = "#f44336";
      }
    } else {
      var days = Math.floor(distance / (1000*60*60*24));
      var hours = Math.floor((distance % (1000*60*60*24)) / (1000*60*60));
      var minutes = Math.floor((distance % (1000*60*60)) / (1000*60));
      var seconds = Math.floor((distance % (1000*60)) / 1000);
      if(el) {
        el.innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s";
        el.style.color = "#ffeb3b";
      }
    }
  }, 1000);
})();
</script>

</div>

<%  }
} else { %>

<p style="text-align:center; font-size:1.3em; color:#ccc;">No auction items found.</p>

<% } %>
</div>

</body>
</html>
