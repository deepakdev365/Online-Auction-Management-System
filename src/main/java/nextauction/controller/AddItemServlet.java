package nextauction.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import org.json.JSONObject;

@WebServlet("/addItem")
@MultipartConfig
public class AddItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        JSONObject json = new JSONObject();

        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            double startPrice = Double.parseDouble(request.getParameter("start_price"));
            String startTime = request.getParameter("start_time");
            String endTime = request.getParameter("end_time");

            // image upload handling
            Part imagePart = request.getPart("image");
            String fileName = imagePart != null ? imagePart.getSubmittedFileName() : null;
            String uploadPath = getServletContext().getRealPath("") + "uploads" + File.separator;
            if (fileName != null && !fileName.isEmpty()) {
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                imagePart.write(uploadPath + fileName);
            }

            // Example DB connection (adjust table name as per your DB)
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/auctiondb", "root", "root");
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO auction_items (title, description, category, start_price, image_path, start_time, end_time, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, category);
            ps.setDouble(4, startPrice);
            ps.setString(5, fileName != null ? "uploads/" + fileName : null);
            ps.setString(6, startTime);
            ps.setString(7, endTime);
            ps.setString(8, "active");

            int rows = ps.executeUpdate();

            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    json.put("success", true);
                    json.put("id", rs.getInt(1));
                }
            } else {
                json.put("success", false);
                json.put("error", "Database insert failed.");
            }

            con.close();
        } catch (Exception e) {
            json.put("success", false);
            json.put("error", e.getMessage());
        }

        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}
