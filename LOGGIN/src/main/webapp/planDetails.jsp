<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insurance Plan Details</title>
    <link rel="stylesheet" href="resources/css/planDetails.css">
</head>
<body>
    <div class="content">
        <h2>Insurance Plan Details</h2>

        <%
            // Retrieve the 'plan' parameter from the URL
            String plan = request.getParameter("plan");

            if ("termLife".equals(plan)) {
        %>
            <h3>Term Life Insurance</h3>
            <p><strong>Term Life Insurance</strong> is a pure life insurance plan that offers financial protection to your loved ones in case of your untimely demise. The policy is available for a specific duration (term) and provides a lump sum benefit to the nominee in the event of the policyholder's death during the term.</p>
            <h4>Key Features:</h4>
            <ul>
                <li>Affordable Premiums</li>
                <li>Death Benefit</li>
                <li>Optional Riders (Critical Illness, Accidental Death, Disability)</li>
                <li>Flexible Term Lengths</li>
                <li>Tax Benefits</li>
            </ul>
        <%
            } else if ("familyInsurance".equals(plan)) {
        %>
            <h3>Family Insurance Plan</h3>
            <p><strong>Family Insurance Plan</strong> is a comprehensive insurance policy that covers the medical and health expenses of all family members under a single plan. It typically includes coverage for the policyholder, their spouse, children, and sometimes parents.</p>
            <h4>Key Features:</h4>
            <ul>
                <li>Comprehensive Coverage for All Family Members</li>
                <li>Cashless Hospitalization</li>
                <li>Lifetime Renewability</li>
                <li>No-Claim Bonus</li>
                <li>Flexibility in Adding Family Members</li>
            </ul>
        <%
            } else if ("healthInsurance".equals(plan)) {
        %>
            <h3>Health Insurance</h3>
            <p><strong>Health Insurance</strong> is designed to cover the medical expenses arising from illnesses, surgeries, and emergencies. It can be an individual policy or a family floater plan that provides coverage for the entire family.</p>
            <h4>Key Features:</h4>
            <ul>
                <li>Hospitalization Coverage</li>
                <li>Pre and Post-Hospitalization</li>
                <li>Daycare Procedures</li>
                <li>Cashless Treatment</li>
                <li>Maternity Benefits</li>
            </ul>
        <%
            } else if ("homeInsurance".equals(plan)) {
        %>
            <h3>Home Insurance</h3>
            <p><strong>Home Insurance</strong> provides financial protection against potential risks to your home, such as fire, theft, natural disasters, or vandalism. It covers both the structure of your house and its contents.</p>
            <h4>Key Features:</h4>
            <ul>
                <li>Coverage for Structure and Contents</li>
                <li>Protection Against Natural Calamities</li>
                <li>Liability Coverage</li>
                <li>Loss of Rent</li>
                <li>Home Burglary</li>
            </ul>
        <%
            } else {
        %>
            <h3>No plan selected</h3>
            <p>Please select a valid insurance plan to view details.</p>
        <%
            }
        %>

        <!-- Buttons: Back and Buy Now -->
        <div class="button-container">
            <button onclick="history.back()" class="btn-back">Back</button>
            <a href="purchasePlan.jsp?plan=<%= plan %>" class="btn-purchase">Buy Now</a>
        </div>
    </div>
</body>
</html>
