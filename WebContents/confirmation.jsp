<html>
  <head>
  </head>
  <body>
    <% if( request.getAttribute("error") != null ) { %>
      <span><%= request.getAttribute("error") %></span>
    <% } else { %>
      <span>Yay HTTPS!</span>
    <% } %>
  </body>
</html>