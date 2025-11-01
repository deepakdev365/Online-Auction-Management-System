<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Auction Item | NextAuction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #0a1222, #050914);
            color: #fff;
            font-family: 'Poppins', sans-serif;
        }
        .form-container {
            max-width: 650px;
            margin: 60px auto;
            background: rgba(255,255,255,0.08);
            padding: 35px 40px;
            border-radius: 14px;
            box-shadow: 0 0 20px rgba(0,170,255,0.2);
        }
        h2 {
            color: #00aaff;
            text-align: center;
            margin-bottom: 25px;
        }
        label {
            font-weight: 500;
            color: #ddd;
        }
        input, select, textarea {
            background: rgba(255,255,255,0.1);
            border: none;
            color: #fff;
        }
        input:focus, select:focus, textarea:focus {
            box-shadow: 0 0 4px #00aaff;
        }
        .btn-submit {
            background: linear-gradient(135deg, #00aaff, #007acc);
            color: white;
            border: none;
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            font-weight: 600;
        }
        .btn-submit:hover {
            background: #00ccff;
        }
        #responseMsg {
            margin-top: 15px;
            text-align: center;
            font-weight: 500;
        }
    </style>
</head>

<body>
<div class="form-container">
    <h2>🛒 Add Auction Item</h2>

    <form id="addItemForm" action="addItem" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="title">Item Title</label>
            <input type="text" class="form-control" name="title" id="title" required>
        </div>

        <div class="mb-3">
            <label for="description">Description</label>
            <textarea class="form-control" name="description" id="description" rows="3" required></textarea>
        </div>

        <div class="mb-3">
            <label for="category">Category</label>
            <select class="form-select" name="category" id="category" required>
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
            <label for="start_price">Starting Price (₹)</label>
            <input type="number" class="form-control" name="start_price" id="start_price" step="0.01" required>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="start_time">Start Time</label>
                <input type="datetime-local" class="form-control" name="start_time" id="start_time" required>
            </div>
            <div class="col-md-6 mb-3">
                <label for="end_time">End Time</label>
                <input type="datetime-local" class="form-control" name="end_time" id="end_time" required>
            </div>
        </div>

        <div class="mb-3">
            <label for="image">Upload Image</label>
            <input type="file" class="form-control" name="image" id="image" accept="image/*">
        </div>

        <button type="submit" class="btn-submit">Add Item</button>
    </form>

    <div id="responseMsg"></div>
</div>

<!-- JavaScript (AJAX for real-time response) -->
<script>
document.getElementById("addItemForm").addEventListener("submit", async function(event) {
    event.preventDefault();

    const formData = new FormData(this);
    const responseMsg = document.getElementById("responseMsg");

    responseMsg.innerHTML = "<p style='color:#00aaff;'>⏳ Adding item...</p>";

    try {
        const res = await fetch("addItem", {
            method: "POST",
            body: formData
        });

        const data = await res.json();
        if (data.success) {
            responseMsg.innerHTML = `<p style='color:lightgreen;'>✅ Item added successfully! (ID: ${data.id})</p>`;
            this.reset();
        } else {
            responseMsg.innerHTML = `<p style='color:#ff4444;'>❌ ${data.error || "Something went wrong"}</p>`;
        }
    } catch (error) {
        responseMsg.innerHTML = `<p style='color:#ff4444;'>⚠️ ${error.message}</p>`;
    }
});
</script>

</body>
</html>
