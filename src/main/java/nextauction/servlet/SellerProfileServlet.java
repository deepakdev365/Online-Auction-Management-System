package nextauction.servlet;

import nextauction.model.Seller;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/profile")
public class SellerProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Seller seller = new Seller();
        // Sample hardcoded data (replace with DB fetch in actual app)
        seller.setName("Amit Sharma");
        seller.setEmail("amit.sharma@example.com");
        seller.setContact("9876543210");
        seller.setAddress("Mumbai, India");

        request.setAttribute("sellerProfile", seller);
        RequestDispatcher dispatcher = request.getRequestDispatcher("SellerProfile.jsp");
        dispatcher.forward(request, response);
    }
}
