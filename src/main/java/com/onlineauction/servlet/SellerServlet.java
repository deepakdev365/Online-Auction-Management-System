package com.onlineauction.servlet;



import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;


public class SellerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Connection con = DBConnection.getConnection();
        List<Map<String, String>> items = new ArrayList<>();

        try {
            HttpSession session = req.getSession();
            String username = (String) session.getAttribute("username");

            PreparedStatement psUser = con.prepareStatement("SELECT id FROM users WHERE username=?");
            psUser.setString(1, username);
            ResultSet rsUser = psUser.executeQuery();
            int sellerId = 0;
            if (rsUser.next()) sellerId = rsUser.getInt("id");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM auction_items WHERE seller_id=?");
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("id", rs.getString("id"));
                item.put("title", rs.getString("title"));
                item.put("description", rs.getString("description"));
                item.put("price", rs.getString("start_price"));
                items.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("items", items);
        RequestDispatcher rd = req.getRequestDispatcher("SellerDashboard.jsp");
        rd.forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Connection con = DBConnection.getConnection();
        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                HttpSession session = req.getSession();
                String username = (String) session.getAttribute("username");
                PreparedStatement psUser = con.prepareStatement("SELECT id FROM users WHERE username=?");
                psUser.setString(1, username);
                ResultSet rsUser = psUser.executeQuery();
                int sellerId = 0;
                if (rsUser.next()) sellerId = rsUser.getInt("id");

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO auction_items (seller_id, title, description, start_price) VALUES (?,?,?,?)");
                ps.setInt(1, sellerId);
                ps.setString(2, req.getParameter("title"));
                ps.setString(3, req.getParameter("description"));
                ps.setDouble(4, Double.parseDouble(req.getParameter("price")));
                ps.executeUpdate();
                res.sendRedirect("SellerServlet");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

