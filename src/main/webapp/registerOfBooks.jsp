<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="config.Config" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Zakladok.net</title>
</head>
<body>
<h1>Register of Books</h1>
<p>
<form action="index.jsp">
    <input type="submit" value="Back to menu"/>
</form>
</p>
<p>
<form action="add-new-author">
    <input type="submit" value="New author">
</form>
<form action="add-new-book">
    <input type="submit" value="New book">
</form>
</p>
<form id="register" method="post">
    <table border="1" style="text-align: center; width: 50%">
        <tr>
            <th style="width: 50%">Title</th>
            <th style="width: 20%">Author</th>
            <th style="width: 15%">Quantity to be added</th>
            <th style="width: 15%">Select to delete</th>
        </tr>
        <%
            try {
                Statement statement = Config.getConnection().createStatement();
                ResultSet rs = statement.executeQuery(
                        "SELECT book_id, title, name, quantity FROM books, authors WHERE books.author = authors.author_id ORDER BY book_id");
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("title") + "</td>");
                    out.println("<td>" + rs.getString("name") + "</td>");
                    out.println("<input type=\"hidden\" name=\"quantityOld\" value=\"" + rs.getInt("quantity") + "\">");
                    out.println("<td><input style=\"width: 100%\" type=\"number\" name=\"quantityNew\"></td>");
                    out.println("<input type=\"hidden\" name=\"book_id\" value=\"" + rs.getInt("book_id") + "\">");
                    out.println("<td>" +
                            "<input type=\"checkbox\" name=\"del_book_id\" value=\"" + rs.getInt("book_id") + "\">" +
                            "</td>");
                    out.println("</tr>");
                }
                statement.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        %>
        <tr>
            <td colspan="2"></td>
            <td>
                <input type="submit"
                       value="Put all" onclick="document.getElementById('register').action='add-books-servlet'">
            </td>
            <td>
                <input type="submit"
                       value="Delete all" onclick="document.getElementById('register').action='delete-books-servlet'">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
