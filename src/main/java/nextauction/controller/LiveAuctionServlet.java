package nextauction.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "jyoti@2025";

@WebServlet("/LiveAuctionServlet")
public class LiveAuctionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        AuctionItemDao itemDao = new AuctionItemDao();
        request.setAttribute("liveItems", itemDao.getLiveAuctions());
        
        RequestDispatcher rd = request.getRequestDispatcher("LiveAuctionPage.jsp");
        rd.forward(request, response);
    }
}