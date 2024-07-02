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
        <p>Este cuaderno muestra la representación de números enteros y de punto flotante. Comienza mostrando cómo se representan los enteros utilizando bits, proporcionando ejemplos prácticos y conversiones de enteros a cadenas de bits. Luego, se muestran los números de punto flotante, explicando su representación detallada, incluyendo el signo, el exponente y el significando, y cómo estas representaciones pueden afectar los cálculos numéricos debido a errores de redondeo y límites de precisión. También se muestra una introducción al cálculo simbólico utilizando la librería Symbolics, mostrando cómo realizar operaciones simbólicas que no dependen de valores numéricos específicos. </p>
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
        <p>En este cuaderno se estudian métodos de integración numérica como las sumas de Riemann, la regla del trapecio y la regla de Simpson. Estos métodos dividen un intervalo \([a,b]\) en subintervalos y aproximan el área bajo una curva utilizando rectángulos o trapecios. Se ejemplifica con las funciones \(y=x^2\) en \([0,3]\) y \(y=e^{x^2}\) en \([0,1]\), mostrando cómo estas técnicas convergen hacia el área exacta conforme se aumenta el número de subintervalos. Estos métodos son esenciales para calcular áreas bajo curvas cuando la función no tiene una integral elemental. </p>
      </div>
    </div>
  </div>

<hr>

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AnalisisNumerico/FEM/" class="button">Método de elementos finitos</a>
</div>

<div class="container">
    <div class="person">
      <div class="info">
        <p>Este cuaderno se centra en el método de elementos finitos. En primer lugar, se estudia el comportamiento de la cuerda elástica en una dimensión. Aquí, discretizamos el dominio y resolvemos ecuaciones lineales con condiciones de frontera específicas. Observamos cómo los resultados varían según ajustamos los parámetros del problema. En la segunda parte, se muestra como resolver la ecuación de Poisson de manera numérica en un dominio bidimensional usando elementos finitos, esto con la ayuda de la librería Gridap. </p>
      </div>
    </div>
  </div>

<hr>