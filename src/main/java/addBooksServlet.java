import config.Config;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "AddBooks", value = "/add-books")
public class addBooksServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] books = request.getParameterValues("book_id");
        String[] quantityOld = request.getParameterValues("quantityOld");
        String[] quantityNew = request.getParameterValues("quantityNew");
        try {
            PreparedStatement preparedStatement = Config.getConnection().prepareStatement(
                    "UPDATE books SET quantity=? WHERE book_id=?");
            for(int i=0; i<books.length; i++) {
                if(!quantityNew[i].equals("")) {
                    preparedStatement.setInt(1,
                            (Integer.parseInt(quantityOld[i]) + Integer.parseInt(quantityNew[i])));
                    preparedStatement.setInt(2, Integer.parseInt(books[i]));
                    preparedStatement.executeUpdate();
                }
            }
            preparedStatement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            request.getRequestDispatcher("/all-books").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}
