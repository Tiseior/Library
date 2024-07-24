import config.Config;
import entities.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "AddUserServlet", value = "/add-user-servlet")
public class AddUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("password").equals(request.getParameter("repeat_password"))) {
            User user = new User(request.getParameter("name"), request.getParameter("surname"),
                    request.getParameter("email"), request.getParameter("password"));
            try {
                PreparedStatement preparedStatement =
                        Config.getConnection().prepareStatement(
                                "INSERT INTO users (login, password, name, access) VALUES (?, crypt(?, gen_salt('md5')), ?, 'user')");
                preparedStatement.setString(1, user.getEmail());
                preparedStatement.setString(2, user.getPassword());
                preparedStatement.setString(3, user.getName() + " " + user.getSurname());
                preparedStatement.executeUpdate();
                preparedStatement.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            try {
                request.getRequestDispatcher("/login").forward(request, response);
            } catch (ServletException e) {
                throw new RuntimeException(e);
            }
        } else {
            try {
                request.getRequestDispatcher("/register").forward(request, response);
            } catch (ServletException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
