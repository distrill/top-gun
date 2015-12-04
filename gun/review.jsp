<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Write a review</title>
<body>
<h3>Write your review here.</h3>
<p>If you have already written a review you may change it by resubmiting.</p>
<form method = "post" action = "postReview.jsp">
  <input type ="hidden" name = "id" value =<%out.println(request.getParameter("id"));%>>
  <select name = "score">
	  <option value = 1>1</option>
	  <option value = 2>2</option>
	  <option value = 3>3</option>
	  <option value = 4>4</option>
	  <option value = 5>5</option>
	</select>
	<h2>Comments:</h2>
	<textarea name="description" style="width:400px; height:100px;" >Enter review here...</textarea>
	<p></p>
	<input type="submit" value="Submit">
</form>
<h4>If you wish to delete your review click here</h4>
<form method = "post" action = "deleteReview.jsp">
	<input type ="hidden" name = "id" value =<%out.println(request.getParameter("id"));%>>
	<input type="submit" value="Delete">
</form>
</body>
</html>