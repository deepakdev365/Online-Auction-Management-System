package nextauction.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.dao.AuctionItemDao;

@WebServlet("/LiveAuctionServlet")
public class LiveAuctionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ✅ Database connection info (optional — you can remove if unused)
    private static final String DB_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "jyoti@2025";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AuctionItemDao itemDao = new AuctionItemDao();

        // ✅ Fetch all live auctions
        request.setAttribute("liveItems", itemDao.getLiveAuctions());

        // ✅ Forward data to JSP page
        RequestDispatcher rd = request.getRequestDispatcher("LiveAuctionPage.jsp");
        rd.forward(request, response);
    }
}
