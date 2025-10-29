package nextauction.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {
	private static Connection con;
	public static Connection getConnection() {
		try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_auction","root","jyoti@2025");
	}
		catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	

}

