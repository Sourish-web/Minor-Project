<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us</title>
    <link rel="stylesheet" href="resources/css/styles.css"> <!-- Global Styles -->
    <link rel="stylesheet" href="resources/css/aboutUs.css"> <!-- Custom CSS for About Us Page -->
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


    <!-- Content Section -->
    <div class="content">
        <h2>About Us</h2>

        <!-- Introduction -->
        <section class="introduction">
            <h3>Welcome to Our Health Insurance Company</h3>
            <p>We are one of the leading health insurance providers in the industry, offering comprehensive plans designed to protect you and your loved ones from unforeseen medical expenses. Our goal is to provide peace of mind by ensuring that you have access to the best healthcare coverage available in the market.</p>
        </section>

        <!-- Mission -->
        <section class="mission">
            <h3>Our Mission</h3>
            <p>Our mission is to provide affordable and accessible healthcare solutions to individuals, families, and businesses. We are committed to enhancing the quality of life by offering innovative health plans that meet the diverse needs of our customers.</p>
        </section>

        <!-- Vision -->
        <section class="vision">
            <h3>Our Vision</h3>
            <p>To be the most trusted and customer-centric health insurance provider, delivering comprehensive health coverage with an unwavering commitment to our customers' well-being and satisfaction.</p>
        </section>

        <!-- Values -->
        <section class="values">
            <h3>Our Values</h3>
            <ul>
                <li><strong>Integrity:</strong> We conduct our business with honesty and transparency.</li>
                <li><strong>Customer Focus:</strong> We put our customers at the heart of everything we do.</li>
                <li><strong>Innovation:</strong> We continuously strive to improve our products and services.</li>
                <li><strong>Reliability:</strong> We are committed to being there when you need us the most.</li>
                <li><strong>Compassion:</strong> We care about the health and well-being of our customers.</li>
            </ul>
        </section>

        <!-- Contact Information -->
        <section class="contact-info">
            <h3>Contact Us</h3>
            <p>If you have any questions or would like more information about our insurance plans, please feel free to reach out to us:</p>
            <ul>
                <li><strong>Phone:</strong> +1 800 123 4567</li>
                <li><strong>Email:</strong> support@healthinsure.com</li>
                <li><strong>Address:</strong> 123 Health St, Wellness City, Country</li>
            </ul>
        </section>
    </div>

</body>
</html>
