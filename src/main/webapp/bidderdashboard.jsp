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
        color: #212529;
        font-family: 'Poppins', sans-serif;
    }

    /* ===== NAVBAR ===== */
    .navbar {
        background: linear-gradient(90deg, #007bff, #00bfff);
        box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
    }
    .navbar-brand {
        font-weight: bold;
        color: #fff !important;
        text-shadow: 0 0 5px rgba(255,255,255,0.6);
    }
    .nav-link {
        color: #fff !important;
        margin-right: 10px;
        transition: 0.3s;
    }
    .nav-link:hover {
        color: #ffe082 !important;
    }
    .nav-link.active {
        background: rgba(255,255,255,0.2);
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(255,255,255,0.3);
    }

    /* ===== SECTIONS ===== */
    .section {
        display: none;
        animation: fadeIn 0.5s ease-in-out;
    }
    .visible {
        display: block;
    }
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* ===== HEADINGS ===== */
    h3 {
        border-left: 4px solid #007bff;
        padding-left: 12px;
        margin-bottom: 20px;
        font-weight: 600;
    }

    /* ===== CARDS ===== */
    .card {
        background: #ffffff;
        border: 1px solid #dee2e6;
        border-radius: 12px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 18px rgba(0,0,0,0.1);
    }
    .card-img-top {
        max-height: 200px;
        object-fit: cover;
        border-radius: 10px;
    }

    /* ===== BUTTON ===== */
    .btn-custom {
        background: linear-gradient(90deg, #007bff, #00bfff);
        color: white;
        border: none;
        border-radius: 8px;
        transition: 0.3s;
        font-weight: 600;
    }
    .btn-custom:hover {
        background: linear-gradient(90deg, #00bfff, #007bff);
        transform: scale(1.05);
        box-shadow: 0 0 10px rgba(0,123,255,0.4);
    }

    /* ===== PROFILE IMAGE ===== */
    #profileDetails img {
        border-radius: 50%;
        box-shadow: 0 0 12px rgba(0,123,255,0.3);
    }
</style>
</head>
<body>

<!-- ===== NAVBAR ===== -->
<nav class="navbar navbar-expand-lg navbar-dark px-3 py-2">
    <a class="navbar-brand" href="#">💰 Online Auction</a>
    <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navMenu">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navMenu">
        <ul class="navbar-nav ms-auto">
            <li class="nav-item"><a href="#" class="nav-link active" onclick="showSection('profileSection', this)"><i class="bi bi-person-circle me-1"></i>Profile</a></li>
            <li class="nav-item"><a href="#" class="nav-link" onclick="showSection('liveSection', this)"><i class="bi bi-lightning-fill me-1"></i>Live Auctions</a></li>
            <li class="nav-item"><a href="#" class="nav-link" onclick="showSection('wonSection', this)"><i class="bi bi-trophy-fill me-1"></i>Won Auctions</a></li>
            <li class="nav-item"><a href="logout.jsp" class="nav-link text-warning"><i class="bi bi-box-arrow-right me-1"></i>Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container py-4">

    <!-- ===== PROFILE SECTION ===== -->
    <div id="profileSection" class="section visible">
        <h3><i class="bi bi-person-badge"></i> My Profile</h3>
        <div id="profileDetails" class="card p-4 text-center"></div>
    </div>

    <!-- ===== LIVE AUCTIONS ===== -->
    <div id="liveSection" class="section">
        <h3><i class="bi bi-fire text-danger"></i> Live Auctions</h3>
        <div id="liveAuctions" class="row g-4"></div>
    </div>

    <!-- ===== WON AUCTIONS ===== -->
    <div id="wonSection" class="section">
        <h3><i class="bi bi-trophy text-success"></i> Won Auctions</h3>
        <div id="wonAuctions" class="row g-4"></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ===== SECTION HANDLER =====
    function showSection(id, el) {
        document.querySelectorAll('.section').forEach(s => s.classList.remove('visible'));
        document.getElementById(id).classList.add('visible');
        document.querySelectorAll('.nav-link').forEach(a => a.classList.remove('active'));
        el.classList.add('active');
    }

    // ===== LOAD PROFILE =====
    async function loadProfile() {
        const res = await fetch('profile');
        if (res.ok) {
            const data = await res.json();
            document.getElementById('profileDetails').innerHTML = data.error
                ? `<p class='text-danger'>${data.error}</p>`
                : `<img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" width="100" class="mb-3">
                   <h4>${data.name}</h4>
                   <p><b>Email:</b> ${data.email}</p>
                   <p><b>Role:</b> ${data.role}</p>`;
        }
    }

    // ===== LOAD LIVE AUCTIONS =====
    async function loadLiveAuctions() {
        const res = await fetch('live');
        const container = document.getElementById('liveAuctions');
        if (!res.ok) { container.innerHTML = `<p class='text-danger'>Error loading auctions</p>`; return; }

        const items = await res.json();
        container.innerHTML = '';
        if (items.length === 0) { container.innerHTML = `<p class='text-secondary'>No live auctions available right now.</p>`; return; }

        items.forEach(it => {
            container.innerHTML += `
                <div class="col-md-4">
                    <div class="card p-3 h-100">
                        ${it.image_path ? `<img src="${it.image_path}" class="card-img-top mb-2">` : ''}
                        <h5>${it.title}</h5>
                        <p>${it.description}</p>
                        <p><b>Seller:</b> ${it.seller_name}</p>
                        <p><b>Start Price:</b> ₹${it.start_price}</p>
                        <p><b>Current Bid:</b> ${it.current_bid ? "₹" + it.current_bid : "No bids yet"}</p>
                        <form onsubmit="placeBid(event, ${it.id})">
                            <div class="input-group mb-2">
                                <input type="number" step="0.01" class="form-control" name="bid_amount" placeholder="Enter your bid" required>
                                <button class="btn btn-custom"><i class="bi bi-cash-coin me-1"></i>Bid</button>
                            </div>
                        </form>
                        <small class="text-muted">Ends: ${it.end_time}</small>
                    </div>
                </div>
            `;
        });
    }

    // ===== PLACE BID =====
    async function placeBid(e, itemId) {
        e.preventDefault();
        const form = e.target;
        const bid = form.bid_amount.value;
        const formData = new URLSearchParams();
        formData.append("item_id", itemId);
        formData.append("bid_amount", bid);

        const res = await fetch('placeBid', { method: 'POST', body: formData });
        const data = await res.json();
        alert(data.success ? "✅ Bid placed successfully!" : "⚠️ " + (data.error || "Failed to bid"));
        loadLiveAuctions();
    }

    // ===== LOAD WON AUCTIONS =====
    async function loadWonAuctions() {
        const res = await fetch('wonAuctions');
        const container = document.getElementById('wonAuctions');
        if (!res.ok) { container.innerHTML = `<p class='text-danger'>Error loading data</p>`; return; }

        const list = await res.json();
        container.innerHTML = '';
        if (list.length === 0) { container.innerHTML = `<p class='text-secondary'>You haven't won any auctions yet.</p>`; return; }

        list.forEach(w => {
            container.innerHTML += `
                <div class="col-md-4">
                    <div class="card p-3 h-100">
                        ${w.image_path ? `<img src="${w.image_path}" class="card-img-top mb-2">` : ''}
                        <h5>${w.title}</h5>
                        <p><b>Final Bid:</b> ₹${w.current_bid || 0}</p>
                        <p><b>Seller:</b> ${w.seller_name}</p>
                        <small class="text-muted">Ended: ${w.end_time}</small>
                    </div>
                </div>
            `;
        });
    }

    // ===== AUTO REFRESH =====
    setInterval(loadLiveAuctions, 6000);
    setInterval(loadWonAuctions, 12000);

    // ===== INITIAL LOAD =====
    loadProfile();
    loadLiveAuctions();
    loadWonAuctions();
</script>
</body>
</html>