package edu.ucla.cs.cs144;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TransactionServlet extends HttpServlet implements Servlet{

	public TransactionServlet() {}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if( !request.isSecure() ) {
			request.setAttribute("error", "Must Use Https");
			request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
			return;
		}
		
		request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
		
	}
	
}
