package nextauction.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import nextauction.model.Admin;

public class AdminDao {

    public Admin validateAdmin(String email, String password) {
        Admin admin= null;

        try (Connection con =DbConnection.getConnection()) {
            String sql= "SELECT * FROM admin WHERE email = ? AND password = ?";
            PreparedStatement ps= con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs= ps.executeQuery();
            if (rs.next()) {
                admin= new Admin(
                    rs.getString("email"),
                  rs.getString("fullname"),
                  rs.getString("password")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return admin;
    }
}
