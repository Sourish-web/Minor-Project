<%@ page import="java.util.*,java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insurance Products</title>
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/insuranceProducts.css">
</head>
<body>
<%
    HttpSession mysession = request.getSession(false);
    if (mysession == null || mysession.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) mysession.getAttribute("username");
%>

<nav class="navbar">
    <div class="logo">InsuranceApp</div>
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

<section class="product-list-section">
    <h1>Our Insurance Products</h1>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                String query = "SELECT sr_no, product_name, plan_no, uin_no, plan_details, coverage_amount, premium_amount, plan_duration FROM insurance_products";
                try (PreparedStatement ps = con.prepareStatement(query);
                     ResultSet rs = ps.executeQuery()) {
                    if (rs.isBeforeFirst()) {
    %>
                        <table class="product-table">
                            <thead>
                                <tr>
                                    <th>Product Name</th>
                                    <th>Plan No.</th>
                                    <th>UIN No.</th>
                                    <th>Details</th>
                                    <th>Coverage</th>
                                    <th>Premium</th>
                                    <th>Duration</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
    <%
                        while (rs.next()) {
                            int srNo = rs.getInt("sr_no");
                            String productName = rs.getString("product_name");
                            String planNo = rs.getString("plan_no");
                            String uinNo = rs.getString("uin_no");
                            String planDetails = rs.getString("plan_details");
                            String coverageAmount = rs.getString("coverage_amount");
                            String premiumAmount = rs.getString("premium_amount");
                            String planDuration = rs.getString("plan_duration");
    %>
                                <tr>
                                    <td><%= productName %></td>
                                    <td><%= planNo %></td>
                                    <td><%= uinNo %></td>
                                    <td><%= planDetails %></td>
                                    <td><%= coverageAmount %></td>
                                    <td><%= premiumAmount %></td>
                                    <td><%= planDuration %></td>
                                    <td><a href="payment.jsp?product_id=<%= srNo %>" class="buy-now-btn">Buy Now</a></td>
                                </tr>
    <%
                        }
    %>
                            </tbody>
                        </table>
    <%
                    } else {
    %>
                        <p>No insurance products available at the moment. Please check back later or contact support for more information.</p>
    <%
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<p>Error fetching products. Please try again later or contact support.</p>");
        }
    %>
</section>

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

</body>
</html>
