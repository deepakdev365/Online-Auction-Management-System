package auction.loginreg.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.jsp.tagext.TryCatchFinally;

import auction.loginreg.model.Login_Reg;

public class Login_RegDao {
	public static Connection getconnection() throws ClassNotFoundException, SQLException{
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	return DriverManager.getConnection("jdbc:mysql://localhost:3306/auction","root","Buster365@");
	}
	public Login_Reg checkRole() {
		Login_Reg loginreg = null;
		Connection con = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
	
	try {
		con=Login_RegDao.getconnection();
		ps=con.prepareStatement("");
		
		
	} catch (Exception e) {
		// TODO: handle exception
	}
	return loginreg;
	}
}
