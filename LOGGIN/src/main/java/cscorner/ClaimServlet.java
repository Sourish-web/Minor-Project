package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class ClaimServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String claimantName = request.getParameter("claimantName");
        String policyNumber = request.getParameter("policyNumber");
        double claimAmount = Double.parseDouble(request.getParameter("claimAmount"));
        String claimDetails = request.getParameter("claimDetails");

        // Get session username
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Database connection
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {

            // Insert claim into database
            String query = "INSERT INTO claims (username, claimant_name, policy_number, claim_amount, claim_details, status) VALUES (?, ?, ?, ?, ?, 'Pending')";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setString(1, username);
                ps.setString(2, claimantName);
                ps.setString(3, policyNumber);
                ps.setDouble(4, claimAmount);
                ps.setString(5, claimDetails);

                int result = ps.executeUpdate();

                // If insertion is successful, redirect with success message
                if (result > 0) {
                    response.sendRedirect("claims.jsp?message=Claim submitted successfully. Your claim is under review.");
                } else {
                    response.sendRedirect("claims.jsp?message=Failed to submit your claim. Please try again.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("claims.jsp?message=Error occurred while processing your claim. Please try again later.");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle other GET requests if any, like fetching claims data for viewing (optional).
        // This example assumes no GET request handling.
    }
}
