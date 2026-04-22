<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.regex.*" %>

<%
if (session.getAttribute("usuario") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<%
String mensaje = null;
String tipoMensaje = "success";

String nombreValor = "";
String ciValor = "";

Connection con = null;
PreparedStatement ps = null;

if ("POST".equalsIgnoreCase(request.getMethod())) {
    request.setCharacterEncoding("UTF-8");

    String nombre = request.getParameter("nombre");
    String ci = request.getParameter("ci");
    String foto1 = request.getParameter("foto1");
    String foto2 = request.getParameter("foto2");
    String foto3 = request.getParameter("foto3");
    String foto4 = request.getParameter("foto4");
    String foto5 = request.getParameter("foto5");

    if (nombre == null) nombre = "";
    if (ci == null) ci = "";
    if (foto1 == null) foto1 = "";
    if (foto2 == null) foto2 = "";
    if (foto3 == null) foto3 = "";
    if (foto4 == null) foto4 = "";
    if (foto5 == null) foto5 = "";

    nombre = nombre.trim();
    ci = ci.trim();

    nombreValor = nombre;
    ciValor = ci;

    boolean nombreValido = Pattern.matches("^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$", nombre);
    boolean ciValido = Pattern.matches("^[0-9]+$", ci);

    if (nombre.equals("")) {
        mensaje = "debe completar el nombre.";
        tipoMensaje = "danger";
    } else if (ci.equals("")) {
        mensaje = "debe completar la cédula.";
        tipoMensaje = "danger";
    } else if (!nombreValido) {
        mensaje = "el nombre solo debe contener letras.";
        tipoMensaje = "danger";
    } else if (!ciValido) {
        mensaje = "la cédula solo debe contener números.";
        tipoMensaje = "danger";
    } else if (foto1.equals("") || foto2.equals("") || foto3.equals("") || foto4.equals("") || foto5.equals("")) {
        mensaje = "debe capturar las 5 fotos obligatorias.";
        tipoMensaje = "danger";
    } else {
        try {
            Class.forName("org.postgresql.Driver");

            String url = "jdbc:postgresql://dpg-d722t9p4tr6s739f73ag-a.oregon-postgres.render.com:5432/biometrico_ytr7";
            String user = "biometrico_ytr7_user";
            String pass = "PON_AQUI_TU_PASSWORD_REAL";

            con = DriverManager.getConnection(url, user, pass);

            ps = con.prepareStatement(
                "insert into personas (nombre, ci, foto1, foto2, foto3, foto4, foto5) values (?, ?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, nombre);
            ps.setString(2, ci);
            ps.setString(3, foto1);
            ps.setString(4, foto2);
            ps.setString(5, foto3);
            ps.setString(6, foto4);
            ps.setString(7, foto5);

            ps.executeUpdate();

            mensaje = "persona registrada correctamente.";
            tipoMensaje = "success";

            nombreValor = "";
            ciValor = "";
        } catch (Exception e) {
            mensaje = "error: " + e.getMessage();
            tipoMensaje = "danger";
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Personas</title>
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
            padding: 30px 15px;
        }

        .contenedor {
            background: rgba(10, 15, 25, 0.88);
            padding: 40px 35px;
            border-radius: 25px;
            color: white;
            box-shadow: 0 10px 40px rgba(0,0,0,0.9);
            width: 100%;
            max-width: 1000px;
        }

        h2 {
            text-align: center;
            font-size: 40px;
            font-weight: bold;
            margin-bottom: 30px;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
        }

        .form-control {
            border-radius: 15px;
            padding: 12px;
        }

        video {
            width: 100%;
            max-width: 500px;
            border-radius: 20px;
            border: 3px solid rgba(255,255,255,0.08);
            background: #000;
        }

        .preview-box {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
            justify-content: center;
        }

        .preview-box img {
            width: 140px;
            height: 110px;
            object-fit: cover;
            border-radius: 12px;
            border: 2px solid rgba(255,255,255,0.08);
        }

        .acciones {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
            justify-content: center;
        }

        .btn-custom {
            border: none;
            border-radius: 25px;
            padding: 12px 24px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            transition: 0.3s ease;
            text-decoration: none;
        }

        .btn-captura {
            background: linear-gradient(45deg, #ff9800, #ff5722);
        }

        .btn-guardar {
            background: linear-gradient(45deg, #28a745, #00c851);
        }

        .btn-volver {
            background: linear-gradient(45deg, #17a2b8, #007bff);
        }

        .btn-custom:hover {
            transform: scale(1.03);
            color: white;
            text-decoration: none;
        }

        .mensaje {
            margin-bottom: 20px;
        }

        .contador {
            text-align: center;
            font-size: 18px;
            font-weight: bold;
            margin-top: 15px;
            color: #ffd166;
        }

        .bloque-video {
            text-align: center;
            margin-top: 25px;
        }

        .boton-centro {
            text-align: center;
            margin-top: 20px;
        }

        canvas {
            display: none;
        }
    </style>
</head>
<body>

<div class="contenedor">
    <h2>Registro de Personas</h2>

<% if (mensaje != null) { %>
    <div class="alert alert-<%= tipoMensaje %> mensaje"><%= mensaje %></div>
<% } %>

    <form method="post" action="registro.jsp" id="formRegistro">
        <div class="form-group">
            <label for="nombre">Nombre completo</label>
            <input type="text" name="nombre" id="nombre" class="form-control" maxlength="100" value="<%= nombreValor %>" required>
        </div>

        <div class="form-group">
            <label for="ci">Cédula de identidad</label>
            <input type="text" name="ci" id="ci" class="form-control" maxlength="20" value="<%= ciValor %>" required>
        </div>

        <div class="bloque-video">
            <video id="video" autoplay playsinline muted></video>
            <canvas id="canvas"></canvas>
        </div>

        <div class="contador">
            Fotos capturadas: <span id="contador">0</span> / 5
        </div>

        <div class="acciones">
            <button type="button" class="btn-custom btn-captura" onclick="capturarFoto()">Capturar foto</button>
            <button type="button" class="btn-custom btn-guardar" onclick="guardarRegistro()">Guardar registro</button>
        </div>

        <input type="hidden" name="foto1" id="foto1">
        <input type="hidden" name="foto2" id="foto2">
        <input type="hidden" name="foto3" id="foto3">
        <input type="hidden" name="foto4" id="foto4">
        <input type="hidden" name="foto5" id="foto5">

        <div class="preview-box" id="previewBox"></div>
    </form>

    <div class="boton-centro">
        <a href="index.jsp" class="btn-custom btn-volver">Volver al inicio</a>
    </div>
</div>

<script>
    const video = document.getElementById("video");
    const canvas = document.getElementById("canvas");
    const previewBox = document.getElementById("previewBox");
    const contador = document.getElementById("contador");
    const formRegistro = document.getElementById("formRegistro");

    let fotosCapturadas = 0;

    navigator.mediaDevices.getUserMedia({ video: true })
        .then(function(stream) {
            video.srcObject = stream;
        })
        .catch(function(error) {
            alert("no se pudo acceder a la cámara: " + error);
        });

    function capturarFoto() {
        if (fotosCapturadas >= 5) {
            alert("ya capturaste las 5 fotos obligatorias.");
            return;
        }

        const context = canvas.getContext("2d");
        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;
        context.drawImage(video, 0, 0, canvas.width, canvas.height);

        const imagenBase64 = canvas.toDataURL("image/png");

        fotosCapturadas++;
        document.getElementById("foto" + fotosCapturadas).value = imagenBase64;
        contador.innerText = fotosCapturadas;

        const img = document.createElement("img");
        img.src = imagenBase64;
        previewBox.appendChild(img);
    }

    function guardarRegistro() {
        const nombre = document.getElementById("nombre").value.trim();
        const ci = document.getElementById("ci").value.trim();

        const regexNombre = /^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$/;
        const regexCi = /^[0-9]+$/;

        if (nombre === "") {
            alert("debe completar el nombre.");
            return;
        }

        if (ci === "") {
            alert("debe completar la cédula.");
            return;
        }

        if (!regexNombre.test(nombre)) {
            alert("el nombre solo debe contener letras.");
            return;
        }

        if (!regexCi.test(ci)) {
            alert("la cédula solo debe contener números.");
            return;
        }

        if (document.getElementById("foto1").value === "" ||
            document.getElementById("foto2").value === "" ||
            document.getElementById("foto3").value === "" ||
            document.getElementById("foto4").value === "" ||
            document.getElementById("foto5").value === "") {
            alert("debe capturar las 5 fotos obligatorias.");
            return;
        }

        formRegistro.submit();
    }
</script>

</body>
</html>