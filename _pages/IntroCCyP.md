---
title: "Introducción a las Ciencias de la Computación y la Programación"
permalink: /Notebooks/IntroCCyP/
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

<h1>INTRODUCCIÓN A LAS CIENCIAS DE LA COMPUTACIÓN Y LA PROGRAMACIÓN</h1>

<hr>

</body>
</html>

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/EnterosYFlotante/" class="button">Enteros y Punto Flotante</a>
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
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/ModelacionMatematica/" class="button">Introducción a la modelación matemática</a>
</div>

  <div class="container">
    <div class="person">
      <div class="info">
        <p>El cuaderno muestra una introducción a la modelación matemática. Se centra en el problema de estimar la cantidad de jugo en una naranja mediante un enfoque matemático. Se presenta un modelo matemático básico asumiendo la forma esférica de la naranja y propone un método numérico para estimar la cantidad de jugo. También se discute la implementación del método numérico y la importancia de determinar y validar los parámetros del modelo, así como de considerar y cuantificar los diferentes errores introducidos en el proceso de modelación. </p>
      </div>
    </div>
  </div>

<hr>

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/AjusteDeCurvas/" class="button">Ajuste de curvas</a>
</div>

<div class="container">
    <div class="person">
      <div class="info">
        <p>El cuaderno aborda el ajuste de curvas y datos, explorando métodos para encontrar modelos que describan con precisión el comportamiento de datos observados, centrándose en el crecimiento de tumores en ratones. Se discuten varios enfoques, como el ajuste lineal, polinómico cúbico, redes neuronales artificiales y ecuaciones diferenciales, específicamente el modelo de Von Bertalanffy. El ajuste de curvas busca establecer relaciones entre variables optimizando los parámetros del modelo para minimizar el desajuste entre datos observados y generados, utilizando la técnica de mínimos cuadrados basada en la norma euclidiana. </p>
      </div>
    </div>
  </div>

<hr>

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/EcuacionesNoLineales/" class="button">Ecuaciones No Lineales</a>
</div>

<div class="container">
    <div class="person">
      <div class="info">
        <p>El cuaderno trata sobre métodos numéricos para encontrar las raíces de una función real \( f: \mathbb{R} \to \mathbb{R} \). Se exploran varios métodos, incluyendo el de bisección, el de Newton y el método del punto fijo. El método de bisección se basa en la propiedad de cambio de signo de la función en un intervalo y se implementa para encontrar raíces de funciones continuas. El método de Newton utiliza la derivada para iterar hacia una raíz, y el método de punto fijo busca un valor \( x^* \) tal que \( F(x^*) = x^* \). El cuaderno también presenta implementaciones y ejemplos prácticos usando la función \( \exp(x) - \sin(x) \) para ilustrar cada método. </p>
      </div>
    </div>
  </div>

<hr>

<div class="button-container">
  <a href="https://labmatecc.github.io/PaginaEnConstruccion/" class="button">Introducción a la optimización</a>
</div>

<div class="container">
    <div class="person">
      <div class="info">
        <p>El cuaderno está en contrucción. </p>
      </div>
    </div>
  </div>

<hr>