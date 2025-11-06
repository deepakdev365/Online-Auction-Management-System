package nextauction.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Bidder {
    private int bidderId;
    private String fullName;
    private String firstName;
    private String lastName;
    private String username;
    private String email;
    private String phone;
    private String password;
    private String address;
    private String gender;
    private Date birthDate;
    private String profileImage;
    private Timestamp createdAt;

    // Getters & Setters
    public int getBidderId() { return bidderId; }
    public void setBidderId(int bidderId) { this.bidderId = bidderId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public Date getBirthDate() { return birthDate; }
    public void setBirthDate(Date birthDate) { this.birthDate = birthDate; }

    public String getProfileImage() { return profileImage; }
    public void setProfileImage(String profileImage) { this.profileImage = profileImage; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    
    
    
    
    
    
    
    
    
    // ✅ Helper method to safely get profile image for JSP
    public String getDisplayProfileImage() {
        if (profileImage != null && !profileImage.trim().isEmpty()) {
            return profileImage;
        } else {
            // Return a default avatar if no image is set
            return "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
        }
    }

    
    
}
