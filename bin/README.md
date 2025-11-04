# Online Auction Management System

Welcome to the Online Auction Management System! This project allows users to create, bid on, and manage online auctions in a secure and user-friendly environment.

## Table of Contents
- [Features](#features)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Features
- User Registration and Login (Bidder, Seller, Admin roles)
- Create and manage auction listings
- Place bids on auction items
- Admin dashboard for managing users and auctions
- View bid history and auction details

## Getting Started

### Prerequisites
- Java 8+
- Apache Tomcat
- MySQL (or your preferred DBMS)

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/deepakdev365/Online-Auction-Management-System.git
   ```
2. Import the project into your IDE.
3. Set up the database using the provided SQL scripts in `/db/`.
4. Configure database connection in `src/main/resources/config.properties`.
5. Deploy the project on Tomcat.

## Project Structure

- `src/main/java/auction/admin`: Admin-related logic
- `src/main/java/auction/bidder`: Bidder user logic
- `src/main/java/auction/seller`: Seller user logic
- `src/main/java/auction/loginreg`: Login and registration logic
- `src/main/webapp/`: JSP pages and static resources

## Usage

- Register as a user (bidder/seller) or log in as admin.
- Sellers can create auction listings.
- Bidders can view and bid on auctions.
- Admin can manage users and auctions.

## Contributing

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

## License

This project is licensed under 

## Contact

For questions or suggestions, open an issue or contact [deepakdev365](mailto:your.email@example.com).
