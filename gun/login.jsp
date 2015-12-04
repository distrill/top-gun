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
    <hr>
    <%-- <%@ include file="header.jsp" %> --%>

<h2>login:</h2>

<form method="get" action="verifyLogin.jsp">
    <input type="text" name="email" placeholder="email"><br>
    <input type="password" name="password" placeholder="password"><br>
    <input type="submit" value="login">
</form>

<%

%>
</body>
</html>
