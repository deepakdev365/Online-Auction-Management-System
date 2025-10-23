package nextauction.servlet;

import nextauction.model.AuctionItem;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/SellerDashboard")
public class SellerServlet extends HttpServlet {

    // Database connection
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "RJP279";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<AuctionItem> items = new ArrayList<>();

        // Query to fetch all auction items
        String sql = "SELECT id, name, description, startingPrice, status, currentBid, endDate, imagePath FROM AuctionItem";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    AuctionItem item = new AuctionItem();

                    item.setId(rs.getInt("id"));
                    item.setName(rs.getString("name"));
                    item.setDescription(rs.getString("description"));
                    item.setStartingPrice(rs.getDouble("startingPrice"));
                    item.setStatus(rs.getString("status"));
                    item.setCurrentBid(rs.getDouble("currentBid"));
                    item.setEndDate(rs.getDate("endDate"));
                    item.setImagePath(rs.getString("imagePath")); // Ensure DB column name matches

                    items.add(item);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                throw new ServletException("Error loading auction items: " + e.getMessage());
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("JDBC Driver not found: " + e.getMessage());
        }

        // Check if items are actually loaded
        if (items.isEmpty()) {
            System.out.println("No auction items found in the database.");
        } else {
            System.out.println(items.size() + " auction items successfully loaded.");
        }

        // Send list to JSP
        request.setAttribute("sellerItems", items);

        // Forward to JSP for display
        request.getRequestDispatcher("SellerDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
