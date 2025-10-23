package nextauction.model;

import java.util.Date;
import java.util.List;

public class AuctionItem {
    private int id;
    private String name;
    private String description;
    private double startingPrice;
    private String status;
    private double currentBid;
    private Date endDate;       // Add this field
    private Date bidEndTime;    // If you have separate bidEndTime, keep both if needed
    private String imagePath;
    private List<String> bids;

    // existing getters and setters...

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Date getBidEndTime() {
        return bidEndTime;
    }

    public void setBidEndTime(Date bidEndTime) {
        this.bidEndTime = bidEndTime;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getStartingPrice() {
		return startingPrice;
	}

	public void setStartingPrice(double startingPrice) {
		this.startingPrice = startingPrice;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public List<String> getBids() {
		return bids;
	}

	public void setBids(List<String> bids) {
		this.bids = bids;
	}

    // other getters and setters...
    
}
