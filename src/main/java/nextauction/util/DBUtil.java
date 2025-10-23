package nextauction.util;
import java.sql.*;
public class DBUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/online_auction?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root"; // change
    private static final String PASS = "RJP279"; // change

    static {
        try { Class.forName("com.mysql.cj.jdbc.Driver"); } catch (ClassNotFoundException e) { e.printStackTrace(); }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
