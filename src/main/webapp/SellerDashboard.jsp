<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Seller Dashboard | Online Auction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f7fa;
            color: #222;
            font-family: 'Segoe UI', sans-serif;
        }

        .navbar {
            background: #0d6efd !important;
        }

        .navbar-brand {
            font-weight: 600;
            color: #fff !important;
        }

        .nav-link {
            color: #f0f4ff !important;
            margin-right: 8px;
            transition: background 0.3s, color 0.3s;
        }

        .nav-link:hover, .nav-link.active {
            background-color: #fff !important;
            color: #0d6efd !important;
            border-radius: 8px;
        }

        .section {
            display: none;
        }

        .visible {
            display: block;
        }

        .card {
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .card-img-top {
            max-height: 180px;
            object-fit: cover;
            border-radius: 6px;
        }

        .btn-custom {
            background-color: #0d6efd;
            color: white;
            border: none;
        }

        .btn-custom:hover {
            background-color: #0b5ed7;
        }

        .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 6px 14px;
        }

        .logout-btn:hover {
            background-color: #c82333;
        }

        h3 {
            font-weight: 600;
        }
    </style>
</head>
<body>

<!-- 🔹 NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark px-3">
    <a class="navbar-brand" href="#">💼 Online Auction</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ms-auto align-items-center">
            <li class="nav-item"><a href="#" class="nav-link active" onclick="showSection('profileSection', this)">Profile</a></li>
            <li class="nav-item"><a href="#" class="nav-link" onclick="showSection('addItemSection', this)">Add Item</a></li>
            <li class="nav-item"><a href="#" class="nav-link" onclick="showSection('liveSection', this)">Live Auctions</a></li>
            <li class="nav-item"><a href="#" class="nav-link" onclick="showSection('winnerSection', this)">Winners</a></li>
            <li class="nav-item ms-3">
                <form action="logout.jsp" method="post" class="d-inline">
                    <button type="submit" class="logout-btn">🚪 Logout</button>
                </form>
            </li>
        </ul>
    </div>
</nav>

<!-- 🔹 MAIN CONTENT -->
<div class="container py-4">

    <!-- 👤 PROFILE SECTION -->
    <div id="profileSection" class="section visible">
        <h3 class="mb-3 text-primary">👤 My Profile</h3>
        <div id="profileDetails" class="card p-3 shadow-sm"></div>
    </div>

    <!-- 🛒 ADD ITEM SECTION -->
    <div id="addItemSection" class="section">
        <h3 class="mb-3 text-info">🛒 Add New Auction Item</h3>
        <form id="addItemForm" enctype="multipart/form-data">
            <div class="row">
                <div class="col-md-6 mb-2">
                    <label class="form-label">Title</label>
                    <input type="text" class="form-control" name="title" required>
                </div>
                <div class="col-md-6 mb-2">
                    <label class="form-label">Starting Price</label>
                    <input type="number" class="form-control" name="start_price" required step="0.01">
                </div>

                <!-- 🆕 CATEGORY FIELD -->
                <div class="col-md-6 mb-2">
                    <label class="form-label">Category</label>
                    <select class="form-select" name="category" required>
                        <option value="">-- Select Category --</option>
                        <option value="Electronics">Electronics</option>
                        <option value="Vehicles">Vehicles</option>
                        <option value="Home & Garden">Home & Garden</option>
                        <option value="Collectibles">Collectibles</option>
                        <option value="Art">Art</option>
                        <option value="Fashion">Fashion</option>
                        <option value="Jewelry">Jewelry</option>
                        <option value="Sports">Sports</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="col-12 mb-2">
                    <label class="form-label">Description</label>
                    <textarea class="form-control" name="description" rows="2"></textarea>
                </div>
                <div class="col-md-6 mb-2">
                    <label class="form-label">Start Time (optional)</label>
                    <input type="datetime-local" class="form-control" name="start_time">
                </div>
                <div class="col-md-6 mb-2">
                    <label class="form-label">End Time</label>
                    <input type="datetime-local" class="form-control" name="end_time" required>
                </div>
                <div class="col-12 mb-2">
                    <label class="form-label">Upload Image</label>
                    <input type="file" class="form-control" name="image" accept="image/*">
                </div>
                <div class="col-12 text-end mt-3">
                    <button type="submit" class="btn btn-custom">Add Item</button>
                </div>
            </div>
        </form>
        <div id="addItemMsg" class="mt-3"></div>
    </div>

    <!-- 🔥 LIVE AUCTIONS -->
    <div id="liveSection" class="section">
        <h3 class="mb-3 text-success">🔥 Live Auctions</h3>
        <div id="liveAuctions" class="row"></div>
    </div>

    <!-- 🏆 WINNERS -->
    <div id="winnerSection" class="section">
        <h3 class="mb-3 text-warning">🏆 Winners</h3>
        <div id="winnersList" class="row"></div>
    </div>

