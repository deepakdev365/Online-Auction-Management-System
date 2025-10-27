package nextauction.login.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ✅ Database configuration
    private static final String DB_URL  = "jdbc:mysql://localhost:3306/online_auction";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "RJP279";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- Get form data ---
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // --- Input validation ---
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=empty");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // --- Load MySQL Driver ---
            Class.forName("com.mysql.cj.jdbc.Driver");

            // --- Connect to Database ---
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // --- Check user credentials ---
            String sql = "SELECT id, name, role FROM users WHERE email=? AND password=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ User authenticated
                int userId = rs.getInt("id");
                String name = rs.getString("name");
                String role = rs.getString("role");

                // --- Create user session ---
                HttpSession session = request.getSession();
                session.setAttribute("user_id", userId);
                session.setAttribute("name", name);
                session.setAttribute("email", email);
                session.setAttribute("role", role);

                // --- Redirect based on user role ---
                if ("seller".equalsIgnoreCase(role)) {
                    response.sendRedirect("SellerDashboard.jsp");  // ✅ case must match actual filename
                } else if ("bidder".equalsIgnoreCase(role)) {
                    response.sendRedirect("bidderdashboard.jsp");  // ✅ case must match actual filename
                } else {
                    response.sendRedirect("login.jsp?error=role");
                }

            } else {
                // ❌ Invalid email or password
                response.sendRedirect("login.jsp?error=invalid");
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=driver");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=db");
        } finally {
            // --- Close resources safely ---
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            try { if (con != null) con.close(); } catch (SQLException ignored) {}
        }
    }

    // --- Redirect GET requests to login page ---
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
