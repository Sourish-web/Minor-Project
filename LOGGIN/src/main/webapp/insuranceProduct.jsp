<%@ page import="java.util.*,java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insurance Products</title>
    <!-- Link to the global styles.css for layout and common design -->
    <link rel="stylesheet" href="resources/css/styles.css">
    <!-- Custom CSS for insurance product specific styles -->
    <link rel="stylesheet" href="resources/css/insuranceProducts.css">
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
            <li><a href="insuranceProduct.jsp" class="active">Insurance Products</a></li>
            <li><a href="faq.jsp">FAQ</a></li>
            <li><a href="claims.jsp">Claims</a></li>
            <li><a href="aboutUs.jsp">About Us</a></li>
            <li><a href="LogoutServlet" class="logout">Logout</a></li>
        </ul>
    </nav>

    <!-- Main Content Section -->
    <div class="content">
        <h2>Our Insurance Products</h2>

        <div class="products-container">
            <!-- Life Insurance Plan Card -->
            <div class="product-card">
                <img src="resources/images/lifeins.png" alt="Life Insurance" class="product-image">
                <div class="product-details">
                    <h3>Term Life Insurance</h3>
                    <p>Affordable and flexible coverage to protect your loved ones.</p>
                    <a href="planDetails.jsp?plan=termLife" class="btn-details">Learn More</a>
                </div>
            </div>

            <!-- Family Insurance Plan Card -->
            <div class="product-card">
                <img src="resources/images/fam.png" alt="Family Insurance" class="product-image">
                <div class="product-details">
                    <h3>Family Insurance Plan</h3>
                    <p>Comprehensive coverage for your entire family with one simple plan.</p>
                    <a href="planDetails.jsp?plan=familyInsurance" class="btn-details">Learn More</a>
                </div>
            </div>

            <!-- Health Insurance Plan Card -->
            <div class="product-card">
                <img src="resources/images/health.png" alt="Health Insurance" class="product-image">
                <div class="product-details">
                    <h3>Health Insurance</h3>
                    <p>Secure your health and well-being with flexible and comprehensive health coverage.</p>
                    <a href="planDetails.jsp?plan=healthInsurance" class="btn-details">Learn More</a>
                </div>
            </div>

            <!-- Home Insurance Plan Card -->
            <div class="product-card">
                <img src="resources/images/homeins.png" alt="Home Insurance" class="product-image">
                <div class="product-details">
                    <h3>Home Insurance</h3>
                    <p>Protect your home and assets against unforeseen circumstances.</p>
                    <a href="planDetails.jsp?plan=homeInsurance" class="btn-details">Learn More</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer Section -->
    <footer>
        <div class="footer-content">
            <p>&copy; 2024 Insurance Co. All Rights Reserved.</p>
            <ul>
                <li><a href="privacy.jsp">Privacy Policy</a></li>
                <li><a href="terms.jsp">Terms of Service</a></li>
            </ul>
        </div>
    </footer>

</body>
</html>
