package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.xml.sax.InputSource;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.w3c.dom.Text;
import java.io.*;
import java.text.*;
import java.util.*;

import java.io.PrintWriter;

public class ItemServlet extends HttpServlet implements Servlet {
       
    public ItemServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
      factory.setValidating(false);
      factory.setIgnoringElementContentWhitespace(true);
      DocumentBuilder builder = null;
      try {
        builder = factory.newDocumentBuilder();
      } catch (javax.xml.parsers.ParserConfigurationException e) {}
      
      Document doc = null;
      String xml = AuctionSearchClient.getXMLDataForItemId(request.getParameter("id"));
      InputSource inputSource = new InputSource(new StringReader(xml));
      try {
        doc = builder.parse(inputSource);
      } catch (org.xml.sax.SAXException e) {}

      Element item = doc.getDocumentElement();
      request.setAttribute("name", getElementTextByTagNameNR(item, "Name"));
      request.setAttribute("currently", getElementTextByTagNameNR(item, "Currently"));
      request.setAttribute("buyPrice", getElementTextByTagNameNR(item, "Buy_Price"));
      request.setAttribute("firstBid", getElementTextByTagNameNR(item, "First_Bid"));
      request.setAttribute("numberOfBids", getElementTextByTagNameNR(item, "Number_of_Bids"));
      request.setAttribute("location", getElementTextByTagNameNR(item, "Location"));
      request.setAttribute("country", getElementTextByTagNameNR(item, "Country"));
      request.setAttribute("started", getElementTextByTagNameNR(item, "Started"));
      request.setAttribute("ends", getElementTextByTagNameNR(item, "Ends"));
      request.setAttribute("description", getElementTextByTagNameNR(item, "Description"));

      Element seller = getElementByTagNameNR(item, "Seller");
      request.setAttribute("sellerId", (seller.getAttributeNode("UserID")).getValue());
      request.setAttribute("sellerRating", (seller.getAttributeNode("Rating")).getValue());

      Element [] nextCat = getElementsByTagNameNR(item, "Category");
      String [] cats = new String[nextCat.length];
      for(int i = 0; i < nextCat.length; i++)
      {
        cats[i] = getElementText(nextCat[i]);
      }
      request.setAttribute("categories", cats);

      Element [] nextBid = getElementsByTagNameNR(getElementByTagNameNR(item, "Bids"), "Bid");
      HashMap[] bids = new HashMap[nextBid.length];
      for(int i = 0; i < nextBid.length; i++)
      {
        bids[i] = new HashMap();
        bids[i].put("amount", getElementTextByTagNameNR(nextBid[i], "Amount"));
        bids[i].put("time", getElementTextByTagNameNR(nextBid[i], "Time"));
        Element bidder = getElementByTagNameNR(nextBid[i], "Bidder");
        bids[i].put("bidderId", (bidder.getAttributeNode("UserID")).getValue());
        bids[i].put("rating", (bidder.getAttributeNode("Rating")).getValue());
        bids[i].put("location", getElementTextByTagNameNR(bidder, "Location"));
        bids[i].put("country", getElementTextByTagNameNR(bidder, "Country"));
      }
      request.setAttribute("bids", bids);
      request.getRequestDispatcher("/item.jsp").forward(request, response);
/*
      int id = Integer.parseInt( request.getParameter("id"));
      PrintWriter out = response.getWriter();
      String xml = AuctionSearchClient.getXMLDataForItemId(request.getParameter("id"));
      out.println(xml);
/*
    	int skip = Integer.parseInt( request.getParameter("numResultsToSkip") );
    	int ret = Integer.parseInt( request.getParameter("numResultsToReturn") );
    	
    	SearchConstraint[] constraints = new SearchConstraint[1];
    	
        SearchConstraint c = new SearchConstraint();
        c.setFieldName("ItemId");
        c.setValue(request.getParameter("itemId"));
        
        constraints[0] = c;
        
        SearchResult[] results = AuctionSearchClient.advancedSearch(constraints, skip, ret);
        
        request.setAttribute("result", results.length == 1 ? results[0] : new SearchResult() );
    	request.getRequestDispatcher("/item.jsp").forward(request, response);
*/
        
    }

  /* Non-recursive (NR) version of Node.getElementsByTagName(...)
   */
  protected Element[] getElementsByTagNameNR(Element e, String tagName) {
      Vector< Element > elements = new Vector< Element >();
      Node child = e.getFirstChild();
      while (child != null) {
          if (child instanceof Element && child.getNodeName().equals(tagName))
          {
              elements.add( (Element)child );
          }
          child = child.getNextSibling();
      }
      Element[] result = new Element[elements.size()];
      elements.copyInto(result);
      return result;
  }

  /* Returns the first subelement of e matching the given tagName, or
   * null if one does not exist. NR means Non-Recursive.
   */
  protected Element getElementByTagNameNR(Element e, String tagName) {
      Node child = e.getFirstChild();
      while (child != null) {
          if (child instanceof Element && child.getNodeName().equals(tagName))
              return (Element) child;
          child = child.getNextSibling();
      }
      return null;
  }

  /* Returns the text associated with the given element (which must have
   * type #PCDATA) as child, or "" if it contains no text.
   */
  protected String getElementText(Element e) {
      if (e.getChildNodes().getLength() == 1) {
          Text elementText = (Text) e.getFirstChild();
          return elementText.getNodeValue();
      }
      else
          return "";
  }

  /* Returns the text (#PCDATA) associated with the first subelement X
   * of e with the given tagName. If no such X exists or X contains no
   * text, "" is returned. NR means Non-Recursive.
   */
  protected String getElementTextByTagNameNR(Element e, String tagName) {
      Element elem = getElementByTagNameNR(e, tagName);
      if (elem != null)
          return getElementText(elem);
      else
          return "";
  }

}



