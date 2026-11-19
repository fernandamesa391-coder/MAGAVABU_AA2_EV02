
package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import modelo.Producto;
import modelo.ProductoDAO;

@WebServlet("/productos")
public class ProductoServlet extends HttpServlet {

    private ProductoDAO productoDAO;

    @Override
    public void init() throws ServletException {
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Producto> productos = productoDAO.listar();

            request.setAttribute("productos", productos);

            request.getRequestDispatcher(
                "/WEB-INF/views/productos.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Error al consultar los productos en MySQL.", e
            );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("nombre");
        String categoria = request.getParameter("categoria");
        String precioTexto = request.getParameter("precio");
        String stockTexto = request.getParameter("stock");
        String descripcion = request.getParameter("descripcion");

        try {
            if (nombre == null || nombre.trim().isEmpty()
                    || categoria == null || categoria.trim().isEmpty()
                    || precioTexto == null || precioTexto.trim().isEmpty()
                    || stockTexto == null || stockTexto.trim().isEmpty()) {

                throw new IllegalArgumentException();
            }

            double precio = Double.parseDouble(precioTexto);
            int stock = Integer.parseInt(stockTexto);

            if (precio <= 0 || stock < 0) {
                throw new IllegalArgumentException();
            }

            Producto nuevo = new Producto(
                0,
                nombre.trim(),
                categoria.trim(),
                precio,
                stock,
                descripcion == null ? "" : descripcion.trim()
            );

            productoDAO.insertar(nuevo);

            response.sendRedirect(
                request.getContextPath() + "/productos"
            );

        } catch (IllegalArgumentException e) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Verifica los datos, el precio y la cantidad."
            );

        } catch (SQLException e) {

            throw new ServletException(
                "No fue posible guardar el producto en MySQL.", e
            );
        }
    }
}
