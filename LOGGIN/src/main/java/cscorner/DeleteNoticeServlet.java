package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class DeleteNoticeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String noticeId = request.getParameter("noticeId"); // Ensure this matches the form parameter name

        if (noticeId != null && !noticeId.trim().isEmpty()) {
            Connection con = null;
            PreparedStatement ps = null;
            try {
                // Load the database driver and establish a connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025");

                // Prepare the SQL query to delete the notice
                String deleteQuery = "DELETE FROM notices WHERE id = ?";
                ps = con.prepareStatement(deleteQuery);
                ps.setInt(1, Integer.parseInt(noticeId));

                // Execute the update
                int rowsAffected = ps.executeUpdate();

                // Check if the deletion was successful
                if (rowsAffected > 0) {
                    // Redirect to the editNotices.jsp page with success message
                    response.sendRedirect("editNotices.jsp?message=Notice deleted successfully.");
                } else {
                    // If no rows were affected, redirect with an error message
                    response.sendRedirect("editNotices.jsp?message=Notice not found.");
                }
            } catch (ClassNotFoundException | SQLException e) {
                // Handle exceptions and redirect to the page with an error message
                e.printStackTrace();
                response.sendRedirect("editNotices.jsp?message=Error deleting notice.");
            } finally {
                // Close the resources in a finally block to ensure they are always closed
                try {
                    if (ps != null) {
                        ps.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            // If the noticeId is null or empty, redirect with an error message
            response.sendRedirect("editNotices.jsp?message=Notice ID is required.");
        }
    }
}
