package nextauction.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.dao.BidderDao;
import nextauction.model.Bidder;

@WebServlet("/ProfileUploadServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 15
)
public class ProfileUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("bidder") == null) {
            response.sendRedirect("bidderlogin.jsp");
            return;
        }

        Bidder bidder = (Bidder) session.getAttribute("bidder");

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String birthDateStr = request.getParameter("birthDate");

        Date birthDate = null;
        if (birthDateStr != null && !birthDateStr.isEmpty()) {
            birthDate = Date.valueOf(birthDateStr);
        }

        // ✅ Image Upload
        Part filePart = request.getPart("profileImage");
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String imageFileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            imageFileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            filePart.write(uploadPath + File.separator + imageFileName);
            bidder.setProfileImage("uploads/" + imageFileName);
        }

        bidder.setFullName(firstName + " " + lastName);
        bidder.setEmail(email);
        bidder.setPhone(phone);
        bidder.setAddress(address);
        bidder.setGender(gender);
        bidder.setBirthDate(birthDate);

        BidderDao dao = new BidderDao();
        boolean updated = dao.updateBidderProfile(bidder);

        if (updated) {
            session.setAttribute("bidder", bidder);
            session.setAttribute("bidderName", bidder.getFullName());
            session.setAttribute("bidderEmail", bidder.getEmail());
            session.setAttribute("bidderMobile", bidder.getPhone());
            request.setAttribute("successMessage", "✅ Profile updated successfully!");
        } else {
            request.setAttribute("errorMessage", "❌ Failed to update profile!");
        }

        RequestDispatcher rd = request.getRequestDispatcher("bidderdashboard.jsp");
        rd.forward(request, response);
    }
}
