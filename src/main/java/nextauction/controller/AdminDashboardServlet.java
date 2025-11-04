package nextauction.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import nextauction.dao.AdminDao;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Session check in servlet
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
        
        String tab = request.getParameter("tab");
        if (tab == null) tab = "pending";
        
        AdminDao adminDao = new AdminDao();
        
        // Load data based on selected tab
        if ("pending".equals(tab)) {
            request.setAttribute("pendingSellers", adminDao.getPendingSellers());
        } else if ("verified".equals(tab)) {
            request.setAttribute("verifiedSellers", adminDao.getVerifiedSellers());
        } else if ("items".equals(tab)) {
            request.setAttribute("allItems", adminDao.getAllItems());
        }
        
        request.setAttribute("activeTab", tab);
        RequestDispatcher rd = request.getRequestDispatcher("AdminDashboard.jsp");
        rd.forward(request, response);
    }
}