package config;

import java.sql.*;

public class Config {
    private static final String dbURL = "jdbc:postgresql://localhost:5432/library";
    private static final String user = "postgres";
    private static final String password = "postgres";
    private static Connection connection = null;
    private Config() {}
    public static Connection getConnection() {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        if(connection == null) {
            try {
                connection = DriverManager.getConnection(dbURL, user, password);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            fillDB();
            System.out.println("Lol");
        }
        return connection;
    }

    private static void fillDB() {
        try {
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet rs = metaData.getTables(null, null, "orders", new String[] {"TABLE"});
            if(!rs.next()) {
                createTables();
                fillTables();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private static void createTables() {
        try {
            Statement statement = connection.createStatement();
            StringBuilder sql = new StringBuilder();
            sql.append("CREATE TABLE IF NOT EXISTS authors (author_id serial PRIMARY KEY, name varchar(100) not null);");
            statement.executeUpdate(sql.toString());
            sql.setLength(0);
            sql.append("CREATE TABLE IF NOT EXISTS books (book_id serial PRIMARY KEY, title varchar(100) not null, ");
            sql.append("author integer not null, quantity integer DEFAULT 0, ");
            sql.append("CONSTRAINT book_authors_fkey FOREIGN KEY (author) REFERENCES authors (author_id));");
            statement.executeUpdate(sql.toString());
            sql.setLength(0);
            sql.append("CREATE TABLE IF NOT EXISTS access_levels (access_id varchar(20) PRIMARY KEY, ");
            sql.append("description varchar(50) not null);");
            statement.executeUpdate(sql.toString());
            sql.setLength(0);
            sql.append("CREATE TABLE IF NOT EXISTS users (user_id serial PRIMARY KEY, login varchar(50) not null, ");
            sql.append("password varchar(50) not null, name varchar(100) not null, access varchar(20) not null, ");
            sql.append("CONSTRAINT users_access_levels_fkey FOREIGN KEY (access) REFERENCES access_levels (access_id));");
            statement.executeUpdate(sql.toString());
            sql.setLength(0);
            sql.append("CREATE TABLE IF NOT EXISTS order_statuses (status_id varchar(20) PRIMARY KEY, ");
            sql.append("description varchar(50) not null);");
            statement.executeUpdate(sql.toString());
            sql.setLength(0);
            sql.append("CREATE TABLE IF NOT EXISTS orders (order_id serial PRIMARY KEY, user_id integer not null, ");
            sql.append("book_id integer not null, date timestamptz DEFAULT now(), status varchar(20) not null, ");
            sql.append("CONSTRAINT orders_users_fkey FOREIGN KEY (user_id) REFERENCES users (user_id), ");
            sql.append("CONSTRAINT orders_books_fkey FOREIGN KEY (book_id) REFERENCES books (book_id), ");
            sql.append("CONSTRAINT orders_statuses_fkey FOREIGN KEY (status) REFERENCES order_statuses (status_id));");
            statement.executeUpdate(sql.toString());
            statement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private static void fillTables() {
        try {
            Statement statement = connection.createStatement();
            statement.executeUpdate("CREATE EXTENSION pgcrypto;");
            statement.executeUpdate("INSERT INTO authors (name) VALUES ('Lewis Carroll'), ('Oscar Wilde'), ('Jane Austen');");
            statement.executeUpdate("INSERT INTO books (title, author, quantity) VALUES ('Alice''s Adventures in Wonderland', 1, 8)," +
                    "('The Picture of Dorian Gray', 2, 10), ('The Canterville Ghost', 2, 10), ('Pride and Prejudice', 3, 9);");
            statement.executeUpdate("INSERT INTO access_levels VALUES ('admin', 'administrator'), ('user', 'normal user')," +
                    "('blocked', 'blocked user');");
            statement.executeUpdate("INSERT INTO users (login, password, name, access) VALUES " +
                    "('admin@mail.ru', crypt('admin', gen_salt('md5')), 'Admin', 'admin'), " +
                    "('email@mail.ru', crypt('123', gen_salt('md5')), 'Name Surname', 'user')," +
                    "('biba@gmail.com', crypt('biba', gen_salt('md5')), 'Biba Qwerty', 'user')," +
                    "('boba@mail.ru', crypt('boba', gen_salt('md5')), 'Boba Qwerty', 'user');");
            statement.executeUpdate("INSERT INTO order_statuses VALUES ('Taken', 'The book is with the user')," +
                    "('Returned', 'The user returned the book')");
            statement.executeUpdate("INSERT INTO orders (user_id, book_id, date, status) VALUES " +
                    "(3, 1, '2024-07-20 10:24:00 +00:00', 'Taken'), (4, 2, '2024-07-20 12:36:00 +00:00', 'Taken')," +
                    "(3, 3, '2024-07-22 08:40:00 +00:00', 'Taken'), (4, 1, '2024-07-23 08:15:00 +00:00', 'Taken');");
            statement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
