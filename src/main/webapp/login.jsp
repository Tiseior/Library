<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<p>
<form action="index.jsp">
    <input type="submit" value="Back to menu"/>
</form>
</p>
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
                    <a href="register">Register</a>
                </p>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
