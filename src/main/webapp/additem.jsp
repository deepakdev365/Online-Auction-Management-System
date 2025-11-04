<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add Auction Item | NextAuction</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: linear-gradient(135deg, #00172D, #004C99);
        color: #fff;
        font-family: 'Poppins', sans-serif;
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 40px 10px;
    }

    .form-card {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
        border-radius: 16px;
        padding: 35px 40px;
        width: 100%;
        max-width: 600px;
        box-shadow: 0 0 20px rgba(0, 150, 255, 0.3);
    }

    h2 {
        text-align: center;
        color: #00bfff;
        margin-bottom: 25px;
        font-weight: 600;
    }

    label {
        color: #e0e0e0;
        font-weight: 500;
    }

    input, select, textarea {
        background: rgba(255,255,255,0.15);
        border: none;
        color: #fff;
        border-radius: 6px;
    }

    input:focus, select:focus, textarea:focus {
        outline: none;
        box-shadow: 0 0 5px #00bfff;
        border: 1px solid #00bfff;
    }

    .btn-submit {
        background: linear-gradient(135deg, #00bfff, #0088cc);
        color: #fff;
        border: none;
        width: 100%;
        padding: 10px;
        border-radius: 8px;
        font-weight: 600;
        transition: 0.3s;
    }

    .btn-submit:hover {
        background: linear-gradient(135deg, #00ccff, #0077b6);
    }

    .btn-back {
        display: inline-block;
        background: transparent;
        border: 1px solid #00bfff;
        color: #00bfff;
        padding: 6px 14px;
        border-radius: 6px;
        text-decoration: none;
        font-size: 14px;
        transition: 0.3s;
    }

    .btn-back:hover {
        background: #00bfff;
        color: #fff;
    }

    #responseMsg {
        margin-top: 15px;
        text-align: center;
        font-weight: 500;
    }
</style>
</head>

<body>

<div class="form-card">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <a href="SellerDashboard.jsp" class="btn-back">← Back to Dashboard</a>
    </div>

    <h2>🛒 Add Auction Item</h2>

    <form id="addItemForm" action="addItem" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label>Item Title</label>
            <input type="text" class="form-control" name="title" required>
        </div>

        <div class="mb-3">
            <label>Description</label>
            <textarea class="form-control" name="description" rows="3" required></textarea>
        </div>

        <div class="mb-3">
            <label>Category</label>
            <select class="form-select" name="category" required>
                <option value="">-- Select Category --</option>
                <option>Electronics</option>
                <option>Vehicles</option>
                <option>Home & Garden</option>
                <option>Collectibles</option>
                <option>Art</option>
                <option>Fashion</option>
                <option>Jewelry</option>
                <option>Sports</option>
                <option>Other</option>
            </select>
        </div>

        <div class="mb-3">
            <label>Starting Price (₹)</label>
            <input type="number" class="form-control" name="start_price" step="0.01" required>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label>Start Time</label>
                <input type="datetime-local" class="form-control" name="start_time" required>
            </div>
            <div class="col-md-6 mb-3">
                <label>End Time</label>
                <input type="datetime-local" class="form-control" name="end_time" required>
            </div>
        </div>

        <div class="mb-3">
            <label>Upload Image</label>
            <input type="file" class="form-control" name="image" accept="image/*">
        </div>

        <button type="submit" class="btn-submit">Add Item</button>
    </form>

    <div id="responseMsg"></div>
</div>

<script>
document.getElementById("addItemForm").addEventListener("submit", async function(e) {
    e.preventDefault();
    const formData = new FormData(this);
    const msg = document.getElementById("responseMsg");
    msg.innerHTML = "<p style='color:#00bfff;'>⏳ Adding item...</p>";

    try {
        const res = await fetch("addItem", { method: "POST", body: formData });
        const data = await res.json();
        if (data.success) {
            msg.innerHTML = `<p style='color:lightgreen;'>✅ Item added successfully! (ID: ${data.id})</p>`;
            this.reset();
        } else {
            msg.innerHTML = `<p style='color:#ff6b6b;'>❌ ${data.error || "Something went wrong!"}</p>`;
        }
    } catch (err) {
        msg.innerHTML = `<p style='color:#ff6b6b;'>⚠️ ${err.message}</p>`;
    }
});
</script>

</body>
</html>
