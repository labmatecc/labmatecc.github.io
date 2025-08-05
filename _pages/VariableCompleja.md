---
title: "Variable Compleja"
permalink: /Notebooks/VariableCompleja/
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

<h1>Variable Compleja</h1>

<hr>

</body>
</html>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <div class="button-container" style="text-align: center; margin: 20px 0;">
        <a href="https://labmatecc.github.io/Notebooks/VariableCompleja/Conceptosbasicos/" 
          class="button" 
          style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
          Conceptos básicos
        </a>
      </div>
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/ac5e5870d289da097e0398ffb92cd7c6e737ee01/Im%C3%A1genes/Basicos_VC.png" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
        <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">El cuaderno aborda la representación de datos en Julia, centrándose en números enteros, números de punto flotante y números complejos. Comienza explicando la representación de enteros y números de punto flotante, mostrando ejemplos de ello.</p>
        <p>Además, se aborda la representación de números complejos, mostrando ejemplos de su creación y operaciones básicas como la suma, resta, multiplicación, división, potenciación, inverso, conjugado y módulo. Finalmente, se introduce la forma exponencial y la fórmula de De Moivre para números complejos.</p>
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
        <a href="https://labmatecc.github.io/Notebooks/VariableCompleja/FuncionesComplejas/" 
          class="button" 
          style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
          Funciones complejas
        </a>
      </div>
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/ac5e5870d289da097e0398ffb92cd7c6e737ee01/Im%C3%A1genes/FuncionesComplejas_VC.png" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
        <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Este cuaderno explora la visualización de funciones complejas utilizando técnicas como Domain Coloring. Se explica cómo representar funciones complejas, como \( \sin(z) \) y \( \frac{1}{\sqrt{z}} \), y cómo obtener y visualizar sus partes real e imaginaria, así como el módulo y el argumento de las funciones. Se incluyen ejemplos prácticos de graficación en espacios tridimensionales, mostrando el uso de la función \(\texttt{zplot}\) para crear visualizaciones en el plano complejo, y se destaca la importancia de estas técnicas para identificar características clave como ceros y polos en las funciones complejas.</p>
      </div>
    </div>
</div>

<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <div class="button-container" style="text-align: center; margin: 20px 0;">
        <a href="https://labmatecc.github.io/Notebooks/VariableCompleja/ConjuntosdeJulia/" 
          class="button" 
          style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
          Conjuntos de Julia
        </a>
      </div>
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/ac5e5870d289da097e0398ffb92cd7c6e737ee01/Im%C3%A1genes/COnjuntos_VC.png" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
        <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">El cuaderno comienza generando y visualizando el conjunto de Mandelbrot utilizando una función iterativa que determina si un punto en el plano complejo pertenece al conjunto o no, basándose en si la serie iterada tiende hacia el infinito o permanece acotada. Después, se menciona la relación entre el conjunto de Mandelbrot y los Conjuntos de Julia, donde cada punto en el conjunto de Mandelbrot corresponde a un conjunto de Julia único.</p>
        <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Se presenta el conjunto de Julia como una familia de fractales generados por una función iterativa de números complejos \(f_c(z) = z^2 + c\), donde \(c\) es un número complejo. También se genera y visualiza conjuntos de Julia para valores específicos de \(c\), tanto para \(f_c(z) = z^2 + c\) como para \(f(z) = c \sin(z)\), con la posibilidad de ajustar los valores de los parámetros \(a\) y \(b\).</p>
      </div>
    </div>
</div>
<hr>