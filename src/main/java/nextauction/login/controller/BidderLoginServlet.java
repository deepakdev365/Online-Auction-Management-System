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

        // --- Step 1: Get input data ---
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // --- Step 2: Validate bidder credentials ---
        BidderDao dao = new BidderDao();
        Bidder bidder = dao.validateBidder(email, password);

        // --- Step 3: Redirect based on result ---
        if (bidder != null) {
            // ✅ Create session for logged-in bidder
            HttpSession session = request.getSession();
            session.setAttribute("bidder", bidder);
            session.setAttribute("bidderName", bidder.getFullName());
            
            // ✅ Redirect to bidder dashboard
            response.sendRedirect("bidderdashboard.jsp");
        } else {
            // ❌ Invalid login
            request.setAttribute("error", "Invalid email or password!");
            RequestDispatcher rd = request.getRequestDispatcher("bidderlogin.jsp");
            rd.forward(request, response);
        }
    }
}
