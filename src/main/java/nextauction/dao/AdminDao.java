package nextauction.dao;

import nextauction.util.DBUtil;
import nextauction.model.User;
import nextauction.model.AuctionItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDao {


    public boolean verifySeller(int userId) {
        int rws=0;

        final String sql1 = "update users set status = 'verified' where id =?";


        try(Connection conn=DBUtil.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql1)) {

            pst.setInt(1,userId);


            rws = pst.executeUpdate();


        } catch(SQLException exc) {

            System.err.println("Database error during verification for ID:" + userId);

        }


        return rws == 1;
    }


    public boolean removeItem(int itmId) {
        int changed=0;


        final String sql2 = "delete from auction_items where id =?";

        try (Connection dbCon=DBUtil.getConnection();
             PreparedStatement ps2 = dbCon.prepareStatement(sql2)) {

            ps2.setInt(1,itmId);

            changed = ps2.executeUpdate();


        } catch (SQLException err) {

             System.out.println("Failed to delete item.");
        }
        return changed == 1;
    }


    public List<User> getPendingSellers() {
        List<User> listP = new ArrayList<>();

        final String sql3="select id, name, email from users where role='seller' and status='pending'";


        try (Connection conx=DBUtil.getConnection();
             PreparedStatement pss=conx.prepareStatement(sql3);
             ResultSet ress=pss.executeQuery()) {

            while (ress.next()) {
                User usr = new User();
                usr.setId(ress.getInt("id"));

                usr.setName(ress.getString("name"));
                usr.setEmail(ress.getString("email"));
                listP.add(usr);
            }
        } catch (SQLException e) {

             e.getMessage();
        }
        return listP;
    }


    public List<AuctionItem> getAllItems() {

        List<AuctionItem> allTheItems = new ArrayList<>();
        final String itemSql = "select * from auction_items";


        return allTheItems;
    }


    public List<User> getAllSellers() {

        List<User> sellrList = new ArrayList<>();
        final String sqlSellers = "select id, name, email, status from users where role='seller'";


        return sellrList;
    }


    public List<AuctionItem> getEndedAuctionsWithWinners() {

        List<AuctionItem> winAuctions = new ArrayList<>();
        final String winnersSql = "select * from auction_items where status='ended' and current_bidder_id is not null";


        return winAuctions;
    }

//to get all the bidding history
    public ResultSet getBiddingHistory() {
     
        Connection connection = DBUtil.getConnection();
		return null;


     
    }
}