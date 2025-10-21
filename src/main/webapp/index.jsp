<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NextAuction | Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
     
</head>
<body>
<nav >
<div class="">
<a class="" href="#">NextAuction</a>
<form class="" action="search" method="get">

<input name="q" type="" placeholder="">
<button type="">Search</button>
</form>

<div class="">
<a href="index.jsp">Home</a>

<a href="AboutUs.jsp">About Us</a>
<a href="categories.jsp">Categories</a>

<a href="Contact.jsp">Contact</a>
<a href="FAQ.jsp">FaQs</a>
</div>

<div class="">
<a href="login.jsp" class="">Login</a>
<a href="Signup.jsp" class="">Register</a>

<a href="SellerSignup.jsp" class="">Sell</a>
<a href="adminLogin.jsp" class="">Admin</a>
</div>
</div>
</nav>


<main class="">

<div class="">
<aside class="">

<section class="">
<h5 class="">Categories</h5>
<ul class="">

<li><a href="#">Electronics</a></li>
<li><a href="#">Vehicles</a></li>
<li><a href="#">Home & Garden</a></li>
<li><a href="#">Collectibles</a></li>
<li><a href="#">Art</a></li>
</ul>
</section>
</aside>

<section class="col-12 col-md-9 col-lg-10">
<section class="na-card">
<div class="na-section-head">
<h5 class="na-section-title">Featured Items</h5>
<a class="na-link" href="featured.jsp">View all</a>
</div>
<div class="na-grid">
<article class="na-item">
<div class="na-thumb"></div>
<h6 class="na-item-title">Rare Swiss Chronograph</h6>
<div class="na-item-meta">
<span class="na-price">₹15,200</span>

</div>



<a href="item?id=1" class="na-btn na-btn-primary w-100">Bid Now</a>
</article>

<article class="na-item">
<div class="na-thumb"></div>
<h6 class="na-item-title">Classic Car</h6>
<div class="na-item-meta">
<span class="na-price">₹45,000</span>
</div>
<a href="item?id=2" class="na-btn na-btn-primary w-100">Bid Now</a>
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
</div>
</main>

</body>
</html>
