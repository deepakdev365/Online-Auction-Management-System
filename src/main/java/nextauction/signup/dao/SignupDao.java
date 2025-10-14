package nextauction.signup.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SignupDao {

	
	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.driver");
		return DriverManager.getConnection("\"jdbc:mysql://localhost:3306/auction_db","root","Buster365@");
		
	}
}
