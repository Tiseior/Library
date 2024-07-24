import config.Config;
import entities.Author;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "AddNewAuthorServlet", value = "/add-new-author-servlet")
public class AddNewAuthorServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Author author = new Author(request.getParameter("name"), request.getParameter("surname"));
        try {
            PreparedStatement preparedStatement =
                    Config.getConnection().prepareStatement("INSERT INTO authors (name) VALUES (?)");
            preparedStatement.setString(1, author.getName() + " " + author.getSurname());
            preparedStatement.executeUpdate();
            preparedStatement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            request.getRequestDispatcher("/register-of-books").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}
