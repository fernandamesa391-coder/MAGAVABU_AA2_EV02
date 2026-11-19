# MAGAVABU – Tienda Virtual de Ropa Deportiva

## Descripción
MAGAVABU es una aplicación web para visualizar y registrar productos de una tienda virtual de ropa deportiva.

## Tecnologías utilizadas
- Java 21
- Apache Tomcat 10.1
- Maven
- MySQL
- Java Servlets
- JSP
- HTML y CSS

## Funcionalidades
- Consultar productos registrados.
- Visualizar imágenes de los productos.
- Registrar nuevos productos mediante un formulario.
- Consultar la información almacenada en MySQL.

## Base de datos
Nombre de la base de datos: `magavabu`.

Tabla utilizada: `productos`.

## Ejecución del proyecto
1. Tener instalado Java y Apache Tomcat.
2. Tener configurada la base de datos MySQL.
3. Configurar la variable de entorno `MAGAVABU_DB_PASSWORD` con la contraseña de MySQL.
4. Ejecutar `mvn clean package` desde la carpeta del proyecto.
5. Desplegar el archivo WAR generado en Apache Tomcat.
6. Abrir en el navegador: `http://localhost:8080/MAGAVABU/productos`.

## Repositorio
https://github.com/fernandamesa391-coder/MAGAVABU_AA2_EV02