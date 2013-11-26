<html>
  <head>
  </head>
  <body>
    <h2>Please Enter Payment Information</h2>
    <label>Item Id: </label><span><%= request.getAttribute("itemId") %></span>
    <form action='https://<%= request.getServerName()%>:8443<%= request.getContextPath() %>/transaction' method='POST' >
      <label>Credit Card Number: </label><input type='text' name='creditCardNumber' />
      <input type='submit' value='Submit' />
    </form>
  </body>
</html>