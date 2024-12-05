<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link rel="stylesheet" href="resources/css/styles.css"> <!-- Global styles -->
</head>
<body>

<h2>Admin Login</h2>

<%-- Display error if any --%>
<%
    String loginError = (String) request.getAttribute("loginError");
    if (loginError != null) {
%>
    <p style="color: red;"><%= loginError %></p>
<% } %>

<form action="AdminLoginServlet" method="POST">
    <label for="adminUsername">Username:</label>
    <input type="text" id="adminUsername" name="adminUsername" required><br><br>

    <label for="adminPassword">Password:</label>
    <input type="password" id="adminPassword" name="adminPassword" required><br><br>

    <input type="submit" value="Login">
</form>

</body>
</html>
