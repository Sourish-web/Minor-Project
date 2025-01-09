package cscorner;

import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class AdminFaqServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, String>> pendingFaqs = new ArrayList<>();
        Connection con = null;
        try {
            // Establish the database connection
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025");

            // Prepare the SQL query
            String query = "SELECT id, question FROM faqs WHERE status = 'pending'";

            try (PreparedStatement ps = con.prepareStatement(query);
                 ResultSet rs = ps.executeQuery()) {

                // Process the ResultSet and populate the FAQ list
                while (rs.next()) {
                    Map<String, String> faq = new HashMap<>();
                    faq.put("id", String.valueOf(rs.getInt("id")));
                    faq.put("question", rs.getString("question"));
                    pendingFaqs.add(faq);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("errorPage.jsp");
            dispatcher.forward(request, response);
            return; // Exit the method if there's an error
        } finally {
            // Ensure the connection is closed
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // Set the list of pending FAQs as a request attribute
        request.setAttribute("pendingFaqs", pendingFaqs);

        // Forward the request to adminFaq.jsp to display the FAQs
        RequestDispatcher dispatcher = request.getRequestDispatcher("adminFaq.jsp");
        dispatcher.forward(request, response);
    }
}
