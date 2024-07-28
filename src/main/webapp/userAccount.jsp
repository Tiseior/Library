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
    <title>User account</title>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
%>
<h1>
    Hello, <%= user.getName() %>!
</h1>
<p>
<form action="index.jsp">
    <input type="submit" value="Back to menu"/>
</form>
</p>
<p>
<form action="logout-servlet">
    <input type="submit" value="Logout"/>
</form>
</p>
    <%
        try {
            Statement statement = Config.getConnection().createStatement();
            ResultSet rs = statement.executeQuery("SELECT count(*) FROM orders " +
                                        "WHERE user_id = " + user.getId() + ";");
            rs.next();
            if(rs.getInt("count") == 0)
                out.println("<h2>You don't have any orders yet!</h2>");
            else {
                rs = statement.executeQuery("SELECT order_id, concat(title, ', ', a.name) AS book, " +
                        "to_char(date, 'dd.mm.yyyy') AS date, to_char(date, 'hh24:mi') AS time, status\n" +
                        "FROM orders o INNER JOIN books b on o.book_id = b.book_id\n" +
                        "INNER JOIN authors a on b.author = a.author_id\n" +
                        "WHERE user_id = " + user.getId() + " ORDER BY order_id DESC;");
                out.println("<table border=\"1\" style=\"text-align: center; width: 50%\">");
                out.println("<tr>");
                out.println("<th style=\"width: 50%\">Book</th>");
                out.println("<th style=\"width: 15%\">Date</th>");
                out.println("<th style=\"width: 15%\">Time</th>");
                out.println("<th style=\"width: 10%\">Status</th>");
                out.println("<th style=\"width: 10%\">Return book</th>");
                out.println("</tr>");
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("book") + "</td>");
                    out.println("<td>" + rs.getString("date") + "</td>");
                    out.println("<td>" + rs.getString("time") + "</td>");
                    out.println("<td>" + rs.getString("status") + "</td>");
                    if(rs.getString("status").equals("Taken")) {
                        out.println("<form action=\"return-book-servlet\" method=\"post\">");
                        out.println("<input type=\"hidden\" name=\"order_id\" value=\"" + rs.getInt("order_id") + "\">");
                        out.println("<td><input type=\"submit\" value=\"Return\"/></td>");
                        out.println("</form>");
                    } else {
                        out.println("<td></td>");
                    }
                    out.println("</tr>");
                }
                out.println("</table>");
            }
            statement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    %>

</body>
</html>
