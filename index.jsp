<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio - Sistema Biométrico</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">

    <style>
        body {
            margin: 0;
            height: 100vh;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #02080f, #0b1f2a, #12384a);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .contenedor {
            background: rgba(10, 15, 25, 0.85);
            padding: 50px 40px;
            border-radius: 25px;
            text-align: center;
            color: white;
            box-shadow: 0 10px 40px rgba(0,0,0,0.9);
            max-width: 500px;
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
            color: #cfd8dc;
            margin-bottom: 30px;
        }

        .btn-custom {
            width: 100%;
            padding: 14px;
            border-radius: 30px;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
            transition: 0.3s;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
        }

        .btn-primary {
            background: linear-gradient(45deg, #007bff, #00c6ff);
            border: none;
        }

        .btn-success {
            background: linear-gradient(45deg, #28a745, #5eff8a);
            border: none;
        }

    </style>
</head>
<body>

<div class="contenedor">

    <img src="img/loogoproyecto.png" class="logo" alt="Logo">

    <h1>Bienvenido</h1>

    <p>
        Sistema de acceso con reconocimiento facial.  
        Registrá usuarios o accedé al sistema.
    </p>

    <a href="registro.jsp" class="btn btn-primary btn-custom">
        Registrar persona
    </a>

    <a href="lista.jsp" class="btn btn-secondary btn-custom">
    Ver registros
    </a>

    <a href="#" class="btn btn-success btn-custom">
        Acceder (próximamente)
    </a>

</div>

</body>
</html>