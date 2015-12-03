<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="head.jsp" %>
</head>
<body>

<%@ include file="header.jsp" %>

<%
// String verified = (String)session.getAttribute("verified");
// if (verified.equals("true")) {

    // TODO: we need to include better inventory management


    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
    ArrayList product = new ArrayList();

    // get db connection
    getConnection();

    // get/set order id (this is not the proper way to do it. oh well.) and date
    int orderId;
    String getOrderIdSql = "SELECT MAX(oid) as oid FROM GunOrder";
    PreparedStatement ps1 = con.prepareStatement(getOrderIdSql);
    ResultSet rs1 = ps1.executeQuery();
    if(rs1.next()) {
        orderId = rs1.getInt("oid") + 1;
    } else {
        orderId = 1;
    }


    // get necessary order stuffs
    java.sql.Date orderDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
    double orderPrice = Double.parseDouble(request.getParameter("price"));
    int wid = (Integer)session.getAttribute("custWarehouse");
    int cid = (Integer)session.getAttribute("custId");

    // SQL to make new order
    String newOrderSql =
        "INSERT INTO GunOrder " +
        "VALUES (?, ?, ?, ?, ?)";

    // prepare the shit outta that statement
    PreparedStatement ps2 = con.prepareStatement(newOrderSql);
    ps2.setInt(1, orderId);
    ps2.setDate(2, orderDate);
    ps2.setDouble(3, orderPrice);
    ps2.setInt(4, wid);
    ps2.setInt(5, cid);

    // execute the shit outta that statement
    ps2.executeUpdate();


    // prepare statement for getting available gunIds
    String getGunIdSql =
        "SELECT MIN(gid) as gunId " +
        "FROM GunGun " +
        "WHERE pid = ?";
    PreparedStatement ps3 = con.prepareStatement(getGunIdSql);

   // prepare a statement for inserting new shippedGuns
    String newShippedGunSql =
        "INSERT INTO GunShipped " +
        "VALUES (?, ?)";
    PreparedStatement ps4 = con.prepareStatement(newShippedGunSql);
    ps4.setInt(1, orderId);

    // prepare a statement to remove gun from GunGun once it is shipped
    String delGunSql =
        "DELETE FROM GunGun " +
        "WHERE gid = ?";
    PreparedStatement ps5 = con.prepareStatement(delGunSql);

    // iterate through the productList and make a shippedGun for each product
	Iterator iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) {
        // get gunId from GunGun table
        int gid;
        Map.Entry entry = (Map.Entry)(iterator.next());
        product = (ArrayList) entry.getValue();
        ps3.setInt(1, Integer.parseInt(product.get(0).toString()));
        ResultSet rs3 = ps3.executeQuery();
        if (rs3.next()) {
           gid = rs3.getInt("gunId");
        } else {
            // something went wrong. TODO: handle this
            gid=0;
        }

        // insert new GunShipped
        ps4.setInt(2, gid);
        ps4.executeUpdate();

        // delete shipped gun from GunGun
        ps5.setInt(1, gid);
        ps5.executeUpdate();
    }

    out.print("<h4 align=\"center\">Thank you for  shopping with</h4><br><h2 align=\"center\">TOP GUN</h2>");
// } else {
//     out.print("You must be <a href=\"login\">logged in</a>");
// }
session.setAttribute("productList", null);
%>

</body>
</html>
