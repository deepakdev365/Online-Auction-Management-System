package nextauction.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;

@WebServlet("/placeBid")
public class PlaceBidServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "jyoti@2025";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        JSONObject json = new JSONObject();

        try {
            int itemId = Integer.parseInt(request.getParameter("item_id"));
            double bidAmount = Double.parseDouble(request.getParameter("bid_amount"));

            // ✅ Fetch current user from session
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user_id") == null) {
                json.put("error", "Please log in to place a bid.");
                response.getWriter().print(json.toString());
                return;
            }

            int userId = (int) session.getAttribute("user_id");

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // ✅ Step 1: Get current highest bid
                String checkSql = "SELECT current_bid FROM auction_items WHERE id = ?";
                PreparedStatement checkPs = con.prepareStatement(checkSql);
                checkPs.setInt(1, itemId);
                ResultSet rs = checkPs.executeQuery();

                if (!rs.next()) {
                    json.put("error", "Item not found.");
                } else {
                    double currentBid = rs.getDouble("current_bid");
                    if (bidAmount <= currentBid) {
                        json.put("error", "Your bid must be higher than the current bid.");
                    } else {
                        // ✅ Step 2: Update auction item with new bid
                        String updateSql = "UPDATE auction_items SET current_bid=?, current_bidder_id=? WHERE id=?";
                        PreparedStatement updatePs = con.prepareStatement(updateSql);
                        updatePs.setDouble(1, bidAmount);
                        updatePs.setInt(2, userId);
                        updatePs.setInt(3, itemId);

                        int rows = updatePs.executeUpdate();
                        if (rows > 0) {
                            json.put("success", true);
                            json.put("message", "Bid placed successfully!");
                        } else {
                            json.put("error", "Bid failed, please try again.");
                        }
                    }
                }

                rs.close();
                checkPs.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
            json.put("error", "Server error: " + e.getMessage());
        }

        response.getWriter().print(json.toString());
    }
}
