---
title: "Optimización"
permalink: /Notebooks/Optimizacion/
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

<h1>Optimización</h1>

<hr>

</body>
</html>

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/Optimizacion/ElProblemaDeLaDieta/" class="button">El problema de la dieta</a>
</div>

  <div class="container">
    <div class="person">
      <div class="info">
        <p>Este cuaderno aborda el problema de la optimización dietética, inspirado en el problema de la dieta de Stigler propuesto por George Stigler. Se enfoca en encontrar la combinación óptima de alimentos que satisfaga los requisitos nutricionales mínimos a un costo mínimo, considerando las restricciones de disponibilidad económica y los límites máximos y mínimos de consumo de alimentos. Además, discute la importancia de estas optimizaciones en términos de políticas públicas para abordar la seguridad alimentaria y la nutrición adecuada, destacando cómo decisiones individuales en la dieta pueden tener implicaciones económicas y sociales más amplias. </p>
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
  <a href="https://labmatecc.github.io/Notebooks/Optimizacion/MetodosDeDescenso/" class="button">Métodos de descenso</a>
</div>

<div class="container">
    <div class="person">
      <div class="info">
        <p>Este cuaderno presenta varios métodos de optimización numérica, enfocándose en el descenso de gradiente y sus variantes. Comienza con una explicación del método de descenso, donde se busca minimizar una función iterativamente ajustando el tamaño de paso y la dirección de búsqueda. Se exploran métodos como el descenso de máximo pendiente en diferentes normas (euclidiana, cuadrática, y norma 1), así como el método de Newton, que utiliza la inversa de la matriz Hessiana para guiar la búsqueda. Se presentan implementaciones prácticas de estos métodos mostrando visualizaciones gráficas para ilustrar los conceptos discutidos.</p>
      </div>
    </div>
  </div>

<hr>