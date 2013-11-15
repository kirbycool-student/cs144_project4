<html>
  <head>
  </head>
  <body>
    <h1>Search Results For "<%= request.getAttribute("query") %>"</h1>
    <h2>Search: </h2><br/>
    <form target='eBay/search' method='GET'>
      <label>Query: </label><input type='text' name='q' />
      <input type='hidden' name='numResultsToSkip' value='<%= request.getAttribute("numResultsToSkip") %>'/>
      <input type='hidden' name='numResultsToReturn' value='<%= request.getAttribute("numResultsToSkip" %>' />
      <input type='submit' value='Submit' />
    </form>
    <table>
      <tr>
        <th>ItemId</th>
        <th>Name</th>
      </tr>
      <% for( SearchResult r : request.getAttribute("results") ) { %>
      <tr>
        <td><a href='eBay/item?id=<%= r.itemId %>'><%= r.itemId %></a></td>
        <td><%= r.name %></td>
      </tr>
      <% } %>
    </table>
  </body>
</html>
