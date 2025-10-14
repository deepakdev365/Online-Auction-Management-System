<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>NextAuction</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <link rel="stylesheet" href="css/style.css">
</head>

<body>
<form action="Login_RegServlet">
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background-color: #5b2c83;">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-white" href="#">
                <img src="images/govt_logo.png" width="35" height="35" class="me-2">
                NextAuction
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link active" href="#">Auction Status</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Auction Search</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Department Onboarding</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Bidder Enrollment</a></li>
                    <li class="nav-item">
                        <a class="btn btn-pink ms-2 text-white" href="Log_in.jsp">Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <section class="hero-section d-flex align-items-center justify-content-center text-center">
        <div>
            <h1 class="text-white fw-bold">A Secure, Transparent Platform for Auctions</h1>
            <p class="text-light mt-3">For Online Auctions Across India</p>
        </div>
    </section>

    <!-- ======= Feature Icons ======= -->
    <section class="features py-5 text-center">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-2">
                    <i class="fa-solid fa-upload fa-3x text-primary mb-2"></i>
                    <h6>Auction Publish</h6>
                </div>
                <div class="col-md-2">
                    <i class="fa-solid fa-user-check fa-3x text-primary mb-2"></i>
                    <h6>Bidders Apply</h6>
                </div>
                <div class="col-md-2">
                    <i class="fa-solid fa-check-circle fa-3x text-primary mb-2"></i>
                    <h6>Scrutiny & Approval</h6>
                </div>
                <div class="col-md-2">
                    <i class="fa-solid fa-gavel fa-3x text-primary mb-2"></i>
                    <h6>Live Auction</h6>
                </div>
                <div class="col-md-2">
                    <i class="fa-solid fa-list-check fa-3x text-primary mb-2"></i>
                    <h6>Evaluation</h6>
                </div>
                <div class="col-md-2">
                    <i class="fa-solid fa-award fa-3x text-primary mb-2"></i>
                    <h6>Award the Winner</h6>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/script.js"></script>
    </form>
</body>
</html>
