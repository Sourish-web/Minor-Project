<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase Insurance Plan</title>
    <link rel="stylesheet" href="resources/css/purchasePlan.css">
</head>
<body>
    <div class="purchase-container">
        <h2>Proceed to Purchase</h2>

        <%
            // Retrieve the 'plan' parameter from the URL
            String plan = request.getParameter("plan");
            if (plan == null) {
                out.println("<p>No plan selected. Please select a plan to purchase.</p>");
            } else {
        %>
            <p>You are about to purchase: <strong><%= plan %></strong></p>
            <div class="purchase-details">
                <form action="processPurchase.jsp" method="POST">
                    <label for="name">Your Name:</label>
                    <input type="text" id="name" name="name" required>

                    <label for="email">Your Email:</label>
                    <input type="email" id="email" name="email" required>

                    <label for="payment">Payment Method:</label>
                    <select id="payment" name="payment">
                        <option value="creditCard">Credit Card</option>
                        <option value="debitCard">Debit Card</option>
                        <option value="paypal">PayPal</option>
                    </select>

                    <button type="submit" class="btn-purchase">Proceed with Payment</button>
                </form>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>
