package nextauction.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;

@WebServlet("/placeBid")
public class PlaceBidServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            jsonResponse.put("error", "User not logged in");
            out.print(jsonResponse.toString());
            return;
        }

        int bidderId = (int) session.getAttribute("user_id");
        double bidAmount = Double.parseDouble(request.getParameter("bid_amount"));
        int itemId = Integer.parseInt(request.getParameter("item_id"));

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/online_auction", "root", "RJP279");

            // ✅ 1. Check if auction is active and fetch current highest bid
            String checkSQL = "SELECT current_bid, start_price, status, end_time FROM auction_items WHERE id = ?";
            ps = con.prepareStatement(checkSQL);
            ps.setInt(1, itemId);
            rs = ps.executeQuery();

            if (!rs.next()) {
                jsonResponse.put("error", "Auction item not found");
            } else if (!"active".equalsIgnoreCase(rs.getString("status"))) {
                jsonResponse.put("error", "Auction is not active");
            } else {
                double currentBid = rs.getDouble("current_bid");
                double startPrice = rs.getDouble("start_price");
                double minAllowedBid = (currentBid > 0 ? currentBid : startPrice) + 1.0;

                if (bidAmount < minAllowedBid) {
                    jsonResponse.put("error", "Bid must be higher than ₹" + minAllowedBid);
                } else {
                    // ✅ 2. Insert bid
                    String insertSQL = "INSERT INTO bids (item_id, bidder_id, bid_amount) VALUES (?, ?, ?)";
                    PreparedStatement psInsert = con.prepareStatement(insertSQL);
                    psInsert.setInt(1, itemId);
                    psInsert.setInt(2, bidderId);
                    psInsert.setDouble(3, bidAmount);
                    psInsert.executeUpdate();
                    psInsert.close();

                    // ✅ 3. Update current bid in auction_items
                    String updateSQL = "UPDATE auction_items SET current_bid = ? WHERE id = ?";
                    PreparedStatement psUpdate = con.prepareStatement(updateSQL);
                    psUpdate.setDouble(1, bidAmount);
                    psUpdate.setInt(2, itemId);
                    psUpdate.executeUpdate();
                    psUpdate.close();

                    jsonResponse.put("success", true);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("error", "Database error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }

        out.print(jsonResponse.toString());
        out.flush();
    }
}
