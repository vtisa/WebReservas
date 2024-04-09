<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
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
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0">Inicio de Sesión</h3>
                    </div>
                    <div class="card-body">
                        <%-- Mostrar mensajes de error si existen --%>
                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <% if ("password".equals(request.getParameter("error"))) { %>
                                    Contraseña incorrecta.
                                <% } else if ("credentials".equals(request.getParameter("error"))) { %>
                                    Credenciales inválidas.
                                <% } else if ("database".equals(request.getParameter("error"))) { %>
                                    Error de conexión a la base de datos.
                                <% } %>
                            </div>
                        <% } %>
                        <form action="loginProcess.jsp" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">Usuario</label>
                                <input type="text" name="username" class="form-control" placeholder="Ingrese su usuario" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Contraseña</label>
                                <input type="password" name="password" class="form-control" placeholder="Ingrese su contraseña" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
                        </form>
                        <div class="text-center mt-3">
                            <a href="register.jsp" class="btn btn-link">Crear cuenta nueva</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>