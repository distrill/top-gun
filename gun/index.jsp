<html>
<head>
<title>TOP GUN</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<html>
<body>
<%
    String  verified = (String)session.getAttribute("verified");
    // int custId = (Integer)session.getAttribute("custId");
    if ( verified != null && verified.equals("true")) {
        // out.println("verified<br>" + custId);
        response.sendRedirect("shop.html");
    } else {
        out.print(
            "<h2>login:</h2>" +
            "<form method=\"get\" action=\"verifyLogin.jsp\">" +
                "<input type=\"text\" name=\"email\" placeholder=\"email\"><br>" +
                "<input type=\"text\" name=\"password\" placeholder=\"password\"><br>" +
                "<input type=\"submit\" value=\"login\">" +
            "</form>"
        );
    }
%>
</body>
</html>
