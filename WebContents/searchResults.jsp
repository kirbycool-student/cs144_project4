<%@ page import="edu.ucla.cs.cs144.SearchResult" %>

<html>
  <head>
    <script type="text/javascript" src="js/autosuggest.js"></script>
    <link rel="stylesheet" type="text/css" href="css/page.css" />        
    <script type="text/javascript">
      window.onload = function () {
        var oTextbox = new AutoSuggestControl(document.getElementById("queryBox"), new SuggestionProvider());        
      }
    </script>
  </head>
  <body>
    <h1>Search Results For "<%= request.getParameter("q") %>"</h1>
    <h2>Search: </h2><br/>
    <form action='search' method='GET'>
      <label>Query: </label><input id='queryBox' type='text' name='q' />
      <input type='hidden' name='numResultsToSkip' value='<%= request.getParameter("numResultsToSkip") %>'/>
      <input type='hidden' name='numResultsToReturn' value='<%= request.getParameter("numResultsToReturn") %>' />
      <input type='submit' value='Submit' />
    </form>
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
