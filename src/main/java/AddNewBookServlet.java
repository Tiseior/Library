import config.Config;
import entities.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Valid;
import jakarta.validation.Validation;
import jakarta.validation.Validator;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Set;

@WebServlet(name = "AddNewBookServlet", value = "/add-new-book-servlet")
public class AddNewBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int quantity = request.getParameter("quantity").equals("") ? 0 :
                Integer.parseInt(request.getParameter("quantity"));
        Book book = new Book(request.getParameter("title"),
                Integer.parseInt(request.getParameter("author").split(",")[0]),
                quantity);
        try {
            PreparedStatement preparedStatement =
                    Config.getConnection().prepareStatement(
                            "INSERT INTO books (title, author, quantity) VALUES (?, ?, ?)");
            preparedStatement.setString(1, book.getTitle());
            preparedStatement.setInt(2, book.getAuthor());
            preparedStatement.setInt(3, book.getQuantity());
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
