<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Claim Submission</title>
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/claims.css">
</head>
<body>

    <!-- Navbar Section -->
    <nav class="navbar">
        <!-- Logo -->
        <div class="logo">InsuranceApp</div>

        <!-- Navigation Links -->
        <ul>
            <li><a href="welcome.jsp">InsuranceApp</a></li>
            <li><a href="quoteCalculator.jsp">Quote Calculator</a></li>
            <li><a href="insuranceProduct.jsp">Insurance Products</a></li>
            <li><a href="faq.jsp">FAQ</a></li>
            <li><a href="claims.jsp">Claims</a></li>
            <li><a href="aboutUs.jsp">About Us</a></li>
            <li><a href="LogoutServlet" class="logout">Logout</a></li>
        </ul>
    </nav>

    <!-- Main Content Section -->
    <div class="content-container">
        <h2>Submit Your Claim</h2>
        
        <!-- Display success or error message -->
        <c:if test="${not empty message}">
            <div class="message">
                <h3>${message}</h3>
            </div>
        </c:if>

        <form action="ClaimServlet" method="post">
            <div class="form-group">
                <label for="claimantName">Claimant Name</label>
                <input type="text" id="claimantName" name="claimantName" required>
            </div>

            <div class="form-group">
                <label for="policyNumber">Policy Number</label>
                <input type="text" id="policyNumber" name="policyNumber" required>
            </div>

            <div class="form-group">
                <label for="claimAmount">Claim Amount (in INR)</label>
                <input type="number" id="claimAmount" name="claimAmount" required>
            </div>

            <div class="form-group">
                <label for="claimDetails">Claim Details</label>
                <textarea id="claimDetails" name="claimDetails" rows="4" required></textarea>
            </div>

            <div class="form-group">
                <input type="submit" value="Submit Claim">
                <input type="reset" value="Reset">
            </div>
        </form>
    </div>

</body>
</html>
