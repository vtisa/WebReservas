<%@page import="com.example.utils.PasswordUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Process</title>
    
</head>
<body>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Obtener el hash de la contraseña
            String hashedPassword = PasswordUtils.hashPassword(password);

            // Establecer la conexión a la base de datos
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/reserva", "root", "");

            // Preparar la consulta SQL
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE username = ?");
            stmt.setString(1, username);

            // Ejecutar la consulta
            ResultSet rs = stmt.executeQuery();

            // Verificar si hay un usuario con las credenciales proporcionadas
            if (rs.next()) {
                // Verificar la contraseña
                if (hashedPassword.equals(rs.getString("password"))) {
                    // Credenciales válidas, obtener el ID del usuario
                    int userId = rs.getInt("id");

                    // Redirigir al formulario de reserva con el ID del usuario
                    response.sendRedirect("reservationForm.jsp?userId=" + userId);
                    return; // Salir del método
                } else {
                    // Contraseña incorrecta, redirigir al formulario de inicio de sesión con un mensaje de error
                    response.sendRedirect("index.jsp?error=password");
                }
            } else {
                // Credenciales inválidas, redirigir al formulario de inicio de sesión con un mensaje de error
                response.sendRedirect("index.jsp?error=credentials");
            }

            // Cerrar los recursos
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            // Manejar el error de conexión o consulta
            response.sendRedirect("index.jsp?error=database");
        }
    %>
</body>
</html>