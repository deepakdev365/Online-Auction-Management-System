<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NextAuction | Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        /* ---------- Global Styles ---------- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Poppins", sans-serif;
            background-color: #f9fafc;
            color: #222;
            line-height: 1.6;
        }

        /* ---------- Navbar ---------- */
        nav {
            background-color: #007bff;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 40px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .logo {
            font-size: 1.6rem;
            font-weight: 700;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
            transition: 0.3s;
            font-weight: 500;
        }

        nav a:hover {
            color: #d1e8ff;
        }

        /* ---------- Layout ---------- */
        main {
            display: flex;
            flex-wrap: wrap;
            padding: 30px 50px;
            gap: 40px;
        }

        /* ---------- Sidebar ---------- */
        aside {
            flex: 1;
            min-width: 220px;
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        aside h4 {
            color: #007bff;
            margin-bottom: 15px;
            border-bottom: 2px solid #007bff;
            display: inline-block;
        }

        aside ul {
            list-style: none;
        }

        aside li {
            margin: 10px 0;
        }

        aside a {
            color: #333;
            text-decoration: none;
            transition: 0.3s;
        }

        aside a:hover {
            color: #007bff;
        }

        /* ---------- Content Section ---------- */
        section.content {
            flex: 3;
            min-width: 300px;
        }

        .section-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .section-header h5 {
            color: #007bff;
            font-size: 1.2rem;
            font-weight: 600;
        }

        .section-header a {
            text-decoration: none;
            color: #007bff;
            font-size: 0.9rem;
        }

        /* ---------- Item Cards ---------- */
        .item-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .item {
            background: #f9f9f9;
            border-radius: 8px;
            text-align: center;
            padding: 15px;
            transition: all 0.3s ease;
            border: 1px solid #eee;
        }

        .item:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .thumb {
            height: 140px;
            background: #e9f2ff;
            color: #007bff;
            font-size: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
            margin-bottom: 10px;
        }

        .title {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .price {
            color: #28a745;
            font-weight: 600;
        }

        .btn {
            display: inline-block;
            background: #007bff;
            color: white;
            padding: 8px 14px;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 10px;
            transition: 0.3s;
        }

        .btn:hover {
            background: #0056b3;
        }

        /* ---------- New Arrivals ---------- */
        .chips {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .chip {
            background: #e9f2ff;
            color: #007bff;
            border-radius: 20px;
            padding: 8px 14px;
            font-weight: 500;
            transition: 0.3s;
        }

        .chip:hover {
            background: #007bff;
            color: white;
        }

        /* ---------- Responsive ---------- */
        @media (max-width: 768px) {
            main {
                flex-direction: column;
                padding: 20px;
            }
            nav {
                flex-direction: column;
                gap: 10px;
                padding: 15px 20px;
            }
        }
    </style>
</head>

<body>
<nav>
    <div class="logo">NextAuction</div>
    <div>
    <a href="LiveAuctionPage.jsp">Live Auctions</a>
        <a href="index.jsp">Home</a>
        <a href="AboutUs.jsp">About</a>
        <a href="categories.jsp">Categories</a>
        <a href="Contact.jsp">Contact</a>
        <a href="bidderlogin.jsp">Login</a>
        <a href="bidderregister.jsp">Register</a>
        <a href="sellerlogin.jsp">Sell</a>
        <a href="adminLogin.jsp">Admin</a>
    </div>
</nav>

    <!-- ---------- Main Layout ---------- -->
    <main>
        <!-- Sidebar -->
        <aside>
            <h4>Categories</h4>
            <ul>
                <li><a href="#">Electronics</a></li>
                <li><a href="#">Vehicles</a></li>
                <li><a href="#">Home & Garden</a></li>
                <li><a href="#">Collectibles</a></li>
                <li><a href="#">Art</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <section class="content">
            <!-- Featured Items -->
            <div class="section-card">
                <div class="section-header">
                    <h5>🔥 Featured Items</h5>
                    <a href="ItemView.jsp">View all</a>
                </div>
                <div class="item-grid">
                    <div class="item">
                        <div class="thumb">🕒</div>
                        <div class="title">Rare Swiss Chronograph</div>
                        <div class="price">₹15,200</div>
                        <a href="item?id=1" class="btn">Bid Now</a>
                    </div>
                    <div class="item">
                        <div class="thumb">🚗</div>
                        <div class="title">Classic Car</div>
                        <div class="price">₹45,000</div>
                        <a href="item?id=2" class="btn">Bid Now</a>
                    </div>
                    <div class="item">
                        <div class="thumb">💎</div>
                        <div class="title">Antique Necklace</div>
                        <div class="price">₹23,800</div>
                        <a href="item?id=3" class="btn">Bid Now</a>
                    </div>
                </div>
            </div>

            <!-- New Arrivals -->
            <div class="section-card">
                <div class="section-header">
                    <h5>🆕 New Arrivals</h5>
                    <a href="new.jsp">View all</a>
                </div>
                <div class="chips">
                    <span class="chip">Camera Lens</span>
                    <span class="chip">Designer Bag</span>
                    <span class="chip">Smart Watch</span>
                    <span class="chip">Vintage Car Model</span>
                    <span class="chip">Luxury Pen</span>
                    <span class="chip">Art Print</span>
                </div>
            </div>
        </section>
    </main>
</body>
</html>
