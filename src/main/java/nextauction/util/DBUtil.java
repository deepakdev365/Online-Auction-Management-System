package nextauction.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
<<<<<<< HEAD

    private static final String URL = "jdbc:mysql://localhost:3306/auction";
    private static final String USER = "root";
    private static final String PASSWORD = "Buster365@";
=======
    
    private static final String URL = "jdbc:mysql://localhost:3306/auction"; 
    private static final String USER = "root"; 
    private static final String PASSWORD = "jyoti@2025"; 
>>>>>>> 31cef8d8d585f6cd5dd1568b5b1aee16e17d2c5a

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            return conn;
        } catch (SQLException e) {
           e.printStackTrace();
            return null;
        }
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
