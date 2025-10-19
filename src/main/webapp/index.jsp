<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NextAuction | Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    

    <style>
      /* ====== RESET & BASE ====== */
      body {
        font-family: 'Times New Roman', serif;
        background-color: #f9f9fb;
        margin: 0;
        color: #333;
      }

      /* ====== NAVBAR ====== */
      .na-navbar {
        background: #111827;
        color: #fff;
        padding: 0.8rem 1.5rem;
        box-shadow: 0 2px 8px rgba(0,0,0,0.15);
      }

      .na-container {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
      }

      .na-brand {
        font-size: 1.6rem;
        font-weight: 600;
        color: #fff;
        text-decoration: none;
      }

      /* Search Bar */
      .na-search {
        display: flex;
        gap: 0.5rem;
        flex: 1;
        max-width: 400px;
        margin: 0 1rem;
      }

      .na-search input {
        flex: 1;
        padding: 0.45rem 0.8rem;
        border-radius: 6px;
        border: none;
        outline: none;
      }

      .na-search button {
        background-color: #2563eb;
        color: white;
        border: none;
        padding: 0.45rem 1rem;
        border-radius: 6px;
        cursor: pointer;
        transition: background 0.3s;
      }

      .na-search button:hover {
        background-color: #1e40af;
      }

      /* Navbar Tabs */
      .na-navlinks {
        display: flex;
        gap: 1.2rem;
        margin-right: 1.5rem;
      }

      .na-navlinks a {
        color: #d1d5db;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s;
      }

      .na-navlinks a:hover {
        color: #fff;
      }

      /* Login / Signup */
      .na-auth {
        display: flex;
        gap: 0.8rem;
      }

      .na-btn {
        text-decoration: none;
        padding: 0.45rem 0.9rem;
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.3s ease;
      }

      .na-btn-primary {
        background: #2563eb;
        color: #fff;
      }

      .na-btn-primary:hover {
        background: #1e40af;
      }

      .na-btn-outline {
        border: 1px solid #fff;
        color: #fff;
      }

      .na-btn-outline:hover {
        background: #fff;
        color: #111827;
      }

      /* ====== MAIN BODY ====== */
      .na-main {
        padding: 1.5rem;
      }

      .na-card {
        background: #fff;
        padding: 1rem 1.2rem;
        border-radius: 10px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        margin-bottom: 1.5rem;
      }

      .na-section-head {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 0.8rem;
      }

      .na-section-title {
        font-size: 1.1rem;
        font-weight: 600;
      }

      .na-link {
        color: #2563eb;
        text-decoration: none;
        font-size: 0.9rem;
      }

      .na-link:hover {
        text-decoration: underline;
      }

      /* ====== SIDEBAR ====== */
      .na-list {
        list-style: none;
        padding: 0;
        margin: 0;
      }

      .na-list li {
        margin: 0.5rem 0;
      }

      .na-list a {
        text-decoration: none;
        color: #374151;
        transition: color 0.3s;
      }

      .na-list a:hover {
        color: #2563eb;
      }

      /* ====== ITEM GRID ====== */
      .na-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
        gap: 1rem;
      }

      .na-item {
        border: 1px solid #e5e7eb;
        border-radius: 10px;
        overflow: hidden;
        transition: all 0.3s ease;
        background: #fafafa;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
      }

      .na-item:hover {
        transform: translateY(-4px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.12);
      }

      .na-thumb {
        background: linear-gradient(135deg, #dbeafe, #93c5fd);
        height: 150px;
      }

      .na-item-title {
        font-size: 1rem;
        font-weight: 600;
        padding: 0.6rem 0.9rem;
      }

      .na-item-meta {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 0.9rem 0.8rem;
        font-size: 0.9rem;
        color: #4b5563;
      }

      .na-price {
        font-weight: 600;
        color: #16a34a;
      }

      .na-timer {
        font-weight: 500;
        color: #dc2626;
      }

      .na-grid-sm {
        display: flex;
        flex-wrap: wrap;
        gap: 0.5rem;
      }

      .na-chip {
        background-color: #eff6ff;
        color: #2563eb;
        padding: 0.4rem 0.9rem;
        border-radius: 20px;
        font-size: 0.9rem;
        cursor: default;
      }

      /* ====== RESPONSIVE ====== */
      @media (max-width: 768px) {
        .na-container {
          flex-direction: column;
          align-items: flex-start;
        }
        .na-search {
          width: 100%;
          margin: 0.5rem 0;
        }
        .na-navlinks {
          flex-wrap: wrap;
          gap: 0.7rem;
          margin: 0.8rem 0;
        }
      }
    </style>
</head>
<body>

  <!-- Header -->
  <nav class="na-navbar">
    <div class="na-container">
      <a class="na-brand" href="#">NextAuction</a>

      <form class="na-search" action="search" method="get">
        <input name="q" type="search" placeholder="Search auctions">
        <button type="submit">Search</button>
      </form>

      <!-- Added Navigation Tabs -->
      <div class="na-navlinks">
        <a href="index.jsp">Home</a>
        <a href="about.jsp">About Us</a>
        <a href="categories.jsp">Categories</a>
        <a href="contact.jsp">Contact</a>
      </div>

      <div class="na-auth">
        <a href="login.jsp" class="na-btn na-btn-primary">Login</a>
        <a href="register.jsp" class="na-btn na-btn-outline">Register</a>
      </div>
    </div>
  </nav>

  <!-- Body -->
  <main class="na-main container-fluid">
    <div class="row g-3">
      <!-- Sidebar -->
      <aside class="col-12 col-md-3 col-lg-2">
        <section class="na-card">
          <h5 class="na-section-title">Categories</h5>
          <ul class="na-list">
            <li><a href="#">Electronics</a></li>
            <li><a href="#">Vehicles</a></li>
            <li><a href="#">Home & Garden</a></li>
            <li><a href="#">Collectibles</a></li>
            <li><a href="#">Art</a></li>
          </ul>
        </section>
      </aside>

      <!-- Main Content -->
      <section class="col-12 col-md-9 col-lg-10">
        <!-- Featured items -->
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
                <span class="na-timer">02:35:10</span>
              </div>
              <a href="item?id=1" class="na-btn na-btn-primary w-100">Bid Now</a>
            </article>

            <article class="na-item">
              <div class="na-thumb"></div>
              <h6 class="na-item-title">Classic Car</h6>
              <div class="na-item-meta">
                <span class="na-price">₹45,000</span>
                <span class="na-timer">1d 10:45</span>
              </div>
              <a href="item?id=2" class="na-btn na-btn-primary w-100">Bid Now</a>
            </article>
          </div>
        </section>

        <!-- New arrivals -->
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
