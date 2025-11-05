package nextauction.Registration.dao;



import java.sql.*;

public class RegistrationDao {

    // ✅ Database connection settings
    private static final String DB_URL  = "jdbc:mysql://localhost:3306/auction";
    private static final String DB_USER = "root";

    private static final String DB_PASS = "Buster365@";


    // ✅ Method to register a new user
    public boolean registerUser(String name, String email, String password, String role) {
        boolean success = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // Check if email already exists
            PreparedStatement check = con.prepareStatement("SELECT * FROM users WHERE email=?");
            check.setString(1, email);
            ResultSet rs = check.executeQuery();
            if (rs.next()) {
                // Email already registered
                return false;
            }

            // Insert new user into DB
            String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                success = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }
}
