package edu.ucla.cs.cs144;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProxyServlet extends HttpServlet implements Servlet {
       
    public ProxyServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        String query = request.getParameter("q");
        String urlString = "http://google.com/complete/search?output=toolbar&q=" + query;
        
        URL url = new URL(urlString);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        
        con.setRequestMethod("GET");
        
        int responseCode = con.getResponseCode();
 
		BufferedReader in = new BufferedReader( new InputStreamReader(con.getInputStream()) );
		String inputLine;
		StringBuffer suggestResponse = new StringBuffer();
 
		while ((inputLine = in.readLine()) != null) {
			suggestResponse.append(inputLine);
		}
		in.close();
		
		response.setContentType("text/xml");
		response.getWriter().write(suggestResponse.toString());
    }
}
