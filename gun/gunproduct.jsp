<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="head.jsp" %>
</head>
<body>

<%@ include file="header.jsp" %>

<%
if(request.getParameter("error") != null){
	if(request.getParameter("error").equals("noReview"))
    	{
    		out.println("<font size=3 color=red>You have to write a review to be able to delete one.</font>");
   	 	}
}
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String getProductInfo = "Select * From GunProduct Where pid ='"+request.getParameter("id")+"'";
String getStock = "Select * From GunGun where pid ='"+request.getParameter("id")+"'";
String getReviews = "Select * From GunReview,GunCustomer where Gunreview.cid = GunCustomer.cid and pid='"+request.getParameter("id")+"'";
String getImage = "Select * From GunImage where pid ='"+request.getParameter("id")+"'";
try
{
	getConnection();

	Statement stmt1 = con.createStatement();
	ResultSet productInfo = stmt1.executeQuery(getProductInfo);//Query to get the info on the product
	productInfo.next();

	Statement stmt2 = con.createStatement();
	ResultSet stock = stmt2.executeQuery(getStock); //Query to get all the serial numbers for the current product
	stock.next();

	Statement stmt3 = con.createStatement();
	ResultSet reviews= stmt3.executeQuery(getReviews); //Query to get all the review for the current product

	Statement stmt4 = con.createStatement();
	ResultSet images = stmt4.executeQuery(getImage);



	out.println("<title>" + productInfo.getString("name") + "</title>");
	out.println("<h1>" + productInfo.getString("name")+ "</h1>");
	if(images.next()){
		out.println("<img src=" + images.getString("url") + " alt=Gun style=width:600px;height:400px;>");
	}
	else{
		out.println("<h3>No image available for the product at this time</h3>");
	}

	out.println("<h3>Price : "+currFormat.format(productInfo.getDouble("price"))+"</h3>");
	if(productInfo.getInt("Quantity")>0){
		String str = URLEncoder.encode(productInfo.getString("name"),"UTF-8");
		out.println("<h3><a href = addcart.jsp?id="+request.getParameter("id")+"&name="+str+"&price="+productInfo.getDouble("price")+">Add to Cart</a></h3>");
	}
	else{
		out.println("<h3>This Product is out of stock. Please check back later.</h3>");
	}

	out.println("<h3><a href=review.jsp?id=" + request.getParameter("id") + ">Write a review for this product.</a></h3>");
	if(reviews.next()){
	out.println("<table border = 1><tr><th>Customer Name</th><th>Date</th><th>Rating</th><th>Review</th></tr>");
	out.println("<tr><td>"+reviews.getString("name")+"</td><td>"+reviews.getString("date")+"</td><td>"+ reviews.getInt("rating")+"</td><td>"+ reviews.getString("description")+"</td></tr>");
		while(reviews.next()){
			out.println("<tr><td>"+reviews.getString("name")+"</td><td>"+reviews.getString("date")+"</td><td>"+ reviews.getInt("rating")+"</td><td>"+ reviews.getString("description")+"</td></tr>");
		}
	}
	else{
		out.println("<h3>No reviews have been written for this product yet.</h3>");
	}




}
 catch (SQLException ex) {
	out.println(ex);
}


%>




</body>
</html>
