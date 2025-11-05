package nextauction.login.dao;

import java.sql.*;

public class LoginDao {

    // ✅ Database connection details
    private static final String DB_URL  = "jdbc:mysql://localhost:3306/auction";
    private static final String DB_USER = "root";

    private static final String DB_PASS = "Buster365@";


    /**
     * Validate user credentials against the database.
     * Returns a ResultSet-like object (UserData) if valid, otherwise null.
     */
    public UserData validateUser(String email, String password) {
        UserData user = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                user = new UserData();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return user;
    }

    // ✅ Inner class to hold user data
    public static class UserData {
        private int id;
        private String name;
        private String email;
        private String role;

        // Getters and setters
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public String getRole() { return role; }
        public void setRole(String role) { this.role = role; }
    }
}
