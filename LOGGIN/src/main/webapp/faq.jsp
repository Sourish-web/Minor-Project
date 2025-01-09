<%@ page import="java.sql.*, java.util.*" %>
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
    HttpSession mysession = request.getSession(false);
    if (mysession == null || mysession.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) mysession.getAttribute("username");
%>

<!-- Navbar -->
<nav class="navbar">
    <div class="logo">InsuranceApp</div>
    <ul>
        <li><a href="welcome.jsp">InsuranceApp</a></li>
        <li><a href="quoteCalculator.jsp">Quote Calculator</a></li>
        <li><a href="insuranceProduct.jsp">Insurance Products</a></li>
        <li><a href="faq.jsp">FAQ</a></li>
        <li><a href="claims.jsp">Claims</a></li>
        <li><a href="aboutUs.jsp">About Us</a></li>
        <li><span class="username">Welcome, <%= username %></span></li>
        <li><a href="LogoutServlet" class="logout">Logout</a></li>
    </ul>
</nav>

<!-- Content -->
<div class="content-container">
    <h2>Frequently Asked Questions</h2>

    <!-- User Question Submission Form -->
    <div class="question-form">
        <h3>Ask a Question</h3>
        <form action="SubmitQuestionServlet" method="POST">
            <label for="question">Your Question:</label><br>
            <textarea name="question" id="question" rows="4" cols="50" required></textarea><br><br>
            <button type="submit">Submit Question</button>
        </form>
    </div>

    <hr>

    <!-- Display Approved FAQs -->
    <div class="faq-list">
        <h3>Approved FAQs</h3>
        <%
            List<Map<String, String>> faqs = new ArrayList<>();
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                String query = "SELECT question, answer FROM faqs WHERE status = 'approved'";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        Map<String, String> faq = new HashMap<>();
                        faq.put("question", rs.getString("question"));
                        faq.put("answer", rs.getString("answer"));
                        faqs.add(faq);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (faqs.isEmpty()) {
        %>
            <p>No approved FAQs available at the moment.</p>
        <%
            } else {
                for (Map<String, String> faq : faqs) {
        %>
            <div class="faq-item">
                <h4><%= faq.get("question") %></h4>
                <p><%= faq.get("answer") %></p>
            </div>
        <%
                }
            }
        %>
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

</body>
</html>
