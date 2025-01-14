package cscorner;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CalculateQuoteServlet")
public class CalculateQuoteServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the form data
        int age = Integer.parseInt(request.getParameter("age"));
        int coverage = Integer.parseInt(request.getParameter("coverage"));
        String plan = request.getParameter("plan");
        String location = request.getParameter("location");

        // Calculate the premium
        double premium = 0;

        // Basic calculation logic
        if (age <= 25) {
            premium = 5000;
        } else if (age <= 40) {
            premium = 7000;
        } else {
            premium = 10000;
        }

        // Adjust premium based on coverage amount
        if (coverage > 1000000) {
            premium += 3000;
        } else if (coverage > 500000) {
            premium += 2000;
        } else {
            premium += 1000;
        }

        // Adjust premium based on plan type
        if (plan.equals("family")) {
            premium *= 1.5;
        }

        // Adjust based on location
        if (location.equals("urban")) {
            premium *= 1.2;
        }

        // Set the calculated quote as a request attribute
        request.setAttribute("calculatedQuote", premium);

        // Forward to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("quoteCalculator.jsp");
        dispatcher.forward(request, response);
    }
}
