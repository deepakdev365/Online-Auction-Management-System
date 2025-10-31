<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Seller Registration | NextAuction</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
    body {
        font-family: "Poppins", sans-serif;
        background: linear-gradient(135deg, #74ebd5, #ACB6E5);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .form-container {
        background: #fff;
        width: 430px;
        padding: 35px 40px;
        border-radius: 14px;
        box-shadow: 0 6px 25px rgba(0,0,0,0.15);
        position: relative;
        overflow: hidden;
    }

    h2 {
        text-align: center;
        color: #007bff;
        font-weight: 600;
        margin-bottom: 10px;
    }

    /* Progress Bar */
    .progress-wrapper {
        width: 100%;
        background: #e9ecef;
        border-radius: 8px;
        overflow: hidden;
        margin: 10px 0 25px;
        height: 8px;
    }

    .progress-bar {
        height: 8px;
        width: 50%;
        background: linear-gradient(90deg, #007bff, #00c6ff);
        transition: width 0.5s ease;
    }

    .step-text {
        text-align: center;
        font-size: 14px;
        color: #555;
        margin-bottom: 5px;
        font-weight: 500;
    }

    label {
        font-weight: 500;
        color: #333;
        display: block;
        margin-bottom: 5px;
    }

    input, select, textarea {
        width: 100%;
        padding: 10px 12px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 15px;
        transition: border-color 0.3s, box-shadow 0.3s;
    }

    input:focus, textarea:focus, select:focus {
        border-color: #007bff;
        outline: none;
        box-shadow: 0 0 4px rgba(0,123,255,0.3);
    }

    .btn {
        width: 100%;
        background: #007bff;
        color: #fff;
        border: none;
        padding: 10px;
        border-radius: 6px;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
    }

    .btn:hover { background: #0056b3; }

    .footer-text {
        text-align: center;
        margin-top: 10px;
        font-size: 14px;
    }

    .footer-text a { color: #007bff; text-decoration: none; }

    .footer-text a:hover { text-decoration: underline; }

    .page {
        display: none;
    }

    .page.active {
        display: block;
        animation: fadeIn 0.4s ease;
    }

    @keyframes fadeIn {
        from {opacity: 0; transform: translateY(10px);}
        to {opacity: 1; transform: translateY(0);}
    }

    .btn-row {
        display: flex;
        justify-content: space-between;
        gap: 10px;
    }
</style>
</head>

<body>

<div class="form-container">
    <h2>Seller Registration</h2>
    <div class="step-text" id="stepText">Step 1 of 2: Personal Info</div>
    <div class="progress-wrapper">
        <div class="progress-bar" id="progressBar"></div>
    </div>

    <form action="SellerSignupServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="role" value="seller">

        <!-- PAGE 1: Personal Details -->
        <div id="page1" class="page active">
            <label>Full Name</label>
            <input type="text" name="fullname" placeholder="Enter your full name" required>

            <label>Father's Name</label>
            <input type="text" name="fathername" placeholder="Enter father's name" required>

            <label>Email</label>
            <input type="email" name="email" placeholder="Enter your email" required>

            <label>Phone Number</label>
            <input type="tel" name="phone" placeholder="Enter phone number" pattern="[0-9]{10}" maxlength="10" required>

            <label>Password</label>
            <input type="password" name="password" placeholder="Enter password" required>

            <label>Confirm Password</label>
            <input type="password" name="confirm_password" placeholder="Re-enter password" required>

            <button type="button" class="btn" onclick="nextPage()">Next ➡️</button>
        </div>

        <!-- PAGE 2: Company Details -->
        <div id="page2" class="page">
            <label>Company Name</label>
            <input type="text" name="company" placeholder="Enter company name" required>

            <label>Company Location</label>
            <input type="text" name="company_location" placeholder="Enter company location" required>

            <label>Address</label>
            <textarea name="address" placeholder="Enter full address" required></textarea>

            <label>Company Proof Type</label>
            <select name="document_type" required>
                <option value="">-- Select Proof Type --</option>
                <option value="Aadhar Card">Aadhar Card</option>
                <option value="Driving License">Driving License</option>
                <option value="Company Registration">Company Registration</option>
                <option value="PAN Card">PAN Card</option>
            </select>

            <label>Upload Document</label>
            <input type="file" name="document_file" accept=".pdf,.jpg,.jpeg,.png" required>

            <div class="btn-row">
                <button type="button" class="btn" onclick="prevPage()">⬅️ Back</button>
                <button type="submit" class="btn">Register ✅</button>
            </div>

            <div class="footer-text">
                Already registered? <a href="sellerlogin.jsp">Login</a>
            </div>
        </div>
    </form>
</div>

<script>
    function nextPage() {
        document.getElementById("page1").classList.remove("active");
        document.getElementById("page2").classList.add("active");
        document.getElementById("progressBar").style.width = "100%";
        document.getElementById("stepText").innerText = "Step 2 of 2: Company Info";
    }

    function prevPage() {
        document.getElementById("page2").classList.remove("active");
        document.getElementById("page1").classList.add("active");
        document.getElementById("progressBar").style.width = "50%";
        document.getElementById("stepText").innerText = "Step 1 of 2: Personal Info";
    }
</script>

</body>
</html>
