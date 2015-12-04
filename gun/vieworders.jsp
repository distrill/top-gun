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
    <%
        // get database connection
        getConnection();

        // check admin and alter sql if so
        String custString;
        int isAdmin = (Integer)session.getAttribute("isAdmin");
        int custId = (Integer)session.getAttribute("custId");
        if (isAdmin == 0) {
            customerString = "WHERE cid = ? ";
        } else {
            custString = "";
        }

        NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    %>

    <div class="orders">
        <%
            // get all orders
            String getOrdersSql = "SELECT * FROM GunOrder " + customerString + "ORDER BY oid DESC";
            PreparedStatement ps1 = con.prepareStatement(getOrdersSql);
            if (isAdmin == 0) {
                ps1.setInt(1, custId);
            }
            ResultSet rs1 = ps1.executeQuery();

            out.print("<table style=\"padding:5px;border:1px solid black;\">");
            out.print("<tr><th>Order Id</th><th>Order Date</th><th>Price</th>");
            if (isAdmin == 1) {
                out.print("<th>Customer Id</th>");
            }
            out.print("<th>Invoice</th></tr>");


            // iterate through result set
            while (rs1.next()) {
                int orderId = rs1.getInt("oid");
                double total = rs1.getDouble("price");
                // print general order info
                out.print("<tr><td>" + orderId + "</td>");
                out.print("<td>" + rs1.getDate("orderDate") + "</td>");
                out.print("<td>" + currFormat.format(total) + "</td>");
                if (isAdmin == 1) {
                    out.print("<td>" + rs1.getInt("cid") + "</td>");
                }
                out.print("<td><a href=\"invoice.jsp?oid=" + orderId + "&total=" + total + "\">Invoice</a></td></tr>");
            }

            out.print("</table>");

            // String getOrdersSql =
            //     "SELECT * " +
            //     "FROM GunOrder O, GunCustomer C, GunShipped S " +
            //     "WHERE O.cid = C.cid AND S.oid = O.oid";
        %>
    </div>


</body>
</html>
