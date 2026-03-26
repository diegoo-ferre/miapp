<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String error = null;

if ("POST".equalsIgnoreCase(request.getMethod())) {
    String clave = request.getParameter("clave");

    if ("tesis2026".equals(clave)) {
        session.setAttribute("autenticado", "si");
        response.sendRedirect("index.jsp");
        return;
    } else {
        error = "Contraseña incorrecta.";
    }
}
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso al sistema</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <style>
        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #02080f, #0b1f2a, #12384a);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-box {
            background: rgba(10, 15, 25, 0.88);
            border-radius: 25px;
            padding: 40px 35px;
            color: white;
            width: 100%;
            max-width: 480px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.9);
            text-align: center;
        }

        .logo-img {
            width: 120px;
            margin-bottom: 15px;
            filter: drop-shadow(0 0 20px rgba(255,255,255,0.6));
        }

        h1 {
            font-size: 38px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        p {
            color: #d0d8df;
            margin-bottom: 25px;
        }

        .form-control {
            border-radius: 12px;
            padding: 12px;
        }

        .btn-custom {
            border-radius: 25px;
            padding: 12px 26px;
            font-weight: bold;
            width: 100%;
            margin-top: 15px;
            border: none;
            background: linear-gradient(45deg, #28a745, #5eff8a);
        }
    </style>
</head>
<body>
    <div class="login-box">
        <img src="img/loogoproyecto.png" class="logo-img" alt="Logo">
        <h1>Acceso</h1>
        <p>Ingresá la contraseña para entrar al sistema biométrico.</p>

        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form method="post">
            <input type="password" name="clave" class="form-control" placeholder="Ingrese la contraseña" required>
            <button type="submit" class="btn btn-custom">Entrar</button>
        </form>
    </div>
</body>
</html>