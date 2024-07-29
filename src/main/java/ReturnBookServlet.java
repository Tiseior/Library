import config.Config;
import entities.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(name = "ReturnBookServlet", value = "/return-book-servlet")
public class ReturnBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Statement statement = Config.getConnection().createStatement();
            ResultSet rs = statement.executeQuery(
                    "SELECT user_id, o.book_id, quantity " +
                            "FROM orders o INNER JOIN books b on b.book_id = o.book_id " +
                            "WHERE order_id = " + request.getParameter("order_id") + ";");
            rs.next();

            PreparedStatement preparedStatement = Config.getConnection().prepareStatement(
                    "UPDATE books SET quantity=? WHERE book_id = ?;");
            preparedStatement.setInt(1, (rs.getInt("quantity") + 1));
            preparedStatement.setInt(2, rs.getInt("book_id"));
            preparedStatement.executeUpdate();

            preparedStatement = Config.getConnection().prepareStatement(
                    "INSERT INTO orders (user_id, book_id, status, order_link) VALUES (?, ?, ?, ?);");
            preparedStatement.setInt(1, rs.getInt("user_id"));
            preparedStatement.setInt(2, rs.getInt("book_id"));
            preparedStatement.setString(3, "Returned");
            preparedStatement.setInt(4, Integer.parseInt(request.getParameter("order_id")));
            preparedStatement.executeUpdate();

            preparedStatement = Config.getConnection().prepareStatement(
                    "UPDATE orders SET order_link = " +
                            "(SELECT order_id FROM orders WHERE order_link = ? AND status = 'Returned') " +
                            "WHERE order_id = ?;");
            preparedStatement.setInt(1, Integer.parseInt(request.getParameter("order_id")));
            preparedStatement.setInt(2, Integer.parseInt(request.getParameter("order_id")));
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
