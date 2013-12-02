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
      <h2>Purchase Completed!</h2>
      <div class="attribute"><label>Item Id: </label><span><%= session.getAttribute("id") %></span></div>
      <div class="attribute"><label>Item Name: </label><span><%= session.getAttribute("name") %></span></div>
      <div class="attribute"><label>Buy Price: </label><span><%= session.getAttribute("buyPrice") %></span></div>
      <div class="attribute"><label>Credit Card Number: </label><%= request.getParameter("creditCardNumber") %></span></div>
      <div class="attribute"><label>Time: </label><%= request.getAttribute("time") %></span></div>
    <% } %>
  </body>
</html>