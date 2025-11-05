package nextauction.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import nextauction.dao.AuctionItemDao;
import nextauction.model.AuctionItem;

@WebServlet("/ItemDetailServlet")
public class ItemDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String itemId = request.getParameter("itemId");
        String error = request.getParameter("error");
        String success = request.getParameter("success");
        
        AuctionItemDao itemDao = new AuctionItemDao();
        AuctionItem item = itemDao.getItemById(Integer.parseInt(itemId));
        
        if (item != null) {
            request.setAttribute("item", item);
            if (error != null) request.setAttribute("error", error);
            if (success != null) request.setAttribute("success", success);
            
            RequestDispatcher rd = request.getRequestDispatcher("ItemDetail.jsp");
            rd.forward(request, response);
        } else {
            response.sendRedirect("LiveAuctionServlet?error=Item not found");
        }
    }
}