<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="resources/css/auth.css">
    <style>
        /* Style for the Admin Login Button */
        .admin-login-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            padding: 10px 20px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .admin-login-btn:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>

    <!-- Admin Login Button -->
    <a href="adminLogin.jsp">
        <button class="admin-login-btn">Admin Login</button>
    </a>

    <div class="container">
        <div class="login-box">
            <h1>Welcome Back!</h1>

            <form action="LoginServlet" method="post">
                <div class="textbox">
                    <input type="text" name="txtName" id="txtName" required>
                    <label for="txtName">Enter Username</label>
                </div>

                <div class="textbox">
                    <input type="password" name="txtPwd" id="txtPwd" required>
                    <label for="txtPwd">Enter Password</label>
                </div>

                <input type="submit" value="Login" class="btn">
                <input type="reset" value="Reset" class="btn reset">
            </form>

            <div class="actions">
                <a href="register.jsp" class="register-link">Don't have an account? Register now!</a>
            </div>

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
    </div>

</body>
</html>
