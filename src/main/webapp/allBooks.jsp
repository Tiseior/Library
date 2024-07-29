<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="config.Config" %>
<%@ page import="entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Zakladok.net</title>
</head>
<body>
<% User user = (User) session.getAttribute("user"); %>
<h1>Books in library</h1>
<p>
    <form action="index.jsp">
        <input type="submit" value="Back to menu"/>
    </form>
</p>
<table border="1" style="text-align: center; width: 50%">
    <tr>
        <th style="width: 60%">Title</th>
        <th style="width: 30%">Author</th>
        <th style="width: 10%">Quantity</th>
        <th></th>
    </tr>
<%
    try {
        Statement statement = Config.getConnection().createStatement();
        ResultSet rs = statement.executeQuery(
                "SELECT book_id, title, name, quantity FROM books, authors WHERE books.author = authors.author_id ORDER BY book_id");
        while (rs.next()) {
            if(rs.getInt("quantity") > 0) {
                if(user != null && user.getAccess().equals("user"))
                    out.println("<form action=\"take-book\">");
                else
                    out.println("<form action=\"login\">");
                out.println("<tr>");
                out.println("<td>" + rs.getString("title") + "</td>");
                out.println("<td>" + rs.getString("name") + "</td>");
                out.println("<input type=\"hidden\" name=\"quantity\" value=\"" + rs.getInt("quantity") + "\">");
                out.println("<td>" + rs.getInt("quantity") + "</td>");
                out.println("<input type=\"hidden\" name=\"book_id\" value=\"" + rs.getInt("book_id") + "\">");
                if(user != null && user.getAccess().equals("admin"))
                    out.println("<td><input type=\"submit\" value=\"Take\" disabled>");
                else
                    out.println("<td><input type=\"submit\" value=\"Take\">");
                out.println("</form>");
                out.println("</tr>");
            }
        }
        statement.close();
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>
</table>
</body>
</html>
