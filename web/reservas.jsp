<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reservas</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0">Reservas</h3>
                    </div>
                    <div class="card-body">
                        <%
                            // Obtener el ID de usuario desde el parámetro de la URL
                            int userId = Integer.parseInt(request.getParameter("userId"));

                            try {
                                // Establecer la conexión a la base de datos
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/reserva", "root", "");

                                // Preparar la consulta SQL para obtener las reservas del usuario
                                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM reservas WHERE id_user = ?");
                                stmt.setInt(1, userId);

                                // Ejecutar la consulta
                                ResultSet rs = stmt.executeQuery();

                                // Mostrar las reservas
                                if (rs.next()) {
                        %>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>DNI</th>
                                    <th>Celular</th>
                                    <th>Correo</th>
                                    <th>Nro. Mesa</th>
                                    <th>Fecha</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    do {
                                %>
                                <tr>
                                    <td><%= rs.getString("name") %></td>
                                    <td><%= rs.getString("dni") %></td>
                                    <td><%= rs.getString("phone") %></td>
                                    <td><%= rs.getString("email") %></td>
                                    <td><%= rs.getInt("table_number") %></td>
                                    <td><%= rs.getString("reservacion_date") %></td>
                                </tr>
                                <%
                                    } while (rs.next());
                                %>
                            </tbody>
                        </table>
                        <%
                                } else {
                        %>
                        <div class="alert alert-info" role="alert">
                            No hay reservas para mostrar aún.
                        </div>
                        <%
                                }

                                // Cerrar los recursos
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                        %>
                        <div class="alert alert-danger" role="alert">
                            Error al obtener las reservas.
                        </div>
                        <%
                            }
                        %>
                        <div class="mt-3">
                            <a href="reservationForm.jsp?userId=<%= userId %>" class="btn btn-primary">Registrar</a>
                            <a href="index.jsp" class="btn btn-secondary">Cerrar Sesión</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>