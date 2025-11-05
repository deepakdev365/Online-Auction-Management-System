package nextauction.model;

import java.sql.Timestamp;

public class AuctionItem {
    private int itemId;
    private int sellerId;
    private String title;
    private String description;
    private String category;
    private double startPrice;
    private double currentBid;
    private String imagePath;
    private Timestamp startTime;
    private Timestamp endTime;
    private String status;

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getSellerId() {
        return sellerId;
    }

    public void setSellerId(int sellerId) {
        this.sellerId = sellerId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getStartPrice() {
        return startPrice;
    }

    public void setStartPrice(double startPrice) {
        this.startPrice = startPrice;
    }

    public double getCurrentBid() {
        return currentBid;
    }

    public void setCurrentBid(double currentBid) {
        this.currentBid = currentBid;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public void setStartTime(String startTime) {
        try {
            this.startTime = Timestamp.valueOf(startTime.replace("T", " ") + ":00");
        } catch (Exception e) {
            this.startTime = null;
        }
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public void setEndTime(String endTime) {
        try {
            this.endTime = Timestamp.valueOf(endTime.replace("T", " ") + ":00");
        } catch (Exception e) {
            this.endTime = null;
        }
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
