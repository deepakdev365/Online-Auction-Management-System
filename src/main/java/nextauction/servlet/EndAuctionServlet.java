package nextauction.servlet;


import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.util.DBUtil;

import java.io.*;
import java.sql.*;

@WebServlet("/endAuctions")
public class EndAuctionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE auction_items SET status='ended' WHERE end_time < NOW() AND status='active'");
            int rows = ps.executeUpdate();
            req.setAttribute("message", "✅ " + rows + " auctions ended!");
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("message", "❌ Error ending auctions!");
        }

        req.getRequestDispatcher("sellerDashboard?action=winners").forward(req, res);
    }
}
