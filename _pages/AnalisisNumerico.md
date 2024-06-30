---
title: "Análisis Numérico"
permalink: /Notebooks/AnalisisNumerico/
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

<h1>ANÁLISIS NUMÉRICO</h1>

<hr>

</body>
</html>

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AnalisisNumerico/EnterosYFlotante/" class="button">Enteros y Punto Flotante</a>
</div>

  <div class="container">
    <div class="person">
      <div class="info">
        <p>. </p>
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

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AnalisisNumerico/IntegracionNumericaI/" class="button">Integración Numérica I</a>
</div>

<div class="container">
    <div class="person">
      <div class="info">
        <p>En este cuaderno se exploran métodos de integración numérica, como las sumas de Riemann, la regla del trapecio y la regla de Simpson.

        Estos métodos utilizan particiones del intervalo \([a,b]\) para dividirlo en subintervalos de longitud \(\Delta x\). La suma de Riemann aproxima el área usando rectángulos con alturas determinadas por \(f(x_i)\) o \(f(x_{i-1})\), mientras que la regla del trapecio utiliza trapecios con bases \([x_{i-1}, x_i]\) y alturas \(f(x_{i-1})\) y \(f(x_i)\).

        Un ejemplo concreto es calcular el área bajo la parábola \(y=x^2\) en \([0,3]\), donde se estima el área usando rectángulos y trapecios. La suma de Riemann izquierda y derecha, así como la regla del trapecio, se utilizan para aproximar estas áreas. Además, se muestra cómo estas aproximaciones convergen hacia el área exacta conforme aumenta el número de subintervalos. Otro ejemplo ilustra el uso de estos métodos para calcular el área bajo la curva \(y=e^{x^2}\) en \([0,1]\), utilizando tanto la suma de Riemann como la regla del trapecio.

        Estos métodos son fundamentales para la aproximación numérica de integrales, ofreciendo herramientas para calcular áreas bajo curvas cuando no es posible realizar la integración analítica directa. </p>
      </div>
    </div>
  </div>

<hr>