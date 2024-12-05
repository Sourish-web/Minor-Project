<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="resources/css/admin.css">
</head>
<body>

<%-- Session Validation for Admin --%>
<%
    HttpSession mysession = request.getSession(false);
    String username = null;
    if (mysession != null && mysession.getAttribute("username") != null) {
        username = (String) mysession.getAttribute("username");
    }

    if (username == null || !username.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<h1>Admin Panel</h1>

<div class="admin-options">
    <h2>Update Content</h2>
    <form action="AdminServlet" method="post">
        <label for="notice">Notice:</label><br>
        <textarea name="notice" rows="4" cols="50"></textarea><br><br>

        <input type="submit" value="Update Notice">
    </form>

    <!-- Other admin options like updating plans, etc. -->
</div>

</body>
</html>
