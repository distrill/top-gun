<H1 align="center">TOP GUN</H1>
<%
    String verified = (String)session.getAttribute("verified");
    if (verified == null || verified != "true" ) {
        response.sendRedirect("login.jsp");
    } else {
        int isAdmin = (Integer)session.getAttribute("isAdmin");
        if (isAdmin == 1) {
            out.print("<h5 align=\"center\"><a href=\"admin.jsp\">admin</a></h5>");
        } else {
            out.print("<h5 align=\"center\"><a href=\"vieworders.jsp\">my orders</a></h5>");
        }
    }
%>
<h5 align="center"><a href="logout.jsp">log out</a></h5>
<hr>
