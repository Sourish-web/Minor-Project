package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class UpdateClaimStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the claim ID and status from the request
        String claimIdStr = request.getParameter("claimId");
        String status = request.getParameter("status");

        // If the claim ID or status is invalid, redirect to the claims page
        if (claimIdStr == null || status == null || claimIdStr.isEmpty()) {
            response.sendRedirect("adminClaims.jsp");
            return;
        }

        // Convert the claim ID to an integer
        int claimId = Integer.parseInt(claimIdStr);

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/sourish";
        String jdbcUsername = "root";
        String jdbcPassword = "258025";

        // SQL query to update the claim status
        String updateQuery = "UPDATE claims SET status = ? WHERE id = ?";

        try (Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = con.prepareStatement(updateQuery)) {

            // Set the parameters for the query
            ps.setString(1, status); // The status value (e.g., Approved, Rejected, Pending)
            ps.setInt(2, claimId); // The claim ID to identify the claim

            // Execute the update query
            int rowsAffected = ps.executeUpdate();

            // Check if the update was successful
            if (rowsAffected > 0) {
                // Set a success message if the claim status was updated
                request.setAttribute("message", "Claim status updated successfully!");
            } else {
                // Set an error message if the claim was not found or updated
                request.setAttribute("message", "Error updating claim status. Claim not found.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // Set an error message if there was a database issue
            request.setAttribute("message", "Database error while updating status.");
        }

        // Forward the request back to the adminClaims.jsp page to show the updated claim list
        RequestDispatcher dispatcher = request.getRequestDispatcher("adminClaims.jsp");
        dispatcher.forward(request, response);
    }
}
