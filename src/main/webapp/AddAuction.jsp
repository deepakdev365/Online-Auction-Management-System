<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head><title>Add Auction</title></head>
<body>
<h2>Add Auction</h2>
<form action="seller?action=add" method="post">
    <input type="hidden" name="action" value="create" />
    Title: <input name="title" required/><br/>
    Description: <textarea name="description"></textarea><br/>
    Start Price: <input name="start_price" type="number" step="0.01" required/><br/>
    Start Time (YYYY-MM-DD HH:MM:SS): <input name="start_time" required/><br/>
    End Time (YYYY-MM-DD HH:MM:SS): <input name="end_time" required/><br/>
    Image: <input type="file" name="image" accept="image/*"/><br/>
    <button type="submit">Create</button>
</form>
</body>
</html>
