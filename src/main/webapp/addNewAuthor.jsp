<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Zakladok.net</title>
</head>
<body>
<h1>Add new Author</h1>
<p>
<form action="register-of-books">
  <input type="submit" value="Back to registry"/>
</form>
</p>
<form action="add-new-author-servlet" method="post">
  <table>
    <tr>
      <td>Name:</td>
      <td><input type="text" maxlength="50" size="25" name="name"></td>
    </tr>
    <tr>
      <td>Surname:</td>
      <td><input type="text" maxlength="50" size="25" name="surname"></td>
    </tr>
    <tr>
      <td colspan="2"><input type="submit" value="Submit"/></td>
    </tr>
  </table>
</form>
</body>
</html>
