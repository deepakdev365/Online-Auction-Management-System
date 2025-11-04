package nextauction.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.dao.SellerDao;
import nextauction.model.Seller;

@WebServlet("/SellerSignupServlet")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // allow file uploads (up to 10 MB)
public class SellerSignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 🧩 Get form fields (names must match your form)
        String fullName = request.getParameter("fullname");
        String fatherName = request.getParameter("fathername");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String companyName = request.getParameter("company_name");
        String companyLocation = request.getParameter("company_location");
        String address = request.getParameter("address");
        String documentType = request.getParameter("document_type");

        // 🧩 Handle uploaded document (optional)
        Part documentPart = request.getPart("document");
        String documentFileName = null;

        if (documentPart != null && documentPart.getSize() > 0) {
            String uploadDir = request.getServletContext().getRealPath("/") + "uploads";
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) uploadFolder.mkdir();

            documentFileName = System.currentTimeMillis() + "_" + documentPart.getSubmittedFileName();
            String documentPath = uploadDir + File.separator + documentFileName;

            documentPart.write(documentPath);
        }

        // 🧩 Create Seller model object
        Seller seller = new Seller();
        seller.setFullName(fullName);
        seller.setFatherName(fatherName);
        seller.setEmail(email);
        seller.setPhone(phone);
        seller.setPassword(password);
        seller.setCompanyName(companyName);
        seller.setCompanyLocation(companyLocation);
        seller.setAddress(address);
        seller.setDocumentType(documentType);
        seller.setDocumentPath(documentFileName);

        // 🧩 Insert into database
        SellerDao dao = new SellerDao();
        boolean success = dao.registerSeller(seller);

        // 🧩 Debug log (helps check data)
        System.out.println("Seller Signup:");
        System.out.println("Full Name: " + fullName);
        System.out.println("Email: " + email);
        System.out.println("Phone: " + phone);
        System.out.println("File: " + documentFileName);
        System.out.println("Inserted: " + success);

        // 🧩 Redirect or show error
        if (success) {
            response.sendRedirect("SellerLogin.jsp");
        } else {
            request.setAttribute("error", "Registration failed. Please try again!");
            RequestDispatcher rd = request.getRequestDispatcher("SellerSignup.jsp");
            rd.forward(request, response);
        }
    }
}
