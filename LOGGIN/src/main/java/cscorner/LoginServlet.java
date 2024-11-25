package cscorner;

import java.io.IOException;
import java.io.PrintWriter;
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

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            response.setContentType("text/html");
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025")) {
                String n = request.getParameter("txtName");
                String p = request.getParameter("txtPwd");

                try (PreparedStatement ps = con.prepareStatement("SELECT uname FROM login WHERE uname = ? AND password = ?")) {
                    ps.setString(1, n);
                    ps.setString(2, p);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            // Successful login, forward to the welcome page
                            RequestDispatcher rd = request.getRequestDispatcher("welcome.jsp");
                            rd.forward(request, response);
                        } else {
                            // Login failed, set error message and forward back to login.jsp
                            request.setAttribute("loginError", "Wrong username/password");
                            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                            rd.forward(request, response);
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
