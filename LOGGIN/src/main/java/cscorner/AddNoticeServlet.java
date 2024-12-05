package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class AddNoticeServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String noticeContent = request.getParameter("notice");

        if (noticeContent != null && !noticeContent.trim().isEmpty()) {
            Connection con = null;
            PreparedStatement ps = null;
            try {
                // Establish database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025");

                // Insert new notice into the 'notices' table
                String insertQuery = "INSERT INTO notices (notice) VALUES (?)";
                ps = con.prepareStatement(insertQuery);
                ps.setString(1, noticeContent);
                ps.executeUpdate();

                // Redirect to editNotices.jsp with success message
                response.sendRedirect("editNotices.jsp?message=Notice added successfully!");
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("editNotices.jsp?message=Error adding notice.");
            } finally {
                try {
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            response.sendRedirect("editNotices.jsp?message=Notice content cannot be empty.");
        }
    }
}
