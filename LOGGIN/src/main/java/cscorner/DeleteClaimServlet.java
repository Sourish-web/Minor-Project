package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class DeleteClaimServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get claim ID from request
        String claimIdStr = request.getParameter("id");
        if (claimIdStr == null || claimIdStr.isEmpty()) {
            response.sendRedirect("adminClaims.jsp"); // Redirect if claim ID is missing
            return;
        }

        int claimId = Integer.parseInt(claimIdStr);
        
        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/sourish";
        String jdbcUsername = "root";
        String jdbcPassword = "258025";
        
        // SQL query to delete the claim
        String deleteQuery = "DELETE FROM claims WHERE id = ?";
        
        try (Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = con.prepareStatement(deleteQuery)) {
            
            // Set the claim ID parameter for the delete query
            ps.setInt(1, claimId);
            
            // Execute the delete query
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                // Successfully deleted, redirect to adminClaims.jsp with success message
                request.setAttribute("message", "Claim deleted successfully!");
            } else {
                // No rows affected, claim not found
                request.setAttribute("message", "Claim not found or could not be deleted.");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database connection failure or SQL issues
            request.setAttribute("message", "Error deleting claim. Please try again later.");
        }

        // Forward the request back to the adminClaims.jsp page to show the updated status
        RequestDispatcher dispatcher = request.getRequestDispatcher("adminClaims.jsp");
        dispatcher.forward(request, response);
    }
}
