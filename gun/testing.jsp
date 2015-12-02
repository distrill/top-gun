<html>
<body>
    <%
        String  verified = (String)session.getAttribute("verified");
        if (verified.equals("true")) {
            out.println("verified");
        } else {
            out.println("not verified");
        }
    %>
</body>
</html>
