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
<h1>Add new book</h1>
<p>
<form action="register-of-books">
    <input type="submit" value="Back to registry"/>
</form>
</p>
<form action="add-new-book-servlet" method="post">
    <table>
    <tr>
        <td>Title:</td>
        <td><input type="text" maxlength="100" size="25" name="title"></td>
    </tr>
    <tr>
        <td>Author:</td>
        <td>
            <select name="author">
                <%
                    try {
                        Statement statement = Config.getConnection().createStatement();
                        ResultSet rs = statement.executeQuery("SELECT * FROM authors");
                        while (rs.next()) {
                            out.println("<option>");
                            out.println(rs.getInt("author_id") + ", " + rs.getString("name"));
                            out.println("</option>");
                        }
                        statement.close();
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                %>
            </select>
        </td>
    </tr>
    <tr>
        <td>Quantity: </td>
        <td><input type="number" name="quantity"></td>
    </tr>
    <tr>
        <td colspan="2"><input type="submit" value="Submit"/></td>
    </tr>
    </table>
</form>
</body>
</html>
