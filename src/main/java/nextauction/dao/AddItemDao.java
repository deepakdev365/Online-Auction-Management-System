package nextauction.dao;

import java.sql.*;
import nextauction.model.AuctionItem;

public class AddItemDao {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "jyoti@2025";

    // Add new auction item, returns generated id or -1 on failure
    public int addItem(AuctionItem item) {
        int generatedId = -1;

        String sql = "INSERT INTO auction_items (seller_id, title, description, category, start_price, image_path, start_time, end_time, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // ensure driver is loaded
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
            return -1;
        }

        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, item.getSellerId());
            ps.setString(2, item.getTitle());
            ps.setString(3, item.getDescription());
            ps.setString(4, item.getCategory());
            ps.setDouble(5, item.getStartPrice());
            ps.setString(6, item.getImagePath());

            // use setTimestamp for Timestamp fields, handle nulls
            Timestamp sTime = item.getStartTime();
            Timestamp eTime = item.getEndTime();

            if (sTime != null) {
                ps.setTimestamp(7, sTime);
            } else {
                ps.setNull(7, Types.TIMESTAMP);
            }

            if (eTime != null) {
                ps.setTimestamp(8, eTime);
            } else {
                ps.setNull(8, Types.TIMESTAMP);
            }

            ps.setString(9, item.getStatus() != null ? item.getStatus() : "active");

            int rows = ps.executeUpdate();

            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return generatedId;
    }
}
