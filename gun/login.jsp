<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>TOP GUN</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<h2>login:</h2>

<form method="get" action="verifyLogin.jsp">
    <input type="text" name="email" placeholder="email"><br>
    <input type="text" name="password" placeholder="password"><br>
    <input type="submit" value="login">
</form>

<%

%>
</body>
</html>
