<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NextAuction | Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Poppins", sans-serif;
            background: #0a0f1a;
            color: #fff;
            line-height: 1.6;
        }

        /* Navbar */
        nav {
            background: #111c30;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 40px;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.3);
        }

        nav a {
            color: #fff;
            text-decoration: none;
            margin: 0 12px;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        nav a:hover {
            color: #00aaff;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 600;
            color: #00aaff;
        }

        /* Search Bar */
        form {
            display: flex;
            align-items: center;
        }

        form input {
            padding: 6px 10px;
            border-radius: 4px;
            border: none;
            outline: none;
        }

        form button {
            margin-left: 8px;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            background: #00aaff;
            color: white;
            cursor: pointer;
            transition: background 0.3s;
        }

        form button:hover {
            background: #0088cc;
        }

        /* Layout */
        main {
            display: flex;
            padding: 40px;
            gap: 30px;
        }

        aside {
            width: 20%;
            background: #121b2b;
            border-radius: 10px;
            padding: 20px;
        }

        aside h5 {
            margin-bottom: 15px;
            color: #00aaff;
        }

        aside ul {
            list-style: none;
        }

        aside li {
            margin: 10px 0;
        }

        aside a {
            color: #ccc;
            text-decoration: none;
            transition: color 0.3s;
        }

        aside a:hover {
            color: #00aaff;
        }

        /* Cards Section */
        section.content {
            width: 80%;
        }

        .na-card {
            background: #121b2b;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .na-section-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .na-section-title {
            color: #00aaff;
            font-size: 1.3rem;
        }

        .na-link {
            color: #00aaff;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .na-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .na-item {
            background: #1a2438;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .na-item:hover {
            transform: translateY(-6px);
            box-shadow: 0 6px 15px rgba(0, 170, 255, 0.2);
        }

        .na-thumb {
            height: 150px;
            background: linear-gradient(135deg, #00aaff55, #00446655);
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .na-item-title {
            font-size: 1rem;
            margin-bottom: 5px;
        }

        .na-price {
            color: #00ffcc;
            font-weight: bold;
        }

        .na-btn {
            display: inline-block;
            background: #00aaff;
            color: white;
            border: none;
            padding: 8px 14px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
            text-decoration: none;
            transition: background 0.3s;
        }

        .na-btn:hover {
            background: #0088cc;
        }

        /* New arrivals chips */
        .na-grid-sm {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .na-chip {
            background: #1a2438;
            padding: 8px 14px;
            border-radius: 20px;
            color: #00aaff;
            font-weight: 500;
            transition: background 0.3s;
        }

        .na-chip:hover {
            background: #00aaff;
            color: #fff;
        }

        @media (max-width: 768px) {
            main {
                flex-direction: column;
                padding: 20px;
            }
            aside {
                width: 100%;
            }
            section.content {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<nav>
    <a class="logo" href="#">NextAuction</a>
    <form action="search" method="get">
        <input name="q" type="text" placeholder="Search items...">
        <button type="submit">Search</button>
    </form>
    <div>
        <a href="index.jsp">Home</a>
        <a href="AboutUs.jsp">About</a>
        <a href="categories.jsp">Categories</a>
        <a href="Contact.jsp">Contact</a>
        <a href="FAQ.jsp">FAQ</a>
        <a href="login.jsp">Login</a>
        <a href="Signup.jsp">Register</a>
        <a href="SellerSignup.jsp">Sell</a>
        <a href="adminLogin.jsp">Admin</a>
    </div>
</nav>

<main>
    <aside>
        <h5>Categories</h5>
        <ul>
            <li><a href="#">Electronics</a></li>
            <li><a href="#">Vehicles</a></li>
            <li><a href="#">Home & Garden</a></li>
            <li><a href="#">Collectibles</a></li>
            <li><a href="#">Art</a></li>
        </ul>
    </aside>

    <section class="content">
        <section class="na-card">
            <div class="na-section-head">
                <h5 class="na-section-title">Featured Items</h5>
                <a class="na-link" href="featured.jsp">View all</a>
            </div>

            <div class="na-grid">
                <article class="na-item">
                    <div class="na-thumb"></div>
                    <h6 class="na-item-title">Rare Swiss Chronograph</h6>
                    <span class="na-price">₹15,200</span><br>
                    <a href="item?id=1" class="na-btn">Bid Now</a>
                </article>

                <article class="na-item">
                    <div class="na-thumb"></div>
                    <h6 class="na-item-title">Classic Car</h6>
                    <span class="na-price">₹45,000</span><br>
                    <a href="item?id=2" class="na-btn">Bid Now</a>
                </article>
            </div>
        </section>

        <section class="na-card">
            <div class="na-section-head">
                <h5 class="na-section-title">New Arrivals</h5>
                <a class="na-link" href="new.jsp">View all</a>
            </div>

            <div class="na-grid-sm">
                <div class="na-chip">Camera Lens</div>
                <div class="na-chip">Designer Bag</div>
                <div class="na-chip">Vintage Car Model</div>
                <div class="na-chip">Art Print</div>
            </div>
        </section>
    </section>
</main>

</body>
</html>