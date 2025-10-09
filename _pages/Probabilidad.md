---
title: "Probabilidad"
permalink: /Notebooks/Probabilidad/
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
  </style>

<hr>

<h1>Probabilidad</h1>

<hr>

</body>
</html>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <div class="button-container" style="text-align: center; margin: 20px 0;">
        <a href="https://labmatecc.github.io/Notebooks/Probabilidad/NumerosAleatorios/" 
          class="button" 
          style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
          Números Aleatorios
        </a>
      </div>
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/54ded4b6c05f0649b28e00a485ad3476d15b8457/Im%C3%A1genes/Aleatorios_P.png" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
        <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Este cuaderno comienza con una reflexión sobre el concepto de aleatoriedad y su formalización en términos de variables aleatorias definidas en un espacio de probabilidad (Ω, 𝓕, P). A continuación se diferencia entre aleatoriedad verdadera y pseudoaleatoriedad en computadoras y se explica el funcionamiento de los generadores congruenciales lineales (LCG) mediante la fórmula
\( X_{n+1} = (a X_n + c)\bmod m \), al tiempo que se proponen preguntas para profundizar en el papel de la semilla y el módulo. Empleando PlutoUI y controles interactivos, el usuario puede ajustar los parámetros del LCG, tales como multiplicador, incremento, módulo y semilla, y visualizar en tiempo real las secuencias generadas con Plots. Posteriormente se presenta el Generador de Lehmer, un caso particular de LCG multiplicativo que utiliza un módulo primo y un multiplicador elegido como generador primitivo para alcanzar un período máximo de \( m-1 \). A continuación se describen sus ventajas de sencillez, largo período y buena distribución, así como sus limitaciones asociadas a posibles correlaciones en dimensiones altas y a la falta de seguridad criptográfica. Por último se introduce el Generador de Fibonacci Modificado o Lagged Fibonacci Generator, que emplea retardos \( j \) y \( k \) y operaciones como suma o XOR sobre valores anteriores para producir secuencias con períodos muy largos y menor correlación, e incluye una implementación interactiva que permite experimentar con los retardos, el módulo y las semillas iniciales para comparar su comportamiento con los métodos anteriores.
</p>
      </div>
    </div>
</div>

  <html>
<head>
    <style>
        .button-container {
            text-align: center; /* Centra el contenido horizontalmente */
        }

        .button {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 20px; /* Esto hace que el botón tenga forma de pastilla */
            background-color: rgba(72, 133, 45, 0.76); /* Cambia el color del botón a verde */
            color: white; /* Cambia el color del texto a blanco */
            text-decoration: none; /* Elimina el subrayado predeterminado en los enlaces */
            font-size: 16px; /* Cambia el tamaño del texto */
            font-weight: bold; /* Hace que el texto sea más audaz */
            border: none; /* Elimina el borde del botón */
        }
    </style>
</head>
<body>

<hr>
