package nextauction.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.dao.AuctionItemDao;
import nextauction.model.AuctionItem;

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

        AuctionItemDao dao = new AuctionItemDao();
        List<AuctionItem> searchResults = dao.searchAuctionItems(query.trim());

        if (searchResults == null || searchResults.isEmpty()) {
            request.setAttribute("message", "❌ Item not available: \"" + query + "\"");
        } else {
            request.setAttribute("message", "✅ Item is available!");
            request.setAttribute("searchResults", searchResults);
        }

        request.setAttribute("query", query);
        RequestDispatcher rd = request.getRequestDispatcher("bidderdashboard.jsp");
        rd.forward(request, response);
    }
}
