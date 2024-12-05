<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<html>
<head>
    <title>Edit User</title>
    <link rel="stylesheet" type="text/css" href="resources/css/dashboard.css">
</head>
<body>
    <header>
        <h1>Edit User</h1>
        <nav>
            <ul>
                <li><a href="adminDashboard.jsp">Dashboard</a></li>
                <li><a href="manageUsers.jsp">Manage Users</a></li>
                <li><a href="LogoutServlet">Logout</a></li>
            </ul>
        </nav>
    </header>

    <section>
        <h2>Edit User Details</h2>
        <%
            String username = request.getParameter("username");
            String password = "";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                    String query = "SELECT password FROM login WHERE uname = ?";
                    try (PreparedStatement ps = con.prepareStatement(query)) {
                        ps.setString(1, username);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) {
                            password = rs.getString("password");
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        %>
        <form action="editUserServlet" method="post">
            <input type="hidden" name="username" value="<%= username %>">
            <label for="password">New Password:</label>
            <input type="password" name="password" value="<%= password %>" required><br><br>
            <input type="submit" value="Update User">
        </form>
    </section>

    <footer>
        <p>&copy; 2024 Admin Dashboard</p>
    </footer>
</body>
</html>
