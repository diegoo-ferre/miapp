<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("usuario") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema Biométrico</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #02080f, #0b1f2a, #12384a);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .contenedor {
            background: rgba(10, 15, 25, 0.88);
            padding: 45px 35px;
            border-radius: 30px;
            text-align: center;
            color: white;
            width: 100%;
            max-width: 700px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.9);
        }

        .logo {
            width: 120px;
            height: 120px;
            object-fit: contain;
            margin-bottom: 20px;
        }

        h1 {
            font-size: 48px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        p {
            font-size: 20px;
            color: #dce6ef;
            margin-bottom: 35px;
        }

        .btn-custom {
            display: block;
            width: 100%;
            max-width: 360px;
            margin: 12px auto;
            padding: 14px 20px;
            border: none;
            border-radius: 30px;
            color: white;
            font-size: 18px;
            font-weight: bold;
            text-decoration: none;
            transition: 0.3s ease;
        }

        .btn-custom:hover {
            transform: scale(1.03);
            color: white;
            text-decoration: none;
        }

        .btn-registro {
            background: linear-gradient(45deg, #00b09b, #96c93d);
        }

        .btn-lista {
            background: linear-gradient(45deg, #2193b0, #6dd5ed);
        }

        .btn-salarios {
            background: linear-gradient(45deg, #f39c12, #f1c40f);
        }

        .btn-cerrar {
            background: linear-gradient(45deg, #dc3545, #ff6b81);
        }
    </style>
</head>
<body>

    <div class="contenedor">
        <img src="img/loogoproyecto.png" class="logo" alt="Logo">
        <h1>Bienvenido</h1>
        <p>Sistema de acceso con reconocimiento facial. Registrá usuarios o accedé al sistema.</p>

        <a href="registro.jsp" class="btn-custom btn-registro">Registrar persona</a>
        <a href="lista.jsp" class="btn-custom btn-lista">Ver registros</a>
        <a href="salarios.jsp" class="btn-custom btn-salarios">Gestión de salarios</a>
        <a href="logout.jsp" class="btn-custom btn-cerrar">Cerrar sesión</a>
    </div>

</body>
</html>