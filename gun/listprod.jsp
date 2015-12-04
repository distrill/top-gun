<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.jsp" %>
</head>
<body>

<%@ include file="header.jsp" %>

<h2>Browse Products By Category and Search by Product Name:</h2>

<form method="get" action="listprod.jsp">
  <p align="left">
  <select size="1" name="gunType">
  <option>All</option>

<%
/*
// Could create category list dynamically - more adaptable, but a little more costly
try
{
	getConnection();
 	ResultSet rst = executeQuery("SELECT DISTINCT categoryName FROM Product");
        while (rst.next())
		out.println("<option>"+rst.getString(1)+"</option>");
}
catch (SQLException ex)
{       out.println(ex);
}
*/
%>

  <option>Assault Rifle</option>
  <option>Handgun</option>
  <option>Shotgun</option>
  <option>Hunting Rifles</option>


  <input type="text" name="productName" size="50">
  </select><input type="submit" value="Submit"><input type="reset" value="Reset"></p>
</form>

<%
// Colors for different item categories
// HashMap colors = new HashMap();		// This may be done dynamically as well, a little tricky...
// colors.put("Beverages", "#0000FF");
// colors.put("Condiments", "#FF0000");
// colors.put("Confections", "#000000");
// colors.put("Dairy Products", "#6600CC");
// colors.put("Grains/Cereals", "#55A5B3");
// colors.put("Meat/Poultry", "#FF9900");
// colors.put("Produce", "#00CC00");
// colors.put("Seafood", "#FF66CC");
%>

<%
	// Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("gunType");


boolean hasNameParam = name != null && !name.equals("");
boolean hasCategoryParam = category != null && !category.equals("") && !category.equals("All");
String filter = "", sql = "";

  if (hasNameParam && hasCategoryParam)
 {
 	filter = "<h3>Products containing '"+name+"' in category: '"+category+"'</h3>";
 	name = '%'+name+'%';
 	sql = "SELECT * FROM GunProduct WHERE name LIKE ? AND category = ?";
 }
 else if (hasNameParam)
 {
 	filter = "<h3>Products containing '"+name+"'</h3>";
 	name = '%'+name+'%';
 	sql = "SELECT * FROM GunProduct WHERE name LIKE ?";
 }
 else if (hasCategoryParam)
 {
 	filter = "<h3>Products in category: '"+category+"'</h3>";
 	sql = "SELECT * FROM GunProduct WHERE category = ?";
 }
 else
 {
 	filter = "<h3>All Products</h3>";
 	sql = "SELECT * FROM GunProduct";
 }

out.println("All Gun Products");


//sql  = "SELECT * FROM GunProduct";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try
{
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	 if (hasNameParam)
	 {
	 	pstmt.setString(1, name);
	 	if (hasCategoryParam)
	 	{
	 		pstmt.setString(2, category);
	 	}
	 }
	 else if (hasCategoryParam)
	 {
	 	pstmt.setString(1, category);
	 }

	ResultSet rst = pstmt.executeQuery();

	out.println("<table border=1><tr><th>Product Name</th><th>Category</th><th>Price</th></tr>");
    while (rst.next()) {
    	out.print("<tr><td><a href=gunproduct.jsp?id="+ rst.getInt("pid") +">"
            +rst.getString("name")+"</a></td><td>"+ rst.getString("category")
            +"</td><td>"+currFormat.format(rst.getDouble("price"))+"</td><td>"
            +"<a href=\"addcart.jsp?id=" + rst.getInt("pid") + "&name=" + rst.getString("name")
        	+"&price=" + rst.getDouble("price") + "\">Add to Cart</a></td></tr>");
    	// out.println("<tr><td><a href=gunproduct.jsp?id="+ rst.getInt("pid") +">"+rst.getString("name")+"</a></td><td>"+ rst.getString("category")+"</td><td>"+currFormat.format(rst.getDouble("price"))+"</td></tr>");
    }

	// out.print("<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th class=\"col-md-1\"></th><th>Product Name</th>");
	// out.println("<th>Category</th><th>Price</th></tr>");
	// while (rst.next())
	// {
	// 	out.print("<td class=\"col-md-1\"><a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
	// 			+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a></td>");
    //
	// 	String itemCategory = rst.getString(4);
	// 	String color = (String) colors.get(itemCategory);
	// 	if (color == null)
	// 		color = "#FFFFFF";
    //
	// 	out.println("<td><font color=\"" + color + "\">" + rst.getString(2) + "</font></td>"
	// 			+ "<td><font color=\"" + color + "\">" + itemCategory + "</font></td>"
	// 			+ "<td><font color=\"" + color + "\">" + currFormat.format(rst.getDouble(3))
	// 			+ "</font></td></tr>");
	// }
	// out.println("</table></font>");
	closeConnection();
} catch (SQLException ex) {
	out.println(ex);
}
%>

</body>
</html>
