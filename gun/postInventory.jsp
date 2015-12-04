<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<%



String gid = request.getParameter("gunId");
String pid = request.getParameter("productId");

String sql = "Insert into GunGun Values(?,?)";



try
{
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,gid);
	pstmt.setString(2,pid);
	pstmt.executeUpdate();
	closeConnection();
}

catch (SQLException ex) {
	out.println(ex);
}
response.sendRedirect("addinventory.jsp?success=true");
%>
