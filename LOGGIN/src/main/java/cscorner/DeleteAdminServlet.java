package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class DeleteAdminServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        Connection con = null;
        PreparedStatement ps = null;
        String message = "Error occurred while deleting admin.";
        
        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025");
            
            // SQL query to delete the admin from the 'admin' table
            String sql = "DELETE FROM admin WHERE username = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            
            // Execute the delete query
            int result = ps.executeUpdate();
            if (result > 0) {
                message = "Admin deleted successfully.";
            } else {
                message = "Admin not found.";
            }
        } catch (ClassNotFoundException e) {
            message = "JDBC Driver not found: " + e.getMessage();
        } catch (SQLException e) {
            message = "Error deleting admin: " + e.getMessage();
        } finally {
            // Close the PreparedStatement and Connection resources
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                message = "Error closing resources: " + e.getMessage();
            }
        }

        // Set success or error message as a request attribute
        request.setAttribute("successMessage", message);
        
        // Forward to the manageUsers.jsp page to display the result
        request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
    }
}
