<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<html>
<head>
    <title>Manage Users and Admins</title>
    <link rel="stylesheet" href="resources/css/dashboard.css">

    <script type="text/javascript">
        function confirmDelete(username) {
            return confirm('Are you sure you want to delete ' + username + '?');
        }
    </script>
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
                <li><a href="adminInsuranceProduct.jsp">Manage Products</a></li>
                <li><a href="adminClaims.jsp">Manage Claims</a></li>
                <li><a href="adminFaq.jsp" class="active">Manage FAQs</a></li>
                <li><a href="LogoutServlet">Logout</a></li>
            </ul>
        </nav>
    </header>

    <!-- Main Content Section -->
    <section class="main-content">
        <h2>User List</h2>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
        <% } else if (request.getAttribute("successMessage") != null) { %>
            <div class="success-message"><%= request.getAttribute("successMessage") %></div>
        <% } %>

        <table class="table">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection con = null;
                    try {
                        // Establish database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025");

                        // Query for fetching users from the 'login' table
                        String userQuery = "SELECT uname FROM login";
                        try (PreparedStatement ps = con.prepareStatement(userQuery);
                             ResultSet rs = ps.executeQuery()) {
                            while (rs.next()) {
                                String username = rs.getString("uname");
                %>
                                    <tr>
                                        <td><%= username %></td>
                                        <td>
                                            <!-- Edit Button: Redirect to edit page with username -->
                                            <a href="editUser.jsp?username=<%= username %>">Edit</a>
                                            <!-- Delete Button: Call confirm delete function before submitting form -->
                                            <form action="DeleteUserServlet" method="post" style="display:inline;" onsubmit="return confirmDelete('<%= username %>');">
                                                <input type="hidden" name="username" value="<%= username %>">
                                                <button type="submit">Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                <%
                            }
                        }
                    } catch (ClassNotFoundException e) {
                        out.println("<tr><td colspan='3'>JDBC Driver not found: " + e.getMessage() + "</td></tr>");
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='3'>Error fetching users: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>

        <hr>

        <h2>Admin List</h2>

        <table class="table">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        // Query for fetching admins from the 'admin' table
                        String adminQuery = "SELECT username FROM admin";
                        try (PreparedStatement ps = con.prepareStatement(adminQuery);
                             ResultSet rs = ps.executeQuery()) {
                            while (rs.next()) {
                                String newadminUsername = rs.getString("username");
                %>
                                    <tr>
                                        <td><%= newadminUsername %></td>
                                        <td>
                                            <!-- Edit Button: Redirect to edit page with admin username -->
                                            <a href="editAdmin.jsp?username=<%= newadminUsername %>">Edit</a>
                                            <!-- Delete Button: Call confirm delete function before submitting form -->
                                            <form action="DeleteAdminServlet" method="post" style="display:inline;" onsubmit="return confirmDelete('<%= adminUsername %>');">
                                                <input type="hidden" name="username" value="<%= newadminUsername %>">
                                                <button type="submit">Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                <% 
                            }
                        }
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='3'>Error fetching admins: " + e.getMessage() + "</td></tr>");
                    } finally {
                        // Close the connection
                        if (con != null) {
                            try {
                                con.close();
                            } catch (SQLException e) {
                                out.println("<tr><td colspan='3'>Error closing connection: " + e.getMessage() + "</td></tr>");
                            }
                        }
                    }
                %> 
            </tbody> 
        </table>

        <!-- Link to add new user or admin -->
        <p><a href="addUser.jsp">Add New User</a> | <a href="addAdmin.jsp">Add New Admin</a></p> 
    </section>

    <!-- Footer section -->
    <footer>
        <p>&copy; 2024 Admin Dashboard</p>
    </footer> 
</body> 
</html>
