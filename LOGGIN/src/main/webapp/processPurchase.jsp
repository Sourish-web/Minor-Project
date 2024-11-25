<%@ page import="java.util.*,java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase Confirmation</title>
    <!-- Link the processPurchase specific CSS -->
    <link rel="stylesheet" href="resources/css/processPurchase.css">
</head>
<body>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String address = request.getParameter("address");
    String planName = request.getParameter("planName");
    String planPrice = request.getParameter("planPrice");

    // Save purchase details to database or process the purchase logic here

    // Display confirmation message
%>

<!-- Purchase Confirmation Content -->
<section class="purchase-confirmation">
    <h2>Thank you for your purchase, <%= name %>!</h2>
    <p>You have successfully purchased the <%= planName %> plan for $<%= planPrice %> per month.</p>
    <p>A confirmation email has been sent to <%= email %>.</p>
    <p>We will process your order and send you further instructions to your shipping address: <%= address %>.</p>
    
    <!-- Optionally, you can include a "Go Back to Home" or "Go to Dashboard" button -->
    <a href="insuranceProduct.jsp" class="btn-primary">Go Back to Plans</a>

    <div class="info-text">
        <p>If you have any questions, feel free to <a href="contact.jsp">contact us</a>.</p>
    </div>
</section>

</body>
</html>
