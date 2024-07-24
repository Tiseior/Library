<%@ page import="entities.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Zakladok.net</title>
</head>
<body>
<%
  User user = (User) session.getAttribute("user");
  String thisUser;
  if(user == null) {
    thisUser = "Guest";
  } else {
    thisUser = user.getName();
  }
%>
<h1>
  <%= thisUser %>, welcome to the library
  <br>
  Zakladok.net
</h1>
<br/>
<a href="all-books">All books</a>
<br>
<a href="register-of-books">Register of books</a>
<br>
<a href="login.jsp">Login</a>
</body>
</html>