package nextauction.RegisterServlet.controller;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.Registration.dao.RegistrationDao;


@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        RegistrationDao dao = new RegistrationDao();

        boolean success = dao.registerUser(name, email, password, role);

        if (success) {
            response.sendRedirect("register.jsp?success=1");
        } else {
            response.sendRedirect("register.jsp?error=Email already registered or DB issue");
        }
    }
}
