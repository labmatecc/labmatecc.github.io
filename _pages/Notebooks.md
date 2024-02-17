---
title: "Notebooks"
permalink: /Notebooks/
date: 2019-02-15
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
            color: green; /* Cambia el color del texto a verde */
        }
    </style>
</head>
<body>

<h1>NOTEBOOKS</h1>

</body>
</html>


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
  </style>

<html>
<head>
    <style>
        /* Estilos opcionales para la línea horizontal */
        hr {
            border: none; /* Elimina el borde */
            height: 2px; /* Altura de la línea */
            background-color: #000; /* Color de la línea */
            margin: 20px 0; /* Margen superior e inferior */
        }
    </style>
</head>
<body>
  

  <div class="container">

    <div class="person">
      <div class="info">
        <h3>Conceptos básicos</h3>
        <p>En este notebook, se presenta una introducción a las matrices. Se explica que una matriz es un conjunto rectangular de números, símbolos o expresiones organizados en filas y columnas, representados con letras mayúsculas y con su dimensión indicada por el número de filas y columnas. </p>

        <p>Se muestran ejemplos de matrices reales, simbólicas y de números complejos, junto con la explicación detallada de cómo acceder a elementos específicos y mostrar submatrices. Se introducen conceptos como matrices menores y por bloques, con ejemplos prácticos. </p>

        <p>Se exploran tipos de matrices como cuadradas, diagonales, identidad y nulas, con ejemplos aleatorios y operaciones básicas como suma y multiplicación por escalar. Se abordan operaciones más avanzadas, como la multiplicación de matrices por vectores, entre matrices y el producto de Kronecker, con ejemplos prácticos utilizando matrices aleatorias. </p>
      </div>
    </div>
  </div>

<div class="button-container">
  <a href="https://laboratoriodealgebralineal.github.io/Notebooks/Conceptosbasicos/" class="button">Conceptos básicos</a>
</div>

</body>
</html>

<hr>

</body>
</html>

<div class="container">

    <div class="person">
      <div class="info">
        <h3>Vectores</h3>
        <p>El cuaderno comienza explicando los vectores como conjuntos ordenados de números, resaltando su representación en Julia mediante el tipo de dato Array. Se exploran operaciones básicas, como la dimensión del arreglo. </p>

        <p>Se detalla el acceso a elementos, introduciendo el uso de índices y la función 'end'. Se muestra cómo trabajar con subconjuntos de vectores mediante rangos. La comparación de vectores y la comparación de elementos individuales. </p>

        <p>Se introducen vectores nulos, canónicos y de unos, mostrando cómo construir manualmente vectores canónicos en Julia. Se utiliza el paquete Plots.jl para generar gráficos de vectores y visualizar datos.</p>

        <p>Las operaciones con vectores se abordan desde la suma componente a componente hasta la multiplicación y división por escalares, proporcionando ejemplos prácticos.</p>
      </div>
    </div>
  </div>

<div class="button-container">
  <a href="https://laboratoriodealgebralineal.github.io/Notebooks/Conceptosbasicos/" class="button">Vectores</a>
</div>

</body>
</html>