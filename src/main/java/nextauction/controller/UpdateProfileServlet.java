package nextauction.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.dao.BidderDao;
import nextauction.model.Bidder;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("bidder") == null) {
            response.sendRedirect("bidderlogin.jsp");
            return;
        }

        // ✅ Get bidder object from session
        Bidder bidder = (Bidder) session.getAttribute("bidder");

        // ✅ Get updated form values
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String birthDate = request.getParameter("birthDate");

        // ✅ Update bidder object
        bidder.setFullName(name);
        bidder.setEmail(email);
        bidder.setPhone(mobile);
        bidder.setAddress(address);
        bidder.setGender(gender);
        if (birthDate != null && !birthDate.isEmpty()) {
            bidder.setBirthDate(java.sql.Date.valueOf(birthDate));
        } else {
            bidder.setBirthDate(null);
        }

        // ✅ Update database
        BidderDao dao = new BidderDao();
        boolean updated = dao.updateBidderProfile(bidder);

        if (updated) {
            // ✅ Update session attributes
            session.setAttribute("bidder", bidder);
            session.setAttribute("bidderName", name);
            session.setAttribute("bidderEmail", email);
            session.setAttribute("bidderMobile", mobile);
            session.setAttribute("bidderAddress", address);
            session.setAttribute("bidderGender", gender);
            session.setAttribute("bidderBirthDate", birthDate);

            // ✅ Redirect back with success message
            request.setAttribute("successMessage", "✅ Profile updated successfully!");
            RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
            rd.forward(request, response);
        } else {
            // ❌ Update failed
            request.setAttribute("errorMessage", "❌ Failed to update profile. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
            rd.forward(request, response);
        }
    }
}
