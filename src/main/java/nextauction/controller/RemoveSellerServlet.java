package nextauction.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import nextauction.dao.AdminDao;

@WebServlet("/RemoveSellerServlet")
public class RemoveSellerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
        
        int sellerId = Integer.parseInt(request.getParameter("sellerId"));
        AdminDao adminDao = new AdminDao();
        
        if (adminDao.removeSeller(sellerId)) {
            response.sendRedirect("AdminDashboardServlet?message=Seller removed");
        } else {
            response.sendRedirect("AdminDashboardServlet?error=Removal failed");
        }
    }
}