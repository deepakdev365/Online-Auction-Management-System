package nextauction.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import org.json.JSONObject;
import nextauction.dao.AddItemDao;
import nextauction.model.AuctionItem;
import nextauction.model.Seller;

@WebServlet("/addItem")
@MultipartConfig
public class AddItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        JSONObject json = new JSONObject();

        try {
            // --- Form fields ---
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            double startPrice = Double.parseDouble(request.getParameter("start_price"));
            String startTime = request.getParameter("start_time");
            String endTime = request.getParameter("end_time");

            // --- Seller info from session ---
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("seller") == null) {
                json.put("success", false);
                json.put("error", "Session expired. Please log in again.");
                response.getWriter().print(json);
                return;
            }

            Seller seller = (Seller) session.getAttribute("seller");

            // --- File upload ---
            Part imagePart = request.getPart("image");
            String fileName = imagePart != null ? imagePart.getSubmittedFileName() : null;
            String uploadPath = getServletContext().getRealPath("") + "uploads" + File.separator;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            if (fileName != null && !fileName.isEmpty()) {
                imagePart.write(uploadPath + fileName);
            }

            // --- Create AuctionItem object ---
            AuctionItem item = new AuctionItem();
            item.setSellerId(seller.getSellerId());
            item.setTitle(title);
            item.setDescription(description);
            item.setCategory(category);
            item.setStartPrice(startPrice);
            item.setStartTime(startTime);
            item.setEndTime(endTime);
            item.setImagePath(fileName != null ? "uploads/" + fileName : null);

            // --- Save to DB ---
            AddItemDao dao = new AddItemDao();
            int id = dao.addItem(item);

            if (id > 0) {
                json.put("success", true);
                json.put("id", id);
            } else {
                json.put("success", false);
                json.put("error", "Item could not be added. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            json.put("success", false);
            json.put("error", e.getMessage());
        }

        response.getWriter().print(json);
    }
}
