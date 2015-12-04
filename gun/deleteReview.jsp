<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<%
boolean error = false;
ResultSet currUser = (ResultSet) session.getAttribute("user");
String pid = request.getParameter("id");
Integer cid = (Integer)session.getAttribute("custId");

String deleteReview = "Delete From GunReview Where cid="+cid+" and pid="+pid;



try
{
	getConnection();
	Statement checkReview = con.createStatement();
	ResultSet check = checkReview.executeQuery("Select cid,pid from GunReview where cid="+cid+" and pid="+pid);
	if(!check.next()){
		error = true;
	}
	else {
	Statement delete = con.createStatement();
	delete.executeUpdate(deleteReview);
	}
	closeConnection();
}

catch (SQLException ex) {
	out.println(ex);
}
if(error)
	response.sendRedirect("gunproduct.jsp?id="+pid+"&error=noReview");
else	
	response.sendRedirect("gunproduct.jsp?id="+pid);

%>
