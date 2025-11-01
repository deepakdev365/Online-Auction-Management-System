package nextauction.dao;

import java.sql.*;
import java.util.*;
import nextauction.model.AuctionItem;
import nextauction.util.DBUtil;

public class AuctionItemDao {

    // ✅ Insert a new auction item
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

            // ✅ Use setTimestamp instead of setString
            ps.setTimestamp(7, item.getStartTime());
            ps.setTimestamp(8, item.getEndTime());
            ps.setString(9, item.getStatus() != null ? item.getStatus() : "active");

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get all live auction items
    public List<AuctionItem> getLiveAuctions() {
        List<AuctionItem> list = new ArrayList<>();
        String sql = "SELECT * FROM auction_items WHERE status = 'active' ORDER BY end_time ASC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AuctionItem item = new AuctionItem();
                item.setItemId(rs.getInt("id"));
                item.setSellerId(rs.getInt("seller_id"));
                item.setTitle(rs.getString("title"));
                item.setDescription(rs.getString("description"));
                item.setCategory(rs.getString("category"));
                item.setStartPrice(rs.getDouble("start_price"));
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
