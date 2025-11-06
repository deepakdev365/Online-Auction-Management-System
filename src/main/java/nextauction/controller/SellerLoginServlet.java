package nextauction.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.dao.SellerDao;
import nextauction.model.Seller;

@WebServlet("/SellerLoginServlet")
public class SellerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        SellerDao dao = new SellerDao();
        Seller seller = dao.validateSeller(email, password);

        if (seller != null) {
            HttpSession session = request.getSession();
            session.setAttribute("seller", seller);
            session.setAttribute("seller_id", seller.getSellerId());
            session.setAttribute("sellerName", seller.getFullName());

            // ✅ ADD THIS LINE — ensures image persists after relogin
            session.setAttribute("profileImage", seller.getProfileImage());

            response.sendRedirect("SellerDashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid email or password!");
            RequestDispatcher rd = request.getRequestDispatcher("sellerlogin.jsp");
            rd.forward(request, response);
        }
    }
}
