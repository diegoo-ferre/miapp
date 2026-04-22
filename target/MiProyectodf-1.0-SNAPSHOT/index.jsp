<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("usuario") == null) {
    response.sendRedirect("login.jsp");
    return;
}
String rol = (String) session.getAttribute("rol");
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
            padding: 40px 35px;
            border-radius: 30px;
            text-align: center;
            color: white;
            width: 100%;
            max-width: 760px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.9);
        }

        h1 {
            font-size: 44px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        p {
            font-size: 18px;
            color: #dce6ef;
            margin-bottom: 25px;
        }

        .camera-box {
            margin: 0 auto 25px auto;
            width: 100%;
            max-width: 520px;
            border-radius: 22px;
            overflow: hidden;
            border: 3px solid rgba(255,255,255,0.08);
            box-shadow: 0 8px 25px rgba(0,0,0,0.5);
            background: #000;
        }

        video {
            width: 100%;
            height: auto;
            display: block;
            background: #000;
        }

        .estado-camara {
            margin-top: 10px;
            margin-bottom: 20px;
            font-size: 15px;
            color: #cfd8dc;
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
            cursor: pointer;
        }

        .btn-custom:hover {
            transform: scale(1.03);
            color: white;
            text-decoration: none;
        }

        .btn-verificar { background: linear-gradient(45deg, #7b1fa2, #9c27b0); }
        .btn-registro { background: linear-gradient(45deg, #00b09b, #96c93d); }
        .btn-lista { background: linear-gradient(45deg, #2193b0, #6dd5ed); }
        .btn-salarios { background: linear-gradient(45deg, #f39c12, #f1c40f); }
        .btn-dashboard { background: linear-gradient(45deg, #5e35b1, #8e24aa); }
        .btn-cerrar { background: linear-gradient(45deg, #dc3545, #ff6b81); }
        .btn-usuarios { background: linear-gradient(45deg, #e17055, #fab1a0); }
        .btn-asistencias { background: linear-gradient(45deg, #6c5ce7, #a29bfe); }
        .btn-salario-base { background: linear-gradient(45deg, #00b894, #00cec9); }
        .btn-salario-auto { background: linear-gradient(45deg, #6c5ce7, #a29bfe); }
        .btn-descuentos { background: linear-gradient(45deg, #6c5ce7, #a29bfe); }
        .btn-liquidacion { background: linear-gradient(45deg, #00b894, #55efc4); }

        canvas {
            display: none;
        }
    </style>
</head>
<body>

<div class="contenedor">
    <h1>Bienvenido</h1>
    <p>Verificación rápida por cámara y acceso a los módulos del sistema.</p>

    <div class="camera-box">
        <video id="video" autoplay playsinline muted></video>
    </div>

    <div class="estado-camara" id="estadoCamara">iniciando cámara...</div>

    <div>
        <canvas id="canvas"></canvas>
        <button type="button" class="btn-custom btn-verificar" onclick="verificarRostro()">Verificar rostro</button>
    </div>

    <div id="resultadoReconocimiento" style="margin-top:20px;"></div>

    <a href="registro.jsp" class="btn-custom btn-registro">Registrar persona</a>
    <a href="lista.jsp" class="btn-custom btn-lista">Ver registros</a>
    <a href="salarios.jsp" class="btn-custom btn-salarios">Gestión de salarios</a>
    <a href="dashboard.jsp" class="btn-custom btn-dashboard">Ver dashboard</a>
    <a href="ver_accesos.jsp" class="btn-custom btn-asistencias">Ver accesos</a>
    <a href="ver_asistencias.jsp" class="btn-custom btn-asistencias">Ver asistencias</a>
    <a href="salario_base.jsp" class="btn-custom btn-salario-base">Asignar sueldo base</a>
    <a href="motivos_descuento.jsp" class="btn-custom btn-salario-auto">Motivos de descuento</a>
    <a href="aplicar_descuentos.jsp" class="btn-custom btn-descuentos">Aplicar descuentos</a>
    <a href="liquidacion_mensual.jsp" class="btn-custom btn-liquidacion">Liquidación mensual</a>

    <% if ("admin".equals(rol)) { %>
        <a href="usuarios.jsp" class="btn-custom btn-usuarios">Administrar usuarios</a>
    <% } %>

    <a href="logout.jsp" class="btn-custom btn-cerrar">Cerrar sesión</a>
</div>

<script>
    const video = document.getElementById("video");
    const canvas = document.getElementById("canvas");
    const estadoCamara = document.getElementById("estadoCamara");
    const resultadoReconocimiento = document.getElementById("resultadoReconocimiento");

    navigator.mediaDevices.getUserMedia({ video: true })
        .then(function(stream) {
            video.srcObject = stream;
            estadoCamara.innerText = "cámara activa";
        })
        .catch(function(error) {
            estadoCamara.innerText = "no se pudo acceder a la cámara";
            alert("no se pudo acceder a la cámara: " + error);
        });

    async function verificarRostro() {
        if (!video.srcObject) {
            alert("la cámara no está disponible.");
            return;
        }

        const context = canvas.getContext("2d");
        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;
        context.drawImage(video, 0, 0, canvas.width, canvas.height);

        const imagenBase64 = canvas.toDataURL("image/png");

        resultadoReconocimiento.innerHTML = `
            <div class="alert alert-info">
                verificando rostro...
            </div>
        `;

        try {
            const respuesta = await fetch("http://192.168.2.14:5000/reconocer", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    foto: imagenBase64
                })
            });

            const data = await respuesta.json();

            if (data.resultado === "permitido") {
                try {
                    const params = new URLSearchParams();
                    params.append("persona_id", data.persona_id);
                    params.append("nombre", data.nombre);
                    params.append("ci", data.ci);

                    const respAsistencia = await fetch("marcar_asistencia.jsp", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: params.toString()
                    });

                    const asistencia = await respAsistencia.json();

                    if (asistencia.ok && asistencia.tipo === "entrada") {
                        resultadoReconocimiento.innerHTML = `
                            <div class="alert alert-success">
                                acceso permitido.<br>
                                <strong>nombre:</strong> ${data.nombre}<br>
                                <strong>ci:</strong> ${data.ci}<br>
                                <strong>entrada registrada:</strong> ${asistencia.hora}<br>
                                <strong>similitud:</strong> ${data.similitud}
                            </div>
                        `;
                    } else if (asistencia.ok && asistencia.tipo === "salida") {
                        resultadoReconocimiento.innerHTML = `
                            <div class="alert alert-success">
                                acceso permitido.<br>
                                <strong>nombre:</strong> ${data.nombre}<br>
                                <strong>ci:</strong> ${data.ci}<br>
                                <strong>salida registrada:</strong> ${asistencia.hora}<br>
                                <strong>horas trabajadas:</strong> ${asistencia.horas}<br>
                                <strong>minutos tardanza:</strong> ${asistencia.tardanza}
                            </div>
                        `;
                    } else {
                        resultadoReconocimiento.innerHTML = `
                            <div class="alert alert-warning">
                                ${asistencia.mensaje}
                            </div>
                        `;
                    }
                } catch (e) {
                    resultadoReconocimiento.innerHTML = `
                        <div class="alert alert-danger">
                            se reconoció a la persona, pero hubo un error al registrar la asistencia.
                        </div>
                    `;
                }
            } else if (data.resultado === "denegado") {
                resultadoReconocimiento.innerHTML = `
                    <div class="alert alert-danger">
                        persona no registrada.
                    </div>
                `;
            } else if (data.resultado === "sin_rostro") {
                resultadoReconocimiento.innerHTML = `
                    <div class="alert alert-warning">
                        no se detectó un rostro en la imagen.
                    </div>
                `;
            } else {
                resultadoReconocimiento.innerHTML = `
                    <div class="alert alert-danger">
                        error: ${data.mensaje}
                    </div>
                `;
            }
        } catch (error) {
            resultadoReconocimiento.innerHTML = `
                <div class="alert alert-danger">
                    no se pudo conectar con el microservicio Flask.
                </div>
            `;
        }
    }
</script>

</body>
</html>