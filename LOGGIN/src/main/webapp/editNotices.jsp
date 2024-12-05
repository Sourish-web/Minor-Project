<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>

<%
    // Validate session
    HttpSession mysession = request.getSession(false); // Get the session without creating a new one
    String adminUsername = (mysession != null) ? (String) mysession.getAttribute("adminUsername") : null;

    if (adminUsername == null) {
        // No valid session, redirect to admin login page
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Notices - Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="resources/css/dashboard.css">
</head>
<body>
    <!-- Header section -->
    <header>
        <h1>Admin Dashboard</h1>
        <nav>
            <ul>
                <li><a href="adminDashboard.jsp">Dashboard</a></li>
                <li><a href="manageUsers.jsp">Manage Users</a></li>
                <li><a href="editNotices.jsp">Edit Notices</a></li>
                <li><a href="adminInsuranceProduct.jsp" class="active">Manage Products</a></li>
                <li><a href="LogoutServlet">Logout</a></li>
            </ul>
        </nav>
    </header>

    <!-- Main Content Section -->
    <section class="main-content">
        <!-- Add New Notice Form -->
        <h2>Add New Notice</h2>
        <form action="AddNoticeServlet" method="post">
            <label for="notice">Notice Content:</label><br>
            <textarea id="notice" name="notice" rows="4" cols="50" required></textarea><br><br>
            <button type="submit">Add Notice</button>
        </form>

        <!-- Manage Existing Notices -->
        <h2>Manage Existing Notices</h2>
        <%
            // Database connection to fetch all notices
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                    String query = "SELECT id, notice, created_at FROM notices ORDER BY created_at DESC";
                    try (PreparedStatement ps = con.prepareStatement(query);
                         ResultSet rs = ps.executeQuery()) {
                        if (rs.isBeforeFirst()) {
        %>
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Notice</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
        <%
                            while (rs.next()) {
                                int id = rs.getInt("id");
                                String notice = rs.getString("notice");
                                String createdAt = rs.getString("created_at");
        %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= notice %></td>
                        <td><%= createdAt %></td>
                        <td>
                            <a href="editNotice.jsp?id=<%= id %>">Edit</a> |
                            <form action="DeleteNoticeServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this notice?');">
                                <input type="hidden" name="id" value="<%= id %>">
                                <button type="submit">Delete</button>
                            </form>
                        </td>
                    </tr>
        <%
                            }
        %>
                </tbody>
            </table>
        <%
                        } else {
        %>
            <p>No notices available to manage.</p>
        <%
                        }
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error fetching notices. Please try again later.</p>");
                e.printStackTrace();
            }
        %>
    </section>

    <!-- Footer section -->
    <footer>
        <p>&copy; 2024 Admin Dashboard</p>
    </footer>
</body>
</html>
