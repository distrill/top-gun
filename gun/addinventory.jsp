<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>  <%@ include file="head.jsp" %></head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Add inventory for new Products</title>

<body>
	<%@ include file="header.jsp" %>
    <%@ include file="isAdmin.jsp" %>
    <%
    if(request.getParameter("success") != null){
    	if(request.getParameter("success").equals("true"))
	    	{
	    		out.println("<font size=3 color=green>Gun added.</font>");
	   	 	}
	}
    %>
    
    <form method = "post" action = "postInventory.jsp">
	Product Id:<br>
	<select name = "productId">
	<% 
	try{
		getConnection();
	 	Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery("SELECT pid,name FROM GunProduct");
	        while (rst.next())
			out.println("<option value="+rst.getString(1)+" >"+rst.getString(2)+"</option>");
	}
	catch (SQLException ex)
	{       out.println(ex);
	}
	%>
	</select><br>
	Serial Number:<br>
	<input type="text" name="gunId" placeholder="enter gun id"><br>
	<input type="submit" value="Submit">
</form>
</body>
</html>