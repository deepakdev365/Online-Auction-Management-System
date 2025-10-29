<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bidder Dashboard | NextAuction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #e6f0ff, #ffffff);
            color: #333;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease-in-out;
        }

        /* Navbar */
        .navbar {
            background: linear-gradient(90deg, #007bff, #00c6ff);
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 1.4rem;
            color: white !important;
        }
        .nav-link {
            color: white !important;
            font-weight: 500;
            margin: 0 10px;
            transition: all 0.3s ease;
        }
        .nav-link.active, .nav-link:hover {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
        }

        /* Sections */
        .section {
            display: none;
            animation: fadeIn 0.6s ease-in-out;
        }
        .visible { display: block; }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(10px);}
            to {opacity: 1; transform: translateY(0);}
        }

        /* Cards */
        .card {
            background-color: #ffffff;
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 123, 255, 0.4);
        }
        .card-img-top {
            max-height: 180px;
            object-fit: cover;
            border-radius: 12px;
        }

        /* Buttons */
        .btn-custom {
            background: linear-gradient(90deg, #007bff, #00c6ff);
            color: white;
            font-weight: 500;
            border: none;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            background: linear-gradient(90deg, #0056b3, #0096c7);
        }

        /* Profile Card */
        .profile-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 30px;
            text-align: center;
            transition: 0.3s;
        }
        .profile-card img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #007bff;
            box-shadow: 0 0 20px rgba(0,123,255,0.4);
        }
        .profile-card h4 {
            color: #007bff;
            margin-top: 15px;
            font-weight: 600;
        }

        .countdown {
            font-weight: bold;
            color: #ff4500;
        }
    </style>
</head>

<body>
<!-- ===== NAVBAR ===== -->
<nav class="navbar navbar-expand-lg navbar-dark px-3">
    <a class="navbar-brand" href="#">⚡ NextAuction</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ms-auto">
            <li class="nav-item"><a href="#" class="nav-link active" onclick="showSection('profileSection', this)">Profile</a></li>
            <li class="nav-item"><a href="#" class="nav-link" onclick="showSection('liveSection', this)">Live Auctions</a></li>
            <li class="nav-item"><a href="#" class="nav-link" onclick="showSection('wonSection', this)">Won Auctions</a></li>
            <li class="nav-item"><a href="logout.jsp" class="nav-link text-warning fw-bold">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container py-5">

    <!-- ===== PROFILE SECTION ===== -->
    <div id="profileSection" class="section visible">
        <h3 class="mb-4 text-center">👤 My Profile</h3>
        <div id="profileDetails" class="profile-card mx-auto" style="max-width:400px;">
            <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile">
            <h4 id="profileName">Loading...</h4>
            <p id="profileEmail"></p>
            <p id="profileRole" class="text-muted"></p>
        </div>
    </div>

    <!-- ===== LIVE AUCTIONS ===== -->
    <div id="liveSection" class="section">
        <h3 class="mb-3 text-center">🔥 Live Auctions</h3>
        <div id="liveAuctions" class="row g-4"></div>
    </div>

    <!-- ===== WON AUCTIONS ===== -->
    <div id="wonSection" class="section">
        <h3 class="mb-3 text-center">🏆 Won Auctions</h3>
        <div id="wonAuctions" class="row g-4"></div>
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
            if (!data.error) {
                document.getElementById('profileName').innerText = data.name;
                document.getElementById('profileEmail').innerText = data.email;
                document.getElementById('profileRole').innerText = data.role;
            }
        }
    }

    // ===== LOAD LIVE AUCTIONS =====
    async function loadLiveAuctions() {
        const res = await fetch('live');
        const container = document.getElementById('liveAuctions');
        if (!res.ok) { container.innerHTML = `<p class='text-danger'>Error loading auctions</p>`; return; }

        const items = await res.json();
        container.innerHTML = '';
        if (items.length === 0) {
            container.innerHTML = `<p class='text-secondary text-center'>No live auctions available right now.</p>`;
            return;
        }

        items.forEach(it => {
            container.innerHTML += `
                <div class="col-md-4">
                    <div class="card p-3">
                        ${it.image_path ? `<img src="${it.image_path}" class="card-img-top mb-3">` : ''}
                        <h5>${it.title}</h5>
                        <p>${it.description}</p>
                        <p><b>Seller:</b> ${it.seller_name}</p>
                        <p><b>Start Price:</b> ₹${it.start_price}</p>
                        <p><b>Current Bid:</b> ${it.current_bid ? "₹" + it.current_bid : "No bids yet"}</p>
                        <p class="countdown" id="timer-${it.id}">Loading...</p>
                        <form onsubmit="placeBid(event, ${it.id})">
                            <div class="input-group mb-2">
                                <input type="number" step="0.01" class="form-control" name="bid_amount" placeholder="Your bid" required>
                                <button class="btn btn-custom">Place Bid</button>
                            </div>
                        </form>
                    </div>
                </div>`;
            startCountdown(it.id, it.end_time);
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

    // ===== COUNTDOWN TIMER =====
    function startCountdown(id, endTime) {
        const timerEl = document.getElementById(`timer-${id}`);
        function update() {
            const end = new Date(endTime).getTime();
            const now = new Date().getTime();
            const diff = end - now;

            if (diff <= 0) {
                timerEl.innerText = "Auction Ended";
                timerEl.style.color = "gray";
                return;
            }

            const hrs = Math.floor(diff / (1000 * 60 * 60));
            const mins = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
            const secs = Math.floor((diff % (1000 * 60)) / 1000);
            timerEl.innerText = `⏳ Ends in ${hrs}h ${mins}m ${secs}s`;
            setTimeout(update, 1000);
        }
        update();
    }

    // ===== LOAD WON AUCTIONS =====
    async function loadWonAuctions() {
        const res = await fetch('wonAuctions');
        const container = document.getElementById('wonAuctions');
        if (!res.ok) { container.innerHTML = `<p class='text-danger'>Error loading data</p>`; return; }

        const list = await res.json();
        container.innerHTML = '';
        if (list.length === 0) { container.innerHTML = `<p class='text-secondary text-center'>You haven't won any auctions yet.</p>`; return; }

        list.forEach(w => {
            container.innerHTML += `
                <div class="col-md-4">
                    <div class="card p-3">
                        ${w.image_path ? `<img src="${w.image_path}" class="card-img-top mb-3">` : ''}
                        <h5>${w.title}</h5>
                        <p><b>Final Bid:</b> ₹${w.current_bid || 0}</p>
                        <p><b>Seller:</b> ${w.seller_name}</p>
                        <small class="text-muted">Ended: ${w.end_time}</small>
                    </div>
                </div>`;
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
