package nextauction.RegisterServlet.controller;


import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import nextauction.dao.BidderDao;
import nextauction.model.Bidder;

@WebServlet("/BidderRegisterServlet")
public class BidderRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm_password");

        if (!password.equals(confirm)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("bidderregister.jsp").forward(request, response);
            return;
        }

        Bidder bidder = new Bidder();
        bidder.setFullName(fullName);
        bidder.setEmail(email);
        bidder.setPhone(phone);
        bidder.setPassword(password);

        BidderDao dao = new BidderDao();
        boolean success = dao.registerBidder(bidder);

        if (success) {
            request.setAttribute("success", "Registration successful! Please login.");
        } else {
            request.setAttribute("error", "Registration failed. Try again!");
        }

        request.getRequestDispatcher("bidderregister.jsp").forward(request, response);
    }
}

