package nextauction.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import nextauction.dao.AdminDao;

@WebServlet("/ApproveSellerServlet")
public class ApproveSellerServlet extends HttpServlet {
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
        
        if (adminDao.verifySeller(sellerId)) {
            response.sendRedirect("AdminDashboardServlet?message=Seller approved");
        } else {
            response.sendRedirect("AdminDashboardServlet?error=Approval failed");
        }
    }
}