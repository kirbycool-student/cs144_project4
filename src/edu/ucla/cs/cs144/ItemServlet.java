package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ItemServlet extends HttpServlet implements Servlet {
       
    public ItemServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	int skip = Integer.parseInt( request.getParameter("numResultsToSkip") );
    	int ret = Integer.parseInt( request.getParameter("numResultsToReturn") );
    	
    	SearchConstraint[] constraints = new SearchConstraint[1];
    	
        SearchConstraint c = new SearchConstraint();
        c.setFieldName("ItemId");
        c.setValue(request.getParameter("itemId"));
        
        constraints[0] = c;
        
        SearchResult[] results = AuctionSearchClient.advancedSearch(constraints, skip, ret);
        
        request.setAttribute("result", results.length == 1 ? results[0] : new SearchResult() );
    	request.getRequestDispatcher("/item.jsp").forward(request, response);
        
    }
}
