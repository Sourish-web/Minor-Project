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
    // Validate admin session
    HttpSession mysession = request.getSession(false);
    String adminUsername = (mysession != null) ? (String) mysession.getAttribute("adminUsername") : null;

    if (adminUsername == null) {
        // No valid session, redirect to admin login
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage FAQs</title>
    <link rel="stylesheet" href="resources/css/dashboard.css">
    <script type="text/javascript">
        // Confirmation for rejecting an FAQ
        function confirmReject(id) {
            return confirm('Are you sure you want to reject this FAQ (ID: ' + id + ')?');
        }
    </script>
</head>
<body>
    <!-- Header Section -->
    <header>
        <h1>Admin Dashboard - Manage FAQs</h1>
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

    <!-- Main Content -->
    <section class="main-content">
        <h2>Pending FAQs</h2>

        <% 
            Connection con = null;
            try {
                // Database Connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025");

                // Fetch pending FAQs
                String query = "SELECT id, question FROM faqs WHERE status = 'pending'";
                try (PreparedStatement ps = con.prepareStatement(query);
                     ResultSet rs = ps.executeQuery()) {
        %>

        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Question</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    while (rs.next()) {
                        int faqId = rs.getInt("id");
                        String question = rs.getString("question");
                %>
                <tr>
                    <td><%= faqId %></td>
                    <td><%= question %></td>
                    <td>
                        <!-- Approve Form -->
                        <form action="UpdateFaqServlet" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= faqId %>">
                            <label for="answer_<%= faqId %>">Answer:</label>
                            <input type="text" name="answer" id="answer_<%= faqId %>" required>
                            <button type="submit">Approve</button>
                        </form>

                        <!-- Reject Form -->
                        <form action="RejectFaqServlet" method="post" style="display:inline;" onsubmit="return confirmReject('<%= faqId %>');">
                            <input type="hidden" name="id" value="<%= faqId %>">
                            <button type="submit" class="reject-button">Reject</button>
                        </form>
                    </td>
                </tr>
                <% 
                    }
                %>
            </tbody>
        </table>

        <%
                }
            } catch (ClassNotFoundException e) {
                out.println("<p>Error: JDBC Driver not found - " + e.getMessage() + "</p>");
            } catch (SQLException e) {
                out.println("<p>Error: Database connection issue - " + e.getMessage() + "</p>");
            } finally {
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException e) {
                        out.println("<p>Error closing connection: " + e.getMessage() + "</p>");
                    }
                }
            }
        %>

        <hr>

        <!-- Approved FAQs -->
        <h2>Approved FAQs</h2>
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Question</th>
                    <th>Answer</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025");
                        String approvedQuery = "SELECT id, question, answer FROM faqs WHERE status = 'approved'";
                        try (PreparedStatement ps = con.prepareStatement(approvedQuery);
                             ResultSet rs = ps.executeQuery()) {
                            while (rs.next()) {
                                int approvedId = rs.getInt("id");
                                String approvedQuestion = rs.getString("question");
                                String approvedAnswer = rs.getString("answer");
                %>
                <tr>
                    <td><%= approvedId %></td>
                    <td><%= approvedQuestion %></td>
                    <td><%= approvedAnswer %></td>
                </tr>
                <%
                            }
                        }
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='3'>Error fetching approved FAQs: " + e.getMessage() + "</td></tr>");
                    } finally {
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
    </section>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Admin Dashboard</p>
    </footer>
</body>
</html>
