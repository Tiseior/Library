import config.Config;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "DeleteBooksServlet", value = "/delete-books-servlet")
public class DeleteBooksServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] books = request.getParameterValues("del_book_id");
        if(books != null) {
            try {
                PreparedStatement preparedStatement = Config.getConnection().prepareStatement(
                        "DELETE FROM books WHERE book_id=?");
                for(String id : books) {
                    preparedStatement.setInt(1, Integer.parseInt(id));
                    preparedStatement.executeUpdate();
                }
                preparedStatement.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        try {
            request.getRequestDispatcher("/register-of-books").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}
