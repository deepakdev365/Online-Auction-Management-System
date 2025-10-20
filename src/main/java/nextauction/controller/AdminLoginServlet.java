package nextauction.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import nextauction.dao.AdminDao;
import nextauction.model.Admin;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AdminDao adminDAO = new AdminDao();
        Admin admin = adminDAO.validateAdmin(email, password);

        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("adminEmail", admin.getEmail());
            session.setAttribute("adminName", admin.getFullname());

            RequestDispatcher rd = request.getRequestDispatcher("adminDashboard.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Invalid email or password");
            RequestDispatcher rd = request.getRequestDispatcher("login/adminLogin.jsp");
            rd.forward(request, response);
        }
    }
}
