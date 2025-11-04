package nextauction.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.dao.BidDao;
import org.json.JSONObject;

@WebServlet("/placeBid")
public class PlaceBidServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        JSONObject json = new JSONObject();

        try {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            double bidAmount = Double.parseDouble(request.getParameter("bidAmount"));
            
            // ✅ Normally from session after bidder login
            HttpSession session = request.getSession();
            Integer bidderId = (Integer) session.getAttribute("bidderId");

            if (bidderId == null) {
                json.put("success", false);
                json.put("error", "You must be logged in as a bidder to place a bid.");
            } else {
                BidDao dao = new BidDao();
                boolean success = dao.placeBid(bidderId, itemId, bidAmount);

                if (success) {
                    json.put("success", true);
                    json.put("message", "Bid placed successfully!");
                } else {
                    json.put("success", false);
                    json.put("error", "Failed to place bid. Try again.");
                }
            }
        } catch (Exception e) {
            json.put("success", false);
            json.put("error", e.getMessage());
        }

        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}
