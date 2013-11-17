package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SearchServlet extends HttpServlet implements Servlet {
       
    public SearchServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	String query = request.getParameter("q");
    	int skip = Integer.parseInt( request.getParameter("numResultsToSkip") );
    	int ret = Integer.parseInt( request.getParameter("numResultsToReturn") );
    	
    	SearchResult[] results = AuctionSearchClient.basicSearch(query, skip, ret);
    	
    	request.setAttribute("results", results);
    	request.getRequestDispatcher("/searchResults.jsp").forward(request, response);
    }
}
