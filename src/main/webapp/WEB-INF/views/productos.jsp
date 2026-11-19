
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Producto" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MAGAVABU - Productos</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f4f6f8;
            color: #333;
        }

        header {
            background-color: #172b4d;
            color: white;
            padding: 25px;
            text-align: center;
        }

        header h1 {
            font-size: 30px;
            margin-bottom: 8px;
        }

        nav {
            background-color: #243b64;
            padding: 15px;
            text-align: center;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-weight: bold;
        }

        nav a:hover {
            color: #ffcc00;
        }

        .contenedor {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto;
        }

        .formulario {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .formulario h2 {
            margin-bottom: 20px;
            color: #172b4d;
        }

        .campos {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        input, textarea, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
        }

        button {
            background-color: #172b4d;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
        }

        button:hover {
            background-color: #294c80;
        }

        .tabla-contenedor {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            overflow-x: auto;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .tabla-contenedor h2 {
            margin-bottom: 20px;
            color: #172b4d;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 750px;
        }

        th {
            background-color: #172b4d;
            color: white;
            padding: 12px;
        }

        td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background-color: #f2f6fc;
        }

        .producto-img {
            width: 90px;
            height: 90px;
            object-fit: contain;
            background-color: white;
            border-radius: 8px;
        }

        footer {
            background-color: #172b4d;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 40px;
        }

        @media (max-width: 600px) {
            .campos {
                grid-template-columns: 1fr;
            }

            nav a {
                display: inline-block;
                margin: 8px;
            }
        }
    </style>
</head>

<body>

<header>
    <h1>MAGAVABU</h1>
    <p>Tienda Virtual de Ropa Deportiva</p>
</header>

<nav>
    <a href="#">Inicio</a>
    <a href="${pageContext.request.contextPath}/productos">Productos</a>
    <a href="#">Carrito</a>
    <a href="#">Mis pedidos</a>
    <a href="#">Iniciar sesión</a>
</nav>

<div class="contenedor">

    <section class="formulario">
        <h2>Registrar nuevo producto</h2>

        <form action="${pageContext.request.contextPath}/productos" method="post">

            <div class="campos">

                <input type="text" name="nombre"
                       placeholder="Nombre del producto" required>

                <input type="text" name="categoria"
                       placeholder="Categoría" required>

                <input type="number" name="precio"
                       placeholder="Precio" min="1" step="0.01" required>

                <input type="number" name="stock"
                       placeholder="Cantidad disponible" min="0" required>

                <textarea name="descripcion"
                          placeholder="Descripción del producto"
                          rows="3"></textarea>

            </div>

            <button type="submit">Agregar producto</button>

        </form>
    </section>

    <section class="tabla-contenedor">

        <h2>Lista de productos</h2>

        <table>

            <thead>
                <tr>
                    <th>ID</th>
                    <th>Imagen</th>
                    <th>Nombre</th>
                    <th>Categoría</th>
                    <th>Precio</th>
                    <th>Stock</th>
                    <th>Descripción</th>
                </tr>
            </thead>

            <tbody>

                <%
                    List<Producto> productos =
                        (List<Producto>) request.getAttribute("productos");

                    if (productos != null && !productos.isEmpty()) {
                        for (Producto p : productos) {
                %>

                <tr>

                    <td><%= p.getId() %></td>

                    <td>
                        <%
                            String nombre = p.getNombre() == null
                                ? "" : p.getNombre().toLowerCase();

                            String categoria = p.getCategoria() == null
                                ? "" : p.getCategoria().trim();
                        %>

                        <% if (nombre.contains("camiseta")) { %>

                            <img class="producto-img"
                                 src="${pageContext.request.contextPath}/img/camiseta.jpg"
                                 alt="Camiseta deportiva">

                        <% } else if (nombre.contains("leggins")) { %>

                            <img class="producto-img"
                                 src="${pageContext.request.contextPath}/img/pantaloneta.jpg"
                                 alt="Leggins deportivos">

                        <% } else if (categoria.equalsIgnoreCase("Calzado")) { %>

                            <img class="producto-img"
                                 src="${pageContext.request.contextPath}/img/tenis.jpg"
                                 alt="Tenis deportivos">

                        <% } else { %>

                            <span>Sin imagen</span>

                        <% } %>

                    </td>

                    <td><%= p.getNombre() %></td>

                    <td><%= p.getCategoria() %></td>

                    <td>$<%= String.format("%,.0f", p.getPrecio()) %></td>

                    <td><%= p.getStock() %></td>

                    <td><%= p.getDescripcion() %></td>

                </tr>

                <%
                        }
                    } else {
                %>

                <tr>
                    <td colspan="7">No hay productos registrados.</td>
                </tr>

                <%
                    }
                %>

            </tbody>

        </table>

    </section>

</div>

<footer>
    <p>MAGAVABU - Moda deportiva para todos</p>
    <p>Comodidad, estilo y calidad</p>
</footer>

</body>
</html>
