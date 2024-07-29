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
<%
  if(user == null)
    out.println("<a href=\"login\">Login</a>");
  else if(user.getAccess().equals("admin"))
    out.println("<a href=\"admin-account\">Admin account</a>");
  else if(user.getAccess().equals("user"))
    out.println("<a href=\"user-account\">My account</a>");
%>
</body>
</html>