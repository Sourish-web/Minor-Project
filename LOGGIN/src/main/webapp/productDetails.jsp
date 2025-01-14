<%@ page import="java.util.*,java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/insuranceProducts.css">
</head>
<body>
<%
    // Check user session
    jakarta.servlet.http.HttpSession mysession = request.getSession(false);
    if (mysession == null || mysession.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) mysession.getAttribute("username");

    // Retrieve product ID from request parameters
    String productId = request.getParameter("sr_no");
    String productName = "";
    String planNo = "";
    String uinNo = "";
    String planDetails = "";

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
            String query = "SELECT product_name, plan_no, uin_no, plan_details FROM insurance_products WHERE sr_no = ?";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setInt(1, Integer.parseInt(productId));
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        productName = rs.getString("product_name");
                        planNo = rs.getString("plan_no");
                        uinNo = rs.getString("uin_no");
                        planDetails = rs.getString("plan_details");
                    } else {
                        out.println("<p>Product not found.</p>");
                        return;
                    }
                }
            }
        }
    } catch (ClassNotFoundException | SQLException e) {
        out.println("<p>Error fetching product details. Please try again later.</p>");
        e.printStackTrace();
    } catch (NumberFormatException e) {
        out.println("<p>Invalid product ID.</p>");
        e.printStackTrace();
    }
%>

<nav class="navbar">
    <div class="logo">InsuranceApp</div>
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

<section class="product-details-section">
    <h1>Product Details</h1>
    <h2><%= productName %></h2>
    <p><strong>Plan No.:</strong> <%= planNo %></p>
    <p><strong>UIN No.:</strong> <%= uinNo %></p>
    <p><strong>Details:</strong></p>
    <p><%= planDetails %></p>

    <!-- Razorpay Payment Form -->
    <form action="CreateOrderServlet" method="post">
        <input type="hidden" name="sr_no" value="<%= productId %>">
        <input type="hidden" name="product_name" value="<%= productName %>">
        <button type="submit">Buy Now</button>
    </form>
</section>

<footer class="footer">
    <p>&copy; 2025 Insurance Hub. All Rights Reserved.</p>
</footer>

</body>
</html>
