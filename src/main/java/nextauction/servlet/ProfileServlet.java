package nextauction.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        JSONObject json = new JSONObject();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            json.put("error", "User not logged in.");
        } else {
            json.put("name", session.getAttribute("name"));
            json.put("email", session.getAttribute("email"));
            json.put("role", session.getAttribute("role"));
        }

        response.getWriter().print(json.toString());
    }
}
