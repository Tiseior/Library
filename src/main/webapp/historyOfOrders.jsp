<%@ page import="entities.User" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="config.Config" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 29.07.2024
  Time: 16:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User history</title>
</head>
<body>
<p>
<form action="user-account">
  <input type="submit" value="Back to account"/>
</form>
</p>
<%
  User user = (User) session.getAttribute("user");
%>
<h1>History of orders</h1>
  <%
    try {
      Statement statement = Config.getConnection().createStatement();
      ResultSet rs = statement.executeQuery("SELECT count(*) FROM orders " +
              "WHERE user_id = " + user.getId() + ";");
      rs.next();
      if(rs.getInt("count") == 0)
        out.println("<h2>You haven't made any orders yet!</h2>");
      else {
        rs = statement.executeQuery("SELECT order_id, concat(title, ', ', a.name) AS book, " +
                "to_char(date, 'dd.mm.yyyy') AS date, to_char(date, 'hh24:mi') AS time, status, order_link\n" +
                "FROM orders o INNER JOIN books b on o.book_id = b.book_id\n" +
                "INNER JOIN authors a on b.author = a.author_id\n" +
                "WHERE user_id = " + user.getId() + " AND status = 'Taken' ORDER BY order_id DESC;");
        out.println("<table border=\"1\" style=\"text-align: center; width: 30%\">");
        out.println("<tr>");
        out.println("<th style=\"width: 60%\">Book</th>");
        out.println("<th style=\"width: 20%\">Taken</th>");
        out.println("<th style=\"width: 20%\">Returned</th>");
        out.println("</tr>");
        while (rs.next()) {
          out.println("<tr>");
          out.println("<td>" + rs.getString("book") + "</td>");
          out.println("<td>" + rs.getString("date") + "<br>" + rs.getString("time") + "</td>");
          if(rs.getInt("order_link") != 0) {
            Statement stReturn = Config.getConnection().createStatement();
            ResultSet rsReturn = stReturn.executeQuery("SELECT to_char(date, 'dd.mm.yyyy') AS date, " +
                    "to_char(date, 'hh24:mi') AS time FROM orders " +
                    "WHERE order_id = " + rs.getInt("order_link") + " AND status = 'Returned';");
            rsReturn.next();
            out.println("<td>" + rsReturn.getString("date") + "<br>" + rsReturn.getString("time") + "</td>");
            stReturn.close();
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
