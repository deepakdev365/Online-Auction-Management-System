package nextauction.dao;

import java.sql.*;
import nextauction.util.DBUtil;

public class BidDao {

    // ✅ Insert new bid
    public boolean placeBid(int bidderId, int itemId, double bidAmount) {
        Connection con = null;
        PreparedStatement psInsert = null;
        PreparedStatement psUpdate = null;

        try {
            con = DBUtil.getConnection();
            con.setAutoCommit(false);

            // ✅ Step 1: Insert bid record
            String insertSql = "INSERT INTO bids (auction_item_id, bidder_id, bid_amount) VALUES (?, ?, ?)";
            psInsert = con.prepareStatement(insertSql);
            psInsert.setInt(1, itemId);
            psInsert.setInt(2, bidderId);
            psInsert.setDouble(3, bidAmount);
            psInsert.executeUpdate();

            // ✅ Step 2: Update current bid in auction_items
            String updateSql = "UPDATE auction_items SET current_bid = ? WHERE item_id = ?";
            psUpdate = con.prepareStatement(updateSql);
            psUpdate.setDouble(1, bidAmount);
            psUpdate.setInt(2, itemId);
            psUpdate.executeUpdate();

            con.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try { if (con != null) con.rollback(); } catch (SQLException ignored) {}
        } finally {
            try { if (psInsert != null) psInsert.close(); } catch (SQLException ignored) {}
            try { if (psUpdate != null) psUpdate.close(); } catch (SQLException ignored) {}
            try { if (con != null) con.close(); } catch (SQLException ignored) {}
        }
        return false;
    }

    // ✅ Get highest bid for a given item
    public double getHighestBid(int itemId) {
        double highestBid = 0.0;

        String sql = "SELECT MAX(bid_amount) AS highest FROM bids WHERE auction_item_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                highestBid = rs.getDouble("highest");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return highestBid;
    }
}
