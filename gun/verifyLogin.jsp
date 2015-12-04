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

int isAdmin = 0;
if (rs.next()) {
    String dbPassword = rs.getString("password");
    int custId = rs.getInt("cid");
    String custName = rs.getString("name");
    String custAddress = rs.getString("address");
    String custProvince = rs.getString("province");
    int custWarehouse = rs.getInt("warehouse");
    isAdmin = rs.getInt("admin");
    if (password.equals(dbPassword)) {
        session.setAttribute("verified", "true");
        session.setAttribute("custId", custId);
        session.setAttribute("custName", custName);
        session.setAttribute("custAddress", custAddress);
        session.setAttribute("custProvince", custProvince);
        session.setAttribute("custWarehouse", custWarehouse);
        session.setAttribute("isAdmin", isAdmin);
    } else {
        session.setAttribute("verified", "false");
    }
} else {
    session.setAttribute("verified", "false");
}
if (isAdmin == 0) {
    response.sendRedirect("listprod.jsp");
} else {
    response.sendRedirect("admin.jsp");
}
%>
<%-- <jsp:forward page="listprod.jsp" /> --%>
