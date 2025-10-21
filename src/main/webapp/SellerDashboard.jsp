<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Seller Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f4f6f9;
        }
        .sidebar {
            min-height: 100vh;
            background-color: #343a40;
        }
        .sidebar a {
            color: #fff;
            text-decoration: none;
        }
        .sidebar a:hover {
            background-color: #495057;
            border-radius: 5px;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .topbar {
            background-color: #fff;
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 sidebar p-3">
            <h3 class="text-center text-white">Seller Panel</h3>
            <ul class="nav flex-column mt-4">
                <li class="nav-item mb-2"><a class="nav-link" href="#"><i class="fa fa-dashboard me-2"></i>Dashboard</a></li>
                <li class="nav-item mb-2"><a class="nav-link" href="#"><i class="fa fa-box me-2"></i>Products</a></li>
                <li class="nav-item mb-2"><a class="nav-link" href="#"><i class="fa fa-shopping-cart me-2"></i>Orders</a></li>
                <li class="nav-item mb-2"><a class="nav-link" href="#"><i class="fa fa-chart-line me-2"></i>Reports</a></li>
                <li class="nav-item mb-2"><a class="nav-link" href="#"><i class="fa fa-user me-2"></i>Profile</a></li>
            </ul>
        </div>

        <!-- Main content -->
        <div class="col-md-10">
            <!-- Top bar -->
            <div class="topbar d-flex justify-content-between align-items-center mb-4">
                <h4>Welcome, Seller!</h4>
                <div>
                    <i class="fa fa-bell me-3"></i>
                    <i class="fa fa-user-circle"></i>
                </div>
            </div>

            <!-- Dashboard Cards -->
            <div class="row mb-4">
                <div class="col-md-3 mb-3">
                    <div class="card p-3 text-center text-white bg-primary">
                        <h5>Total Products</h5>
                        <h2>120</h2>
                        <i class="fa fa-box fa-2x"></i>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card p-3 text-center text-white bg-success">
                        <h5>Orders</h5>
                        <h2>75</h2>
                        <i class="fa fa-shopping-cart fa-2x"></i>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card p-3 text-center text-white bg-warning">
                        <h5>Revenue</h5>
                        <h2>$4,500</h2>
                        <i class="fa fa-dollar-sign fa-2x"></i>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card p-3 text-center text-white bg-danger">
                        <h5>Pending</h5>
                        <h2>12</h2>
                        <i class="fa fa-clock fa-2x"></i>
                    </div>
                </div>
            </div>

            <!-- Products Table -->
            <div class="card mb-4 p-3">
                <h5>Recent Products</h5>
                <table class="table table-hover mt-3">
                    <thead class="table-light">
                    <tr>
                        <th>#</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td>${product.id}</td>
                            <td>${product.name}</td>
                            <td>${product.category}</td>
                            <td>$${product.price}</td>
                            <td>${product.stock}</td>
                            <td>
                                <a href="editProduct?id=${product.id}" class="btn btn-sm btn-primary">Edit</a>
                                <a href="deleteProduct?id=${product.id}" class="btn btn-sm btn-danger">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
