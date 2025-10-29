<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NextAuction | Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        nav {
            background-color: #333;
            padding: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        nav a {
            color: white;
            margin-right: 15px;
            text-decoration: none;
            font-weight: 500;
        }
        nav a:hover {
            text-decoration: underline;
        }
        form {
            display: inline-flex;
            align-items: center;
        }
        input[type="text"] {
            padding: 5px;
            border-radius: 3px;
            border: none;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 6px 10px;
            margin-left: 5px;
            cursor: pointer;
            border-radius: 3px;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>

<body>

<!-- ✅ Navigation Bar -->
<nav>
    <div>
        <a href="home.jsp">NextAuction</a>
        <a href="live.jsp">Live Auctions</a>
        <a href="profile.jsp">Profile</a>
        <a href="categories.jsp">Categories</a>
        <a href="Contact.jsp">Contact</a>
        <a href="FAQ.jsp">FAQs</a>
    </div>

    <form action="search" method="get">
        <input name="q" type="text" placeholder="Search items...">
        <button type="submit">Search</button>
    </form>

    <div>
        <a href="login.jsp">Login</a>
        <a href="Signup.jsp">Register</a>
        <a href="SellerSignup.jsp">Sell</a>
        <a href="adminLogin.jsp">Admin</a>
        <a href="logout.jsp">Logout</a>
    </div>
</nav>

<!-- ✅ Main Content -->
<main>
    <div class="">
        <aside class="">
            <section class="">
                <h5>Categories</h5>
                <ul>
                    <li><a href="#">Electronics</a></li>
                    <li><a href="#">Vehicles</a></li>
                    <li><a href="#">Home & Garden</a></li>
                    <li><a href="#">Collectibles</a></li>
                    <li><a href="#">Art</a></li>
                </ul>
            </section>
        </aside>

        <section class="">
            <section class="">
                <div class="">
                    <h5>Featured Items</h5>
                    <a href="featured.jsp">View all</a>
                </div>
                <div class="">
                    <article>
                        <div class="na-thumb"></div>
                        <h6>Rare Swiss Chronograph</h6>
                        <div>
                            <span>₹15,200</span>
                        </div>
                        <a href="item?id=1" class="">Bid Now</a>
                    </article>

                    <article>
                        <div class="na-thumb"></div>
                        <h6>Classic Car</h6>
                        <div>
                            <span>₹45,000</span>
                        </div>
                        <a href="item?id=2" class="">Bid Now</a>
                    </article>
                </div>
            </section>

            <section>
                <div>
                    <h5>New Arrivals</h5>
                    <a href="new.jsp">View all</a>
                </div>
                <div>
                    <div>Camera Lens</div>
                    <div>Designer Bag</div>
                    <div>Vintage Car Model</div>
                    <div>Art Print</div>
                </div>
            </section>
        </section>
    </div>
</main>

</body>
</html>
