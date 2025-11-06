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

        // --- Step 1: Read login credentials ---
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // --- Step 2: Basic validation ---
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "⚠️ Please enter both email and password!");
            request.getRequestDispatcher("bidderlogin.jsp").forward(request, response);
            return;
        }

        // --- Step 3: Validate bidder ---
        BidderDao dao = new BidderDao();
        Bidder bidder = dao.validateBidder(email, password);

        if (bidder != null) {
            // ✅ Login success – create a session
            HttpSession session = request.getSession(true);
            session.setAttribute("bidder", bidder);
            session.setAttribute("bidderName", bidder.getFullName());
            session.setAttribute("bidderEmail", bidder.getEmail());
            session.setAttribute("bidderMobile", bidder.getPhone());
            session.setAttribute("bidderAddress", bidder.getAddress());
            session.setAttribute("bidderGender", bidder.getGender());
            session.setAttribute("bidderBirthDate", bidder.getBirthDate());
            session.setAttribute("bidderProfileImage", bidder.getProfileImage());

            System.out.println("✅ Login successful for: " + email);

            // ✅ Redirect safely using context path
            response.sendRedirect(request.getContextPath() + "/bidderdashboard.jsp");


        } else {
            // ❌ Invalid credentials
            System.out.println("❌ Login failed for: " + email);
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("bidderlogin.jsp").forward(request, response);
        }
    }
}
