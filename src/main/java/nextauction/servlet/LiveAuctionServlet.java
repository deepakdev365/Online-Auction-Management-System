package nextauction.servlet;

import nextauction.util.DBUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;

@WebServlet("/live")
public class LiveAuctionServlet extends HttpServlet {

    private static final SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        try (Connection con = DBUtil.getConnection()) {
            // Mark ended auctions before listing (simple approach)
            PreparedStatement mark = con.prepareStatement("UPDATE auction_items SET status='ended' WHERE status!='ended' AND end_time IS NOT NULL AND end_time <= NOW()");
            mark.executeUpdate();

            PreparedStatement ps = con.prepareStatement(
                    "SELECT ai.id, ai.title, ai.description, ai.start_price, ai.current_bid, ai.current_bidder_id, ai.start_time, ai.end_time, ai.status, u.name AS seller_name " +
                    "FROM auction_items ai LEFT JOIN users u ON ai.seller_id = u.id WHERE ai.status IN ('active','pending') ORDER BY ai.end_time ASC");
            ResultSet rs = ps.executeQuery();
            StringBuilder sb = new StringBuilder();
            sb.append("[");
            boolean first = true;
            while (rs.next()) {
                if (!first) sb.append(",");
                first = false;
                sb.append("{");
                sb.append("\"id\":").append(rs.getInt("id")).append(",");
                sb.append("\"title\":\"").append(escape(rs.getString("title"))).append("\",");
                sb.append("\"description\":\"").append(escape(rs.getString("description"))).append("\",");
                sb.append("\"start_price\":").append(rs.getDouble("start_price")).append(",");
                Object cbObj = rs.getObject("current_bid");
                if (cbObj == null) sb.append("\"current_bid\":null,"); else sb.append("\"current_bid\":").append(rs.getDouble("current_bid")).append(",");
                sb.append("\"current_bidder_id\":").append(rs.getObject("current_bidder_id")==null?"null":rs.getInt("current_bidder_id")).append(",");
                Timestamp st = rs.getTimestamp("start_time");
                Timestamp et = rs.getTimestamp("end_time");
                sb.append("\"start_time\":\"").append(st==null?"":SDF.format(st)).append("\",");
                sb.append("\"end_time\":\"").append(et==null?"":SDF.format(et)).append("\",");
                sb.append("\"status\":\"").append(rs.getString("status")).append("\",");
                sb.append("\"seller_name\":\"").append(escape(rs.getString("seller_name"))).append("\"");
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
        if (s == null) return "";
        return s.replace("\"","\\\"").replace("\n"," ");
    }
}
