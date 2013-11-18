<%@ page import="edu.ucla.cs.cs144.SearchResult" %>
<%@ page import="java.util.HashMap" %>

<html>
  <head>
    <style>
  	  /* inline styles are dumb but so lazy */
  	  .attribute label {
  	    font-weight: bold;
  	  }
    </style>
  </head>
  <body>
    <h1>Item For "<%= request.getParameter("id") %>"</h1>
    <h2>Search: </h2><br/>
    <form action='item' method='GET'>
      <label>Query: </label><input type='text' name='id' />
      <input type='submit' value='Submit' />
    </form>
    <div class="attribute"><label>Name: </label><span><%= request.getAttribute("name") %></span></div>
    <div class="attribute"><label>Currently: </label><span><%= request.getAttribute("currently") %></span></div>
    <div class="attribute"><label>Buy Price: </label><span><%= request.getAttribute("buyPrice") %></span></div>
    <div class="attribute"><label>First Bid: </label><span><%= request.getAttribute("firstBid") %></span></div>
    <div class="attribute"><label>Number of Bids: </label><span><%= request.getAttribute("numberOfBids") %></span></div>
    <div class="attribute"><label>Location: </label><span><%= request.getAttribute("location") %></span></div>
    <div class="attribute"><label>Country: </label><span><%= request.getAttribute("country") %></span></div>
    <div class="attribute"><label>Started: </label><span><%= request.getAttribute("started") %></span></div>
    <div class="attribute"><label>Seller Id: </label><span><%= request.getAttribute("sellerId") %></span></div>
    <div class="attribute"><label>Seller Rating: </label><span><%= request.getAttribute("sellerRating") %></span></div>  
    <div class="attribute"><label>Description: </label><span><%= request.getAttribute("description") %></span></div>
    <div class="attribute">
      <label>Categories: </label>
      <table>
      <%
      String[] categories = (String[]) request.getAttribute("categories");
      for( String c : categories ) { %>
        <tr>
          <td>
    	    <span><%= c %></span>
    	  </td>
    	</tr>
      <% } %>
      </table>
    </div>
    <table>
      <tr>
      	<th>Amount</th>
      	<th>Time</th>
        <th>Bidder Id</th>
        <th>Bidder Rating</th>
        <th>Bidder Location</th>
        <th>Bidder Country</th>
      </tr>
      <%
      HashMap[] bids = (HashMap[]) request.getAttribute("bids");
      for( HashMap bid : bids ) {
      %>
      <tr>
        <td><%= (String) bid.get("amount") %></td>
        <td><%= (String) bid.get("time") %></td>
        <td><%= (String) bid.get("bidderId") %></td>
        <td><%= (String) bid.get("rating") %></td>
        <td><%= (String) bid.get("location") %></td>
        <td><%= (String) bid.get("country") %></td>
      </tr>
      <% } %>
    </table>
  </body>
</html>