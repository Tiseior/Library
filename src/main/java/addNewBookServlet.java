import config.Config;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "AddNewBook", value = "/add-new-book")
public class addNewBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            PreparedStatement preparedStatement =
                    Config.getConnection().prepareStatement(
                            "INSERT INTO books (title, author, quantity) VALUES (?, ?, ?)");
            preparedStatement.setString(1, request.getParameter("title"));
            int author = Integer.parseInt(request.getParameter("author").split(",")[0]);
            preparedStatement.setInt(2, author);
            int quantity = request.getParameter("quantity").equals("") ? 0 :
                    Integer.parseInt(request.getParameter("quantity"));
            preparedStatement.setInt(3, quantity);
            preparedStatement.executeUpdate();
            preparedStatement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}
