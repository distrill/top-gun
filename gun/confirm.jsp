<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery Order Processing</title>
</head>
<body>

<%@ include file="header.jsp" %>

<%
String  verified = (String)session.getAttribute("verified");
if (verified.equals("true")) {
    // get things started
    @SuppressWarnings({"unchecked"})
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
    ArrayList product = new ArrayList();

    // get customer information from session
    int custId = (Integer)session.getAttribute("custId");
    String custName = (String)session.getAttribute("custName");
    String custAddress = (String)session.getAttribute("custAddress");
    String custProvince = (String)session.getAttribute("custProvince");

    if (productList == null) {
        out.println("<h1>Your shopping cart is empty!</h1>");
        out.println("Check out our <a href=\"listprod.jsp\">Sweet Guns</a> though.");
    } else {
        try {

            // get database connection
            getConnection();

            // list products from invoice (same as cart page)
            out.println("<H1>Confirm Order</H1>");
            out.println("<h3>Shipping To:</h3>");
            out.println("<h4>" + custName + " at<br>" + custAddress + ", " + custProvince + ".</h4>");
            out.print("<TABLE><TR><TH>Quantity</TH><TH>Product</TH>");
            out.println("<TH>Price</TH><TH>Subtotal</TH><TH></TH><TH></TH></TR>");

            int count = 0;
            double total =0;
            // iterate through all items in the shopping cart
            Iterator iterator = productList.entrySet().iterator();
            while (iterator.hasNext()) {
                count++;
                Map.Entry entry = (Map.Entry)(iterator.next());
                product = (ArrayList) entry.getValue();
                // read in values for that product ID
                // out.print("<TR><TD>"+product.get(0)+"</TD>");
                out.print("<tr><td>" + product.get(3) + "</td>");
                out.print("<td>" + product.get(1) + "</td>");

                // out.print("<TD ALIGN=CENTER><INPUT TYPE=\"text\" name=\"newqty"+count+"\" size=\"3\" value=\""
                // +product.get(3)+"\"></TD>");
                double pr = Double.parseDouble( (String) product.get(2));
                int qty = ( (Integer)product.get(3)).intValue();

                // print out values for that product from shopping cart
                out.print("<TD ALIGN=RIGHT>"+currFormat.format(pr)+"</TD>");
                out.print("<TD ALIGN=RIGHT>"+currFormat.format(pr*qty)+"</TD>");
                // allow the customer to delete items from their shopping cart by clicking here
                // out.println("<TD>&nbsp;&nbsp;&nbsp;&nbsp;<A HREF=\"showcart.jsp?delete="
                // +product.get(0)+"\">Remove Item from Cart</A></TD>");
                // // allow customer to change quantities for a product in their shopping cart
                // out.println("<TD>&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE=BUTTON OnClick=\"update("
                // +product.get(0)+", document.form1.newqty"+count+".value)\" VALUE=\"Update Quantity\">");
                out.println("</TR>");
                // keep a running total for all items ordered
                total = total +pr*qty;
            }
            // print out order total
            out.println("<TR><TD COLSPAN=4 ALIGN=RIGHT><B>Order Total</B></TD>"
            +"<TD ALIGN=RIGHT>"+currFormat.format(total)+"</TD></TR>");
            out.print("</TABLE>");
            out.print("<h2><a href=\"order.jsp?price=" + total);
            out.print("&province=" + custProvince);
            out.print("\">Confirm Purchase</a><h2>");
            out.print("<h2><a href=\"showcart.jsp\">Back to Cart</a></h2>");
        } catch (SQLException e) {
            out.print(e);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                out.println(e);
            }
        }
    }
} else {
    out.println("You must be logged in.<br>Please<a href=\"login.jsp\">log in</a>");
}

%>


