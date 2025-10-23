<!DOCTYPE html>
<html>
<head>
    <title>Add New Auction Item</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f9f9f9 0%, #dce7f2 100%);
            padding: 40px;
        }
        .form-container {
            background: white;
            max-width: 500px;
            margin: auto;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 6px 16px rgb(0 0 0 / 20%);
        }
        h2 {
            margin-bottom: 25px;
            color: #333;
            text-align: center;
        }
        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
            color: #444;
        }
        input[type="text"], input[type="number"], input[type="date"], textarea, input[type="file"] {
            width: 100%;
            padding: 10px 12px;
            margin-top: 6px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background-color: #3949ab;
            border: none;
            color: white;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }
        input[type="submit"]:hover {
            background-color: #283593;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Add New Auction Item</h2>
        <form action="AddItemServlet" method="post" enctype="multipart/form-data">
            <label for="name">Item Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="description">Description:</label>
            <textarea id="description" name="description" required></textarea>

            <label for="startingPrice">Starting Price (₹):</label>
            <input type="number" id="startingPrice" name="startingPrice" required step="0.01" min="0">

            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" required>

            <label for="image">Item Image:</label>
            <input type="file" id="image" name="image" accept="image/*" required>

            <input type="submit" value="Add Item">
        </form>
    </div>
</body>
</html>
