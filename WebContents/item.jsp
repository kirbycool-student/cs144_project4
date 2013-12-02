<%@ page import="edu.ucla.cs.cs144.SearchResult" %>
<%@ page import="java.util.HashMap" %>

<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" /> 
    <style type="text/css"> 
      html { height: 100% } 
      body { height: 100%; margin: 0px; padding: 0px } 
      #map_canvas { height: 100% } 
    </style> 
    <script type="text/javascript" 
        src="http://maps.google.com/maps/api/js?sensor=false"> 
    </script> 
    <script type="text/javascript"> 
      var geocoder;
      var map;
      function initialize() { 
        geocoder = new google.maps.Geocoder();
        var loc = '${location} ${country}';
        geocoder.geocode( {address: loc}, function(results, status) {
          if(status == google.maps.GeocoderStatus.OK) {
            var latlng = results[0].geometry.location;
            var myOptions = { 
              zoom: 4, // default is 8  
              center: latlng, 
              mapTypeId: google.maps.MapTypeId.ROADMAP 
            };
            map = new google.maps.Map(document.getElementById("map_canvas"),
              myOptions); 
            var marker = new google.maps.Marker({
              map: map,
              position: results[0].geometry.location
            });
          }
        });
      } 
      google.maps.event.addDomListener(window, 'load', initialize);
    
    </script> 
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
    <% if( request.getAttribute("buyPrice") != "" ) { %>
      <form action='https://<%= request.getServerName()%>:8443<%= request.getContextPath() %>/creditCard' method=GET />
       <input type='submit' value='Pay Now' />
      </form>
    <% } %>
    <div class="attribute"><label>Name: </label><span><%= request.getAttribute("name") %></span></div>
    <div class="attribute"><label>Currently: </label><span><%= request.getAttribute("currently") %></span></div>
    <div class="attribute"><label>Buy Price: </label><span><%= request.getAttribute("buyPrice") %></span></div>
    <div class="attribute"><label>First Bid: </label><span><%= request.getAttribute("firstBid") %></span></div>
    <div class="attribute"><label>Number of Bids: </label><span><%= request.getAttribute("numberOfBids") %></span></div>
    <div class="attribute"><label>Location: </label><span="location"><%= request.getAttribute("location") %></span></div>
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
    <div id="map_canvas" style="width:400; height:400"></div>
  </body>
</html>
