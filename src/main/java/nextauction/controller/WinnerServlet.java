package nextauction.controller;

import nextauction.util.DBUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/winners")
public class WinnerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT ai.id, ai.title, ai.current_bid, ai.current_bidder_id, winner.name AS winner_name, seller.name AS seller_name, ai.end_time " +
                "FROM auction_items ai " +
                "LEFT JOIN users winner ON ai.current_bidder_id = winner.id " +
                "LEFT JOIN users seller ON ai.seller_id = seller.id " +
                "WHERE ai.status = 'ended' ORDER BY ai.end_time DESC");
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
                Object cb = rs.getObject("current_bid");
                sb.append("\"current_bid\":").append(cb==null?"null":rs.getDouble("current_bid")).append(",");
                sb.append("\"winner_name\":\"").append(escape(rs.getString("winner_name"))).append("\",");
                sb.append("\"seller_name\":\"").append(escape(rs.getString("seller_name"))).append("\",");
                sb.append("\"end_time\":\"").append(rs.getTimestamp("end_time")).append("\"");
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
        return s.replace("\"", "\\\"").replace("\n", " ");
    }
}
