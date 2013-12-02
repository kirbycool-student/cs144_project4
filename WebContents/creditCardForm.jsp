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
  	<% if( request.getAttribute("error") != null ) { %>
      <span><%= request.getAttribute("error") %></span>
    <% } else { %>
      <h2>Please Enter Payment Information</h2>
      <div class="attribute"><label>Item Id: </label><span><%= session.getAttribute("id") %></span></div>
      <div class="attribute"><label>Item Name: </label><span><%= session.getAttribute("name") %></span></div>
      <div class="attribute"><label>Buy Price: </label><span><%= session.getAttribute("buyPrice") %></span></div>
      <form action='https://<%= request.getServerName()%>:8443<%= request.getContextPath() %>/transaction' method='POST' >
        <label>Credit Card Number: </label><input type='text' name='creditCardNumber' />
        <input type='submit' value='Submit' />
      </form>
    <% } %>
  </body>
</html>