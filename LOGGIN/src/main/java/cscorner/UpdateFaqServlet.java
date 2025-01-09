package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class UpdateFaqServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the FAQ details from the request parameters
        int id = Integer.parseInt(request.getParameter("id"));
        String answer = request.getParameter("answer");

        // Update the FAQ answer and set status to 'approved'
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
            String query = "UPDATE faqs SET answer = ?, status = 'approved' WHERE id = ?";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setString(1, answer);
                ps.setInt(2, id);

                int rowsUpdated = ps.executeUpdate();
                if (rowsUpdated > 0) {
                    // Successfully updated the FAQ, redirect to the list
                    response.sendRedirect("AdminFaqServlet");
                } else {
                    // No rows were updated, handle the error
                    request.setAttribute("error", "Failed to update FAQ, please try again.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("errorPage.jsp");
                    dispatcher.forward(request, response);
                }
            }
        } catch (SQLException e) {
            // Log the exception (instead of just printing the stack trace)
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while updating the FAQ. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("errorPage.jsp");
            dispatcher.forward(request, response);
        }
    }
}
