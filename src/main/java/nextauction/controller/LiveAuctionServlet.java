package nextauction.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import nextauction.dao.LiveAuctionDao;
import nextauction.model.AuctionItem;

@WebServlet("/liveAuctions")
public class LiveAuctionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LiveAuctionDao dao = new LiveAuctionDao();
        List<AuctionItem> liveList = dao.getLiveAuctions();

        request.setAttribute("liveAuctions", liveList);
        RequestDispatcher rd = request.getRequestDispatcher("LiveAuction.jsp");
        rd.forward(request, response);
    }
}
