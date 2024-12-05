package cscorner;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("username");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement ps = null;
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025");

            // Prepare SQL statement for insertion
            String query = "INSERT INTO login (uname, password) VALUES (?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, password);

            int result = ps.executeUpdate();

            // Check if the registration was successful
            if (result > 0) {
                // If successful, set a message and redirect to the login page
                request.setAttribute("registerSuccess", "Registration successful! Please login.");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            } else {
                // If not successful, set an error message
                request.setAttribute("registerError", "Registration failed! Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("registerError", "An error occurred. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
        } finally {
            // Clean up resources
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
