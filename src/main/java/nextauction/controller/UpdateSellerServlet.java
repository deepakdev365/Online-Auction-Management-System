package nextauction.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import nextauction.util.DBUtil;
import nextauction.model.Seller;

@WebServlet("/UpdateSellerServlet")
@MultipartConfig
public class UpdateSellerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Seller seller = (Seller) session.getAttribute("seller");

        if (seller == null) {
            response.sendRedirect("sellerlogin.jsp");
            return;
        }

        String fullName = request.getParameter("full_name");
        String fatherName = request.getParameter("father_name");
        String phone = request.getParameter("phone");
        String companyName = request.getParameter("company_name");
        String companyLocation = request.getParameter("company_location");
        String address = request.getParameter("address");

        // ✅ Handle Profile Image Upload
        Part imagePart = request.getPart("profile_image");
        String imagePath = seller.getProfileImage(); // keep old image if none uploaded

        if (imagePart != null && imagePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "profile_images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            imagePart.write(uploadPath + File.separator + fileName);
            imagePath = "profile_images/" + fileName;
        }

        try (Connection con = DBUtil.getConnection()) {
            String sql = "UPDATE sellers SET full_name=?, father_name=?, phone=?, company_name=?, company_location=?, address=?, profile_image=? WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, fatherName);
            ps.setString(3, phone);
            ps.setString(4, companyName);
            ps.setString(5, companyLocation);
            ps.setString(6, address);
            ps.setString(7, imagePath);
            ps.setString(8, seller.getEmail());
            ps.executeUpdate();

            // ✅ Update session object
            seller.setFullName(fullName);
            seller.setFatherName(fatherName);
            seller.setPhone(phone);
            seller.setCompanyName(companyName);
            seller.setCompanyLocation(companyLocation);
            seller.setAddress(address);
            seller.setProfileImage(imagePath);
            session.setAttribute("seller", seller);

            response.sendRedirect("SellerProfile.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error updating profile: " + e.getMessage());
        }
    }
}
