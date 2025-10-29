package nextauction.dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import nextauction.model.Bidder;

public class BidderDao {
    public static List<Bidder> getAllBidders() {
        List<Bidder> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_auction","root", "jyoti@2025");
            PreparedStatement ps = con.prepareStatement("select * from bidder");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bidder b = new Bidder();
                b.setId(rs.getInt("id"));
                b.setFullName(rs.getString("fullname"));
                b.setEmail(rs.getString("email"));
                b.setPassword(rs.getString("password"));
                b.setAddress(rs.getString("address"));
                list.add(b);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
