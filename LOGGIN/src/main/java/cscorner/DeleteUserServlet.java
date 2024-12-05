package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class DeleteUserServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        
        Connection con = null;
        PreparedStatement ps = null;
        String message = "Error occurred while deleting user.";
        
        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025");
            
            // Query to delete the user from the 'login' table
            String sql = "DELETE FROM login WHERE uname = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            
            int result = ps.executeUpdate();
            if (result > 0) {
                message = "User deleted successfully.";
            }
        } catch (Exception e) {
            message = "Error deleting user: " + e.getMessage();
        } finally {
            // Close resources
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                message = "Error closing resources: " + e.getMessage();
            }
        }
        
        // Set success or error message as an attribute
        request.setAttribute("successMessage", message);
        request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
    }
}