</div>

<!-- 🔹 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ===== NAVIGATION =====
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

    // ===== ADD ITEM =====
    document.getElementById('addItemForm').addEventListener('submit', async (e) => {
        e.preventDefault();
        const formData = new FormData(e.target);
        const res = await fetch('addItem', { method: 'POST', body: formData });
        const msgDiv = document.getElementById('addItemMsg');
        if (res.ok) {
            const data = await res.json();
            msgDiv.innerHTML = data.success 
                ? `<p class='text-success'>✅ Item added successfully (ID: ${data.id})</p>` 
                : `<p class='text-danger'>❌ ${data.error}</p>`;
            if (data.success) e.target.reset();
        } else {
            msgDiv.innerHTML = `<p class='text-danger'>⚠️ Failed to add item</p>`;
        }
    });

    // ===== LOAD LIVE AUCTIONS =====
    async function loadLiveAuctions() {
        const res = await fetch('live');
        const container = document.getElementById('liveAuctions');
        if (!res.ok) { container.innerHTML = `<p class='text-danger'>Error loading auctions</p>`; return; }

        const items = await res.json();
        container.innerHTML = '';
        if (items.length === 0) { container.innerHTML = `<p class='text-secondary'>No live auctions available.</p>`; return; }

        items.forEach(it => {
            container.innerHTML += `
                <div class="col-md-4 mb-3">
                    <div class="card p-3">
                        ${it.image_path ? `<img src="${it.image_path}" class="card-img-top mb-2">` : ''}
                        <h5>${it.title}</h5>
                        <p>${it.description}</p>
                        <p><b>Category:</b> ${it.category || 'N/A'}</p>
                        <p><b>Start Price:</b> ₹${it.start_price}</p>
                        <p><b>Current Bid:</b> ${it.current_bid ? "₹" + it.current_bid : "No bids yet"}</p>
                        <small class="text-muted">Ends: ${it.end_time}</small>
                    </div>
                </div>
            `;
        });
    }

    // ===== LOAD WINNERS =====
    async function loadWinners() {
        const res = await fetch('winners');
        const container = document.getElementById('winnersList');
        if (!res.ok) { container.innerHTML = `<p class='text-danger'>Error loading winners</p>`; return; }

        const list = await res.json();
        container.innerHTML = '';
        if (list.length === 0) { container.innerHTML = `<p class='text-secondary'>No auctions ended yet.</p>`; return; }

        list.forEach(w => {
            container.innerHTML += `
                <div class="col-md-4 mb-3">
                    <div class="card p-3">
                        ${w.image_path ? `<img src="${w.image_path}" class="card-img-top mb-2">` : ''}
                        <h5>${w.title}</h5>
                        <p><b>Winner:</b> ${w.winner_name || 'No winner'}</p>
                        <p><b>Final Bid:</b> ₹${w.current_bid || 0}</p>
                        <p><b>Category:</b> ${w.category || 'N/A'}</p>
                        <small class="text-muted">Ended: ${w.end_time}</small>
                    </div>
                </div>
            `;
        });
    }

    // ===== AUTO REFRESH =====
    setInterval(loadLiveAuctions, 5000);
    setInterval(loadWinners, 8000);

    // ===== INITIAL LOAD =====
    loadProfile();
    loadLiveAuctions();
    loadWinners();
</script>

</body>
</html>
