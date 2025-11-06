package nextauction.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import nextauction.model.Bid;
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
            String insertSql = "INSERT INTO bids (auction_item_id, bidder_id, bid_amount, bid_time) VALUES (?, ?, ?, NOW())";
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
            try {
                if (con != null) con.rollback();
            } catch (SQLException ignored) {}
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

    // ✅ Get all bids placed by a specific bidder
    public List<Bid> getBidsByBidder(int bidderId) {
        List<Bid> bids = new ArrayList<>();
        String sql = "SELECT b.*, ai.title AS item_title FROM bids b "
                   + "JOIN auction_items ai ON b.auction_item_id = ai.item_id "
                   + "WHERE b.bidder_id = ? ORDER BY b.bid_time DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bidderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Bid bid = new Bid();
                bid.setBidId(rs.getInt("bid_id"));
                bid.setAuctionItemId(rs.getInt("auction_item_id"));
                bid.setBidderId(rs.getInt("bidder_id"));
                bid.setBidAmount(rs.getDouble("bid_amount"));
                bid.setBidTime(rs.getTimestamp("bid_time"));
                bid.setItemTitle(rs.getString("item_title"));
                bids.add(bid);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bids;
    }
}
