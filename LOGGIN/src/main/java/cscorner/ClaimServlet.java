package cscorner;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ClaimServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String claimantName = request.getParameter("claimantName");
        String policyNumber = request.getParameter("policyNumber");
        String claimAmount = request.getParameter("claimAmount");
        String claimDetails = request.getParameter("claimDetails");

        try (PrintWriter out = response.getWriter()) {
            response.setContentType("text/html");

            // Load MySQL driver
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                out.println("<h3>Error: MySQL Driver not found!</h3>");
                return;
            }

            // Establish database connection
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                // Query to insert claim data
                String query = "INSERT INTO claims (claimantName, policyNumber, claimAmount, claimDetails) VALUES (?, ?, ?, ?)";
                
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setString(1, claimantName);
                    ps.setString(2, policyNumber);
                    ps.setString(3, claimAmount);
                    ps.setString(4, claimDetails);

                    // Execute query
                    int rowsAffected = ps.executeUpdate();

                    // Response to user based on success/failure
                    if (rowsAffected > 0) {
                        // Redirect to claims confirmation page or show success message
                        request.setAttribute("message", "Claim submitted successfully!");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("claims.jsp");
                        dispatcher.forward(request, response);  // Forward to the same page or another confirmation page
                    } else {
                        request.setAttribute("message", "Error in submitting claim. Please try again.");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("claims.jsp");
                        dispatcher.forward(request, response);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<h3>Error in processing claim!</h3>");
            }
        }
    }
}
