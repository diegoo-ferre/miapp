<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String mensaje = "";

if ("POST".equalsIgnoreCase(request.getMethod())) {

    String nombre = request.getParameter("nombre");

    String f1 = request.getParameter("foto1");
    String f2 = request.getParameter("foto2");
    String f3 = request.getParameter("foto3");
    String f4 = request.getParameter("foto4");
    String f5 = request.getParameter("foto5");

    if (nombre == null || nombre.trim().isEmpty()) {
        mensaje = "Debe completar el nombre";
    } else if (f1 == null || f2 == null || f3 == null || f4 == null || f5 == null ||
               f1.isEmpty() || f2.isEmpty() || f3.isEmpty() || f4.isEmpty() || f5.isEmpty()) {
        mensaje = "Debe capturar las 5 fotos";
    } else {

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:postgresql://jdbc:postgresql://dpg-d722t9p4tr6s739f73ag-a.oregon-postgres.render.com:5432/biometrico_ytr7",
                "biometrico_ytr7_user",
                "kV68XNGBKHeMYUF8hX0fpS2hUueDUI0p"
            );

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO personas (nombre, foto1, foto2, foto3, foto4, foto5) VALUES (?, ?, ?, ?, ?, ?)"
            );

            ps.setString(1, nombre);
            ps.setString(2, f1);
            ps.setString(3, f2);
            ps.setString(4, f3);
            ps.setString(5, f4);
            ps.setString(6, f5);

            ps.executeUpdate();

            mensaje = "Registro guardado correctamente";

            conn.close();

        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        }
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Registro</title>
    <meta charset="UTF-8">
</head>
<body style="text-align:center; font-family:Arial;">

<h2>Registrar Persona</h2>

<% if (!mensaje.equals("")) { %>
    <p><b><%= mensaje %></b></p>
<% } %>

<form method="post" onsubmit="return validarFotos();">

    <!-- 🔴 IMPORTANTE: name="nombre" -->
    <input type="text" name="nombre" id="nombre" placeholder="Nombre" required><br><br>

    <video id="video" width="300" autoplay></video><br><br>

    <button type="button" onclick="capturar()">Capturar Foto</button><br><br>

    <!-- Fotos ocultas -->
    <input type="hidden" name="foto1" id="foto1">
    <input type="hidden" name="foto2" id="foto2">
    <input type="hidden" name="foto3" id="foto3">
    <input type="hidden" name="foto4" id="foto4">
    <input type="hidden" name="foto5" id="foto5">

    <p id="contador">Fotos: 0 / 5</p>

    <canvas id="canvas" style="display:none;"></canvas>

    <button type="submit">Guardar Registro</button>

</form>

<script>
let contador = 0;

navigator.mediaDevices.getUserMedia({ video: true })
.then(stream => {
    document.getElementById("video").srcObject = stream;
});

function capturar() {
    if (contador >= 5) {
        alert("Ya capturaste las 5 fotos");
        return;
    }

    const video = document.getElementById("video");
    const canvas = document.getElementById("canvas");

    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;

    const ctx = canvas.getContext("2d");
    ctx.drawImage(video, 0, 0);

    const foto = canvas.toDataURL("image/png");

    contador++;

    document.getElementById("foto" + contador).value = foto;
    document.getElementById("contador").innerText = "Fotos: " + contador + " / 5";
}

function validarFotos() {
    if (contador < 5) {
        alert("Debes capturar 5 fotos");
        return false;
    }
    return true;
}
</script>

</body>
</html>