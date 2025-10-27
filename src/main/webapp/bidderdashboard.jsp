<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bidder Dashboard | Online Auction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #0d1117;
            color: #c9d1d9;
            font-family: 'Segoe UI', sans-serif;
        }
        .nav-link.active {
            background-color: #21262d !important;
            color: #58a6ff !important;
            border-radius: 8px;
        }
        .section {
            display: none;
        }
        .visible {
            display: block;
        }
        .card {
            background-color: #161b22;
            border: 1px solid #30363d;
            border-radius: 8px;
        }
        .btn-custom {
            background-color: #238636;
            color: white;
        }
        .btn-custom:hover {
            background-color: #2ea043;
        }
        .card-img-top {
            max-height: 180px;
            object-fit: cover;
            border-radius: 6px;
        }
    </style>
</head>
<body>

<!-- ===== NAVBAR ===== -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
    <a class="navbar-brand" href="#">💰 Online Auction</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ms-auto">
            <li class="nav-item"><a href="#" class="nav-link active" onclick="showSection('profileSection', this)">Profile</a></li>
            <li class="nav-item"><a href="#" class="nav-link" onclick="showSection('liveSection', this)">Live Auctions</a></li>
            <li class="nav-item"><a href="#" class="nav-link" onclick="showSection('wonSection', this)">Won Auctions</a></li>
            <li class="nav-item"><a href="logout.jsp" class="nav-link text-danger">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container py-4">

    <!-- ===== PROFILE SECTION ===== -->
    <div id="profileSection" class="section visible">
        <h3 class="mb-3 text-info">👤 My Profile</h3>
        <div id="profileDetails" class="card p-3"></div>
    </div>

    <!-- ===== LIVE AUCTIONS ===== -->
    <div id="liveSection" class="section">
        <h3 class="mb-3 text-warning">🔥 Live Auctions</h3>
        <div id="liveAuctions" class="row"></div>
    </div>

    <!-- ===== WON AUCTIONS ===== -->
    <div id="wonSection" class="section">
        <h3 class="mb-3 text-success">🏆 Won Auctions</h3>
        <div id="wonAuctions" class="row"></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ===== NAVIGATION HANDLER =====
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
                : `<p><b>Name:</b> ${data.name}</p>
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
                <div class="col-md-4 mb-3">
                    <div class="card p-3">
                        ${it.image_path ? `<img src="${it.image_path}" class="card-img-top mb-2">` : ''}
                        <h5>${it.title}</h5>
                        <p>${it.description}</p>
                        <p><b>Seller:</b> ${it.seller_name}</p>
                        <p><b>Start Price:</b> ₹${it.start_price}</p>
                        <p><b>Current Bid:</b> ${it.current_bid ? "₹" + it.current_bid : "No bids yet"}</p>
                        <form onsubmit="placeBid(event, ${it.id})">
                            <div class="input-group mb-2">
                                <input type="number" step="0.01" class="form-control" name="bid_amount" placeholder="Your bid" required>
                                <button class="btn btn-custom">Place Bid</button>
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
                <div class="col-md-4 mb-3">
                    <div class="card p-3">
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
    setInterval(loadLiveAuctions, 5000);
    setInterval(loadWonAuctions, 10000);

    // ===== INITIAL LOAD =====
    loadProfile();
    loadLiveAuctions();
    loadWonAuctions();
</script>

</body>
</html>
