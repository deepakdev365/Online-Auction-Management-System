package nextauction.servlet;

import nextauction.util.DBUtil;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;

@WebServlet("/seller")
@MultipartConfig // if you later add file upload
public class SellerServlet extends HttpServlet {

    // List active (or all) items
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("list".equals(action)) {
            listItems(resp);
        } else if ("winners".equals(action)) {
            listWinners(resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "action required");
        }
    }

    private void listItems(HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        try (Connection con = DBUtil.getConnection()) {
            String sql = "SELECT ai.*, u.name AS seller_name FROM auction_items ai LEFT JOIN users u ON ai.seller_id=u.id WHERE ai.status IN ('active','pending') ORDER BY ai.end_time ASC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            StringBuilder sb = new StringBuilder();
            sb.append("[");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            boolean first = true;
            while (rs.next()) {
                if (!first) sb.append(",");
                first = false;
                sb.append("{");
                sb.append("\"id\":" + rs.getInt("id") + ",");
                sb.append("\"title\":\"" + escape(rs.getString("title")) + "\",");
                sb.append("\"description\":\"" + escape(rs.getString("description")) + "\",");
                sb.append("\"start_price\":" + rs.getDouble("start_price") + ",");
                Double cb = rs.getDouble("current_bid");
                if (rs.wasNull()) cb = null;
                sb.append("\"current_bid\":" + (cb==null?"null":cb) + ",");
                sb.append("\"current_bidder_id\":" + (rs.getObject("current_bidder_id")==null?"null":rs.getInt("current_bidder_id")) + ",");
                sb.append("\"seller_name\":\"" + escape(rs.getString("seller_name")) + "\",");
                sb.append("\"start_time\":\"" + (rs.getTimestamp("start_time")!=null?sdf.format(rs.getTimestamp("start_time")):"") + "\",");
                sb.append("\"end_time\":\"" + (rs.getTimestamp("end_time")!=null?sdf.format(rs.getTimestamp("end_time")):"") + "\",");
                sb.append("\"status\":\"" + rs.getString("status") + "\"");
                sb.append("}");
            }
            sb.append("]");
            out.print(sb.toString());
        } catch (SQLException e) {
            e.printStackTrace();
            resp.setStatus(500);
            out.print("[]");
        }
    }

    // Add new item (POST)
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            addItem(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "action required");
        }
    }

    private void addItem(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.getWriter().print("{\"error\":\"not logged in\"}");
            return;
        }
        int sellerId = (Integer) session.getAttribute("userId");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String startPriceStr = req.getParameter("start_price");
        String startTimeStr = req.getParameter("start_time"); // format: yyyy-MM-dd HH:mm
        String endTimeStr = req.getParameter("end_time");
        double startPrice = Double.parseDouble(startPriceStr);
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO auction_items (seller_id,title,description,start_price,current_bid,start_time,end_time,status) VALUES (?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, sellerId);
            ps.setString(2, title);
            ps.setString(3, description);
            ps.setDouble(4, startPrice);
            ps.setObject(5, null);
            ps.setTimestamp(6, startTimeStr.isEmpty() ? null : Timestamp.valueOf(startTimeStr + ":00"));
            ps.setTimestamp(7, endTimeStr.isEmpty() ? null : Timestamp.valueOf(endTimeStr + ":00"));
            ps.setString(8, "active"); // directly set active; you can change to pending if start_time in future
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            int id = 0;
            if (keys.next()) id = keys.getInt(1);
            resp.setContentType("application/json");
            resp.getWriter().print("{\"success\":true, \"id\":" + id + "}");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.setStatus(500);
            resp.getWriter().print("{\"error\":\"server\"}");
        }
    }

    private void listWinners(HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        try (Connection con = DBUtil.getConnection()) {
            String sql = "SELECT ai.id, ai.title, ai.current_bid, ai.current_bidder_id, u.name AS winner_name, s.name AS seller_name, ai.end_time FROM auction_items ai LEFT JOIN users u ON ai.current_bidder_id=u.id LEFT JOIN users s ON ai.seller_id=s.id WHERE ai.status='ended' ORDER BY ai.end_time DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            StringBuilder sb = new StringBuilder();
            sb.append("[");
            boolean first=true;
            while (rs.next()) {
                if(!first) sb.append(",");
                first=false;
                sb.append("{");
                sb.append("\"id\":"+rs.getInt("id")+",");
                sb.append("\"title\":\""+escape(rs.getString("title"))+"\",");
                sb.append("\"current_bid\":"+(rs.getObject("current_bid")==null?"null":rs.getDouble("current_bid"))+",");
                sb.append("\"winner_name\":\""+escape(rs.getString("winner_name"))+"\",");
                sb.append("\"seller_name\":\""+escape(rs.getString("seller_name"))+"\",");
                sb.append("\"end_time\":\""+rs.getTimestamp("end_time")+"\"");
                sb.append("}");
            }
            sb.append("]");
            out.print(sb.toString());
        } catch (SQLException e) {
            e.printStackTrace();
            resp.setStatus(500);
            out.print("[]");
        }
    }

    private String escape(String s) {
        if (s==null) return "";
        return s.replace("\"","\\\"").replace("\n"," ").replace("\r"," ");
    }
}
