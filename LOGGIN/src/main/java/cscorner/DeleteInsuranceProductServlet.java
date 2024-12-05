package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class DeleteInsuranceProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int srNo = Integer.parseInt(request.getParameter("sr_no"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                String query = "DELETE FROM insurance_products WHERE sr_no = ?";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setInt(1, srNo);
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
