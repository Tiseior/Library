<%@ page import="java.sql.Statement" %>
<%@ page import="config.Config" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 26.07.2024
  Time: 18:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Zakladok.net</title>
</head>
<body>
<h1>All users</h1>
<p>
    <form action="admin-account">
        <input type="submit" value="Back to account"/>
    </form>
</p>
<table border="1" style="text-align: center; width: 30%">
    <tr>
        <th>User id</th>
        <th>Email</th>
        <th>Name</th>
        <th>Access</th>
    </tr>
    <%
        try {
            Statement statement = Config.getConnection().createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM users");
            while(rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("user_id") + "</td>");
                out.println("<td>" + rs.getString("login") + "</td>");
                out.println("<td>" + rs.getString("name") + "</td>");
                out.println("<td>" + rs.getString("access") + "</td>");
                out.println("</tr>");
            }
            statement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    %>
</table>

</body>
</html>
