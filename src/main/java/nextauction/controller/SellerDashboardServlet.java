package nextauction.controller;


import java.io.*;
import java.nio.file.Paths;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SellerDashboardServlet")
@MultipartConfig
public class SellerDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addItem(request, response);
        } else if ("end".equals(action)) {
            endAuction(request, response);
        }
    }

    // 🟢 ADD ITEM
    private void addItem(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();
        int sellerId = (int) session.getAttribute("sellerId");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        double startPrice = Double.parseDouble(request.getParameter("startPrice"));
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");

        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        new File(uploadPath).mkdirs();
        filePart.write(uploadPath + File.separator + fileName);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/online_auction", "root", "RJP279");

            String sql = "INSERT INTO auction_items (seller_id, title, description, category, start_price, image_path, start_time, end_time, status) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, sellerId);
            ps.setString(2, title);
            ps.setString(3, description);
            ps.setString(4, category);
            ps.setDouble(5, startPrice);
            ps.setString(6, "uploads/" + fileName);
            ps.setString(7, startTime);
            ps.setString(8, endTime);
            ps.setString(9, "active");

            ps.executeUpdate();
            ps.close();
            con.close();

            response.sendRedirect("SellerDashboard.jsp?msg=ItemAdded");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SellerDashboard.jsp?msg=Error");
        }
    }

    // 🔴 END AUCTION
    private void endAuction(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/online_auction", "root", "RJP279");

            PreparedStatement ps = con.prepareStatement("UPDATE auction_items SET status='ended' WHERE id=?");
            ps.setInt(1, itemId);
            ps.executeUpdate();

            ps.close();
            con.close();
            response.sendRedirect("SellerDashboard.jsp?msg=AuctionEnded");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SellerDashboard.jsp?msg=ErrorEnding");
        }
    }
}
