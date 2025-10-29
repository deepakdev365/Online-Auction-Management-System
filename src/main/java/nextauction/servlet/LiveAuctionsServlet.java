package nextauction.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * LiveAuctionsServlet
 * Fetches all currently active auctions with seller info and current highest bidder.
 */
@WebServlet("/live")
public class LiveAuctionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ✅ Database Configuration
    private static final String DB_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "jyoti@2025";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONArray auctionsArray = new JSONArray();

        // ✅ Updated query using current_bidder_id
        String query =
            "SELECT a.id, a.title, a.description, a.start_price, a.current_bid, " +
            "a.end_time, a.image_path, a.status, " +
            "u.name AS seller_name, " +
            "(SELECT name FROM users WHERE id = a.current_bidder_id) AS current_bidder " +
            "FROM auction_items a " +
            "JOIN users u ON a.seller_id = u.id " +
            "WHERE NOW() BETWEEN a.start_time AND a.end_time " +
            "AND a.status = 'active' " +
            "ORDER BY a.end_time ASC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement ps = con.prepareStatement(query);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    JSONObject item = new JSONObject();
                    item.put("id", rs.getInt("id"));
                    item.put("title", rs.getString("title"));
                    item.put("description", rs.getString("description"));
                    item.put("start_price", rs.getDouble("start_price"));
                    item.put("current_bid", rs.getDouble("current_bid"));
                    item.put("seller_name", rs.getString("seller_name"));
                    item.put("current_bidder",
                             rs.getString("current_bidder") != null
                             ? rs.getString("current_bidder")
                             : "No bids yet");
                    item.put("end_time", rs.getString("end_time"));
                    item.put("image_path", rs.getString("image_path"));
                    item.put("status", rs.getString("status"));
                    item.put("time_left", getTimeLeft(rs.getTimestamp("end_time")));
                    auctionsArray.put(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.getWriter().print(auctionsArray.toString());
    }

    /**
     * Utility function to calculate remaining time
     */
    private String getTimeLeft(Timestamp endTime) {
        long diffMillis = endTime.getTime() - System.currentTimeMillis();
        if (diffMillis <= 0) return "Auction ended";
        long hours = diffMillis / (1000 * 60 * 60);
        long minutes = (diffMillis / (1000 * 60)) % 60;
        long seconds = (diffMillis / 1000) % 60;
        return String.format("%02dh %02dm %02ds", hours, minutes, seconds);
    }
}
