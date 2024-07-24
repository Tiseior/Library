<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 24.07.2024
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h1>Login to Zakladok.net</h1>
<form action="login-to-account">
    <table>
        <tr>
            <td>Email<td>
        </tr>
        <tr>
            <td><input type="text" maxlength="50" size="25" name="email"></td>
        </tr>
        <tr>
            <td>Password<td>
        </tr>
        <tr>
            <td><input type="text" maxlength="50" size="25" name="password"></td>
        </tr>
        <tr>
            <td style="text-align: center">
                <input type="submit" value="Sign in">
                <p>
                    <a href="register.jsp">Register</a>
                </p>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
