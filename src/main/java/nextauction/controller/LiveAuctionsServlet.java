package nextauction.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/live")
public class LiveAuctionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/online_auction";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "RJP279";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        JSONArray items = new JSONArray();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "SELECT a.*, u.name AS seller_name FROM auction_items a " +
                         "JOIN users u ON a.seller_id = u.id " +
                         "WHERE NOW() BETWEEN a.start_time AND a.end_time AND a.status='active'";

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);

            while (rs.next()) {
                JSONObject item = new JSONObject();
                item.put("id", rs.getInt("id"));
                item.put("title", rs.getString("title"));
                item.put("description", rs.getString("description"));
                item.put("start_price", rs.getDouble("start_price"));
                item.put("current_bid", rs.getDouble("current_bid"));
                item.put("seller_name", rs.getString("seller_name"));
                item.put("end_time", rs.getString("end_time"));
                item.put("image_path", rs.getString("image_path"));
                items.put(item);
            }

            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.getWriter().print(items.toString());
    }
}
