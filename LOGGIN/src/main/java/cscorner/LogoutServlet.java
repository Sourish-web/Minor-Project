package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Attempt to retrieve the current session, but do not create a new one
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Retrieve session attributes to check for admin or user login
            String adminUsername = (String) session.getAttribute("adminUsername");
            String userUsername = (String) session.getAttribute("username");

            // Invalidate the session to log out the user/admin
            session.invalidate();

            // Redirect to the appropriate login page based on the session attributes
            if (adminUsername != null) {
                response.sendRedirect("adminLogin.jsp"); // Admin login page
            } else if (userUsername != null) {
                response.sendRedirect("login.jsp"); // User login page
            } else {
                response.sendRedirect("login.jsp"); // Default redirection if no specific session info
            }
        } else {
            // No session exists, redirect to the generic login page
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect POST requests to the GET method for consistent behavior
        doGet(request, response);
    }
}
