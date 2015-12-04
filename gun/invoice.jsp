<%@ page import="java.sql.*" %>
<%-- <%@ page import="java.util.HashMap" %> --%>
<%@ page import="java.text.NumberFormat" %>
<%-- <%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%> --%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.jsp" %>
</head>
<body>
    <%@ include file="header.jsp" %>

    <h1>Invoice</h1>
    <%
        int orderId = Integer.parseInt(request.getParameter("oid"));
        double total = Double.parseDouble(request.getParameter("total"));
        String name;
        String address;
        String date;
        // if (orderId == null) {
        //     response.sendRedirect("");
        // }

        // check if they are admin or just a customer
        int isAdmin = (Integer)session.getAttribute("isAdmin");
        if (isAdmin == 0) {
            // if they are customer, check that the order id belongs to them
            // if they are admin it doesn't matter.
        }

        // get connection from jdbc
        getConnection();

        // get sql
        String invoiceSql =
            "SELECT O.orderDate, O.price as total, C.name as cname, C.address, S.gid, S.pid, P.price as gprice, P.name as pname " +
            "FROM GunOrder O, GunCustomer C, GunShipped S, GunProduct P " +
            "WHERE O.cid = C.cid and S.oid = O.oid and S.pid = P.pid and O.oid = ?";
        PreparedStatement ps1 = con.prepareStatement(invoiceSql);
        ps1.setInt(1, orderId);

        ResultSet rs1 = ps1.executeQuery();

        // if what we want even exists then
        if (rs1.next()) {
            // out.print(rs1.getMetaData().getColumnName(1) + "<br>");
            // out.print(rs1.getMetaData().getColumnName(2) + "<br>");
            // out.print(rs1.getMetaData().getColumnName(3) + "<br>");
            // out.print(rs1.getMetaData().getColumnName(4) + "<br>");
            // out.print(rs1.getMetaData().getColumnName(5) + "<br>");
            // out.print(rs1.getMetaData().getColumnName(6) + "<br>");
            // out.print(rs1.getMetaData().getColumnName(7) + "<br>");
            // out.print(rs1.getMetaData().getColumnName(8) + "<br>");
            // name = rs1.getString("cname");
            // address = rs1.getString("address");
            // date = rs1.getDate("orderDate");
            out.print("<h2>for " + rs1.getString("cname") + "</h2>");
            out.print("<h4> on " + rs1.getDate("orderDate") + "</h4>");
            out.print("<h3>" + rs1.getString("address") + "</h3>");

            // out.print("<h2>gun: " + rs1.getString("pname") + "</h2>");
            out.print("<table><tr><th>gun</th><th>price</th><th>gun SN</th></tr>");
            do {
                out.print("<tr>");
                out.print("<td>" + rs1.getString("pname") + "</td>");
                out.print("<td>" + rs1.getDouble("gprice") + "</td>");
                out.print("<td>" + rs1.getInt("gid") + "</td>");
                out.print("</tr>");
            } while (rs1.next());
            out.print("</table>");
            out.print("total: " + total + "<br><br>");
        } else {
            out.print("System changed recently and old invoices are hard to find. Please call customer support to get more information about your past orders.");
        }
        // out.print("Shipping:")
        // out.print("<h4>" + name ",</h4>");
        // out.print("<h4>" + address + "</h4>");
    %>
</body>
