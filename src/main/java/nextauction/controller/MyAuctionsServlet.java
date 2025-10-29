package nextauction.controller;


import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/MyAuctionsServlet")
public class MyAuctionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "RJP279";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int sellerId = (int) session.getAttribute("user_id");

        out.println("<!DOCTYPE html>");
        out.println("<html><head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css' rel='stylesheet'>");
        out.println("<style>");
        out.println("body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }");
        out.println(".card { border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 20px; }");
        out.println(".card img { border-radius: 10px 10px 0 0; height: 200px; object-fit: cover; }");
        out.println("</style>");
        out.println("</head><body class='container py-3'>");
        out.println("<h3 class='text-primary mb-4'>📦 My Auctioned Items</h3>");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "SELECT * FROM auction_items WHERE seller_id=? ORDER BY created_at DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();

            boolean hasItems = false;

            while (rs.next()) {
                hasItems = true;
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String category = rs.getString("category");
                String desc = rs.getString("description");
                double startPrice = rs.getDouble("start_price");
                double currentBid = rs.getDouble("current_bid");
                String status = rs.getString("status");
                String imagePath = rs.getString("image_path");
                Timestamp endTime = rs.getTimestamp("end_time");

                out.println("<div class='card'>");
                if (imagePath != null && !imagePath.isEmpty()) {
                    out.println("<img src='" + imagePath + "' class='card-img-top' alt='Item Image'>");
                }
                out.println("<div class='card-body'>");
                out.println("<h5 class='card-title text-primary'>" + title + "</h5>");
                out.println("<p class='mb-1'><b>Category:</b> " + (category != null ? category : "N/A") + "</p>");
                out.println("<p class='mb-1'><b>Description:</b> " + desc + "</p>");
                out.println("<p class='mb-1'><b>Start Price:</b> ₹" + startPrice + "</p>");
                out.println("<p class='mb-1'><b>Current Bid:</b> ₹" + (currentBid > 0 ? currentBid : startPrice) + "</p>");
                out.println("<p class='mb-1'><b>Status:</b> <span class='text-" + 
                            (status.equalsIgnoreCase("active") ? "success" : status.equalsIgnoreCase("ended") ? "danger" : "secondary") + 
                            "'>" + status.toUpperCase() + "</span></p>");
                out.println("<p class='mb-1'><b>End Time:</b> " + endTime + "</p>");
                out.println("</div></div>");
            }

            if (!hasItems) {
                out.println("<div class='alert alert-secondary text-center'>You haven’t listed any items yet.</div>");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace(out);
            out.println("<div class='alert alert-danger mt-3'>Error loading auctions. Please try again later.</div>");
        }

        out.println("</body></html>");
    }
}
