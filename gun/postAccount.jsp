<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Random" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<%


Random rn = new Random();
String admin;
String name = request.getParameter("cname");
String province = request.getParameter("province");
String address = request.getParameter("address");
String tokenId = request.getParameter("tokenId");
String email = request.getParameter("email");
String password = request.getParameter("pw");
String confPassword = request.getParameter("confPw");
if(request.getParameter("admin") != null){
	admin = "1";
	}
else{
	admin = "0";
}
String classification = request.getParameter("classification");
if(!password.equals(confPassword)){
	response.sendRedirect("addcustomer.jsp?error=pw");
}

try
{
	
	getConnection();
	
	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery("Select wid From GunWarehouse Where province='"+province+"'");
	rst.next();
	if(province.equals("NT")){
		if(rn.nextInt(2) == 1){
			rst.next();
		}
	}
	int wid = rst.getInt("wid");
	
	Statement stmt2 = con.createStatement();
	ResultSet rst1 = stmt.executeQuery("Select max(cid) as max From GunCustomer");
	rst1.next();
	int cid = rst1.getInt("max")+1;

	String sql = "Insert into GunCustomer Values("+cid+",?,?,'"+province+"',?,?,?,"+wid+","+admin+")";
	String insertToken = "Insert into GunToken Values (?,'"+classification+"','2020-12-03')"; 
	PreparedStatement pstmt = con.prepareStatement(sql);
	PreparedStatement pstmt2 = con.prepareStatement(insertToken);
	pstmt2.setString(1,tokenId);
	pstmt.setString(1,name);
	pstmt.setString(2,address);
	pstmt.setString(3,tokenId);
	pstmt.setString(4,email);
	pstmt.setString(5,password);
	pstmt2.executeUpdate();
	pstmt.executeUpdate();
	closeConnection();
}

catch (SQLException ex) {
	out.println(ex);
}
response.sendRedirect("addcustomer.jsp?success=true");
%>
