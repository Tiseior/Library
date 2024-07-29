import config.Config;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "BlockUserServlet", value = "/block-user-servlet")
public class BlockUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            PreparedStatement preparedStatement = Config.getConnection().prepareStatement(
                    "UPDATE users SET access = 'blocked' WHERE user_id = ?");
            preparedStatement.setInt(1, Integer.parseInt(request.getParameter("user_id")));
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            request.getRequestDispatcher("/all-users").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}
