package nextauction.search.controller;

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");

        if (query == null || query.trim().isEmpty()) {
            request.setAttribute("message", "⚠️ Please enter an item name to search!");
            RequestDispatcher rd = request.getRequestDispatcher("bidderdashboard.jsp");
            rd.forward(request, response);
            return;
        }

        AuctionDao dao = new AuctionDao();
        List<Auction> searchResults = dao.searchAuctions(query.trim());

        if (searchResults == null || searchResults.isEmpty()) {
            // ❌ No items found
            request.setAttribute("message", "❌ Item not available: \"" + query + "\"");
        } else {
            // ✅ Items found
            request.setAttribute("message", "✅ Item is available!");
            request.setAttribute("searchResults", searchResults);
        }

        request.setAttribute("query", query);

        // Forward back to dashboard (results will show below search bar)
        RequestDispatcher rd = request.getRequestDispatcher("bidderdashboard.jsp");
        rd.forward(request, response);
    }
}
