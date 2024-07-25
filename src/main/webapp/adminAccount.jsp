<%@ page import="entities.User" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 25.07.2024
  Time: 12:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin account</title>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
%>
<h1>
    Welcome, <%= user.getName() %>!
</h1>
<p>
<form action="logout-servlet">
    <input type="submit" value="Logout"/>
</form>
</p>

</body>
</html>
