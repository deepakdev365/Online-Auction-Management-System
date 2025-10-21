<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
</head>
<body>
<h2>Admin Dashboard</h2>

<h3>Welcome, Admin</h3>

<form action="ViewBidderServlet" method="post">
<input type="submit" value="View All Users"><br>
<br>
</form>



<form action="ViewItemsServlet" method="post">

<input type="submit" value="View All Items"><br><br>
</form>

<form action="ApproveSellerServlet" method="post">

<input type="submit" value="View Pending Sellers"><br>
</form>

<form action="ReportsServlet" method="post">
<br>
<input type="submit" value="View Reports"><br>
</form>

<form action="LogoutServlet" method="post">
<input type="submit" value="Logout"><br><br>




</form>

</body>
</html>
