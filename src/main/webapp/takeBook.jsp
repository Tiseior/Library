<%@ page import="java.sql.Statement" %>
<%@ page import="config.Config" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Zakladok.net</title>
</head>
<body>
<h1>Take this book?</h1>
<form id="take" method="post">
    <table style="text-align: center; width: 20%">
    <%
        try {
            Statement statement = Config.getConnection().createStatement();
            ResultSet rs = statement.executeQuery(
                    "SELECT book_id, title, name, quantity FROM books, authors " +
                            "WHERE books.author = authors.author_id AND book_id = " + request.getParameter("book_id") + ";");
            rs.next();
            out.println("<th style=\"text-align: right; width: 30%\">Title: </td>" +
                    "<td style=\"text-align: left; width: 70%\">" + rs.getString("title") + "</td>");
            out.println("</tr>");
            out.println("<tr>");
            out.println("<th style=\"text-align: right\">Author: </td>" +
                    "<td style=\"text-align: left\">" + rs.getString("name") + "</td>");
            out.println("<input type=\"hidden\" name=\"book_id\" value=\"" + rs.getInt("book_id") + "\">");
            out.println("<input type=\"hidden\" name=\"quantity\" value=\"" + rs.getInt("quantity") + "\">");
            out.println("</tr>");
            statement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    %>
        <tr>
            <td style="text-align: right">
                <input type="submit" value="Yes"
                       onclick="document.getElementById('take').action='take-book-servlet'"/>
            </td>
            <td style="text-align: left">
                <input type="submit" value="No"
                       onclick="document.getElementById('take').action='all-books'"/>
            </td>
        </tr>
    </table>
</form>

</body>
</html>
