package nextauction.servlet;



import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.util.DBUtil;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/seller")
@MultipartConfig(fileSizeThreshold = 1024*1024, // 1MB
                 maxFileSize = 5 * 1024 * 1024,  // 5MB
                 maxRequestSize = 10 * 1024 * 1024) // 10MB
public class SellerServlet extends HttpServlet {

    // helper to check seller login and redirect if not
    private boolean ensureSeller(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null || !"seller".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp"); // adjust path
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (!ensureSeller(req, resp)) return;

        switch (action == null ? "list" : action) {
            case "add":
                req.getRequestDispatcher("/WEB-INF/jsp/AddAuction.jsp").forward(req, resp);
                break;
            case "edit":
                showEditForm(req, resp);
                break;
            case "delete":
                deleteItem(req, resp);
                break;
            case "list":
            default:
                listItems(req, resp);
                break;
        }
    }

    private void listItems(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int sellerId = (Integer) req.getSession().getAttribute("userId");
        List<Item> items = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM auction_items WHERE seller_id = ?")) {
            ps.setInt(1, sellerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Item it = new Item(rs.getInt("id"), rs.getString("title"), rs.getString("description"),
                                       rs.getBigDecimal("start_price"), rs.getString("image_path"),
                                       rs.getTimestamp("start_time"), rs.getTimestamp("end_time"),
                                       rs.getString("status"));
                    items.add(it);
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
        req.setAttribute("items", items);
        req.getRequestDispatcher("/WEB-INF/jsp/SellerDashboard.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect("seller");
            return;
        }
        int id = Integer.parseInt(idStr);
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM auction_items WHERE id = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    req.setAttribute("item", rs);
                    req.getRequestDispatcher("/WEB-INF/jsp/EditAuction.jsp").forward(req, resp);
                    return;
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
        resp.sendRedirect("seller");
    }

    private void deleteItem(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect("seller");
            return;
        }
        int id = Integer.parseInt(idStr);
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM auction_items WHERE id = ?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        resp.sendRedirect("seller");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!ensureSeller(req, resp)) return;

        String action = req.getParameter("action");
        if ("create".equals(action)) {
            createItem(req, resp);
        } else if ("update".equals(action)) {
            updateItem(req, resp);
        } else {
            resp.sendRedirect("seller");
        }
    }

    private void createItem(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int sellerId = (Integer) req.getSession().getAttribute("userId");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String startPriceStr = req.getParameter("start_price");
        String startTime = req.getParameter("start_time");
        String endTime = req.getParameter("end_time");

        // handle image upload using Part API
        Part filePart = req.getPart("image");
        String imagePath = null;
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadsDir = req.getServletContext().getRealPath("/uploads");
            File uploads = new File(uploadsDir);
            if (!uploads.exists()) uploads.mkdirs();
            File file = new File(uploads, fileName);
            try (InputStream in = filePart.getInputStream()) {
                Files.copy(in, file.toPath());
                imagePath = "uploads/" + fileName; // relative path for serving
            }
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "INSERT INTO auction_items (seller_id, title, description, start_price, image_path, start_time, end_time) VALUES (?, ?, ?, ?, ?, ?, ?)")) {
            ps.setInt(1, sellerId);
            ps.setString(2, title);
            ps.setString(3, description);
            ps.setBigDecimal(4, new java.math.BigDecimal(startPriceStr));
            ps.setString(5, imagePath);
            ps.setTimestamp(6, Timestamp.valueOf(startTime));
            ps.setTimestamp(7, Timestamp.valueOf(endTime));
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        resp.sendRedirect("seller");
    }

    private void updateItem(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String idStr = req.getParameter("id");
        if (idStr == null) { resp.sendRedirect("seller"); return; }
        int id = Integer.parseInt(idStr);
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String startPriceStr = req.getParameter("start_price");

        String imagePath = null;
        Part filePart = req.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadsDir = req.getServletContext().getRealPath("/uploads");
            File uploads = new File(uploadsDir);
            if (!uploads.exists()) uploads.mkdirs();
            File file = new File(uploads, fileName);
            try (InputStream in = filePart.getInputStream()) {
                Files.copy(in, file.toPath());
                imagePath = "uploads/" + fileName;
            }
        }

        try (Connection conn = DBUtil.getConnection()) {
            String sql = imagePath == null
                ? "UPDATE auction_items SET title=?, description=?, start_price=? WHERE id=?"
                : "UPDATE auction_items SET title=?, description=?, start_price=?, image_path=? WHERE id=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, title);
                ps.setString(2, description);
                ps.setBigDecimal(3, new java.math.BigDecimal(startPriceStr));
                if (imagePath == null) {
                    ps.setInt(4, id);
                } else {
                    ps.setString(4, imagePath);
                    ps.setInt(5, id);
                }
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
        resp.sendRedirect("seller");
    }

    // lightweight item class (or create separate model file)
    public static class Item {
        public int id;
        public String title, description, image;
        public java.math.BigDecimal price;
        public Timestamp start, end;
        public String status;
        public Item(int id, String title, String description, java.math.BigDecimal price, String image, Timestamp start, Timestamp end, String status) {
            this.id = id; this.title = title; this.description = description; this.price = price; this.image = image; this.start = start; this.end = end; this.status = status;
        }
    }
}
