<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NextAuction | Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        /* Global Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(circle at top left, #0a1222, #050914 60%);
            color: #e9ecf1;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Navbar */
        nav {
            background: rgba(10, 20, 40, 0.9);
            backdrop-filter: blur(10px);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 50px;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 0 20px rgba(0, 170, 255, 0.1);
        }

        .logo {
            font-size: 1.7rem;
            font-weight: 700;
            color: #00aaff;
            letter-spacing: 1px;
        }

        nav a {
            color: #d5d5d5;
            text-decoration: none;
            margin: 0 12px;
            font-weight: 500;
            transition: color 0.3s ease, text-shadow 0.3s ease;
        }

        nav a:hover {
            color: #00aaff;
            text-shadow: 0 0 8px #00aaff;
        }

        /* Search */
        form {
            display: flex;
            align-items: center;
        }

        form input {
            background: rgba(255, 255, 255, 0.1);
            border: none;
            color: #fff;
            padding: 8px 12px;
            border-radius: 6px;
            outline: none;
            width: 180px;
        }

        form button {
            margin-left: 10px;
            padding: 8px 14px;
            border: none;
            border-radius: 6px;
            background: linear-gradient(135deg, #00aaff, #007acc);
            color: #fff;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        form button:hover {
            transform: scale(1.05);
        }

        /* Layout */
        main {
            display: flex;
            padding: 40px 60px;
            gap: 40px;
            flex-wrap: wrap;
        }

        aside {
            flex: 1;
            min-width: 220px;
            background: rgba(18, 27, 45, 0.6);
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.25);
        }

        aside h5 {
            color: #00aaff;
            font-size: 1.1rem;
            margin-bottom: 15px;
            border-bottom: 1px solid #00aaff33;
            padding-bottom: 6px;
        }

        aside ul {
            list-style: none;
        }

        aside li {
            margin: 10px 0;
        }

        aside a {
            color: #bbb;
            text-decoration: none;
            transition: 0.3s;
        }

        aside a:hover {
            color: #00aaff;
            text-shadow: 0 0 6px #00aaff;
        }

        /* Content Cards */
        section.content {
            flex: 3;
            min-width: 300px;
        }

        .na-card {
            background: rgba(18, 27, 45, 0.65);
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 0 25px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .na-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 0 25px rgba(0, 170, 255, 0.2);
        }

        .na-section-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .na-section-title {
            color: #00aaff;
            font-size: 1.4rem;
            font-weight: 600;
        }

        .na-link {
            color: #00aaff;
            font-size: 0.9rem;
            text-decoration: none;
        }

        .na-link:hover {
            text-decoration: underline;
        }

        /* Items Grid */
        .na-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            gap: 20px;
        }

        .na-item {
            background: rgba(26, 36, 56, 0.8);
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .na-item:hover {
            transform: translateY(-6px);
            box-shadow: 0 6px 20px rgba(0, 170, 255, 0.25);
        }

        .na-thumb {
            height: 150px;
            border-radius: 8px;
            background: linear-gradient(135deg, #00aaff40, #00446650);
            margin-bottom: 12px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 2rem;
            color: #00aaff;
        }

        .na-item-title {
            font-size: 1.05rem;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .na-price {
            color: #00ffcc;
            font-weight: bold;
        }

        .na-btn {
            display: inline-block;
            background: linear-gradient(135deg, #00aaff, #0099cc);
            color: #fff;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            margin-top: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .na-btn:hover {
            background: #00ccff;
            transform: scale(1.05);
        }

        /* Chips */
        .na-grid-sm {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }

        .na-chip {
            background: rgba(26, 36, 56, 0.8);
            border-radius: 20px;
            padding: 8px 14px;
            color: #00aaff;
            font-weight: 500;
            transition: 0.3s;
        }

        .na-chip:hover {
            background: #00aaff;
            color: #fff;
            transform: translateY(-3px);
        }

        /* Responsive */
        @media (max-width: 768px) {
            nav {
                flex-wrap: wrap;
                gap: 10px;
                padding: 15px 20px;
            }

            main {
                flex-direction: column;
                padding: 20px;
            }

            aside, section.content {
                width: 100%;
            }

            form input {
                width: 120px;
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
                <h5 class="na-section-title">🔥 Featured Items</h5>
                <a class="na-link" href="featured.jsp">View all</a>
            </div>

            <div class="na-grid">
                <article class="na-item">
                    <div class="na-thumb">🕒</div>
                    <h6 class="na-item-title">Rare Swiss Chronograph</h6>
                    <span class="na-price">₹15,200</span><br>
                    <a href="item?id=1" class="na-btn">Bid Now</a>
                </article>

                <article class="na-item">
                    <div class="na-thumb">🚗</div>
                    <h6 class="na-item-title">Classic Car</h6>
                    <span class="na-price">₹45,000</span><br>
                    <a href="item?id=2" class="na-btn">Bid Now</a>
                </article>

                <article class="na-item">
                    <div class="na-thumb">💎</div>
                    <h6 class="na-item-title">Antique Necklace</h6>
                    <span class="na-price">₹23,800</span><br>
                    <a href="item?id=3" class="na-btn">Bid Now</a>
                </article>
            </div>
        </section>

        <section class="na-card">
            <div class="na-section-head">
                <h5 class="na-section-title">🆕 New Arrivals</h5>
                <a class="na-link" href="new.jsp">View all</a>
            </div>

            <div class="na-grid-sm">
                <div class="na-chip">Camera Lens</div>
                <div class="na-chip">Designer Bag</div>
                <div class="na-chip">Vintage Car Model</div>
                <div class="na-chip">Art Print</div>
                <div class="na-chip">Smart Watch</div>
                <div class="na-chip">Luxury Pen</div>
            </div>
        </section>
    </section>
</main>

</body>
</html>
