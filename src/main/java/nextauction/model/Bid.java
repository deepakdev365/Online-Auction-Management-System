package nextauction.model;

import java.sql.Timestamp;

public class Bid {
    private int bidId;
    private int auctionItemId;
    private int bidderId;
    private double bidAmount;
    private Timestamp bidTime;
    private String itemTitle; // for showing item name in My Bids page

    // --- Getters and Setters ---
    public int getBidId() {
        return bidId;
    }
    public void setBidId(int bidId) {
        this.bidId = bidId;
    }

    public int getAuctionItemId() {
        return auctionItemId;
    }
    public void setAuctionItemId(int auctionItemId) {
        this.auctionItemId = auctionItemId;
    }

    public int getBidderId() {
        return bidderId;
    }
    public void setBidderId(int bidderId) {
        this.bidderId = bidderId;
    }

    public double getBidAmount() {
        return bidAmount;
    }
    public void setBidAmount(double bidAmount) {
        this.bidAmount = bidAmount;
    }

    public Timestamp getBidTime() {
        return bidTime;
    }
    public void setBidTime(Timestamp bidTime) {
        this.bidTime = bidTime;
    }

    public String getItemTitle() {
        return itemTitle;
    }
    public void setItemTitle(String itemTitle) {
        this.itemTitle = itemTitle;
    }
}
