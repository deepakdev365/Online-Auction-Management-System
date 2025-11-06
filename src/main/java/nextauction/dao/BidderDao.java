package nextauction.dao;

import java.sql.*;
import java.util.*;
import nextauction.model.Bidder;
import nextauction.util.DBUtil;

public class BidderDao {

    // ✅ Login Validation
    public Bidder validateBidder(String email, String password) {
        String sql = "SELECT * FROM bidders WHERE email=? AND password=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email.trim());
            ps.setString(2, password.trim());

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractBidder(rs);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error in validateBidder(): " + e.getMessage());
        }
        return null;
    }

    // ✅ Register New Bidder
    public boolean registerBidder(Bidder bidder) {
        String sql = "INSERT INTO bidders (full_name, email, phone, password, address, gender, birth_date, profile_image, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, bidder.getFullName());
            ps.setString(2, bidder.getEmail());
            ps.setString(3, bidder.getPhone());
            ps.setString(4, bidder.getPassword());
            ps.setString(5, bidder.getAddress());
            ps.setString(6, bidder.getGender());
            ps.setDate(7, bidder.getBirthDate());
            ps.setString(8, bidder.getProfileImage());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error in registerBidder(): " + e.getMessage());
        }
        return false;
    }

    // ✅ Update Full Profile (ProfileUploadServlet)
 // ✅ Update basic profile info (used in UpdateProfileServlet)
    public boolean updateBidderProfile(Bidder bidder) {
        String sql = "UPDATE bidders SET full_name=?, email=?, phone=?, address=?, gender=?, birth_date=? WHERE bidder_id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, bidder.getFullName());
            ps.setString(2, bidder.getEmail());
            ps.setString(3, bidder.getPhone());
            ps.setString(4, bidder.getAddress());
            ps.setString(5, bidder.getGender());
            ps.setDate(6, bidder.getBirthDate());
            ps.setInt(7, bidder.getBidderId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error in updateBidderProfile(): " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }


    // ✅ Extract Bidder
    private Bidder extractBidder(ResultSet rs) throws SQLException {
        Bidder bidder = new Bidder();
        bidder.setBidderId(rs.getInt("bidder_id"));
        bidder.setFullName(rs.getString("full_name"));
        bidder.setEmail(rs.getString("email"));
        bidder.setPhone(rs.getString("phone"));
        bidder.setPassword(rs.getString("password"));
        bidder.setAddress(rs.getString("address"));
        bidder.setGender(rs.getString("gender"));
        bidder.setBirthDate(rs.getDate("birth_date"));
        bidder.setProfileImage(rs.getString("profile_image"));
        bidder.setCreatedAt(rs.getTimestamp("created_at"));
        return bidder;
    }
}
