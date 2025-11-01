package nextauction.controller;


import java.io.*;
import java.nio.file.Paths;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddItemServlets")
@MultipartConfig
public class SellerDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        int sellerId = (int) session.getAttribute("user_id");

        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        double startPrice = Double.parseDouble(request.getParameter("start_price"));
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");

        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        new File(uploadPath).mkdirs();
        filePart.write(uploadPath + File.separator + fileName);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/online_auction", "root", "RJP279");

            String sql = "INSERT INTO auction_items (seller_id, title, category, description, start_price, image_path, start_time, end_time, status) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, sellerId);
            ps.setString(2, title);
            ps.setString(3, category);
            ps.setString(4, description);
            ps.setDouble(5, startPrice);
            ps.setString(6, "uploads/" + fileName);
            ps.setString(7, startTime);
            ps.setString(8, endTime);
            ps.setString(9, "active");  // ✅ changed from Pending → active

            int row = ps.executeUpdate();
            if (row > 0) {
                response.sendRedirect("SellerDashboard.jsp?msg=success");
            } else {
                response.sendRedirect("SellerDashboard.jsp?msg=fail");
            }

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SellerDashboard.jsp?msg=fail");
        }
    }
}
