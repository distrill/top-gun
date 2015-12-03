<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="head.jsp" %>
</head>
<body>
    <!-- temp hard code header to prevent redirect loop -->
    <H1 align="center">TOP GUN</H1>
    <h5 align="center"><a href="logout.jsp">log out</a></h5>
    <hr>
    <%-- <%@ include file="header.jsp" %> --%>

<h2>login:</h2>

<form method="get" action="passing/verifyLogin.jsp">
    <input type="text" name="email" placeholder="email"><br>
    <input type="text" name="password" placeholder="password"><br>
    <input type="submit" value="login">
</form>

<%

%>
</body>
</html>
