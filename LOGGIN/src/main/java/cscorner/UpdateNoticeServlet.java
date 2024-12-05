package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class UpdateNoticeServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String noticeId = request.getParameter("id");
        String noticeContent = request.getParameter("notice");

        if (noticeId != null && noticeContent != null && !noticeContent.trim().isEmpty()) {
            Connection con = null;
            PreparedStatement ps = null;
            try {
                // Establish database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025");

                // Update the existing notice
                String updateQuery = "UPDATE notices SET notice = ? WHERE id = ?";
                ps = con.prepareStatement(updateQuery);
                ps.setString(1, noticeContent);
                ps.setInt(2, Integer.parseInt(noticeId));
                ps.executeUpdate();

                // Redirect to editNotices.jsp with success message
                response.sendRedirect("editNotices.jsp?message=Notice updated successfully!");
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("editNotices.jsp?message=Error updating notice.");
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
