<%@ page import="edu.ucla.cs.cs144.SearchResult" %>

<html>
  <head>
  </head>
  <body>
    <h1>Item For "<%= request.getParameter("itemId") %>"</h1>
    <table>
      <tr>
        <th>ItemId</th>
        <th>Name</th>
      </tr>
      <%
      SearchResult[] searchResults = (SearchResult[])  request.getAttribute("results");
      for( SearchResult r : searchResults ) {
      %>
      <tr>
        <td><a href='item?id=<%= r.getItemId() %>'><%= r.getItemId() %></a></td>
        <td><%= r.getName() %></td>
      </tr>
      <% } %>
    </table>
  </body>
</html>