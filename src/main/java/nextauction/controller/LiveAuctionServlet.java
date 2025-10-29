package nextauction.controller;


import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/liveAuction")
public class LiveAuctionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        JSONArray items = new JSONArray();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/online_auction", "root", "RJP279");

            // ✅ STEP 1: Update auction status automatically
            String updateSQL = 
                "UPDATE auction_items " +
                "SET status = CASE " +
                "WHEN NOW() < start_time THEN 'Pending' " +
                "WHEN NOW() BETWEEN start_time AND end_time THEN 'active' " +
                "WHEN NOW() > end_time THEN 'ended' " +
                "ELSE status END";
            PreparedStatement updateStmt = con.prepareStatement(updateSQL);
            updateStmt.executeUpdate();
            updateStmt.close();

            // ✅ STEP 2: Fetch only active (live) auctions
            String sql = "SELECT i.id, i.title, i.description, i.image_path, i.start_price, " +
                         "i.current_bid, i.end_time, s.name AS seller_name " +
                         "FROM auction_items i " +
                         "JOIN sellers s ON i.seller_id = s.id " +
                         "WHERE i.status = 'active'";

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);

            // ✅ STEP 3: Prepare JSON response
            while (rs.next()) {
                JSONObject obj = new JSONObject();
                obj.put("id", rs.getInt("id"));
                obj.put("title", rs.getString("title"));
                obj.put("description", rs.getString("description"));
                obj.put("image_path", rs.getString("image_path"));
                obj.put("start_price", rs.getDouble("start_price"));
                obj.put("current_bid", rs.getDouble("current_bid"));
                obj.put("end_time", rs.getString("end_time"));
                obj.put("seller_name", rs.getString("seller_name"));
                items.put(obj);
            }

            rs.close();
            st.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        out.print(items.toString());
        out.flush();
    }
}
