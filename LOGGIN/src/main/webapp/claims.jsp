<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Session Validation
    HttpSession mysession = request.getSession(false);
    if (mysession == null || mysession.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) mysession.getAttribute("username");

    // Handle success/error messages from ClaimServlet
    String message = request.getParameter("message");
%>

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
    <div class="logo">InsuranceApp</div>
    <ul>
        <li><a href="welcome.jsp">Home</a></li>
        <li><a href="quoteCalculator.jsp">Quote Calculator</a></li>
        <li><a href="insuranceProduct.jsp">Insurance Products</a></li>
        <li><a href="faq.jsp">FAQ</a></li>
        <li><a href="claims.jsp" class="active">Claims</a></li>
        <li><a href="aboutUs.jsp">About Us</a></li>
        <li><span class="username">Welcome, <%= username %></span></li>
        <li><a href="LogoutServlet" class="logout">Logout</a></li>
    </ul>
</nav>

<!-- Main Content Section -->
<div class="content-container">
    <h2>Submit Your Claim</h2>

    <!-- Display Success/Error Message -->
    <% if (message != null) { %>
        <div class="message">
            <p><%= message %></p>
        </div>
    <% } %>

    <!-- Claim Submission Form -->
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
            <input type="number" id="claimAmount" name="claimAmount" step="0.01" required>
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

<!-- User's Submitted Claims Table -->
<div class="submitted-claims">
    <h2>Your Submitted Claims</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Policy Number</th>
            <th>Claim Amount (INR)</th>
            <th>Status</th>
            <th>Submitted On</th>
        </tr>
        <%
            // Database Connection to Fetch Claims
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                    String query = "SELECT * FROM claims WHERE username = ? ORDER BY created_at DESC";
                    try (PreparedStatement ps = con.prepareStatement(query)) {
                        ps.setString(1, username);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
        %>
                            <tr>
                                <td><%= rs.getInt("id") %></td>
                                <td><%= rs.getString("policy_number") %></td>
                                <td><%= rs.getDouble("claim_amount") %></td>
                                <td><%= rs.getString("status") %></td>
                                <td><%= rs.getTimestamp("created_at") %></td>
                            </tr>
        <%
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
            <tr>
                <td colspan="5">An error occurred while retrieving your claims.</td>
            </tr>
        <%
            }
        %>
    </table>
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

</body>
</html>
