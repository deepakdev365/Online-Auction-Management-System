package nextauction.model;
import java.util.Date;
public class AuctionItem {
    private int id;
    private int sellerId;
    private String title;
    private String description;
    private double startPrice;
    private Double currentBid;
    private Integer currentBidderId;
    private String imagePath;
    private Date startTime;
    private Date endTime;
    private String status;
    // getters/setters omitted for brevity (implement all)
    // ...
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public double getStartPrice() {
		return startPrice;
	}
	public void setStartPrice(double startPrice) {
		this.startPrice = startPrice;
	}
	public Double getCurrentBid() {
		return currentBid;
	}
	public void setCurrentBid(Double currentBid) {
		this.currentBid = currentBid;
	}
	public Integer getCurrentBidderId() {
		return currentBidderId;
	}
	public void setCurrentBidderId(Integer currentBidderId) {
		this.currentBidderId = currentBidderId;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
    
    
    
}
