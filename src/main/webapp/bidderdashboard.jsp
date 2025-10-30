<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Bidder Dashboard | Online Auction</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<style>
    body {
        background-color: #f8f9fa;
        font-family: 'Segoe UI', sans-serif;
        display: flex;
        min-height: 100vh;
        margin: 0;
    }

    /* Sidebar */
    .sidebar {
        width: 250px;
        background-color: #0d6efd;
        color: white;
        padding-top: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        position: fixed;
        height: 100%;
        box-shadow: 2px 0 8px rgba(0,0,0,0.1);
    }

    /* Profile inside sidebar */
    .sidebar .profile-summary {
        text-align: center;
        margin-bottom: 25px;
    }
    .sidebar .profile-summary img {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        border: 2px solid white;
    }
    .sidebar .profile-summary h6 {
        margin-top: 10px;
        font-weight: 600;
    }
    .sidebar .profile-summary p {
        font-size: 13px;
        color: #e0e0e0;
        margin: 0;
    }

    .sidebar h4 {
        font-weight: bold;
        margin-bottom: 20px;
    }

    .sidebar .nav-link {
        color: white;
        padding: 12px 20px;
        width: 100%;
        text-align: left;
        border-radius: 5px;
        transition: 0.3s;
    }

    .sidebar .nav-link:hover, .sidebar .nav-link.active {
        background-color: #0b5ed7;
        text-decoration: none;
    }

    /* Main content */
    .main-content {
        margin-left: 250px;
        padding: 30px;
        width: 100%;
    }

    /* Sections */
    .section {
        display: none;
    }
    .visible {
        display: block;
        animation: fadeIn 0.4s ease;
    }
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* Cards */
    .card {
        border-radius: 10px;
        border: 1px solid #dee2e6;
        transition: 0.3s;
    }
    .card:hover {
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        transform: translateY(-3px);
    }

    /* Buttons */
    .btn-custom {
        background-color: #0d6efd;
        color: white;
        border: none;
    }
    .btn-custom:hover {
        background-color: #0b5ed7;
    }

    /* Profile Section in main area */
    .profile-box {
        display: flex;
        align-items: center;
        gap: 20px;
        padding: 20px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
    .profile-box img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        border: 2px solid #0d6efd;
    }
</style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
  <h4>💰 Auction</h4>

  <!-- Profile summary always visible in sidebar -->
  <div class="profile-summary">
    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile">
    <h6 id="sidebarName">John Doe</h6>
    <p id="sidebarEmail">johndoe@example.com</p>
  </div>

  <!-- Sidebar navigation -->
  <a href="#" class="nav-link active" onclick="showSection('profileSection', this)">
    <i class="bi bi-person-circle me-2"></i>Profile
  </a>
  <a href="#" class="nav-link" onclick="showSection('liveSection', this)">
    <i class="bi bi-lightning-charge-fill me-2"></i>Live Auctions
  </a>
  <a href="#" class="nav-link" onclick="showSection('wonSection', this)">
    <i class="bi bi-trophy-fill me-2"></i>Won Auctions
  </a>
  <a href="logout.jsp" class="nav-link text-warning mt-auto">
    <i class="bi bi-box-arrow-right me-2"></i>Logout
  </a>
</div>

