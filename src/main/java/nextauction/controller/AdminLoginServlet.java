package nextauction.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import nextauction.dao.AdminDao;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AdminDao adminDao = new AdminDao();
        
        if (adminDao.validateAdmin(email, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", "admin");
            session.setAttribute("adminEmail", email);
            session.setAttribute("adminName", adminDao.getAdminName(email));
            
            response.sendRedirect("AdminDashboardServlet");
        } else {
            request.setAttribute("error", "Invalid admin credentials!");
            RequestDispatcher rd = request.getRequestDispatcher("AdminLogin.jsp");
            rd.forward(request, response);
        }
    }
}