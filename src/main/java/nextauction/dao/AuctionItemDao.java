package nextauction.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import nextauction.model.AuctionItem;
import nextauction.util.DBUtil;

public class AuctionItemDao {

    public boolean addItem(AuctionItem item) {
        String sql = "INSERT INTO auction_items (seller_id, title, description, category, start_price, image_path, start_time, end_time, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, item.getSellerId());
            ps.setString(2, item.getTitle());
            ps.setString(3, item.getDescription());
            ps.setString(4, item.getCategory());
            ps.setDouble(5, item.getStartPrice());
            ps.setString(6, item.getImagePath());
            ps.setTimestamp(7, item.getStartTime());
            ps.setTimestamp(8, item.getEndTime());
            ps.setString(9, item.getStatus() != null ? item.getStatus() : "active");

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<AuctionItem> getLiveAuctions() {
        List<AuctionItem> list = new ArrayList<>();
        String sql = "SELECT * FROM auction_items WHERE status = 'active' AND end_time > NOW() ORDER BY end_time ASC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AuctionItem item = new AuctionItem();
                item.setItemId(rs.getInt("item_id"));
                item.setSellerId(rs.getInt("seller_id"));
                item.setTitle(rs.getString("title"));
                item.setDescription(rs.getString("description"));
                item.setCategory(rs.getString("category"));
                item.setStartPrice(rs.getDouble("start_price"));
                item.setCurrentBid(rs.getDouble("current_bid"));
                item.setImagePath(rs.getString("image_path"));
                item.setStartTime(rs.getTimestamp("start_time"));
                item.setEndTime(rs.getTimestamp("end_time"));
                item.setStatus(rs.getString("status"));
                list.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public AuctionItem getItemById(int itemId) {
        String sql = "SELECT * FROM auction_items WHERE item_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                AuctionItem item = new AuctionItem();
                item.setItemId(rs.getInt("item_id"));
                item.setSellerId(rs.getInt("seller_id"));
                item.setTitle(rs.getString("title"));
                item.setDescription(rs.getString("description"));
                item.setCategory(rs.getString("category"));
                item.setStartPrice(rs.getDouble("start_price"));
                item.setCurrentBid(rs.getDouble("current_bid"));
                item.setImagePath(rs.getString("image_path"));
                item.setStartTime(rs.getTimestamp("start_time"));
                item.setEndTime(rs.getTimestamp("end_time"));
                item.setStatus(rs.getString("status"));
                return item;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<AuctionItem> getItemsBySeller(int sellerId) {
        List<AuctionItem> list = new ArrayList<>();
        String sql = "SELECT * FROM auction_items WHERE seller_id = ? ORDER BY item_id DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                AuctionItem item = new AuctionItem();
                item.setItemId(rs.getInt("item_id"));
                item.setSellerId(rs.getInt("seller_id"));
                item.setTitle(rs.getString("title"));
                item.setDescription(rs.getString("description"));
                item.setCategory(rs.getString("category"));
                item.setStartPrice(rs.getDouble("start_price"));
                item.setCurrentBid(rs.getDouble("current_bid"));
                item.setImagePath(rs.getString("image_path"));
                item.setStartTime(rs.getTimestamp("start_time"));
                item.setEndTime(rs.getTimestamp("end_time"));
                item.setStatus(rs.getString("status"));
                list.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateItemStatus(int itemId, String status) {
        String sql = "UPDATE auction_items SET status = ? WHERE item_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, itemId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<AuctionItem> getEndedAuctionsWithWinners() {
        List<AuctionItem> list = new ArrayList<>();
        String sql = "SELECT ai.*, u.name as winner_name FROM auction_items ai " +
                     "LEFT JOIN users u ON ai.highest_bidder_id = u.id " +
                     "WHERE ai.status = 'ended' AND ai.end_time < NOW() " +
                     "ORDER BY ai.end_time DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AuctionItem item = new AuctionItem();
                item.setItemId(rs.getInt("item_id"));
                item.setSellerId(rs.getInt("seller_id"));
                item.setTitle(rs.getString("title"));
                item.setDescription(rs.getString("description"));
                item.setCategory(rs.getString("category"));
                item.setStartPrice(rs.getDouble("start_price"));
                item.setCurrentBid(rs.getDouble("current_bid"));
                item.setImagePath(rs.getString("image_path"));
                item.setStartTime(rs.getTimestamp("start_time"));
                item.setEndTime(rs.getTimestamp("end_time"));
                item.setStatus(rs.getString("status"));
                list.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
