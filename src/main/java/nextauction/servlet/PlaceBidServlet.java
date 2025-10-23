package nextauction.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/PlaceBidServlet")
public class PlaceBidServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "RJP279";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int itemId = Integer.parseInt(request.getParameter("itemId"));
        String bidderName = request.getParameter("bidderName");
        double bidAmount = Double.parseDouble(request.getParameter("bidAmount"));

        String sqlCheck = "SELECT bidEndTime FROM AuctionItem WHERE id = ?";
        String sqlInsertBid = "INSERT INTO Bid (itemId, bidderName, bidAmount) VALUES (?, ?, ?)";
        String sqlUpdateBid = "UPDATE AuctionItem SET currentBid = ? WHERE id = ? AND currentBid < ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

                try (PreparedStatement psCheck = conn.prepareStatement(sqlCheck)) {
                    psCheck.setInt(1, itemId);
                    ResultSet rs = psCheck.executeQuery();
                    if (rs.next()) {
                        Timestamp bidEndTime = rs.getTimestamp("bidEndTime");
                        if (bidEndTime.before(new Timestamp(System.currentTimeMillis()))) {
                            response.sendRedirect("BidsServlet?msg=Auction Ended. Bid rejected.");
                            return;
                        }
                    }
                }

                conn.setAutoCommit(false);

                try (PreparedStatement psInsert = conn.prepareStatement(sqlInsertBid)) {
                    psInsert.setInt(1, itemId);
                    psInsert.setString(2, bidderName);
                    psInsert.setDouble(3, bidAmount);
                    psInsert.executeUpdate();
                }

                try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdateBid)) {
                    psUpdate.setDouble(1, bidAmount);
                    psUpdate.setInt(2, itemId);
                    psUpdate.setDouble(3, bidAmount);
                    psUpdate.executeUpdate();
                }

                conn.commit();
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }

        response.sendRedirect("BidsServlet");
    }
}
