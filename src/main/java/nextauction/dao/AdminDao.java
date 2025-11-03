package nextauction.dao;

import nextauction.util.DBUtil;
import nextauction.model.User;
import nextauction.model.AuctionItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDao {

    public boolean validateAdmin(String email, String password) {
        String sql = "SELECT * FROM admin WHERE email = ? AND password = ?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getAdminName(String email) {
        String sql = "SELECT full_name FROM admin WHERE email = ?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("full_name");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Admin";
    }

    public List<User> getPendingSellers() {
        List<User> listP = new ArrayList<>();
        String sql = "SELECT id, name, email FROM users WHERE role='seller' AND status='pending'";

        try (Connection conx = DBUtil.getConnection();
             PreparedStatement pss = conx.prepareStatement(sql);
             ResultSet ress = pss.executeQuery()) {

            while (ress.next()) {
                User usr = new User();
                usr.setId(ress.getInt("id"));
                usr.setName(ress.getString("name"));
                usr.setEmail(ress.getString("email"));
                listP.add(usr);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listP;
    }

    public List<User> getVerifiedSellers() {
        List<User> verifiedSellers = new ArrayList<>();
        String sql = "SELECT id, name, email FROM users WHERE role='seller' AND status='verified'";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                verifiedSellers.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return verifiedSellers;
    }

    public List<AuctionItem> getAllItems() {
        List<AuctionItem> allItems = new ArrayList<>();
        String sql = "SELECT * FROM auction_items";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AuctionItem item = new AuctionItem();
                item.setItemId(rs.getInt("item_id"));
                item.setTitle(rs.getString("title"));
                item.setDescription(rs.getString("description"));
                item.setCategory(rs.getString("category"));
                item.setStartPrice(rs.getDouble("start_price"));
                item.setStatus(rs.getString("status"));
                allItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return allItems;
    }

    public boolean removeItem(int itemId) {
        String sql = "DELETE FROM auction_items WHERE item_id = ?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, itemId);
            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean verifySeller(int userId) {
        String sql = "UPDATE users SET status = 'verified' WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, userId);
            int rws = pst.executeUpdate();
            return rws == 1;

        } catch (SQLException exc) {
            System.err.println("Database error during verification for ID: " + userId);
            exc.printStackTrace();
        }
        return false;
    }

    public boolean rejectSeller(int userId) {
        String sql = "UPDATE users SET status = 'rejected' WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, userId);
            int rws = pst.executeUpdate();
            return rws == 1;

        } catch (SQLException exc) {
            System.err.println("Database error during rejection for ID: " + userId);
            exc.printStackTrace();
        }
        return false;
    }

    public boolean removeSeller(int sellerId) {
        String sql = "DELETE FROM users WHERE id = ? AND role = 'seller'";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, sellerId);
            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getSellerDetails(int sellerId) {
        String sql = "SELECT * FROM users WHERE id = ? AND role = 'seller'";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User seller = new User();
                seller.setId(rs.getInt("id"));
                seller.setName(rs.getString("name"));
                seller.setEmail(rs.getString("email"));
                return seller;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
