package cscorner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class CalculateQuoteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the input parameters
        int age = Integer.parseInt(request.getParameter("age"));
        double coverage = Double.parseDouble(request.getParameter("coverage"));
        String plan = request.getParameter("plan");
        String location = request.getParameter("location");

        // Initialize base premium
        double basePremium = 1000; // Example base premium

        // Calculate premium based on age
        if (age > 50) {
            basePremium += 2000;  // Add more if the user is older
        } else if (age < 25) {
            basePremium -= 500;  // Discount for younger individuals
        }

        // Adjust premium based on coverage
        basePremium += (coverage / 1000) * 100;  // Example: coverage affects premium

        // Modify premium based on plan type
        if (plan.equals("family")) {
            basePremium += 500;  // Add extra for family floater plans
        }

        // Adjust for location
        if (location.equals("rural")) {
            basePremium -= 200;  // Discount for rural areas
        }

        // Calculate the final quote
        double calculatedQuote = basePremium;

        // Set the calculated quote as a request attribute
        request.setAttribute("calculatedQuote", calculatedQuote);

        // Forward the request and response to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("quoteCalculator.jsp");
        dispatcher.forward(request, response);
    }
}
