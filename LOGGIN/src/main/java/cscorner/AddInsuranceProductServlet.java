package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class AddInsuranceProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("product_name");
        String planNo = request.getParameter("plan_no");
        String uinNo = request.getParameter("uin_no");
        String planDetails = request.getParameter("plan_details");
        String coverageAmount = request.getParameter("coverage_amount");
        String premiumAmount = request.getParameter("premium_amount");
        String planDuration = request.getParameter("plan_duration");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                String query = "INSERT INTO insurance_products (product_name, plan_no, uin_no, plan_details, coverage_amount, premium_amount, plan_duration) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setString(1, productName);
                    ps.setString(2, planNo);
                    ps.setString(3, uinNo);
                    ps.setString(4, planDetails);
                    ps.setString(5, coverageAmount);
                    ps.setString(6, premiumAmount);
                    ps.setString(7, planDuration);
                    int rowsAffected = ps.executeUpdate();

                    if (rowsAffected > 0) {
                        response.sendRedirect("adminInsuranceProduct.jsp");
                    } else {
                        response.getWriter().println("Error adding product.");
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
