package nextauction.auction.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.dao.AuctionDao;
import nextauction.model.Auction;

@WebServlet("/SearchAuctionServlet")
public class SearchAuctionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");

        // Prevent null or empty query
        if (query == null || query.trim().isEmpty()) {
            request.setAttribute("error", "Please enter a search term.");
            RequestDispatcher rd = request.getRequestDispatcher("bidderdashboard.jsp");
            rd.forward(request, response);
            return;
        }

        AuctionDao dao = new AuctionDao();
        List<Auction> results = dao.searchAuctions(query.trim());
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    List<nextauction.model.Auction> results =
        (List<nextauction.model.Auction>) request.getAttribute("searchResults");

    if (results == null || results.isEmpty()) {
%>
        <p>No auction items found matching your search.</p>
<%
    } else {
        for (nextauction.model.Auction a : results) {
%>
            <div class="auction-card">
                <h3><%= a.getItemName() %></h3>
                <p><strong>Category:</strong> <%= a.getCategory() %></p>
                <p><strong>Description:</strong> <%= a.getDescription() %></p>
                <p><strong>Starting Price:</strong> ₹<%= a.getStartingPrice() %></p>
                <p><strong>Current Bid:</strong> ₹<%= a.getCurrentBid() %></p>
            </div>
<%
        }
    }
%>

<a href="bidderdashboard.jsp" class="back-btn">← Back to Dashboard</a>

</body>
</html>

        request.setAttribute("query", query);
        request.setAttribute("results", results);

        RequestDispatcher rd = request.getRequestDispatcher("searchresults.jsp");
        rd.forward(request, response);
    }
}
