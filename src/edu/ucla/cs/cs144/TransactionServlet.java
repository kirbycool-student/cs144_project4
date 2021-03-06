package edu.ucla.cs.cs144;

import java.io.IOException;
import java.util.Date;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class TransactionServlet extends HttpServlet implements Servlet{

	public TransactionServlet() {}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if( !request.isSecure() ) {
			request.setAttribute("error", "Must Use Https");
			request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
			return;
		}
		
		HttpSession session = request.getSession(false);
		
		if( session == null ) {
			request.setAttribute("error", "No session data available");
			request.getRequestDispatcher("/creditCardForm.jsp").forward(request, response);
			return;
		}
		
		if( session.getAttribute("buyPrice") == null) {
			request.setAttribute("error", "This item is not available for immediate purchase");
			request.getRequestDispatcher("/creditCardForm.jsp").forward(request, response);
			return;
		}
		
		Date date = new Date();
		request.setAttribute("time", date.toString());
		
		request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
		
	}
	
}