</body>
</html>
<%-- // Get customer id
// String custId = request.getParameter("customerId");
// Get password
// String password = request.getParameter("password");
// Get shopping cart
// @SuppressWarnings({"unchecked"})
// HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// try {
//     	// if (custId == null || custId.equals(""))
//     	// 	out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
//     	// else
//         if (productList == null)
//     		out.println("<h1>Your shopping cart is empty!</h1>");
//     	else
//     	{
//     		// Check if customer id is a number
//     		int num=-1;
//     		try
//     		{
//     			num = Integer.parseInt(custId);
//     		}
//     		catch(Exception e)
//     		{
//     			out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
//     			return;
//     		}
//
//     		// Get database connection
//             getConnection();
//
//             String sql = "SELECT customerId, cname, password FROM Customer WHERE customerId = ?";
//
//        		con = DriverManager.getConnection(url, uid, pw);
//        		PreparedStatement pstmt = con.prepareStatement(sql);
//        		pstmt.setInt(1, num);
//        		ResultSet rst = pstmt.executeQuery();
//        		int orderId=0;
//        		String custName = "";
//
//        		if (!rst.next())
//        		{
//        			out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
//        		}
//        		else
//        		{
//        			custName = rst.getString(2);
//     			String dbpassword = rst.getString(3);
//
//     			// make sure the password on the database is the same as the one the user entered
//     			if (!dbpassword.equals(password))
//     			{
//     				out.println("The password you entered was not correct.  Please go back and try again.<br>");
//     				return;
//     			}
//
//        			// Enter order information into database
//        			sql = "INSERT INTO Orders (customerId, totalAmount) VALUES(?, 0);";
//
//        			// Retrieve auto-generated key for orderId
//        			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
//        			pstmt.setInt(1, num);
//        			pstmt.executeUpdate();
//        			ResultSet keys = pstmt.getGeneratedKeys();
//        			keys.next();
//        			orderId = keys.getInt(1);
//
//        			out.println("<h1>Your Order Summary</h1>");
//              	  	out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
//
//                	double total =0;
//                	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
//                	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
//
//                	while (iterator.hasNext())
//                	{
//                		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
//                        ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
//        				String productId = (String) product.get(0);
//                        out.print("<tr><td>"+productId+"</td>");
//                        out.print("<td>"+product.get(1)+"</td>");
//        				out.print("<td align=\"center\">"+product.get(3)+"</td>");
//                        String price = (String) product.get(2);
//                        double pr = Double.parseDouble(price);
//                        int qty = ( (Integer)product.get(3)).intValue();
//        				out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
//                       	out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
//                        out.println("</tr>");
//                        total = total +pr*qty;
//
//        				sql = "INSERT INTO OrderedProduct VALUES(?, ?, ?, ?)";
//        				pstmt = con.prepareStatement(sql);
//        				pstmt.setInt(1, orderId);
//        				pstmt.setInt(2, Integer.parseInt(productId));
//        				pstmt.setInt(3, qty);
//        				pstmt.setString(4, price);
//        				pstmt.executeUpdate();
//                	}
//                	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
//                               	+"<td aling=\"right\">"+currFormat.format(total)+"</td></tr>");
//                	out.println("</table>");
//
//        			// Update order total
//        			sql = "UPDATE Orders SET totalAmount=? WHERE orderId=?";
//        			pstmt = con.prepareStatement(sql);
//        			pstmt.setDouble(1, total);
//        			pstmt.setInt(2, orderId);
//        			pstmt.executeUpdate();
//
//        			out.println("<h1>Order completed.  Will be shipped soon...</h1>");
//        			out.println("<h1>Your order reference number is: "+orderId+"</h1>");
//        			out.println("<h1>Shipping to customer: "+custId+" Name: "+custName+"</h1>");
//
//        			// Clear session variables (cart)
//        			session.setAttribute("productList", null);
//        		}
//        	}
//     }
//     catch (SQLException ex)
//     { 	out.println(ex);
//     }
//     finally {
//     	try {
//     		if (con != null)
//     			con.close();
//     	}
//     	catch (SQLException ex) {
//             out.println(ex);
//     	}
//     }
// } --%>
