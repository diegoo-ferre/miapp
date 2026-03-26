<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String autenticado = (String) session.getAttribute("autenticado");
if (autenticado == null || !autenticado.equals("si")) {
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
            background: rgba(10, 15, 25, 0.85);
            border: 1px solid rgba(255,255,255,0.08);
            backdrop-filter: blur(15px);
            border-radius: 25px;
            padding: 45px 35px;
            text-align: center;
            color: white;
            box-shadow: 0 10px 40px rgba(0,0,0,0.9);
            max-width: 520px;
            width: 100%;
        }

        .logo {
            width: 120px;
            max-width: 100%;
            height: auto;
            margin-bottom: 15px;
            filter: drop-shadow(0 0 20px rgba(255,255,255,0.6));
            animation: flotar 3s ease-in-out infinite;
        }

        @keyframes flotar {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-8px); }
            100% { transform: translateY(0px); }
        }

        h1 {
            font-size: 40px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        p {
            font-size: 18px;
            color: #d0d8df;
            margin-bottom: 30px;
        }

        .btn-custom {
            display: block;
            width: 100%;
            margin: 12px 0;
            border-radius: 30px;
            padding: 14px;
            font-size: 18px;
            font-weight: 600;
            transition: 0.3s;
            text-decoration: none;
            color: white;
            border: none;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
            text-decoration: none;
            color: white;
        }

        .btn-registro {
            background: linear-gradient(45deg, #007bff, #00c6ff);
        }

        .btn-lista {
            background: linear-gradient(45deg, #28a745, #5eff8a);
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
        <a href="logout.jsp" class="btn-custom btn-cerrar">Cerrar sesión</a>
    </div>
</body>
</html>