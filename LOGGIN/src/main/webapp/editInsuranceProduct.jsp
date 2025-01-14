<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Insurance Product</title>
    <link rel="stylesheet" href="resources/css/insuranceProducts.css">
</head>
<body>
    <h2>Edit Insurance Product</h2>
    <%
        ResultSet product = (ResultSet) request.getAttribute("product");
        if (product != null) {
            String productName = product.getString("product_name");
            String planNo = product.getString("plan_no");
            String uinNo = product.getString("uin_no");
            String planDetails = product.getString("plan_details");
            String coverageAmount = product.getString("coverage_amount");
            String premiumAmount = product.getString("premium_amount");
            String planDuration = product.getString("plan_duration");
    %>
    <form action="EditInsuranceProductServlet" method="post">
        <input type="hidden" name="sr_no" value="<%= product.getInt("sr_no") %>">
        <label for="product_name">Product Name:</label><br>
        <input type="text" id="product_name" name="product_name" value="<%= productName %>" required><br><br>

        <label for="plan_no">Plan No.:</label><br>
        <input type="text" id="plan_no" name="plan_no" value="<%= planNo %>" required><br><br>

        <label for="uin_no">UIN No.:</label><br>
        <input type="text" id="uin_no" name="uin_no" value="<%= uinNo %>" required><br><br>

        <label for="plan_details">Plan Details:</label><br>
        <textarea id="plan_details" name="plan_details" rows="4" cols="50" required><%= planDetails %></textarea><br><br>

        <label for="coverage_amount">Coverage Amount:</label><br>
        <input type="text" id="coverage_amount" name="coverage_amount" value="<%= coverageAmount %>" required><br><br>

        <label for="premium_amount">Premium Amount:</label><br>
        <input type="text" id="premium_amount" name="premium_amount" value="<%= premiumAmount %>" required><br><br>

        <label for="plan_duration">Plan Duration:</label><br>
        <input type="text" id="plan_duration" name="plan_duration" value="<%= planDuration %>" required><br><br>

        <button type="submit">Update Product</button>
    </form>
    <%
        } else {
            out.println("Product not found.");
        }
    %>
</body>
</html>
