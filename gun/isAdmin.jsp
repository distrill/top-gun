<%
    int isAdmin = (Integer)session.getAttribute("isAdmin");
    if (isAdmin == 0) {
        response.sendRedirect("index.jsp");
    }
%>
