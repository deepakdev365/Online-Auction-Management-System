package nextauction.dao;

import java.sql.*;
import nextauction.model.AuctionItem;

public class AddItemDao {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "jyoti@2025";

    // ✅ Add new auction item
    public int addItem(AuctionItem item) {
        int generatedId = -1;

        String sql = "INSERT INTO auction_items (seller_id, title, description, category, start_price, image_path, start_time, end_time, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            // Load driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

                // ✅ Bind values safely
                ps.setInt(1, item.getSellerId());
                ps.setString(2, item.getTitle());
                ps.setString(3, item.getDescription());
                ps.setString(4, item.getCategory());
                ps.setDouble(5, item.getStartPrice());
                ps.setString(6, item.getImagePath());

                // ✅ Use setTimestamp for Timestamp values
                ps.setTimestamp(7, item.getStartTime());
                ps.setTimestamp(8, item.getEndTime());

                ps.setString(9, "active");

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            generatedId = rs.getInt(1);
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return generatedId;
    }
}
