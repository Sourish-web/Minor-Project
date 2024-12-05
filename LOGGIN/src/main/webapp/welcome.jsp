<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Insurance Hub</title>
    <link rel="stylesheet" type="text/css" href="resources/css/styles.css"> <!-- Global styles -->
    <link rel="stylesheet" href="resources/css/home.css"> <!-- Additional home page styles -->
</head>
<body>

<%-- Session Validation --%>
<%
    HttpSession mysession = request.getSession(false);
    String username = null;
    if (mysession != null && mysession.getAttribute("username") != null) {
        username = (String) mysession.getAttribute("username");
    }
%>

<!-- Navbar Section -->
<nav class="navbar">
    <div class="logo">InsuranceApp</div>
    <ul>
        <li><a href="welcome.jsp">Home</a></li>
        <li><a href="quoteCalculator.jsp">Quote Calculator</a></li>
        <li><a href="insuranceProduct.jsp">Insurance Products</a></li>
        <li><a href="faq.jsp">FAQ</a></li>
        <li><a href="claims.jsp">Claims</a></li>
        <li><a href="aboutUs.jsp">About Us</a></li>
        <%
            if (username == null) {
        %>
            <li><a href="login.jsp">Sign In</a></li>
        <%
            } else {
        %>
            <li><span class="username">Welcome, <%= username %></span></li>
            <li><a href="LogoutServlet" class="logout">Logout</a></li>
        <%
            }
        %>
    </ul>
</nav>

<!-- Main Content Section -->
<div class="home-content-wrapper">
    <!-- Left Section (Main Content) -->
    <div class="home-content">
        <!-- Advertisement Slideshow -->
        <div class="slideshow-container">
            <div class="slide fade">
                <img src="resources/images/add1.jpg" alt="Advert 1">
            </div>
            <div class="slide fade">
                <img src="resources/images/add2.jpg" alt="Advert 2">
            </div>
            <div class="slide fade">
                <img src="resources/images/add3.webp" alt="Advert 3">
            </div>
            <!-- Next and Previous Buttons -->
            <a class="prev" onclick="changeSlide(-1)">&#10094;</a>
            <a class="next" onclick="changeSlide(1)">&#10095;</a>
        </div>

        <!-- Welcome Section -->
        <h1>Welcome to Insurance Hub</h1>
        <p>Your trusted partner for secure and reliable insurance solutions. We are committed to protecting what matters most to you – your health, home, vehicle, and life.</p>

        <!-- Key Features Section -->
        <div class="features-grid">
            <div class="feature-card">
                <img src="resources/images/flexible-benefits.webp" alt="Flexible Plans">
                <h3>Flexible Plans</h3>
                <p>Choose from a wide range of insurance policies tailored to your needs.</p>
            </div>
            <div class="feature-card">
                <img src="resources/images/CustomerSupport.jpg" alt="24/7 Support">
                <h3>24/7 Customer Support</h3>
                <p>Our dedicated support team is here to assist you at any time.</p>
            </div>
            <div class="feature-card">
                <img src="resources/images/FastClaim Processing.jpg" alt="Fast Claims">
                <h3>Fast Claims Processing</h3>
                <p>Enjoy hassle-free and quick claim settlements.</p>
            </div>
            <div class="feature-card">
                <img src="resources/images/AffordablePremiums.jpg" alt="Affordable Premiums">
                <h3>Affordable Premiums</h3>
                <p>Get comprehensive coverage at competitive rates.</p>
            </div>
        </div>

        <!-- Why Us Section -->
        <div class="why-us">
            <h3>Why Choose Us?</h3>
            <p>We stand out in the market by providing tailored insurance plans that suit every need. Our services are backed by excellent customer support and fast claims processing, ensuring peace of mind for our customers.</p>
        </div>

        <!-- Claim Performance Section -->
        <div class="claim-performance">
            <h3>Claim Performance</h3>
            <p>We pride ourselves on our claim settlement ratio, consistently achieving high customer satisfaction. Our efficient claim process ensures that our customers get the support they need in their time of need.</p>
        </div>

        <!-- Important Notice -->
        <div class="notice-box">
            <h2>Important Notices</h2>
            <%
                try {
                    // Database connection and query to fetch all notices
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                        String query = "SELECT id, notice, created_at FROM notices ORDER BY created_at DESC";
                        try (PreparedStatement ps = con.prepareStatement(query)) {
                            ResultSet rs = ps.executeQuery();
                            if (rs.next()) {
                                do {
                                    int id = rs.getInt("id");
                                    String notice = rs.getString("notice");
                                    String createdAt = rs.getString("created_at");
            %>
                                    <div class="notice-item">
                                        <p><strong>Notice:</strong> <%= notice %></p>
                                        <p><em>Created on: <%= createdAt %></em></p>
                                    </div>
            <%
                                } while (rs.next());
                            } else {
            %>
                                <p>No important notices available at the moment.</p>
            <%
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>

    <!-- Right Section (Side Content) -->
    <div class="side-content">
        <h3>Our Vision</h3>
        <div class="vision-content">
            <p><strong>Mission Statement:</strong> Providing affordable, reliable, and comprehensive insurance solutions to protect your future.</p>
            <p><strong>Core Values:</strong> Trust, security, transparency, customer focus.</p>
            <p><strong>Commitment to Service:</strong> We are committed to ensuring that you feel secure and informed throughout your insurance journey.</p>
            <p><strong>Why Choose Us?</strong> Our services stand out due to personalized solutions and exceptional support that truly care for your needs.</p>
        </div>

        <!-- Customer Testimonials -->
        <h4>Customer Testimonials</h4>
        <div class="testimonials">
            <p>"The team at Insurance Hub is incredibly helpful and easy to work with. I got the coverage I needed at a great rate!" - Alex P.</p>
            <p>"Their customer support is second to none. I always feel confident in their services." - Sarah T.</p>
        </div>

        <!-- Social Responsibility -->
        <p><strong>Social Responsibility:</strong> We support local community initiatives and focus on sustainability to help build a better future for everyone.</p>
    </div>
</div>

<!-- Footer Section -->
<footer class="footer">
    <div class="footer-content">
        <div class="contact-info">
            <h3>Contact Us</h3>
            <p><strong>Address:</strong> 123 Insurance Ave, Finance City, Country</p>
            <p><strong>Email:</strong> support@insurancehub.com</p>
            <p><strong>Phone:</strong> +1 234 567 890</p>
        </div>
        <div class="quick-links">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="quoteCalculator.jsp">Get a Quote</a></li>
                <li><a href="insuranceProduct.jsp">Our Products</a></li>
                <li><a href="faq.jsp">FAQ</a></li>
                <li><a href="claims.jsp">Submit a Claim</a></li>
            </ul>
        </div>
        <div class="social-media">
            <h3>Follow Us</h3>
            <p>
                <a href="#"><img src="resources/images/facebook.png" alt="Facebook"></a>
                <a href="#"><img src="resources/images/twitter.jpeg" alt="Twitter"></a>
                <a href="#"><img src="resources/images/instagram.webp" alt="Instagram"></a>
            </p>
        </div>
    </div>
    <p class="footer-note">&copy; 2024 Insurance Hub. All Rights Reserved.</p>
</footer>

<script src="resources/js/home.js"></script> <!-- JavaScript for slideshow -->
</body>
</html>
