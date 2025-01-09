package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class UpdateClaimServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get claim ID and status from the form
        int claimId = Integer.parseInt(request.getParameter("claimId"));
        String status = request.getParameter("status");

        // Update claim status in the database
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
            String query = "UPDATE claims SET status = ? WHERE id = ?";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setString(1, status);
                ps.setInt(2, claimId);

                int result = ps.executeUpdate();

                // If update is successful, redirect with a success message
                if (result > 0) {
                    response.sendRedirect("adminClaims.jsp?message=Claim status updated successfully.");
                } else {
                    response.sendRedirect("adminClaims.jsp?message=Failed to update claim status.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("adminClaims.jsp?message=Error occurred while updating claim status.");
        }
    }
}
