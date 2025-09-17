package auction.loginreg.model;

public class Login_Reg {

	private int id;
	private String name;
	private String email;
	private String address;
	private long mobileNo;
	private String role;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public long getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(long mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	@Override
	public String toString() {
		return "Login_Reg [id=" + id + ", name=" + name + ", email=" + email + ", address=" + address + ", mobileNo="
				+ mobileNo + ", role=" + role + "]";
	}
	public Login_Reg(int id, String name, String email, String address, long mobileNo, String role) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.address = address;
		this.mobileNo = mobileNo;
		this.role = role;
	}
	public Login_Reg() {
		super();
		// TODO Auto-generated constructor stub
	}

}
