<%@ page import="java.util.*,java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Razorpay</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>

<%
    // Fetch customer details from the form
    String productId = request.getParameter("product_id");
    String customerName = request.getParameter("customer_name");
    String customerEmail = request.getParameter("customer_email");
    String customerPhone = request.getParameter("customer_phone");
    String customerAddress = request.getParameter("customer_address");

    // Get the premium amount and check if it's valid
    String premiumAmountStr = request.getParameter("premium_amount");
    double premiumAmount = 0;

    if (premiumAmountStr != null && !premiumAmountStr.trim().isEmpty()) {
        try {
            premiumAmount = Double.parseDouble(premiumAmountStr);
        } catch (NumberFormatException e) {
            out.println("<p>Error: Invalid premium amount.</p>");
            return; // Exit if the amount is invalid
        }
    } else {
        out.println("<p>Error: Premium amount is missing.</p>");
        return; // Exit if the amount is missing
    }

    // Razorpay API Key and Secret
    String razorpayApiKey = "rzp_test_FFKNH2qcZWMx2A";
    String razorpayApiSecret = "GRG54hVKpeXWclfPk4XGho9a";

    // Prepare the data to create an order on Razorpay
    // In a production scenario, you should create an order on the server side using Razorpay's API and then use the order ID in the checkout flow.
%>

<!-- Hidden form to initiate Razorpay checkout -->
<form action="/completePaymentServlet" method="POST">
    <input type="hidden" name="product_id" value="<%= productId %>">
    <input type="hidden" name="customer_name" value="<%= customerName %>">
    <input type="hidden" name="customer_email" value="<%= customerEmail %>">
    <input type="hidden" name="customer_phone" value="<%= customerPhone %>">
    <input type="hidden" name="customer_address" value="<%= customerAddress %>">
    <input type="hidden" name="premium_amount" value="<%= premiumAmount %>">

    <button type="button" id="rzp-button1">Pay with Razorpay</button>
</form>

<script>
    var options = {
        "key": "<%= razorpayApiKey %>", // Replace with your Razorpay API Key
        "amount": <%= (premiumAmount * 100) %>, // Amount in paise (1 INR = 100 paise)
        "currency": "INR",
        "name": "Insurance Payment",
        "description": "Payment for Product ID: <%= productId %>",
        "image": "https://your-logo-url.com", // Optional logo image URL
        "handler": function (response) {
            // Process the payment success here
            // You can store the payment info in your database
            // For now, we'll redirect to a success page.
            alert("Payment Successful! Razorpay Payment ID: " + response.razorpay_payment_id);
            document.forms[0].submit(); // Submit the form to proceed with payment processing
        },
        "prefill": {
            "name": "<%= customerName %>",
            "email": "<%= customerEmail %>",
            "contact": "<%= customerPhone %>"
        },
        "theme": {
            "color": "#007BFF"
        }
    };

    var rzp1 = new Razorpay(options);
    document.getElementById('rzp-button1').onclick = function (e) {
        rzp1.open();
        e.preventDefault();
    }
</script>

</body>
</html>
