package nextauction.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import org.json.JSONObject;
import nextauction.util.DBUtil;

@WebServlet("/placeBid")
public class PlaceBidServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        JSONObject json = new JSONObject();

        HttpSession session = request.getSession(false);
        if (session == null) {
            json.put("error", "Please log in to place a bid.");
            response.getWriter().print(json.toString());
            return;
        }

        // Check if user is admin
        if (session.getAttribute("admin") != null) {
            json.put("error", "Admin cannot place bids. Please use a bidder account.");
            response.getWriter().print(json.toString());
            return;
        }

        // Check if user is bidder
        if (session.getAttribute("bidder") == null) {
            json.put("error", "Please login as bidder to place a bid.");
            response.getWriter().print(json.toString());
            return;
        }

        int bidderId = (int) session.getAttribute("bidderId");
        int itemId = Integer.parseInt(request.getParameter("item_id"));
        double bidAmount = Double.parseDouble(request.getParameter("bid_amount"));

        try (Connection con = DBUtil.getConnection()) {
            String query = "SELECT start_price, current_bid, end_time FROM auction_items WHERE item_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                double startPrice = rs.getDouble("start_price");
                double currentBid = rs.getDouble("current_bid");
                Timestamp endTime = rs.getTimestamp("end_time");
                double minBid = (currentBid > 0) ? currentBid + 1 : startPrice + 1;

                if (bidAmount < minBid) {
                    json.put("error", "Bid must be higher than current bid. Minimum bid: ₹" + minBid);
                } else if (endTime.before(new Timestamp(System.currentTimeMillis()))) {
                    json.put("error", "Auction already ended.");
                } else {
                    // Update auction_items table
                    String updateItem = "UPDATE auction_items SET current_bid=?, highest_bidder_id=? WHERE item_id=?";
                    PreparedStatement ps2 = con.prepareStatement(updateItem);
                    ps2.setDouble(1, bidAmount);
                    ps2.setInt(2, bidderId);
                    ps2.setInt(3, itemId);
                    ps2.executeUpdate();
                    ps2.close();

                    // Record bid in bids table
                    String insertBid = "INSERT INTO bids (item_id, bidder_id, bid_amount) VALUES (?, ?, ?)";
                    PreparedStatement ps3 = con.prepareStatement(insertBid);
                    ps3.setInt(1, itemId);
                    ps3.setInt(2, bidderId);
                    ps3.setDouble(3, bidAmount);
                    ps3.executeUpdate();
                    ps3.close();

                    json.put("success", true);
                    json.put("message", "Bid placed successfully!");
                }
            } else {
                json.put("error", "Item not found.");
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
            json.put("error", "Database error occurred: " + e.getMessage());
        }

        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
    }
}