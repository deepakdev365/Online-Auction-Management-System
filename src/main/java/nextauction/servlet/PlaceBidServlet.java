package nextauction.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;

@WebServlet("/placeBid")  
public class PlaceBidServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "RJP279";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        JSONObject json = new JSONObject();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            json.put("error", "Please log in to place a bid.");
            response.getWriter().print(json.toString());
            return;
        }

        int bidderId = (int) session.getAttribute("user_id");
        int itemId = Integer.parseInt(request.getParameter("item_id"));
        double bidAmount = Double.parseDouble(request.getParameter("bid_amount"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // Get current bid
            String query = "SELECT current_bid, end_time FROM auction_items WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                double currentBid = rs.getDouble("current_bid");
                Timestamp endTime = rs.getTimestamp("end_time");

                if (bidAmount <= currentBid) {
                    json.put("error", "Bid must be higher than current bid.");
                } else if (endTime.before(new Timestamp(System.currentTimeMillis()))) {
                    json.put("error", "Auction already ended.");
                } else {
                    // Update bid
                    String update = "UPDATE auction_items SET current_bid=?, highest_bidder_id=? WHERE id=?";
                    PreparedStatement ps2 = con.prepareStatement(update);
                    ps2.setDouble(1, bidAmount);
                    ps2.setInt(2, bidderId);
                    ps2.setInt(3, itemId);
                    ps2.executeUpdate();
                    ps2.close();

                    json.put("success", true);
                }
            } else {
                json.put("error", "Item not found.");
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            json.put("error", "Database error occurred.");
        }

        response.getWriter().print(json.toString());
    }
}
