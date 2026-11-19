
package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static final String URL =
        "jdbc:mysql://localhost:3306/magavabu?useSSL=false&serverTimezone=UTC";

    private static final String USER = "root";

    private static final String PASSWORD =
        System.getenv("MAGAVABU_DB_PASSWORD");

    public static Connection conectar() throws SQLException {

        if (PASSWORD == null || PASSWORD.isEmpty()) {
            throw new SQLException("No se configuró la contraseña de MySQL.");
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encontró el controlador de MySQL.", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
