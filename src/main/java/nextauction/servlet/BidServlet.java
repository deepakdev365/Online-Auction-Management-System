package nextauction.servlet;

import nextauction.util.DBUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/placeBid")
public class BidServlet extends HttpServlet {

    // minimum increment (simple rule)
    private static final double MIN_INCREMENT = 1.0;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"error\":\"not_logged_in\"}");
            return;
        }
        int bidderId = (Integer) session.getAttribute("userId");

        String itemIdStr = req.getParameter("item_id");
        String bidAmountStr = req.getParameter("bid_amount");
        if (itemIdStr == null || bidAmountStr == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"missing_params\"}");
            return;
        }

        int itemId;
        double bidAmount;
        try {
            itemId = Integer.parseInt(itemIdStr);
            bidAmount = Double.parseDouble(bidAmountStr);
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"invalid_params\"}");
            return;
        }

        try (Connection con = DBUtil.getConnection()) {
            con.setAutoCommit(false);

            // lock row
            PreparedStatement lock = con.prepareStatement("SELECT current_bid, start_price, end_time, status FROM auction_items WHERE id = ? FOR UPDATE");
            lock.setInt(1, itemId);
            ResultSet rs = lock.executeQuery();
            if (!rs.next()) {
                con.rollback();
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"item_not_found\"}");
                return;
            }

            String status = rs.getString("status");
            Timestamp endTs = rs.getTimestamp("end_time");
            Object cbObj = rs.getObject("current_bid");
            Double currentBid = cbObj == null ? null : rs.getDouble("current_bid");
            double startPrice = rs.getDouble("start_price");

            // check if ended
            long now = System.currentTimeMillis();
            if ("ended".equalsIgnoreCase(status) || (endTs != null && endTs.getTime() <= now)) {
                PreparedStatement updateStatus = con.prepareStatement("UPDATE auction_items SET status='ended' WHERE id = ?");
                updateStatus.setInt(1, itemId);
                updateStatus.executeUpdate();
                con.commit();
                out.print("{\"error\":\"auction_ended\"}");
                return;
            }

            double minAccept = (currentBid == null) ? startPrice : (currentBid + MIN_INCREMENT);
            if (bidAmount < minAccept) {
                con.rollback();
                out.print("{\"error\":\"bid_too_low\", \"min\":" + minAccept + "}");
                return;
            }

            // insert bid
            PreparedStatement insertBid = con.prepareStatement("INSERT INTO bids (item_id, bidder_id, bid_amount, bid_time) VALUES (?,?,?,NOW())");
            insertBid.setInt(1, itemId);
            insertBid.setInt(2, bidderId);
            insertBid.setDouble(3, bidAmount);
            insertBid.executeUpdate();

            // update current bid
            PreparedStatement updateItem = con.prepareStatement("UPDATE auction_items SET current_bid = ?, current_bidder_id = ? WHERE id = ?");
            updateItem.setDouble(1, bidAmount);
            updateItem.setInt(2, bidderId);
            updateItem.setInt(3, itemId);
            updateItem.executeUpdate();

            con.commit();
            out.print("{\"success\":true, \"current_bid\":" + bidAmount + "}");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.setStatus(500);
            out.print("{\"error\":\"server_error\"}");
        }
    }
}
