<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>Admin Dashboard</title>
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

    <!-- Main Content -->
    <section class="main-content">
        <div class="cards">
            <div class="card">
                <h3>Total Users</h3>
                <p>120</p>
                <a href="manageUsers.jsp">View Details</a>
            </div>
            <div class="card">
                <h3>Notices</h3>
                <p>15</p>
                <a href="editNotices.jsp">Manage Notices</a>
            </div>
            <div class="card">
                <h3>Reports</h3>
                <p>5 New</p>
                <a href="viewReports.jsp">View Reports</a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Admin Dashboard</p>
    </footer>
</body>
</html>
