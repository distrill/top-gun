<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.jsp" %>
</head>
<html>
<body>

    <H1 align="center">TOP GUN</H1>
    <hr>
<%-- <%@ include file="header.jsp" %> --%>

<%
    String  verified = (String)session.getAttribute("verified");
    // int custId = (Integer)session.getAttribute("custId");
    if ( verified != null && verified.equals("true")) {
        // out.println("verified<br>" + custId);
        response.sendRedirect("listprod.jsp");
    } else {
        out.print(
            "<h2>login:</h2>" +
            "<form method=\"get\" action=\"verifyLogin.jsp\">" +
                "<input type=\"text\" name=\"email\" placeholder=\"email\"><br>" +
                "<input type=\"password\" name=\"password\" placeholder=\"password\"><br>" +
                "<input type=\"submit\" value=\"login\">" +
            "</form>"
        );
    }
%>
<%-- lander page do cool things here.<br>
for now just link to <a href="listprod.jsp">listprod.jsp</a>. --%>
</body>
</html>
