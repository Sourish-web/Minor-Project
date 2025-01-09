package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AddInsuranceProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String productName = request.getParameter("product_name");
        String planNo = request.getParameter("plan_no");
        String uinNo = request.getParameter("uin_no");
        String planDetails = request.getParameter("plan_details"); // New field for plan details

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish database connection
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                // Insert query with the new plan_details column
                String query = "INSERT INTO insurance_products (product_name, plan_no, uin_no, plan_details) VALUES (?, ?, ?, ?)";
                
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    // Set parameters
                    ps.setString(1, productName);
                    ps.setString(2, planNo);
                    ps.setString(3, uinNo);
                    ps.setString(4, planDetails); // Set the plan details
                    
                    // Execute update and redirect
                    int result = ps.executeUpdate();

                    if (result > 0) {
                        response.sendRedirect("adminInsuranceProduct.jsp?success=1"); // Success case
                    } else {
                        response.sendRedirect("adminInsuranceProduct.jsp?error=1"); // Error case
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("adminInsuranceProduct.jsp?error=driver"); // JDBC driver error
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("adminInsuranceProduct.jsp?error=db"); // Database error
        }
    }
}
