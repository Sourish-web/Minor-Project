<%@ page import="java.util.*,java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Insurance Product</title>
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/payment.css">
</head>
<body>
<%
    // Get the product ID from the URL
    String productId = request.getParameter("product_id");

    if (productId == null || productId.isEmpty()) {
        response.sendRedirect("insuranceProduct.jsp");
        return;
    }

    // Fetch product details from the database (optional)
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025");
        String query = "SELECT * FROM insurance_products WHERE sr_no = ?";
        ps = con.prepareStatement(query);
        ps.setString(1, productId);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            String productName = rs.getString("product_name");
            double premiumAmount = rs.getDouble("premium_amount");
%>

    <h1>Complete Your Payment for <%= productName %></h1>
    
    <form action="processPayment.jsp" method="POST">
        <input type="hidden" name="product_id" value="<%= productId %>">
        <input type="hidden" name="premium_amount" value="<%= premiumAmount %>">

        <h2>Customer Details</h2>
        <label for="customer_name">Full Name:</label><br>
        <input type="text" id="customer_name" name="customer_name" required><br><br>

        <label for="customer_email">Email:</label><br>
        <input type="email" id="customer_email" name="customer_email" required><br><br>

        <label for="customer_phone">Phone Number:</label><br>
        <input type="text" id="customer_phone" name="customer_phone" required><br><br>

        <label for="customer_address">Address:</label><br>
        <textarea id="customer_address" name="customer_address" required></textarea><br><br>

        <button type="submit">Proceed to Payment</button>
    </form>

<%
        } else {
            out.println("<p>Product not found.</p>");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("<p>Error fetching product details. Please try again later.</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
