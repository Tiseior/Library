package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Config {
    private static final String dbURL = "jdbc:postgresql://localhost:5432/library";
    private static final String user = "postgres";
    private static final String password = "postgres";
    public static Connection getConnection() {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(dbURL, user, password);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }
}
