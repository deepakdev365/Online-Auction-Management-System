package nextauction.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import nextauction.dao.AdminDao;
import nextauction.model.User;

@WebServlet("/SellerDetailServlet")
public class SellerDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Session check in servlet
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
        
        String sellerId = request.getParameter("id");
        String type = request.getParameter("type");
        
        AdminDao adminDao = new AdminDao();
        User seller = adminDao.getSellerDetails(Integer.parseInt(sellerId));
        
        if (seller != null) {
            request.setAttribute("seller", seller);
            request.setAttribute("type", type);
            RequestDispatcher rd = request.getRequestDispatcher("SellerDetail.jsp");
            rd.forward(request, response);
        } else {
            response.sendRedirect("AdminDashboardServlet?error=Seller not found");
        }
    }
}