package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class AdminClaimsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Claim> claims = new ArrayList<>();

        // Try to fetch claims from the database
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
            String query = "SELECT * FROM claims ORDER BY created_at DESC";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ResultSet rs = ps.executeQuery();

                // Fetch all claims from result set
                while (rs.next()) {
                    Claim claim = new Claim();
                    claim.setId(rs.getInt("id"));
                    claim.setUsername(rs.getString("username"));
                    claim.setClaimantName(rs.getString("claimant_name"));
                    claim.setPolicyNumber(rs.getString("policy_number"));
                    claim.setClaimAmount(rs.getDouble("claim_amount"));
                    claim.setClaimDetails(rs.getString("claim_details"));
                    claim.setStatus(rs.getString("status"));
                    claim.setCreatedAt(rs.getTimestamp("created_at"));

                    claims.add(claim);
                }
            }
        } catch (SQLException e) {
            // Log and handle the SQL exception
            e.printStackTrace();
            // Optionally, you could redirect to an error page or display an error message
            request.setAttribute("error", "Failed to retrieve claims.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("errorPage.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Set the claims list as a request attribute for the JSP
        request.setAttribute("claims", claims);

        // Forward the request to adminClaims.jsp for rendering the claims list
        RequestDispatcher dispatcher = request.getRequestDispatcher("adminClaims.jsp");
        dispatcher.forward(request, response);
    }
}
