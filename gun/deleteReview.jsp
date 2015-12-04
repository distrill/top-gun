<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<%

ResultSet currUser = (ResultSet) session.getAttribute("user");
String pid = request.getParameter("id");
// String cid = currUser.getString("cid");
String cid = (String)session.getAttribute("custId");
String deleteReview = "Delete From GunReview Where cid="+cid+" and pid="+pid;



try
{
	getConnection();
	Statement delete = con.createStatement();
	delete.executeUpdate(deleteReview);
	closeConnection();
}

catch (SQLException ex) {
	out.println(ex);
}
response.sendRedirect("gunproduct.jsp?id="+pid);
%>
