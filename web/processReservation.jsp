<%@page import="java.sql.*"%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
    <%
        int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("name");
        String dni = request.getParameter("dni");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String tableNumberStr = request.getParameter("tableNumber");
        String date = request.getParameter("date");

        try {
            // Establecer la conexión a la base de datos
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/reserva", "root", "");

            // Preparar la consulta SQL para verificar si la reserva ya existe
            PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM reservas WHERE id_user = ? AND dni = ? AND email = ? AND table_number = ? AND reservacion_date = ?");
            checkStmt.setInt(1, userId);
            checkStmt.setString(2, dni);
            checkStmt.setString(3, email);
            checkStmt.setInt(4, Integer.parseInt(tableNumberStr));
            checkStmt.setString(5, date);

            // Ejecutar la consulta de verificación
            ResultSet rs = checkStmt.executeQuery();

            // Verificar si hay una reserva existente con los mismos datos
            if (rs.next()) {
                // Reserva repetida, mostrar un mensaje de error y no guardar la nueva reserva
                response.sendRedirect("reservationForm.jsp?userId=" + userId + "&error=duplicate");
            } else {
                // Preparar la consulta SQL para insertar la nueva reserva
                PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO reservas (id_user, name, dni, phone, email, password, table_number, reservacion_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
                insertStmt.setInt(1, userId);
                insertStmt.setString(2, name);
                insertStmt.setString(3, dni);
                insertStmt.setString(4, phone);
                insertStmt.setString(5, email);
                insertStmt.setString(6, password); // No hash the password
                insertStmt.setInt(7, Integer.parseInt(tableNumberStr));
                insertStmt.setString(8, date);

                // Ejecutar la consulta de inserción
                int rowsAffected = insertStmt.executeUpdate();

                // Verificar si se insertó la reserva correctamente
                if (rowsAffected > 0) {
                    // Redirigir al formulario de reserva después de guardar la reserva
                    response.sendRedirect("reservas.jsp?userId=" + userId + "&success=true");
                } else {
                    // Mostrar un mensaje de error si no se pudo guardar la reserva
                    response.sendRedirect("reservationForm.jsp?userId=" + userId + "&error=save");
                }

                // Cerrar los recursos
                rs.close();
                checkStmt.close();
                insertStmt.close();
                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Manejar el error de conexión o consulta
            response.sendRedirect("reservationForm.jsp?userId=" + userId + "&error=database");
        }
    %>
</body>
</html>