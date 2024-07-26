<%@ page import="entities.User" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="config.Config" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
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
<table>
    <tr>
        <td>
            <form action="index.jsp">
                <input type="submit" value="Back to menu"/>
            </form>
        </td>
        <td>
            <form action="all-users">
                <input type="submit" value="All users"/>
            </form>
        </td>
        <td>
            <form action="register-of-books">
                <input type="submit" value="Register of books"/>
            </form>
        </td>
        <td>
            <form action="logout-servlet">
                <input type="submit" value="Logout"/>
            </form>
        </td>
    </tr>
</table>
<h1>All orders</h1>
<table border="1" style="text-align: center; width: 80%">
    <tr>
        <th rowspan="2" style="width: 5%">Order id</th>
        <th colspan="2" style="width: 25%">User info</th>
        <th colspan="2" style="width: 45%">Book info</th>
        <th colspan="2" style="width: 25%">Date and time</th>
    </tr>
    <tr>
        <th style="width: 5%">Id</th>
        <th style="width: 20%">Email</th>
        <th style="width: 5%">Id</th>
        <th style="width: 40%">Title, author</th>
        <th style="width: 13%">Date</th>
        <th style="width: 12%">Time</th>
    </tr>
        <%
            try {
                Statement statement = Config.getConnection().createStatement();
                StringBuilder state = new StringBuilder();
                state.append("SELECT order_id, u.user_id, login, b.book_id, CONCAT(title, ', ', a.name) AS book,\n");
                state.append("to_char(date, 'dd.mm.yyyy') AS ordDate, to_char(date, 'hh24:mi') AS ordTIme\n");
                state.append("FROM orders o INNER JOIN users u on o.user_id = u.user_id\n");
                state.append("INNER JOIN books b on b.book_id = o.book_id\n");
                state.append("INNER JOIN authors a on a.author_id = b.author\n");
                state.append("ORDER BY order_id DESC;");
                ResultSet rs = statement.executeQuery(state.toString());
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("order_id") + "</td>");
                    out.println("<td>" + rs.getString("user_id") + "</td>");
                    out.println("<td>" + rs.getString("login") + "</td>");
                    out.println("<td>" + rs.getString("book_id") + "</td>");
                    out.println("<td>" + rs.getString("book") + "</td>");
                    out.println("<td>" + rs.getString("ordDate") + "</td>");
                    out.println("<td>" + rs.getString("ordTime") + "</td>");
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
