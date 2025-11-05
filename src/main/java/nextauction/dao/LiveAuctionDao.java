package nextauction.dao;

import java.sql.*;
import java.util.*;
import nextauction.model.AuctionItem;

public class LiveAuctionDao {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "RJP279";

    // ✅ Fetch all active (live) auctions
    public List<AuctionItem> getLiveAuctions() {
        List<AuctionItem> auctions = new ArrayList<>();

        String sql = "SELECT * FROM auction_items WHERE status='active' ORDER BY end_time ASC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    AuctionItem item = new AuctionItem();
                    item.setItemId(rs.getInt("item_id"));
                    item.setTitle(rs.getString("title"));
                    item.setDescription(rs.getString("description"));
                    item.setCategory(rs.getString("category"));
                    item.setStartPrice(rs.getDouble("start_price"));
                    item.setImagePath(rs.getString("image_path"));
                    item.setEndTime(rs.getTimestamp("end_time"));
                    auctions.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return auctions;
    }
}
