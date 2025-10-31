package nextauction.dao;

import java.sql.*;
import nextauction.model.Seller;
import nextauction.util.DBUtil;

public class SellerDao {

    // ✅ Validate seller login
    public Seller validateSeller(String email, String password) {
        Seller seller = null;
        try (Connection con = DBUtil.getConnection()) {
            String sql = "SELECT * FROM sellers WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                seller = new Seller();
                seller.setSellerId(rs.getInt("seller_id"));
                seller.setFullName(rs.getString("full_name"));
                seller.setFatherName(rs.getString("father_name"));
                seller.setEmail(rs.getString("email"));
                seller.setPhone(rs.getString("phone"));
                seller.setCompanyName(rs.getString("company_name"));
                seller.setCompanyLocation(rs.getString("company_location"));
                seller.setAddress(rs.getString("address"));
                seller.setDocumentType(rs.getString("document_type"));
                seller.setDocumentPath(rs.getString("document_path"));
                seller.setRole(rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return seller;
    }

    // ✅ Register new seller
    public boolean registerSeller(Seller seller) {
        String sql = "INSERT INTO sellers (full_name, father_name, email, phone, password, company_name, company_location, address, document_type, document_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, seller.getFullName());
            ps.setString(2, seller.getFatherName());
            ps.setString(3, seller.getEmail());
            ps.setString(4, seller.getPhone());
            ps.setString(5, seller.getPassword());
            ps.setString(6, seller.getCompanyName());
            ps.setString(7, seller.getCompanyLocation());
            ps.setString(8, seller.getAddress());
            ps.setString(9, seller.getDocumentType());
            ps.setString(10, seller.getDocumentPath());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
