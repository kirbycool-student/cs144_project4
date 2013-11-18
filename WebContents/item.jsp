<%@ page import="edu.ucla.cs.cs144.SearchResult" %>
<%@ page import="import java.util.HashMap" %>

<html>
  <head>
  </head>
  <body>
    <h1>Item For "<%= request.getParameter("") %>"</h1>
    <h2>Search: </h2><br/>
    <form action='item' method='GET'>
      <label>Query: </label><input type='text' name='itemId' />
      <input type='submit' value='Submit' />
    </form>
    <div class="attribute><label>Name: </label><span><%= request.getAttribute("name") %></div>
    <div class="attribute><label>Category: </label><span><%= request.getAttribute("category") %></div>
    <div class="attribute><label>Currently: </label><span><%= request.getAttribute("currently") %></div>
    <div class="attribute><label>Buy Price: </label><span><%= request.getAttribute("buyPrice") %></div>
    <div class="attribute><label>First Bid: </label><span><%= request.getAttribute("firstBid") %></div>
    <div class="attribute><label>Number of Bids: </label><span><%= request.getAttribute("numberOfBids") %></div>
    <div class="attribute><label>Location: </label><span><%= request.getAttribute("location") %></div>
    <div class="attribute><label>Country: </label><span><%= request.getAttribute("country") %></div>
    <div class="attribute><label>Started: </label><span><%= request.getAttribute("started") %></div>
    <div class="attribute><label>Seller Id: </label><span><%= request.getAttribute("sellerId") %></div>
    <div class="attribute><label>Seller Rating: </label><span><%= request.getAttribute("sellerRating") %></div>  
    <div class="attribute><label>Description: </label><span><%= request.getAttribute("description") %></div>
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