<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="resources/css/auth.css">
</head>
<body>

    <div class="container">
        <h1>User Login</h1>

        <form action="LoginServlet" method="post">
            <label for="txtName">Enter Name:</label>
            <input type="text" name="txtName" id="txtName" required><br>

            <label for="txtPwd">Enter Password:</label>
            <input type="password" name="txtPwd" id="txtPwd" required><br>

            <input type="submit" value="Login">
            <input type="reset" value="Reset">
        </form>

        <a href="register.jsp">Don't have an account? Register now!</a>

        <!-- Display error message from LoginServlet if login failed -->
        <%
            String errorMessage = (String) request.getAttribute("loginError");
            if (errorMessage != null) {
        %>
            <div class="error-message"><%= errorMessage %></div>
        <%
            }
        %>

    </div>

</body>
</html>
