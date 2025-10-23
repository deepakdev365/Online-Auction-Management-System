package nextauction.servlet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.util.DBUtil;

import java.io.*;
import java.nio.file.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/addItem")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 5 * 1024 * 1024,   // 5MB
    maxRequestSize = 10 * 1024 * 1024
)
public class AddItemServlet extends HttpServlet {

    private static final DateTimeFormatter DTF = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
    private static final String IMAGE_UPLOAD_DIR = "uploads"; // relative to WebContent

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"error\":\"not_logged_in\"}");
            return;
        }
        int sellerId = (Integer) session.getAttribute("userId");

        // Get form parameters
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String startPriceStr = req.getParameter("start_price");
        String startTimeStr = req.getParameter("start_time");
        String endTimeStr = req.getParameter("end_time");

        if (title == null || startPriceStr == null || endTimeStr == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"missing_params\"}");
            return;
        }

        double startPrice;
        try {
            startPrice = Double.parseDouble(startPriceStr);
        } catch (NumberFormatException ex) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"invalid_start_price\"}");
            return;
        }

        Timestamp startTs = null;
        Timestamp endTs = null;
        try {
            if (startTimeStr != null && !startTimeStr.isEmpty())
                startTs = Timestamp.valueOf(LocalDateTime.parse(startTimeStr, DTF));
            endTs = Timestamp.valueOf(LocalDateTime.parse(endTimeStr, DTF));
        } catch (Exception ex) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"invalid_datetime_format\"}");
            return;
        }

        // Handle image upload
        String imagePath = null;
        Part filePart = req.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            ServletContext context = getServletContext();
            String uploadDir = context.getRealPath("/" + IMAGE_UPLOAD_DIR);
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) uploadFolder.mkdirs();

            String newFileName = System.currentTimeMillis() + "_" + fileName;
            File file = new File(uploadFolder, newFileName);
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
            imagePath = IMAGE_UPLOAD_DIR + "/" + newFileName; // relative path for browser
        }

        // Determine status
        String status = "active";
        if (startTs != null && startTs.after(new Timestamp(System.currentTimeMillis()))) {
            status = "pending";
        }

        // Insert into DB
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO auction_items (seller_id, title, description, start_price, current_bid, current_bidder_id, image_path, start_time, end_time, status) " +
                            "VALUES (?,?,?,?,?,?,?,?,?,?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setInt(1, sellerId);
            ps.setString(2, title);
            ps.setString(3, description);
            ps.setDouble(4, startPrice);
            ps.setObject(5, null); // current_bid
            ps.setObject(6, null); // current_bidder_id
            ps.setString(7, imagePath); // image_path
            ps.setTimestamp(8, startTs); // start_time
            ps.setTimestamp(9, endTs);   // end_time
            ps.setString(10, status);    // status

            int updated = ps.executeUpdate();
            if (updated > 0) {
                ResultSet keys = ps.getGeneratedKeys();
                int id = 0;
                if (keys.next()) id = keys.getInt(1);
                out.print("{\"success\":true, \"id\":" + id + ", \"image\":\"" + (imagePath != null ? imagePath : "") + "\"}");
            } else {
                resp.setStatus(500);
                out.print("{\"error\":\"insert_failed\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.setStatus(500);
            out.print("{\"error\":\"server_error\"}");
        }
    }
}
