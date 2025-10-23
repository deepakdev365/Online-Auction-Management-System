package nextauction.servlet;

import nextauction.model.AuctionItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/BidsServlet")
public class BidsServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "RJP279";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<AuctionItem> items = new ArrayList<>();

        String sqlItems = "SELECT * FROM AuctionItem WHERE bidEndTime > NOW()";
        String sqlBids  = "SELECT bidderName, bidAmount FROM Bid WHERE itemId = ? ORDER BY bidTime DESC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                 PreparedStatement psItems = conn.prepareStatement(sqlItems)) {

                ResultSet rsItems = psItems.executeQuery();
                while (rsItems.next()) {
                    AuctionItem item = new AuctionItem();
                    try {
                        item.setId(rsItems.getInt("id"));
                        item.setName(rsItems.getString("name"));
                        item.setDescription(rsItems.getString("description"));
                        item.setStartingPrice(rsItems.getDouble("startingPrice"));
                        item.setStatus(rsItems.getString("status"));
                        item.setCurrentBid(rsItems.getDouble("currentBid"));
                        item.setBidEndTime(rsItems.getTimestamp("bidEndTime"));
                        item.setImagePath(rsItems.getString("imagePath"));

                        List<String> bids = new ArrayList<>();
                        try (PreparedStatement psBids = conn.prepareStatement(sqlBids)) {
                            psBids.setInt(1, item.getId());
                            try (ResultSet rsBids = psBids.executeQuery()) {
                                while (rsBids.next()) {
                                    bids.add(rsBids.getString("bidderName") + ": ₹" + rsBids.getDouble("bidAmount"));
                                }
                            }
                        }
                        item.setBids(bids);
                    } catch (SQLException e) {
                        e.printStackTrace();
                        throw new ServletException("Error parsing auction item data", e);
                    }
                    items.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Failed to load auction items", e);
        }

        request.setAttribute("auctionItems", items);
        request.getRequestDispatcher("bids.jsp").forward(request, response);
    }
}