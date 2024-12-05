package cscorner;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("adminUsername");
        String password = request.getParameter("adminPassword");

        // Check if username or password is empty
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("loginError", "Username and password cannot be empty.");
            RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
            rd.forward(request, response);
            return;
        }

        try {
            // Load MySQL driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                // Prepare SQL query
                String query = "SELECT username FROM admin WHERE username = ? AND password = ?";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setString(1, username);
                    ps.setString(2, password);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            // Successful login, create a session and set the username attribute
                            HttpSession session = request.getSession();
                            session.setAttribute("adminUsername", username); // Store admin username in session

                            // Redirect to the admin dashboard
                            response.sendRedirect("adminDashboard.jsp");
                        } else {
                            // Login failed, set error message and forward back to login.jsp
                            request.setAttribute("loginError", "Wrong username or password.");
                            RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
                            rd.forward(request, response);
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("loginError", "Database connection error.");
                RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
                rd.forward(request, response);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("loginError", "Database driver not found.");
            RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
            rd.forward(request, response);
        }
    }
}
