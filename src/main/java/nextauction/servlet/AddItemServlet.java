package nextauction.servlet;

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

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/online_auction";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "jyoti@2025";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        JSONObject json = new JSONObject();

        try (PrintWriter out = response.getWriter()) {

            // ===== Check session =====
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user_id") == null) {
                json.put("success", false);
                json.put("error", "User not logged in");
                out.print(json.toString());
                return;
            }

            int sellerId = (int) session.getAttribute("user_id");

            // ===== Get form data =====
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String startPriceStr = request.getParameter("start_price");
            String startTime = request.getParameter("start_time");
            String endTime = request.getParameter("end_time");
            Part imagePart = request.getPart("image");

            if (title == null || title.trim().isEmpty() ||
                startPriceStr == null || startPriceStr.trim().isEmpty() ||
                endTime == null || endTime.trim().isEmpty()) {

                json.put("success", false);
                json.put("error", "All required fields must be filled");
                out.print(json.toString());
                return;
            }

            // ===== Handle Image Upload =====
            String imagePath = null;
            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                imagePart.write(uploadPath + File.separator + fileName);
                imagePath = "uploads/" + fileName;
            }

            double startPrice = Double.parseDouble(startPriceStr);

            // ===== Save to Database =====
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sql = "INSERT INTO auction_items "
                           + "(seller_id, title, description, start_price, image_path, start_time, end_time, status) "
                           + "VALUES (?, ?, ?, ?, ?, ?, ?, 'active')";
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, sellerId);
                ps.setString(2, title);
                ps.setString(3, description);
                ps.setDouble(4, startPrice);
                ps.setString(5, imagePath);
                ps.setString(6, (startTime == null || startTime.isEmpty()) ? null : startTime);
                ps.setString(7, endTime);

                int row = ps.executeUpdate();
                if (row > 0) {
                    ResultSet rs = ps.getGeneratedKeys();
                    int itemId = 0;
                    if (rs.next()) itemId = rs.getInt(1);
                    json.put("success", true);
                    json.put("id", itemId);
                    System.out.println("✅ Item added successfully. ID = " + itemId);
                } else {
                    json.put("success", false);
                    json.put("error", "Failed to insert into DB");
                    System.out.println("❌ Insert returned 0 rows.");
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            JSONObject error = new JSONObject();
            try {
                error.put("success", false);
                error.put("error", e.getMessage());
            } catch (Exception ignored) {}
            response.getWriter().print(error.toString());
        }
    }
}
