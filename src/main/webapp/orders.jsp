<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h3>Orders</h3>
    <table class="table table-hover">
        <thead class="table-light">
        <tr>
            <th>#</th>
            <th>Order ID</th>
            <th>Customer</th>
            <th>Product</th>
            <th>Quantity</th>
            <th>Status</th>
            <th>Total</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td>${order.id}</td>
                <td>${order.orderId}</td>
                <td>${order.customerName}</td>
                <td>${order.productName}</td>
                <td>${order.quantity}</td>
                <td>${order.status}</td>
                <td>$${order.total}</td>
                <td>
                    <a href="viewOrder?id=${order.id}" class="btn btn-sm btn-info">View</a>
                    <a href="updateOrder?id=${order.id}" class="btn btn-sm btn-primary">Update</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
