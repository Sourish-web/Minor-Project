package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String notice = request.getParameter("notice");

        // Save the notice in a session, database, or file
        // For example, saving it in the session (or replace with database logic)
        HttpSession session = request.getSession();
        session.setAttribute("notice", notice);

        // Forward to the admin page to show the updated notice
        response.sendRedirect("admin.jsp");
    }
}
