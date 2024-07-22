import config.Config;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "TakeBook", value = "/take-book")
public class takeBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            PreparedStatement preparedStatement = Config.getConnection().prepareStatement(
                    "UPDATE books SET quantity=? WHERE book_id=?");
            preparedStatement.setInt(1, (Integer.parseInt(request.getParameter("quantity"))-1));
            preparedStatement.setInt(2, Integer.parseInt(request.getParameter("book_id")));
            preparedStatement.executeUpdate();
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
