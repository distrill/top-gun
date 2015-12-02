<html>
<body>
    <%
        String  verified = (String)session.getAttribute("verified");
        int custId = (Integer)session.getAttribute("custId");
        if (verified.equals("true")) {
            out.println("verified<br>" + custId);
        } else {
            out.println("You must be logged in.<br>Please<a href=\"login.jsp\">log in</a>");
        }
    %>
</body>
</html>
