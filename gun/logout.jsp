<%
    session.setAttribute("verified", "false");
    session.setAttribute("custId", null);
    session.setAttribute("custName", null);
    session.setAttribute("custAddress", null);
    session.setAttribute("custProvince", null);
    session.invalidate();
%>
<jsp:forward page="login.jsp" />
