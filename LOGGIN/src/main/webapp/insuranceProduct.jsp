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
            <li><a href="insuranceProduct.jsp" class="active">Insurance Products</a></li>
            <li><a href="faq.jsp">FAQ</a></li>
            <li><a href="claims.jsp">Claims</a></li>
            <li><a href="aboutUs.jsp">About Us</a></li>
            <li><a href="LogoutServlet" class="logout">Logout</a></li>
        </ul>
    </nav>

    <!-- Main Content Section -->
    <section class="product-list-section">
        <h1>Our Insurance Products</h1>

        <%
            // Database connection to fetch insurance products
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                    String query = "SELECT sr_no, product_name, plan_no, uin_no FROM insurance_products";
                    try (PreparedStatement ps = con.prepareStatement(query);
                         ResultSet rs = ps.executeQuery()) {
                        if (rs.isBeforeFirst()) {
        %>
                            <table class="product-table">
                                <thead>
                                    <tr>
                                        <th>Sr. No.</th>
                                        <th>Product Name</th>
                                        <th>Plan No.</th>
                                        <th>UIN No.</th>
                                    </tr>
                                </thead>
                                <tbody>
        <%
                            while (rs.next()) {
                                int srNo = rs.getInt("sr_no");
                                String productName = rs.getString("product_name");
                                String planNo = rs.getString("plan_no");
                                String uinNo = rs.getString("uin_no");
        %>
                                    <tr>
                                        <td><%= srNo %></td>
                                        <td><%= productName %></td>
                                        <td><%= planNo %></td>
                                        <td><%= uinNo %></td>
                                    </tr>
        <%
                            }
        %>
                                </tbody>
                            </table>
        <%
                        } else {
        %>
                            <p>No insurance products available at the moment.</p>
        <%
                        }
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error fetching insurance products. Please try again later.</p>");
                e.printStackTrace();
            }
        %>
    </section>

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
