package nextauction.servlet;

import nextauction.model.AuctionItem;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/AddItemServlet")
@MultipartConfig
public class AddItemServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "RJP279";
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String appPath = request.getServletContext().getRealPath("");
        String uploadPath = appPath + File.separator + UPLOAD_DIR;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        filePart.write(uploadPath + File.separator + fileName);

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double startingPrice = Double.parseDouble(request.getParameter("startingPrice"));
        Date endDate = null;
        try {
            endDate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("endDate"));
        } catch (Exception e) {
            e.printStackTrace();
        }

        String imagePath = UPLOAD_DIR + "/" + fileName;

        String sql = "INSERT INTO AuctionItem(name, description, startingPrice, status, currentBid, endDate, imagePath) VALUES(?, ?, ?, ?, ?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, name);
                ps.setString(2, description);
                ps.setDouble(3, startingPrice);
                ps.setString(4, "Active");
                ps.setDouble(5, startingPrice);
                if (endDate != null) ps.setDate(6, new java.sql.Date(endDate.getTime()));
                else ps.setDate(6, null);
                ps.setString(7, imagePath);

                ps.executeUpdate();
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }

        response.sendRedirect("SellerDashboard");
    }
}
