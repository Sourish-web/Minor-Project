package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class addAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                
                // Insert data into the admin table
                String query = "INSERT INTO admin (username, password) VALUES (?, ?)";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setString(1, username);
                    ps.setString(2, password);
                    int rowsAffected = ps.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        response.sendRedirect("adminDashboard.jsp"); // Redirect to admin dashboard after successful addition
                    } else {
                        request.setAttribute("errorMessage", "Error adding admin.");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("addAdmin.jsp");
                        dispatcher.forward(request, response);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Database error.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("addAdmin.jsp");
                dispatcher.forward(request, response);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database driver not found.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("addAdmin.jsp");
            dispatcher.forward(request, response);
        }
    }
}
