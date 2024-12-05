<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Health Insurance Quote Calculator</title>
    <link rel="stylesheet" href="resources/css/styles.css"> <!-- Main styles -->
    <link rel="stylesheet" href="resources/css/quoteCalculator.css"> <!-- Custom CSS for Quote Calculator Page -->
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
        <li><a href="insuranceProduct.jsp">Insurance Products</a></li>
        <li><a href="faq.jsp">FAQ</a></li>
        <li><a href="claims.jsp">Claims</a></li>
        <li><a href="aboutUs.jsp">About Us</a></li>
        <!-- Show the username beside logout -->
        <li><span class="username">Welcome, <%= username %></span></li>
        <li><a href="LogoutServlet" class="logout">Logout</a></li>
    </ul>
</nav>

    <!-- Main Content Section -->
    <div class="main-container">
        <div class="content-wrapper">
            <h2>Health Insurance Quote Calculator</h2>

            <!-- Grid Section -->
            <div class="calculator-container">
                <!-- Left Section: Explanation -->
                <div class="rules">
                    <h3>How Your Premium is Calculated</h3>
                    <ul>
                        <li><strong>Age:</strong> Premium increases with age.</li>
                        <li><strong>Coverage Amount:</strong> Higher coverage means higher premiums.</li>
                        <li><strong>Pre-existing Diseases:</strong> Affects your premium.</li>
                        <li><strong>Plan Type:</strong> Individual plans are cheaper than family plans.</li>
                        <li><strong>Location:</strong> Urban areas typically have higher premiums.</li>
                        <li><strong>Add-ons:</strong> Additional coverages increase the premium.</li>
                    </ul>
                </div>

                <!-- Right Section: Quote Form -->
                <div class="quote-form-section">
                    <form action="CalculateQuoteServlet" method="post" class="quote-form">
                        <div class="form-group">
                            <label for="age">Age</label>
                            <input type="number" id="age" name="age" required>
                        </div>

                        <div class="form-group">
                            <label for="coverage">Coverage Amount</label>
                            <input type="number" id="coverage" name="coverage" required>
                        </div>

                        <div class="form-group">
                            <label for="plan">Plan Type</label>
                            <select id="plan" name="plan" required>
                                <option value="individual">Individual</option>
                                <option value="family">Family Floater</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="location">Location</label>
                            <select id="location" name="location" required>
                                <option value="urban">Urban</option>
                                <option value="rural">Rural</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <input type="submit" value="Get Quote">
                            <input type="reset" value="Reset">
                        </div>
                    </form>

                    <!-- Displaying the Calculated Quote -->
                    <c:if test="${not empty calculatedQuote}">
                        <div class="quote-result">
                            <h3>Your Calculated Quote:</h3>
                            <p>Rs.${calculatedQuote}</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
