<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%
    HttpSession mysession = request.getSession(false);
    String adminUsername = (mysession != null) ? (String) mysession.getAttribute("adminUsername") : null;

    if (adminUsername == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Insurance Products - Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="resources/css/dashboard.css">
    <link rel="stylesheet" href="resources/css/insuranceProducts.css">
</head>
<body>
    <header>
        <h1>Admin Dashboard</h1>
        <nav>
            <ul>
                <li><a href="adminDashboard.jsp">Dashboard</a></li>
                <li><a href="manageUsers.jsp">Manage Users</a></li>
                <li><a href="editNotices.jsp">Edit Notices</a></li>
                <li><a href="adminInsuranceProduct.jsp" class="active">Manage Products</a></li>
                <li><a href="adminClaims.jsp">Manage Claims</a></li>
                <li><a href="adminFaq.jsp">Manage FAQs</a></li>
                <li><a href="LogoutServlet">Logout</a></li>
            </ul>
        </nav>
    </header>

    <section class="product-management">
        <h2>Manage Insurance Products</h2>
        <h3>Add New Product</h3>
        <form action="AddInsuranceProductServlet" method="post">
            <label for="product_name">Product Name:</label><br>
            <input type="text" id="product_name" name="product_name" required><br><br>

            <label for="plan_no">Plan No.:</label><br>
            <input type="text" id="plan_no" name="plan_no" required><br><br>

            <label for="uin_no">UIN No.:</label><br>
            <input type="text" id="uin_no" name="uin_no" required><br><br>

            <label for="plan_details">Plan Details:</label><br>
            <textarea id="plan_details" name="plan_details" rows="4" cols="50" required></textarea><br><br>

            <!-- Add more details -->
            <label for="coverage_amount">Coverage Amount:</label><br>
            <input type="text" id="coverage_amount" name="coverage_amount" required><br><br>

            <label for="premium_amount">Premium Amount:</label><br>
            <input type="text" id="premium_amount" name="premium_amount" required><br><br>

            <label for="plan_duration">Plan Duration:</label><br>
            <input type="text" id="plan_duration" name="plan_duration" required><br><br>

            <button type="submit">Add Product</button>
        </form>

        <h3>Existing Products</h3>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                    String query = "SELECT sr_no, product_name, plan_no, uin_no, plan_details, coverage_amount, premium_amount, plan_duration FROM insurance_products";
                    try (PreparedStatement ps = con.prepareStatement(query);
                         ResultSet rs = ps.executeQuery()) {
                        if (rs.isBeforeFirst()) {
        %>
                            <table class="product-table">
                                <thead>
                                    <tr>
                                        <th>Sr. No.</th>
                                        <th>Product Name</th>
                                        <th>Plan No.</th>
                                        <th>UIN No.</th>
                                        <th>Plan Details</th>
                                        <th>Coverage Amount</th>
                                        <th>Premium Amount</th>
                                        <th>Plan Duration</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
        <%
                            while (rs.next()) {
                                int srNo = rs.getInt("sr_no");
                                String productName = rs.getString("product_name");
                                String planNo = rs.getString("plan_no");
                                String uinNo = rs.getString("uin_no");
                                String planDetails = rs.getString("plan_details");
                                String coverageAmount = rs.getString("coverage_amount");
                                String premiumAmount = rs.getString("premium_amount");
                                String planDuration = rs.getString("plan_duration");
        %>
                                    <tr>
                                        <td><%= srNo %></td>
                                        <td><%= productName %></td>
                                        <td><%= planNo %></td>
                                        <td><%= uinNo %></td>
                                        <td><%= planDetails %></td>
                                        <td><%= coverageAmount %></td>
                                        <td><%= premiumAmount %></td>
                                        <td><%= planDuration %></td>
                                        <td>
                                            <a href="editInsuranceProduct.jsp?sr_no=<%= srNo %>">Edit</a> | 
                                            <form action="DeleteInsuranceProductServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="sr_no" value="<%= srNo %>">
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
                            <p>No insurance products available to manage.</p>
        <%
                        }
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error fetching insurance products. Please try again later.</p>");
                e.printStackTrace();
            }
        %>
    </section>

    <footer>
        <p>&copy; 2024 Admin Dashboard</p>
    </footer>

</body>
</html>
