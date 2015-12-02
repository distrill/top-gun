<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

String sql = "SELECT * FROM GunCustomer WHERE email = ?";

getConnection();

PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, email);

ResultSet rs = ps.executeQuery();

if (rs.next()) {
    String dbPassword = rs.getString("password");
    if (password.equals(dbPassword)) {
        session.setAttribute("verified", "true");
    } else {
        session.setAttribute("verified", "false");
    }
} else {
    session.setAttribute("verified", "false");
}
%>
<jsp:forward page="testing.jsp" />
