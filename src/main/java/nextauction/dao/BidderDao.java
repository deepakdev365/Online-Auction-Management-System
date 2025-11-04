package nextauction.dao;

import java.sql.*;
import java.util.*;
import nextauction.model.Bidder;
import nextauction.util.DBUtil;

public class BidderDao {

    // ✅ Register new bidder
    public boolean registerBidder(Bidder bidder) {
        String sql = "INSERT INTO bidders (full_name, email, phone, password, address, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, bidder.getFullName());
            ps.setString(2, bidder.getEmail());
            ps.setString(3, bidder.getPhone());
            ps.setString(4, bidder.getPassword());
            ps.setString(5, bidder.getAddress() != null ? bidder.getAddress() : ""); // optional field

            int rows = ps.executeUpdate();
            return rows > 0; // ✅ true if successfully inserted

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Validate bidder login
    public Bidder validateBidder(String email, String password) {
        Bidder bidder = null;
        String sql = "SELECT * FROM bidders WHERE email=? AND password=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                bidder = new Bidder();
                bidder.setBidderId(rs.getInt("bidder_id"));
                bidder.setFullName(rs.getString("full_name"));
                bidder.setEmail(rs.getString("email"));
                bidder.setPhone(rs.getString("phone"));
                bidder.setPassword(rs.getString("password"));
                bidder.setAddress(rs.getString("address"));
                bidder.setCreatedAt(rs.getTimestamp("created_at"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return bidder;
    }

    // ✅ Fetch all bidders (for admin view)
    public static List<Bidder> getAllBidders() {
        List<Bidder> list = new ArrayList<>();
        String sql = "SELECT * FROM bidders ORDER BY created_at DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Bidder bidder = new Bidder();
                bidder.setBidderId(rs.getInt("bidder_id"));
                bidder.setFullName(rs.getString("full_name"));
                bidder.setEmail(rs.getString("email"));
                bidder.setPhone(rs.getString("phone"));
                bidder.setAddress(rs.getString("address"));
                bidder.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(bidder);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
