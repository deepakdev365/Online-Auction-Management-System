<html>
<head>
<title>Add Auction Item</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="header"><h2>ONLINE AUCTION</h2></div>
    <div class="form-container">
        <h3>Add New Item</h3>
        <form action="SellerServlet" method="post">
            <input type="hidden" name="action" value="add">
            <label>Title:</label><input type="text" name="title"><br>
            <label>Description:</label><textarea name="description"></textarea><br>
            <label>Start Price:</label><input type="text" name="price"><br>
            <button type="submit">Add Item</button>
        </form>
    </div>
</body>
</html>
