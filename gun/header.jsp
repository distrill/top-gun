<H1 align="center">TOP GUN</H1>
<h5 align="center"><a href="logout.jsp">log out</a></h5>
<hr>
<%
    String verified = (String)session.getAttribute("verified");
    if (verified == null || verified != "true" ) {
        response.sendRedirect("login.jsp");
    }
%>
