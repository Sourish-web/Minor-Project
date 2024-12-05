package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AddInsuranceProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("product_name");
        String planNo = request.getParameter("plan_no");
        String uinNo = request.getParameter("uin_no");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                String query = "INSERT INTO insurance_products (product_name, plan_no, uin_no) VALUES (?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setString(1, productName);
                    ps.setString(2, planNo);
                    ps.setString(3, uinNo);
                    int result = ps.executeUpdate();

                    if (result > 0) {
                        response.sendRedirect("adminInsuranceProduct.jsp"); // Redirect to the same page to see the updated list
                    } else {
                        response.sendRedirect("adminInsuranceProduct.jsp?error=1"); // Error case
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminInsuranceProduct.jsp?error=2"); // Error case
        }
    }
}
