package nextauction.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String USER = "root";
    private static final String PASSWORD = "jyoti@2025";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ MySQL JDBC Driver loaded successfully!");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Failed to load JDBC Driver!");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            System.err.println("❌ Database connection failed!");
            e.printStackTrace();
            return null;
        }
    }
}