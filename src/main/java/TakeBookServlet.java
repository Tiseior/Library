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
import java.sql.SQLException;

@WebServlet(name = "TakeBookServlet", value = "/take-book-servlet")
public class TakeBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            PreparedStatement preparedStatement = Config.getConnection().prepareStatement(
                    "UPDATE books SET quantity=? WHERE book_id=?");
            preparedStatement.setInt(1, (Integer.parseInt(request.getParameter("quantity")) - 1));
            preparedStatement.setInt(2, Integer.parseInt(request.getParameter("book_id")));
            preparedStatement.executeUpdate();

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            preparedStatement = Config.getConnection().prepareStatement(
                    "INSERT INTO orders (user_id, book_id, status) VALUES (?, ?, ?)");
            preparedStatement.setInt(1, user.getId());
            preparedStatement.setInt(2, Integer.parseInt(request.getParameter("book_id")));
            preparedStatement.setString(3, "Taken");
            preparedStatement.executeUpdate();
            preparedStatement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            request.getRequestDispatcher("/user-account").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}
