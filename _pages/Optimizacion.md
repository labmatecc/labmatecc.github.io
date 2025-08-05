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
  <div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <div class="button-container" style="text-align: center; margin: 20px 0;">
        <a href="https://labmatecc.github.io/Notebooks/Optimizacion/ElProblemaDeLaDieta/" 
          class="button" 
          style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
          El problema de la dieta
        </a>
      </div>
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/1a9fb0ed9d1b3cffebb2eb63cae75fbb4ec7ae1e/Im%C3%A1genes/Dieta_OP.png" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
        <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Este cuaderno aborda el problema de la optimización dietética, inspirado en el problema de la dieta de Stigler propuesto por George Stigler. Se enfoca en encontrar la combinación óptima de alimentos que satisfaga los requisitos nutricionales mínimos a un costo mínimo, considerando las restricciones de disponibilidad económica y los límites máximos y mínimos de consumo de alimentos. Además, discute la importancia de estas optimizaciones en términos de políticas públicas para abordar la seguridad alimentaria y la nutrición adecuada, destacando cómo decisiones individuales en la dieta pueden tener implicaciones económicas y sociales más amplias. </p>
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
  <div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <div class="button-container" style="text-align: center; margin: 20px 0;">
        <a href="https://labmatecc.github.io/Notebooks/Optimizacion/MetodosDeDescenso/" 
          class="button" 
          style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
          Métodos de descenso
        </a>
      </div>
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/1a9fb0ed9d1b3cffebb2eb63cae75fbb4ec7ae1e/Im%C3%A1genes/Dieta_OP.png" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
        <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Este cuaderno presenta varios métodos de optimización numérica, enfocándose en el descenso de gradiente y sus variantes. Comienza con una explicación del método de descenso, donde se busca minimizar una función iterativamente ajustando el tamaño de paso y la dirección de búsqueda. Se exploran métodos como el descenso de máximo pendiente en diferentes normas (euclidiana, cuadrática, y norma 1), así como el método de Newton, que utiliza la inversa de la matriz Hessiana para guiar la búsqueda. Se presentan implementaciones prácticas de estos métodos mostrando visualizaciones gráficas para ilustrar los conceptos discutidos.</p>
      </div>
    </div>
</div>
<hr>