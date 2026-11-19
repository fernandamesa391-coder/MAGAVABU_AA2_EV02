
package modelo;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    public List<Producto> listar() throws SQLException {

        List<Producto> productos = new ArrayList<>();

        String sql = "SELECT * FROM productos";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement consulta = conexion.prepareStatement(sql);
             ResultSet resultado = consulta.executeQuery()) {

            while (resultado.next()) {

                Producto producto = new Producto(
                    resultado.getInt("id"),
                    resultado.getString("nombre"),
                    resultado.getString("categoria"),
                    resultado.getDouble("precio"),
                    resultado.getInt("cantidad"),
                    resultado.getString("descripcion")
                );

                productos.add(producto);
            }
        }

        return productos;
    }

    public void insertar(Producto producto) throws SQLException {

        String sql = "INSERT INTO productos "
                   + "(nombre, descripcion, precio, cantidad, categoria) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conexion = Conexion.conectar();
             PreparedStatement consulta = conexion.prepareStatement(sql)) {

            consulta.setString(1, producto.getNombre());
            consulta.setString(2, producto.getDescripcion());
            consulta.setDouble(3, producto.getPrecio());
            consulta.setInt(4, producto.getStock());
            consulta.setString(5, producto.getCategoria());

            consulta.executeUpdate();
        }
    }
}
