<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ</title>
    <!-- Main CSS -->
    <link rel="stylesheet" href="resources/css/styles.css">
    <!-- FAQ-specific CSS -->
    <link rel="stylesheet" href="resources/css/faq.css">
</head>
<body>

<%-- Session Validation --%>
<%
    // Get the session object without creating a new one
    HttpSession mysession = request.getSession(false);

    // Check if the session exists and if the username attribute is set
    if (mysession == null || mysession.getAttribute("username") == null) {
        // Redirect to login page if session is invalid
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve the username from the session
    String username = (String) mysession.getAttribute("username");
%>


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
        <!-- Show the username beside logout -->
        <li><span class="username">Welcome, <%= username %></span></li>
        <li><a href="LogoutServlet" class="logout">Logout</a></li>
    </ul>
</nav>

    <!-- FAQ Content Section -->
    <div class="content-container">
        <h2>Frequently Asked Questions</h2>
        <div class="faq-list">
            <div class="faq-item">
                <h3>What is health insurance?</h3>
                <p>Health insurance provides financial protection for medical expenses, hospitalization, and other healthcare services.</p>
            </div>
            <div class="faq-item">
                <h3>How do I apply for an insurance plan?</h3>
                <p>You can apply online through our website or visit our nearest branch to complete the application process.</p>
            </div>
            <div class="faq-item">
                <h3>What is a claim, and how do I file one?</h3>
                <p>A claim is a formal request to your insurer for coverage or compensation for a covered loss. You can file one online or via our customer service hotline.</p>
            </div>
            <div class="faq-item">
                <h3>Are pre-existing conditions covered?</h3>
                <p>Coverage for pre-existing conditions depends on the specific insurance plan. Some plans may have waiting periods for such conditions.</p>
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
