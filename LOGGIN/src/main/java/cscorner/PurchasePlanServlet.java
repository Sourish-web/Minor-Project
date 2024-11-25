package cscorner;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class PurchasePlanServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String product = request.getParameter("product");

        try (PrintWriter out = response.getWriter()) {
            response.setContentType("text/html");

            // Database connection
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sourish", "root", "258025");

                String query = "INSERT INTO purchases (name, contact, email, address, product) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, name);
                ps.setString(2, contact);
                ps.setString(3, email);
                ps.setString(4, address);
                ps.setString(5, product);

                int result = ps.executeUpdate();
                if (result > 0) {
                    out.println("<h3>Plan purchased successfully!</h3>");
                } else {
                    out.println("<h3>Error in purchasing plan!</h3>");
                }

                con.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                out.println("<h3>Error in processing request!</h3>");
            }
        }
    }
}
