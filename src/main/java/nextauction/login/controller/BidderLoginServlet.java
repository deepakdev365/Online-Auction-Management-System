package nextauction.login.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nextauction.dao.BidderDao;
import nextauction.model.Bidder;

@WebServlet("/BidderLoginServlet")
public class BidderLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        BidderDao dao = new BidderDao();
        Bidder bidder = dao.validateBidder(email, password);

        if (bidder != null) {
            HttpSession session = request.getSession();
            session.setAttribute("bidder", bidder);
            session.setAttribute("bidderName", bidder.getFullName());
            session.setAttribute("bidderEmail", bidder.getEmail());
            session.setAttribute("bidderMobile", bidder.getPhone()); // ✅ Correct field

            response.sendRedirect("bidderdashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid email or password!");
            RequestDispatcher rd = request.getRequestDispatcher("bidderlogin.jsp");
            rd.forward(request, response);
        }
    }
}
