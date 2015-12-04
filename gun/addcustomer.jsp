<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><%@ include file="head.jsp" %></head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create an Account</title>

<body>
	<%@ include file="header.jsp" %>
    <%@ include file="isAdmin.jsp" %>
    <%
    if(request.getParameter("success") != null){
    	if(request.getParameter("success").equals("true"))
	    	{
	    		out.println("<font size=3 color=green>Account created.</font>");
	   	 	}
	}
	if(request.getParameter("error") != null){
    	if(request.getParameter("error").equals("pw"))
	    	{
	    		out.println("<font size=3 color=red>Passwords did not match please try again.</font>");
	   	 	}
	}
    %>
    <form method = "post" action = "postAccount.jsp">
	<input type="text" name="cname" placeholder="Name" required><br>
	<select name = "province" required>
	  <option></option>
	  <option value = "AB">Alberta</option>
	  <option value = "BC">British Coloumbia</option>
	  <option value = "MB">Manitoba</option>
	  <option value = "NB">New Brunswick</option>
	  <option value = "NL">Newfoundland</option>
	  <option value = "NS">Nova Scotia</option>
	  <option value = "ON">Ontario</option>
	  <option value = "PE">Prince Edward Island</option>
	  <option value = "QC">Qubec</option>
	  <option value = "SK">Saskatchewon</option>
	  <option value = "NT">Northwest Territories</option>
	  <option value = "NU">Nunavut</option>
	  <option value = "YT">Yukon</option>
	</select><br>
	<input type="text" name="address" placeholder="Address" required><br>
	<input type="text" name="tokenId" placeholder="Gun Id Number" ><br>
	<input type="date" name="tokenExp" placeholder="Format YYYY-MM-DD" ><br>
	<select name = "classification" >
	  <option></option>
	  <option value = "Unrestricted">Unrestricted</option>
	  <option value = "Restriceted">Restriceted</option>
	  <option value = "Prohibited">Prohibited</option>
	</select><br>
	<input type="email" name="email" placeholder="email" required><br>
	<input type="password" name="pw" placeholder="Password" required><br>
	<input type="password" name="confPw" placeholder="Confirm Password" required><br>
	Admin:	<input type="checkbox"  id = "admin" name="admin" value="1"><br>
	<input type="submit" value="Submit">
</form>
</body>
</html>