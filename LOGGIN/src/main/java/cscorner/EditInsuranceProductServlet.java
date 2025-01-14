package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class EditInsuranceProductServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int srNo = Integer.parseInt(request.getParameter("sr_no"));
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                String query = "SELECT * FROM insurance_products WHERE sr_no = ?";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setInt(1, srNo);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            request.setAttribute("product", rs);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("editInsuranceProduct.jsp");
                            dispatcher.forward(request, response);
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int srNo = Integer.parseInt(request.getParameter("sr_no"));
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
                String query = "UPDATE insurance_products SET product_name = ?, plan_no = ?, uin_no = ?, plan_details = ?, coverage_amount = ?, premium_amount = ?, plan_duration = ? WHERE sr_no = ?";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setString(1, productName);
                    ps.setString(2, planNo);
                    ps.setString(3, uinNo);
                    ps.setString(4, planDetails);
                    ps.setString(5, coverageAmount);
                    ps.setString(6, premiumAmount);
                    ps.setString(7, planDuration);
                    ps.setInt(8, srNo);
                    int rowsAffected = ps.executeUpdate();

                    if (rowsAffected > 0) {
                        response.sendRedirect("adminInsuranceProduct.jsp");
                    } else {
                        response.getWriter().println("Error updating product.");
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
