package nextauction.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/wonAuctions")
public class WinnerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        Integer bidderId = (session != null) ? (Integer) session.getAttribute("user_id") : null;

        JSONArray wonItems = new JSONArray();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/online_auction", "root", "RJP279");

            // ✅ Step 1: Update auction statuses
            String updateSQL =
                "UPDATE auction_items " +
                "SET status = CASE " +
                "WHEN NOW() < start_time THEN 'Pending' " +
                "WHEN NOW() BETWEEN start_time AND end_time THEN 'active' " +
                "WHEN NOW() > end_time THEN 'ended' " +
                "ELSE status END";
            PreparedStatement psUpdate = con.prepareStatement(updateSQL);
            psUpdate.executeUpdate();
            psUpdate.close();

            // ✅ Step 2: Determine winners for ended auctions
            // If an auction has ended, find the highest bidder and update the winner field
            String winnerSQL =
                "UPDATE auction_items i " +
                "JOIN (SELECT item_id, bidder_id, MAX(bid_amount) AS max_bid " +
                "      FROM bids GROUP BY item_id) b " +
                "ON i.id = b.item_id " +
                "SET i.winner_id = b.bidder_id, i.current_bid = b.max_bid " +
                "WHERE i.status = 'ended' AND i.winner_id IS NULL";
            PreparedStatement psWinner = con.prepareStatement(winnerSQL);
            psWinner.executeUpdate();
            psWinner.close();

            // ✅ Step 3: Get all won auctions for the logged-in bidder
            if (bidderId != null) {
                String sql =
                    "SELECT i.id, i.title, i.image_path, i.current_bid, i.end_time, s.name AS seller_name " +
                    "FROM auction_items i " +
                    "JOIN sellers s ON i.seller_id = s.id " +
                    "WHERE i.winner_id = ? AND i.status = 'ended'";

                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, bidderId);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    JSONObject obj = new JSONObject();
                    obj.put("id", rs.getInt("id"));
                    obj.put("title", rs.getString("title"));
                    obj.put("image_path", rs.getString("image_path"));
                    obj.put("current_bid", rs.getDouble("current_bid"));
                    obj.put("end_time", rs.getString("end_time"));
                    obj.put("seller_name", rs.getString("seller_name"));
                    wonItems.put(obj);
                }

                rs.close();
                ps.close();
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        out.print(wonItems.toString());
        out.flush();
    }
}
