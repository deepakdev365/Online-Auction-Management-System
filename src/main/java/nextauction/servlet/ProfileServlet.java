package nextauction.servlet;

import nextauction.util.DBUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(false);
        if(session == null || session.getAttribute("userId") == null){
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"error\":\"not_logged_in\"}");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        try(Connection con = DBUtil.getConnection()){
            PreparedStatement ps = con.prepareStatement("SELECT name,email,role FROM users WHERE id=?");
            ps.setInt(1,userId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                out.print("{\"name\":\""+rs.getString("name")+"\",\"email\":\""+rs.getString("email")+"\",\"role\":\""+rs.getString("role")+"\"}");
            } else {
                out.print("{\"error\":\"user_not_found\"}");
            }
        } catch(SQLException e){
            e.printStackTrace();
            resp.setStatus(500);
            out.print("{\"error\":\"server_error\"}");
        }
    }
}
