package nextauction.controller;


import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateAuctionStatusServlet")
public class UpdateAuctionStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/online_auction", "root", "RJP279");

            // ✅ Step 1: Mark items as ACTIVE when start_time <= now and end_time > now
            PreparedStatement psActive = con.prepareStatement(
                "UPDATE auction_items SET status='Active' " +
                "WHERE status='Pending' AND start_time <= NOW() AND end_time > NOW()");
            psActive.executeUpdate();
            psActive.close();

            // ✅ Step 2: Mark items as ENDED when end_time < now
            PreparedStatement psEnded = con.prepareStatement(
                "UPDATE auction_items SET status='Ended' " +
                "WHERE (status='Pending' OR status='Active') AND end_time <= NOW()");
            psEnded.executeUpdate();
            psEnded.close();

            con.close();

            // You can redirect back where it came from
            response.sendRedirect("SellerDashboard.jsp?statusUpdated=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SellerDashboard.jsp?error=updateFailed");
        }
    }
}
