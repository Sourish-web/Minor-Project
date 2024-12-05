package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class editUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                String query = "UPDATE login SET password = ? WHERE uname = ?";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setString(1, password);
                    ps.setString(2, username);
                    int rowsAffected = ps.executeUpdate();
                    if (rowsAffected > 0) {
                        response.sendRedirect("manageUsers.jsp");
                    } else {
                        response.getWriter().println("Error updating user.");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