<!-- Main Content -->
<div class="main-content">

  <!-- Profile -->
  <div id="profileSection" class="section visible">
    <h4 class="mb-3 text-primary"><i class="bi bi-person-circle me-2"></i>My Profile</h4>
    <div id="profileDetails" class="profile-box">
      <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile">
      <div>
        <h5 id="userName">John Doe</h5>
        <p id="userEmail" class="mb-1 text-secondary">johndoe@example.com</p>
        <p id="userRole" class="text-secondary">Role: Bidder</p>
      </div>
    </div>
  </div>

  <!-- Live Auctions -->
  <div id="liveSection" class="section">
    <h4 class="mb-3 text-primary"><i class="bi bi-lightning-charge-fill me-2"></i>Live Auctions</h4>
    <div id="liveAuctions" class="row g-3"></div>
  </div>

  <!-- Won Auctions -->
  <div id="wonSection" class="section">
    <h4 class="mb-3 text-success"><i class="bi bi-trophy-fill me-2"></i>Won Auctions</h4>
    <div id="wonAuctions" class="row g-3"></div>
  </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Switch sections
  function showSection(id, el) {
    document.querySelectorAll('.section').forEach(s => s.classList.remove('visible'));
    document.getElementById(id).classList.add('visible');
    document.querySelectorAll('.nav-link').forEach(a => a.classList.remove('active'));
    el.classList.add('active');
  }

  // Load data
  async function loadProfile() {
    const res = await fetch('profile');
    if (res.ok) {
      const data = await res.json();
      document.getElementById('userName').textContent = data.name || 'User';
      document.getElementById('userEmail').textContent = data.email || '';
      document.getElementById('userRole').textContent = "Role: " + (data.role || 'Bidder');

      // Sidebar update
      document.getElementById('sidebarName').textContent = data.name || 'User';
      document.getElementById('sidebarEmail').textContent = data.email || '';
    }
  }

  async function loadLiveAuctions() {
    const res = await fetch('live');
    const container = document.getElementById('liveAuctions');
    if (!res.ok) { container.innerHTML = `<p class='text-danger'>Error loading auctions</p>`; return; }

    const items = await res.json();
    container.innerHTML = items.length ? '' : `<p class='text-secondary'>No live auctions.</p>`;

    items.forEach(it => {
      container.innerHTML += `
        <div class="col-md-4">
          <div class="card p-3">
            ${it.image_path ? `<img src="${it.image_path}" class="card-img-top mb-2" style="border-radius:8px;">` : ''}
            <h6>${it.title}</h6>
            <p>${it.description}</p>
            <p><b>Start:</b> ₹${it.start_price}</p>
            <p><b>Current:</b> ${it.current_bid ? "₹" + it.current_bid : "No bids yet"}</p>
            <form onsubmit="placeBid(event, ${it.id})">
              <div class="input-group">
                <input type="number" class="form-control" name="bid_amount" placeholder="Enter bid" required>
                <button class="btn btn-custom">Bid</button>
              </div>
            </form>
          </div>
        </div>`;
    });
  }

  async function placeBid(e, id) {
    e.preventDefault();
    const form = e.target;
    const bid = form.bid_amount.value;
    const body = new URLSearchParams({ item_id: id, bid_amount: bid });
    const res = await fetch('placeBid', { method: 'POST', body });
    const data = await res.json();
    alert(data.success ? "✅ Bid placed successfully!" : "⚠️ " + (data.error || "Failed to place bid"));
    loadLiveAuctions();
  }

  async function loadWonAuctions() {
    const res = await fetch('wonAuctions');
    const container = document.getElementById('wonAuctions');
    if (!res.ok) { container.innerHTML = `<p class='text-danger'>Error loading</p>`; return; }

    const list = await res.json();
    container.innerHTML = list.length ? '' : `<p class='text-secondary'>No won auctions yet.</p>`;

    list.forEach(w => {
      container.innerHTML += `
        <div class="col-md-4">
          <div class="card p-3">
            ${w.image_path ? `<img src="${w.image_path}" class="card-img-top mb-2" style="border-radius:8px;">` : ''}
            <h6>${w.title}</h6>
            <p><b>Final Bid:</b> ₹${w.current_bid || 0}</p>
            <p><b>Seller:</b> ${w.seller_name}</p>
          </div>
        </div>`;
    });
  }

  // Auto-refresh
  setInterval(loadLiveAuctions, 8000);
  loadProfile();
  loadLiveAuctions();
  loadWonAuctions();
</script>
</body>
</html>
