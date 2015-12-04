<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<% 

ResultSet currUser = (ResultSet) session.getAttribute("user");

String sql;
String rating = request.getParameter("score");
String description = request.getParameter("description");
String pid = request.getParameter("id");
String cid = currUser.getString("cid");

Date date = new Date();
DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
String today = dateFormat.format(date);
String checkReview = "Select cid,pid From GunReview Where cid="+cid+" and pid="+pid;



try
{
	getConnection();
	Statement check = con.createStatement();
	ResultSet oldReview = check.executeQuery(checkReview);
	if(oldReview.next()){
		sql = "Update GunReview Set description = ?, rating = ? Where cid ="+cid+" and pid ="+pid;
	}
	else{
		sql = "INSERT INTO GunReview VALUES("+cid+","+pid+",'"+today+"',?,?)";
	}
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,description);
	pstmt.setString(2,rating);
	pstmt.executeUpdate();
	closeConnection();
} 

catch (SQLException ex) {
	out.println(ex);
}
response.sendRedirect("gunproduct.jsp?id="+pid);
%>
