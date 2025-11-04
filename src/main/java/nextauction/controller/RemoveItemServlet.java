package nextauction.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import nextauction.dao.AdminDao;

@WebServlet("/RemoveItemServlet")
public class RemoveItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
        
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        AdminDao adminDao = new AdminDao();
        
        if (adminDao.removeItem(itemId)) {
            response.sendRedirect("AdminDashboardServlet?message=Item removed");
        } else {
            response.sendRedirect("AdminDashboardServlet?error=Item removal failed");
        }
    }
}