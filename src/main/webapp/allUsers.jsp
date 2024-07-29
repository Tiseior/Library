<%@ page import="java.sql.Statement" %>
<%@ page import="config.Config" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
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
<table border="1" style="text-align: center; width: 40%">
    <tr>
        <th style="width: 10%">User id</th>
        <th style="width: 35%">Email</th>
        <th style="width: 35%">Name</th>
        <th style="width: 10%">Access</th>
        <td style="width: 10%"></td>
    </tr>
    <%
        try {
            Statement statement = Config.getConnection().createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM users ORDER BY user_id");
            while(rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("user_id") + "</td>");
                out.println("<td>" + rs.getString("login") + "</td>");
                out.println("<td>" + rs.getString("name") + "</td>");
                out.println("<td>" + rs.getString("access") + "</td>");
                if(rs.getString("access").equals("user")) {
                    out.println("<td>");
                    out.println("<form action=\"block-user-servlet\" method=\"post\">");
                    out.println("<input type=\"hidden\" name=\"user_id\" value=\"" + rs.getInt("user_id") + "\">");
                    out.println("<input type=\"submit\" value=\"Block\">");
                    out.println("</form>");
                    out.println("</td>");
                } else if(rs.getString("access").equals("blocked")) {
                    out.println("<td>");
                    out.println("<form action=\"unblock-user-servlet\" method=\"post\">");
                    out.println("<input type=\"hidden\" name=\"user_id\" value=\"" + rs.getInt("user_id") + "\">");
                    out.println("<input type=\"submit\" value=\"Unblock\">");
                    out.println("</form>");
                    out.println("</td>");
                } else {
                    out.println("<td></td>");
                }
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
