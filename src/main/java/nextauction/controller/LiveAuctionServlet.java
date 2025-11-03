package nextauction.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nextauction.dao.AuctionItemDao;

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