<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="resources/css/auth.css">
    <script type="text/javascript">
        // Function to display an alert and redirect
        function showAlertAndRedirect(success) {
            if (success) {
                alert("Registration successful! Please login.");
                window.location.href = "login.jsp";  // Redirect to login page
            } else {
                alert("Registration failed. Please try again.");
            }
        }
    </script>
</head>
<body>

    <div class="container">
        <h2>Register</h2>

        <form action="RegisterServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" required><br><br>

            <label for="password">Password:</label>
            <input type="password" name="password" id="password" required><br><br>

            <input type="submit" value="Register">
        </form>

        <br>
        <%
            String registerSuccess = (String) request.getAttribute("registerSuccess");
            String registerError = (String) request.getAttribute("registerError");

            if (registerSuccess != null) {
        %>
            <script type="text/javascript">
                showAlertAndRedirect(true);  // Show success alert and redirect
            </script>
        <%
            } else if (registerError != null) {
        %>
            <script type="text/javascript">
                showAlertAndRedirect(false);  // Show failure alert
            </script>
        <%
            }
        %>

    </div>

</body>
</html>
