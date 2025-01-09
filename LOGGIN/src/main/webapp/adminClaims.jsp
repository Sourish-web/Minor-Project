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
    <title>Manage Claims - Admin Dashboard</title>
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
                <li><a href="adminInsuranceProduct.jsp">Manage Products</a></li>
                <li><a href="adminClaims.jsp">Manage Claims</a></li>
                <li><a href="adminFaq.jsp" class="active">Manage FAQs</a></li>
                <li><a href="LogoutServlet">Logout</a></li>
            </ul>
        </nav>
    </header>

    <!-- Main Content Section -->
    <section class="main-content">
        <h2>Manage Claims</h2>

        <!-- Manage Existing Claims -->
        <h3>Existing Claims</h3>
        <%
            // Database connection to fetch all claims
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                    String query = "SELECT id, username, claimant_name, policy_number, claim_amount, claim_details, status, created_at FROM claims ORDER BY created_at DESC";
                    try (PreparedStatement ps = con.prepareStatement(query);
                         ResultSet rs = ps.executeQuery()) {
                        if (rs.isBeforeFirst()) {
        %>
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Claimant Name</th>
                        <th>Policy Number</th>
                        <th>Claim Amount (INR)</th>
                        <th>Details</th>
                        <th>Status</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
        <%
                            while (rs.next()) {
                                int id = rs.getInt("id");
                                String username = rs.getString("username");
                                String claimantName = rs.getString("claimant_name");
                                String policyNumber = rs.getString("policy_number");
                                double claimAmount = rs.getDouble("claim_amount");
                                String claimDetails = rs.getString("claim_details");
                                String status = rs.getString("status");
                                String createdAt = rs.getString("created_at");
        %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= username %></td>
                        <td><%= claimantName %></td>
                        <td><%= policyNumber %></td>
                        <td><%= claimAmount %></td>
                        <td><%= claimDetails %></td>
                        <td><%= status %></td>
                        <td><%= createdAt %></td>
                        <td>
                            <!-- Update Claim Status -->
                            <form action="UpdateClaimStatusServlet" method="post" style="display:inline;">
                                <input type="hidden" name="claimId" value="<%= id %>">
                                <select name="status">
                                    <option value="Pending" <%= status.equals("Pending") ? "selected" : "" %>>Pending</option>
                                    <option value="Approved" <%= status.equals("Approved") ? "selected" : "" %>>Approved</option>
                                    <option value="Rejected" <%= status.equals("Rejected") ? "selected" : "" %>>Rejected</option>
                                </select>
                                <button type="submit">Update</button>
                            </form>

                            <!-- Delete Claim -->
                            <form action="DeleteClaimServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this claim?');">
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
            <p>No claims available to manage.</p>
        <%
                        }
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error fetching claims. Please try again later.</p>");
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
