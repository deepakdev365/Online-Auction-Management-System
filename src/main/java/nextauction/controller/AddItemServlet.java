package nextauction.controller;

import java.io.*;
import java.sql.Timestamp;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import nextauction.dao.AddItemDao;
import nextauction.model.AuctionItem;
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
            // ✅ Get seller ID from session
            HttpSession session = request.getSession(false);
            Integer sellerId = (session != null) ? (Integer) session.getAttribute("seller_id") : null;

            if (sellerId == null) {
                json.put("success", false);
                json.put("error", "Seller not logged in!");
                response.getWriter().print(json);
                return;
            }

            // ✅ Read form fields
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            double startPrice = Double.parseDouble(request.getParameter("start_price"));
            String startTimeStr = request.getParameter("start_time");
            String endTimeStr = request.getParameter("end_time");

            // ✅ Convert date/time strings to Timestamp
            Timestamp startTime = Timestamp.valueOf(startTimeStr.replace("T", " ") + ":00");
            Timestamp endTime = Timestamp.valueOf(endTimeStr.replace("T", " ") + ":00");

            // ✅ Handle image upload
            Part imagePart = request.getPart("image");
            String fileName = null;
            if (imagePart != null && imagePart.getSize() > 0) {
                fileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                imagePart.write(uploadPath + File.separator + fileName);
            }

            // ✅ Prepare item model
            AuctionItem item = new AuctionItem();
            item.setSellerId(sellerId);
            item.setTitle(title);
            item.setDescription(description);
            item.setCategory(category);
            item.setStartPrice(startPrice);
            item.setImagePath(fileName != null ? "uploads/" + fileName : null);
            item.setStartTime(startTime);
            item.setEndTime(endTime);
            item.setStatus("active");

            // ✅ Insert item using DAO
            AddItemDao dao = new AddItemDao();
            int itemId = dao.addItem(item);

            if (itemId > 0) {
                json.put("success", true);
                json.put("id", itemId);
            } else {
                json.put("success", false);
                json.put("error", "Database insertion failed.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            json.put("success", false);
            json.put("error", e.getMessage());
        }

        // ✅ Send JSON response
        response.getWriter().print(json);
    }
}
