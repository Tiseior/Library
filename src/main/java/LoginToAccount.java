import config.Config;
import entities.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "LoginToAccount", value = "/login-to-account")
public class LoginToAccount extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            PreparedStatement preparedStatement = Config.getConnection().prepareStatement(
                    "SELECT * FROM users WHERE login = ? AND (password = crypt(?, password)) " +
                            "AND access <> 'blocked'");
            preparedStatement.setString(1, request.getParameter("email"));
            preparedStatement.setString(2, request.getParameter("password"));
            ResultSet rs = preparedStatement.executeQuery();
            if(rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setEmail(rs.getString("login"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setAccess(rs.getString("access"));
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                try {
                    request.getRequestDispatcher("/index.jsp").forward(request, response);
                } catch (ServletException e) {
                    throw new RuntimeException(e);
                }
            } else {
                try {
                    request.getRequestDispatcher("/login").forward(request, response);
                } catch (ServletException e) {
                    throw new RuntimeException(e);
                }
            }
            preparedStatement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
