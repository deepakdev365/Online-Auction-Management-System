package com.onlineauction.servlet;


import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static Connection conn;
    public static Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/online_auction",
                    "root", "RJP279");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}

