---
title: "Página en construcción"
permalink: /PaginaEnConstruccion/
date: 2024-02-15
header-includes: |
    \usepackage{amsmath,mathtools}
---
<script
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
  type="text/javascript">
</script>

<html>
<head>
    <style>
        /* Estilos para centrar y cambiar el color del texto */
        h1 {
            text-align: center; /* Centra el texto horizontalmente */
            color: rgba(72, 133, 45, 0.76); /* Cambia el color del texto a verde */
        }
    </style>
</head>
<body>

<style>

    .container {
      max-width: 800px;
      margin: 20px auto;
      overflow: hidden;
    }

    .person {
      display: flex;
      margin-bottom: 20px;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
    }

    .person img {
      max-width: 200px;
      max-height: 200px;
      border-radius: 50%;
      margin-right: 20px;
      margin-left: 20px;
    }

    .person .info {
      flex: 1;
      text-align: left;
    }

    .person:nth-child(even) {
      flex-direction: row-reverse;
    }

    h2 {
      text-align: center;
      color: #333;
    }

    hr {
      border: none; /* Elimina el borde */
      height: 1px; /* Altura de la línea */
      background-color: #CCCCCC; /* Color de la línea */
      margin: 20px 0; /* Margen superior e inferior */
    }

    /* Fondo blanco */
    body {
      background-color: white;
    }

    .construction-container {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 25vh; /* Mantén la altura total de la vista */
        padding-top: 35vh; /* Aumenta el espacio superior */
        padding-bottom: 5vh; /* Reduce el espacio inferior */
        color: rgba(72, 133, 45, 0.76);
        box-sizing: border-box; /* Asegura que el padding se considere dentro de la altura total */
    }

    .construction-message {
        text-align: center;
        font-size: 2em;
        margin-right: 20px; /* Espacio entre el texto y la imagen */
    }

    .construction-image {
        max-width: 200px;
        max-height: 200px;
    }

  </style>

  <!-- Mensaje de página en construcción -->
  <div class="construction-container">
    <div class="construction-message">
      <h1>Estamos Trabajando</h1>
      <p>Esta página está en construcción. ¡Vuelve pronto!</p>
    </div>
    <img src="/assets/images/Bob.png" alt="Logotipo" class="construction-image">
  </div>

</body>
</html>