<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 24.07.2024
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
</head>
<body>
<h1>Register in Zakladok.net</h1>
<form action="add-user-servlet" method="post">
  <table>
    <tr>
      <td>Name<td>
    </tr>
    <tr>
      <td><input type="text" maxlength="50" size="25" name="name"></td>
    </tr>
    <tr>
      <td>Surname<td>
    </tr>
    <tr>
      <td><input type="text" maxlength="50" size="25" name="surname"></td>
    </tr>
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
      <td>Repeat password<td>
    </tr>
    <tr>
      <td><input type="text" maxlength="50" size="25" name="repeat_password"></td>
    </tr>
    <tr>
      <td style="text-align: center">
        <input type="submit" value="Register">
      </td>
    </tr>
  </table>
</form>
</body>
</html>
