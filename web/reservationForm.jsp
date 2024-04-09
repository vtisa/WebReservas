<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Formulario de Reserva</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <style>
        .error {
            color: red;
        }
        .success {
            color: green;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h1 class="mb-0">Formulario de Reserva</h1>
                    </div>
                    <div class="card-body">
                        <%
                            int userId = Integer.parseInt(request.getParameter("userId"));
                            String errorMessage = request.getParameter("error");

                            if ("duplicate".equals(errorMessage)) {
                        %>
                        <div class="alert alert-danger" role="alert">
                            Ya existe una reserva con los mismos datos.
                        </div>
                        <% } else if ("save".equals(errorMessage)) { %>
                        <div class="alert alert-danger" role="alert">
                            Error al guardar la reserva.
                        </div>
                        <% } else if ("database".equals(errorMessage)) { %>
                        <div class="alert alert-danger" role="alert">
                            Error de conexión a la base de datos.
                        </div>
                        <% } else if ("true".equals(request.getParameter("success"))) { %>
                        <div class="alert alert-success" role="alert">
                            Reserva guardada correctamente.
                        </div>
                        <% } %>

                        <form id="reservationForm" action="processReservation.jsp" method="post">
                            <input type="hidden" name="userId" value="<%= userId %>">

                            <div class="mb-3">
                                <label for="name" class="form-label">Nombre:</label>
                                <input type="text" id="name" name="name" class="form-control" required maxlength="100"
                                       pattern="^[A-ZÁÉÍÓÚÜÑ][a-záéíóúüñ]*(\s[A-ZÁÉÍÓÚÜÑ][a-záéíóúüñ]*)*$"
                                       title="Por favor, ingresa un nombre válido. Cada palabra debe comenzar con mayúscula, separadas por un solo espacio.">
                                <span class="error" id="nameError"></span>
                            </div>


                            <div class="mb-3">
                                <label for="dni" class="form-label">DNI:</label>
                                <input type="text" id="dni" name="dni" class="form-control" required maxlength="8" pattern="^\d{8}$"
                                       title="El DNI debe contener exactamente 8 dígitos numéricos, sin espacios, ni letras.">
                                <span class="error" id="dniError"></span>
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">Celular:</label>
                                <input type="tel" id="phone" name="phone" class="form-control" required maxlength="20"
                                       pattern="\+\d{1,3}\d{9}$"
                                      title="El número de celular debe tener 9 dígitos numéricos y código de país">
                                <span class="error" id="phoneError"></span>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Correo:</label>
                                <input type="email" id="email" name="email" class="form-control" required maxlength="100"
                                       pattern="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
                                       title="Formato básico: El usuario puede contener letras, dígitos, guiones bajos (_) y puntos (.). Debe contener el símbolo @. El dominio puede contener letras, dígitos y guiones.">
                                <span class="error" id="emailError"></span>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">Contraseña:</label>
                                <input type="password" id="password" name="password" class="form-control" required
                                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d.*\d).{6,}$"
                                       title="La contraseña debe tener al menos 6 caracteres, incluyendo al menos una letra minúscula, una letra mayúscula y dos dígitos.">
                                <span class="error" id="passwordError"></span>
                            </div>


                            <div class="mb-3">
                                <label for="tableNumber" class="form-label">Nro. Mesa:</label>
                                <input type="number" id="tableNumber" name="tableNumber" class="form-control" required min="1" max="100"
                                       title="Introduce un número de mesa válido, del 1 al 100">
                                <span class="error" id="tableNumberError"></span>
                            </div>

                            <div class="mb-3">
                                <label for="date" class="form-label">Fecha:</label>
                                <input type="text" id="date" name="date" class="form-control" required pattern="^\d{4}-\d{2}-\d{2}$"
                                       title="Introduce una fecha válida en formato yyyy-mm-dd">
                                <span class="error" id="dateError"></span>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <button type="submit" class="btn btn-primary btn-lg">Enviar</button>
                                <a href="reservas.jsp?userId=<%= userId %>" class="btn btn-secondary btn-lg">Lista de Reservas</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.getElementById("reservationForm").onsubmit = function() {
            var inputDate = document.getElementById("date").value;

            if (!/^\d{4}-\d{2}-\d{2}$/.test(inputDate)) {
                alert("Inserta una fecha válida en formato yyyy-mm-dd.");
                return false;
            }

            return true;
        };
    </script>
</body>
</html>