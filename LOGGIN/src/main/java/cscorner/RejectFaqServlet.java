package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class RejectFaqServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the FAQ ID from the request parameters
        int id = Integer.parseInt(request.getParameter("id"));

        // Set the FAQ status to 'rejected'
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
            String query = "UPDATE faqs SET status = 'rejected' WHERE id = ?";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setInt(1, id);

                int rowsUpdated = ps.executeUpdate();
                if (rowsUpdated > 0) {
                    // Successfully rejected the FAQ
                    response.sendRedirect("AdminFaqServlet");
                } else {
                    // If no rows were updated, handle the error
                    request.setAttribute("error", "Failed to reject FAQ.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("errorPage.jsp");
                    dispatcher.forward(request, response);
                }
            }
        } catch (SQLException e) {
            // Handle database connection or query errors
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while rejecting the FAQ.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("errorPage.jsp");
            dispatcher.forward(request, response);
        }
    }
}
