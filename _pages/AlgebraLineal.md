---
title: "Álgebra Lineal"
permalink: /Notebooks/AlgebraLineal/
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

<h1>Álgebra Lineal</h1>

<hr>

</body>
</html>

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/Conceptosbasicos/" 
     class="button"
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;"
  >
    Conceptos básicos
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen más grande y centrada con sombras -->
            <img src="https://assets.tivadardanka.com/2022_matrix_multiplication_def_08_695d7e6e9a.png" 
                 alt="Conceptos Básicos de Matrices" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Representación de una matríz
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Introducción a las Matrices
            </h2>
            <!-- Texto más llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                En este notebook, se presenta una <strong>introducción a las matrices</strong>. Se explica que una matriz es un conjunto rectangular de números, símbolos o expresiones organizados en filas y columnas, representados con letras mayúsculas y con su dimensión indicada por el número de filas y columnas.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se muestran ejemplos de <strong>matrices reales, simbólicas y de números complejos</strong>, junto con la explicación detallada de cómo acceder a elementos específicos y mostrar submatrices. Se introducen conceptos como matrices menores y por bloques, con ejemplos prácticos.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se exploran tipos de matrices como <strong>cuadradas, diagonales, identidad y nulas</strong>, con ejemplos aleatorios y operaciones básicas como suma y multiplicación por escalar. Se abordan operaciones más avanzadas, como la multiplicación de matrices por vectores, entre matrices y el producto de Kronecker, con ejemplos prácticos utilizando matrices aleatorias.
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

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/Vectores/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Vectores
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://www.3blue1brown.com/content/lessons/2016/vectors/figures/introduction/MathematiciansPerspective.svg" 
                 alt="Conceptos de Vectores" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Suma y producto de vectores
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Introducción a los Vectores
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno comienza explicando los <strong>vectores como conjuntos ordenados de números</strong>, resaltando su representación en Julia mediante el tipo de dato Array. Se exploran operaciones básicas, como la dimensión del arreglo.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se detalla el acceso a elementos, introduciendo el uso de índices y la función <code>end</code>. Se muestra cómo trabajar con subconjuntos de vectores mediante rangos, la <strong>comparación de vectores</strong> y de elementos individuales.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se introducen <strong>vectores nulos, canónicos y de unos</strong>, mostrando cómo construir manualmente vectores canónicos en Julia. Se utiliza el paquete <code>Plots.jl</code> para generar gráficos de vectores y visualizar datos.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Las operaciones con vectores se abordan desde la <strong>suma componente a componente</strong> hasta la <strong>multiplicación y división por escalares</strong>, proporcionando ejemplos prácticos.
            </p>
        </div>
    </div>
</div>

<!-- Introducción al procesamiento de imágenes -->
<hr>
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/Introduccionalprocesamientodeimagenes/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Introducción al procesamiento de imágenes
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXQ0vvegMO20rxejxRyqiQ5g_Op2Df-b4eUcGiH00Q5ASWRXB84qxdHrC82kdj-vtUwE8&usqp=CAU" 
                 alt="Introducción al procesamiento de imágenes" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Canales de color de una imagen
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Introducción al procesamiento de imágenes
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Este notebook introduce el procesamiento de imágenes mediante <strong>representaciones numéricas de intensidad</strong> y los <strong>canales RGB</strong>. Se destaca la creación interactiva del notebook en Pluto.jl, usando librerías como <code>Colors</code> e <code>ImageShow</code>.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                La exploración de <strong>píxeles y matrices</strong> revela propiedades RGB y facilita la manipulación eficiente de imágenes. Se abordan operaciones como la <strong>selección de subimágenes</strong>, el ajuste de tamaños y el uso del operador de <strong>Broadcasting</strong> para manipulación de datos.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Finalmente, se presentan operaciones avanzadas de procesamiento como la <strong>reducción de tamaño</strong> y la <strong>inversión</strong>, utilizando álgebra lineal para <strong>reescalar píxeles y realizar combinaciones lineales</strong>.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Para concluir, el notebook muestra la aplicación de <strong>filtros y kernels</strong>, ilustrando cómo estos pueden ser utilizados en diferentes operaciones de procesamiento de imágenes.
            </p>
        </div>
    </div>
</div>
<hr>



<!-- Descripción de grafos usando matrices -->

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/Descripciondegrafosusandomatrices/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Descripción de grafos usando matrices
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://aprende.olimpiada-informatica.org/sites/default/files/inline-images/Captura%20de%20pantalla%202019-10-18%20a%20las%2014.44.23.png" 
                 alt="Descripción de grafos usando matrices" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Grafo de navegación
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Descripción de grafos usando matrices
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno introduce conceptos básicos de <strong>grafos</strong>, como nodos, aristas y adyacencia, ilustrados mediante el famoso problema de los <strong>Puentes de Königsberg</strong>.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se explican los distintos tipos de <strong>nodos y aristas</strong>, destacando cómo la flexibilidad de los grafos permite representar diversas estructuras. A través de ejemplos interactivos, se construyen y visualizan grafos usando la librería <code>GraphPlot</code>.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                También se introducen las <strong>matrices de adyacencia e incidencia</strong>, utilizadas para representar conexiones entre nodos y aristas, facilitando el análisis y comprensión de las estructuras de grafos.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Finalmente, se presentan generadores de grafos incorporados, permitiendo crear grafos con diferentes características para fines de estudio y experimentación.
            </p>
        </div>
    </div>
</div>
<hr>


<!-- Clustering -->

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/Clustering/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Clustering
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*aZdqqvSkDcZj4SE3PK9j_Q.png" 
                 alt="Clustering en Machine Learning" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Visualización de Clustering con el algoritmo K-Means
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Clustering
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno comienza con una introducción al <strong>machine learning</strong>, destacando la importancia de la <strong>distancia euclidiana</strong> en el contexto del clustering.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se presenta una función para evaluar la calidad de los clusters y se introduce el algoritmo <code>K-Means</code>, con una implementación y un ejemplo de aplicación a datos generados aleatoriamente.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Además, se aborda el <strong>preprocesamiento de datos</strong>, que incluye la carga desde archivos y la generación aleatoria de datos.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se detallan técnicas de <strong>normalización y estandarización</strong>, proporcionando funciones para <code>Min-Máx</code> y <code>Z-Score</code>.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                La visualización de datos antes y después de la normalización se presenta, seguida de la aplicación del algoritmo <code>K-Means</code> y la visualización de los clusters resultantes.
            </p>
        </div>
    </div>
</div>
<hr>

<!-- Independencia lineal I -->

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/Independencialineal/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Independencia lineal I
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*LRTQ4Co7iQj3n7TW0qAnQg.png" 
                 alt="Independencia Lineal" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Concepto de Independencia Lineal
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Independencia Lineal I
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno comienza introduciendo el concepto de <strong>independencia lineal</strong>. Se define la dependencia e independencia lineal, relacionándolos con la existencia de combinaciones lineales no triviales.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se muestra un teorema clave que establece la relación de dependencia lineal entre dos vectores cuando uno es un múltiplo escalar del otro, ilustrando este concepto con un ejemplo específico.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Luego, se explora la relación entre matrices y la independencia lineal, destacando que las columnas de una matriz son linealmente independientes si y solo si el determinante de la matriz es diferente de cero.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se proporcionan ejemplos adicionales para determinar la dependencia o independencia lineal de conjuntos de vectores en \(\mathbb{R}^n\), utilizando el concepto de determinante para tomar decisiones sobre la independencia lineal.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se introduce el concepto de <strong>base</strong> en un espacio vectorial, demostrando que cualquier conjunto de \(n\) vectores linealmente independientes en \(\mathbb{R}^n\) genera todo el espacio, ilustrado con un ejemplo específico.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno concluye abordando el tema de <strong>vectores ortonormales</strong> y presenta el proceso de <strong>ortogonalización de Gram-Schmidt</strong> para convertir un conjunto linealmente independiente en un conjunto ortonormal.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se describen las variantes clásica y modificada del algoritmo de Gram-Schmidt, y se demuestra su aplicación en un ejemplo práctico, proporcionando código para implementar estos algoritmos.
            </p>
        </div>
    </div>
</div>
<hr>



<!-- Independencia lineal II -->
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/IndependencialinealII/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Independencia lineal II
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://substackcdn.com/image/fetch/w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F826e04a5-c4a6-453e-b9eb-b56b37f3c92f_1920x1080.png" 
                 alt="Factorización QR" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Introducción a la Factorización QR
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Independencia Lineal II
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Este notebook presenta una introducción a la <strong>factorización QR</strong>, un método clave para descomponer una matriz \( A \) en el producto de una matriz ortogonal \( Q \) y una matriz triangular superior \( R \).
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                La descomposición QR se utiliza para resolver sistemas de ecuaciones lineales y problemas de optimización. El cuaderno describe métodos para obtener la factorización QR, centrándose en las <strong>reflexiones de Householder</strong> y las <strong>rotaciones de Givens</strong>.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Primero, se explican las propiedades y el cálculo de las matrices de Householder, que se utilizan para transformar un vector en un múltiplo de un vector canónico, facilitando la ortogonalización de las columnas de una matriz. Se proporciona un algoritmo para calcular el vector y el coeficiente de Householder, junto con ejemplos prácticos.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Luego, se muestra cómo usar las reflexiones de Householder para triangularizar una matriz y obtener la matriz \( R \), así como la matriz \( Q \) mediante acumulación progresiva. Finalmente, se introducen las rotaciones de Givens, que son especialmente útiles para matrices dispersas, mostrando cómo aplicar estas rotaciones para lograr una factorización QR eficiente.
            </p>
        </div>
    </div>
</div>
<hr>


<!-- Diagonalización (Sucesión de Fibonacci) -->

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/Diagonalizacion/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Diagonalización (Sucesión de Fibonacci)
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://cdn1.byjus.com/wp-content/uploads/2019/04/Diagonal-Matrix.png" 
                 alt="Diagonalización" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Aplicaciones de la Diagonalización
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Diagonalización (Sucesión de Fibonacci)
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno comienza con la importación de librerías. Luego, aborda el tema de <strong>matrices semejantes</strong>, proporcionando definiciones y ejemplos. También incluye un teorema que establece que matrices semejantes tienen el mismo polinomio característico y, por lo tanto, los mismos valores propios.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se presentan ejemplos de matrices semejantes y se verifica que comparten los valores propios. Luego, se introduce el concepto de <strong>matriz diagonalizable</strong>, junto con un teorema que establece las condiciones para que una matriz sea diagonalizable. Se presenta un corolario que afirma que si una matriz tiene valores propios distintos, entonces es diagonalizable.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se proporcionan ejemplos de matrices diagonalizables y se calculan sus valores y vectores propios. Posteriormente, se explora la aplicación de estos conceptos a la <strong>sucesión de Fibonacci</strong>. Se describe cómo se puede expresar el sistema recursivo de Fibonacci en términos matriciales y se muestra cómo calcular directamente el n-ésimo número de Fibonacci mediante la diagonalización de la matriz asociada.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se implementa una función para calcular \(F_n\) de manera eficiente utilizando la diagonalización.
            </p>
        </div>
    </div>
</div>
<hr>


<!-- Compresión de imágenes (SVD) -->

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/SVD/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Compresión de imágenes (SVD)
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://cdn.prod.website-files.com/632808d90ad3162f9c7ada64/64943240cfcffe7760bb7f19_Why%20Image%20Compression%20is%20Necessary.webp" 
                 alt="Compresión de imágenes usando SVD" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Técnicas de Compresión de Imágenes
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Compresión de imágenes (SVD)
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                En este cuaderno, se presentan definiciones de <strong>valor y vector propio</strong>. Posteriormente, se muestra cómo hallar los valores singulares de una matriz. A continuación, se detalla la <strong>descomposición en valores singulares (SVD)</strong> con diversos ejemplos.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Luego, nos enfocamos en la descomposición en valores singulares reducida, que es la que utiliza Julia, y se muestran ejemplos específicos. Después de explorar la SVD, se muestra la <strong>compresión de imágenes</strong>. Este proceso implica realizar la SVD de la imagen y luego truncar dicha descomposición en \(k\) valores singulares (se realiza esto en cada canal de color para luego ensamblar nuevamente la imagen).
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Con este concepto presente, se presenta la creación de una <strong>marca de agua digital</strong>. Esta técnica permite personalizar imágenes sin que sea perceptible al ojo humano. La marca de agua se inserta creando una perturbación en la matriz \(V\). Una vez que la imagen está marcada, se muestra cómo deducir y recuperar la marca de agua.
            </p>
        </div>
    </div>
</div>
<hr>


<!-- Análisis de componentes principales (PCA) -->

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/PCA/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Análisis de componentes principales (PCA)
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9XGCVvE3ZGlCl-jeccCVjerpRvT_4empBag&s" 
                 alt="Análisis de Componentes Principales" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Técnicas de Reducción de Dimensionalidad
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Análisis de componentes principales (PCA)
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno aborda el <strong>Método de Análisis de Componentes Principales (PCA)</strong>, una técnica de reducción de dimensionalidad. Comienza explicando conceptos como la <strong>media</strong> y la <strong>varianza</strong> en un conjunto de datos.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Luego, se presenta la <strong>covarianza</strong> y la <strong>matriz de covarianza</strong>, seguidas por el proceso detallado de cómo se emplea el PCA. Se describen los pasos desde la centralización de datos y cálculo de la matriz de covarianza hasta la reconstrucción de datos y la compresión de imágenes utilizando las componentes principales.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se muestra cómo la compresión efectiva mantiene la información esencial de la imagen original mientras reduce su dimensionalidad. Además, se incluyen ejemplos prácticos de compresión de imágenes con diferentes números de componentes principales y se evalúa el error de compresión en cada caso.
            </p>
        </div>
    </div>
</div>
<hr>

<!-- Introducción al Procesamiento Básico de Sonido -->

<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/Sonido/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Introducción al Procesamiento Básico de Sonido
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://github.com/labmatecc/labmatecc.github.io/blob/main/Im%C3%A1genes/image.png?raw=true" 
                 alt="Introducción al Procesamiento Básico de Sonido" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Onda de sonido de un mono
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Introducción al Procesamiento Básico de Sonido
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
    Este cuaderno explora los fundamentos del <strong>procesamiento digital de sonido</strong>, abordando desde su representación discreta hasta la manipulación básica de señales de audio. Inicia explicando cómo una señal continua es convertida en digital mediante el <strong>muestreo</strong> y la <strong>cuantificación</strong>, ilustrando la importancia de la <strong>frecuencia de muestreo</strong> y la <strong>profundidad en bits</strong> en distintos contextos como telefonía, música o producción audiovisual.
</p>
<p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
    Luego, se introducen las diferencias entre señales <strong>mono</strong> y <strong>estéreo</strong>, junto con los principales <strong>tipos de datos</strong> utilizados en audio digital (enteros y punto flotante). Se enseña a leer y graficar archivos <code>.wav</code>, tanto desde archivos locales como en línea, y se analizan aspectos como la duración, número de canales y tipo de codificación de los archivos.
</p>
<p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
    Finalmente, se exploran modificaciones básicas como <strong>cambiar el volumen</strong>, <strong>recortar fragmentos</strong>, <strong>mezclar señales</strong> y <strong>reproducirlas al revés</strong>, todo con ejemplos interactivos. Se incluye además una reflexión comparativa entre el procesamiento de sonido y el de imágenes digitales, destacando las similitudes en muestreo y cuantificación, y las diferencias en dimensionalidad y percepción.
</p>
        </div>
    </div>
</div>
<hr>

<!-- Sistemas de ecuaciones diferenciales -->
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/Sistemasdeecuacionesdiferenciales/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Sistemas de ecuaciones diferenciales
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://cse.umn.edu/sites/cse.umn.edu/files/styles/webp_scaled/public/dynamical-systems-and-differential-equations%20%281%29.jpg.webp?itok=Ag4k_Iaj" 
                 alt="Sistemas de Ecuaciones Diferenciales" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">  
              Sistemas dinámicos y ecuaciones diferencialess
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Sistemas de ecuaciones diferenciales
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se comienza con una introducción sobre <strong>ecuaciones diferenciales</strong>, destacando la forma general de las ecuaciones de primer orden y proporcionando un ejemplo específico. Luego, presentan una solución numérica para el ejemplo utilizando la biblioteca <code>DifferentialEquations</code> de Julia.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno continúa con una sección sobre <strong>sistemas lineales homogéneos</strong>. Se introduce la notación matricial y se explica cómo resolver sistemas lineales homogéneos mediante el uso de matrices diagonalizables. Se presenta un ejemplo concreto, mostrando cómo la solución general de un sistema homogéneo se puede expresar en términos de los vectores propios y valores propios de la matriz asociada al sistema. Luego, se muestra cómo resolver un sistema específico con condiciones iniciales dadas.
            </p>
        </div>
    </div>
</div>
<hr>


<!-- Círculos de Gershgorin -->
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/CirculosDeGershgorin/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Círculos de Gershgorin
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://nhigham.com/wp-content/uploads/2022/11/gersh1.jpg?w=630" 
                 alt="Círculos de Gershgorin" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Teorema de Gershgorin
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Círculos de Gershgorin
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno muestra los métodos de localización de <strong>valores propios</strong>, comenzando con el <strong>Teorema de Gershgorin</strong>, que establece que todos los valores propios de una matriz están contenidos en la unión de discos en el plano complejo. Luego, se extiende la teoría a los discos de Brauer y a los discos generalizados de Gershgorin, mostrando mejoras en las estimaciones sobre la ubicación de los valores propios.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Además, se proporciona una serie de ejemplos prácticos que ilustran la aplicación de estos teoremas y métodos, mostrando cómo se pueden visualizar los discos correspondientes para diferentes matrices y cómo estos métodos pueden ser utilizados en la práctica para análisis y simulaciones.
            </p>
        </div>
    </div>
</div>
<hr>

<!-- Mínimos cuadrados -->
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AlgebraLineal/Minimoscuadrados/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Mínimos cuadrados
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://kenndanielso.github.io/mlrefined/mlrefined_images/superlearn_images/Least_Squares.png" 
                 alt="Método de Mínimos Cuadrados" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Método de ajuste por mínimos cuadrados
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Mínimos cuadrados
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno proporciona una introducción al <strong>método de mínimos cuadrados</strong>, destacando su aplicación para resolver sistemas sobredeterminados de ecuaciones lineales. Luego, se presenta un ejemplo con datos y se resuelve utilizando el operador de backslash (<code>\</code>) en Julia.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Posteriormente, el cuaderno aborda el ajuste por mínimos cuadrados en el contexto de la <strong>regresión lineal</strong> y presenta un ejemplo específico de ajuste polinomial. Se describe cómo se puede aplicar el método para encontrar un polinomio de grado específico que se ajuste de manera óptima a un conjunto de datos dado.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Finalmente, se explora el ajuste por mínimos cuadrados de ecuaciones cuadráticas en las variables <code>x</code> e <code>y</code>, y se proporciona un ejemplo práctico con datos que se ajustan a una elipse.
            </p>
        </div>
    </div>
</div>
<hr>


<!-- Recurso adicional -->
<div class="button-container">
  <a href="https://codepen.io/mr-joseph-charles/pen/WbNNgor" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Recurso adicional
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Como parte del curso de Álgebra Lineal impartido por la profesora Carolina Neira, se propuso a los estudiantes desarrollar herramientas visuales para comprender mejor los conceptos geométricos del curso, como planos, rectas y el conjunto de soluciones de sistemas de ecuaciones lineales en dos y tres dimensiones. En respuesta a esta iniciativa, el estudiante José Carlos Robles Martínez, del programa de Ciencias de la Computación, diseñó un complemento a GeoGebra que permite visualizar de forma clara e interactiva estos elementos. El recurso facilita la interpretación geométrica de la existencia y unicidad de soluciones, así como de la relación entre ecuaciones y sus representaciones en el espacio.
            </p>
        </div>
    </div>
</div>
<hr>


<!-- Contenedor para referencias de imágenes -->
<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); margin-top: 20px;">
    <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
        <!-- Imagen centrada y más pequeña -->
        <img src="https://apastyle.apa.org/images/references-page-category_tcm11-282727_w1024_n.jpg" 
             alt="Descripción de la imagen" 
             style="max-width: 50%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
        <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Créditos de las imagenes
            </footer>
        <!-- Título más grande -->
        <h2 style="font-family: 'Arial', sans-serif; font-size: 28px; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
            Imágenes tomadas de
        </h2>
        <div class="references" style="text-align: start; max-width: 900px; margin: 0 auto; font-size: 16px; color: #34495e;">
            <!-- Uso de flex para alinear el texto y el enlace -->
            <p style="font-family: 'Arial', sans-serif; line-height: 1.6;">
                <span style="display: flex; justify-content: space-between;">
                    <span>1.  Introducción a las Matrices </span> 
                    <a href="https://tivadardanka.com/blog/behind-matrix-multiplication/" target="_blank" style="color: #3498db; text-decoration: none;">Representación de una matríz </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>2.  Introducción a los Vectores </span> 
                    <a href="https://www.3blue1brown.com/lessons/vectors" target="_blank" style="color: #3498db; text-decoration: none;">Representación de una matríz </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>3. Introducción al procesamiento de imágenes  </span> 
                    <a href="https://biblus.us.es/bibing/proyectos/abreproy/12112/fichero/Documento_por_capitulos%252F3_Cap%C3%ADtulo_3.pdf" target="_blank" style="color: #3498db; text-decoration: none;">  Canales de color de una imagen </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>4.  Descripción de grafos usando matrices </span> 
                    <a href="https://aprende.olimpiada-informatica.org/" target="_blank" style="color: #3498db; text-decoration: none;"> Grafo de navegación </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>5.  Clustering </span> 
                    <a href="https://towardsdatascience.com/understanding-the-concept-of-hierarchical-clustering-technique-c6e8243758ec" target="_blank" style="color: #3498db; text-decoration: none;"> Visualización de Clustering con el algoritmo K-Means </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>6.  Independencia Lineal I </span> 
                    <a href="https://medium.com/swlh/how-to-understand-linear-independence-linear-algebra-8bab1d918509" target="_blank" style="color: #3498db; text-decoration: none;"> Concepto de Independencia Lineal </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>7.  Independencia Lineal II </span> 
                    <a href="https://thepalindrome.org/p/epsilons-no-5-the-qr-decomposition" target="_blank" style="color: #3498db; text-decoration: none;"> Introducción a la Factorización QR </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>8.   Diagonalización (Sucesión de Fibonacci)  </span> 
                    <a href="https://www.google.com/url?sa=i&url=https%3A%2F%2Fbyjus.com%2Fmaths%2Fdiagonal-matrix%2F&psig=AOvVaw1ELzbHroQlAC5MNMwRtJ0y&ust=1730727836353000&source=images&cd=vfe&opi=89978449&ved=0CBcQjhxqFwoTCNjR_PSlwIkDFQAAAAAdAAAAABAE" target="_blank" style="color: #3498db; text-decoration: none;">  Aplicaciones de la Diagonalización  </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>9.   Compresión de imágenes (SVD)  </span> 
                    <a href="https://www.shrink.media/blog/future-of-image-compression" target="_blank" style="color: #3498db; text-decoration: none;">  Técnicas de Compresión de Imágenes  </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>10.   Análisis de componentes principales (PCA) </span> 
                    <a href="https://numxl.com/blogs/principal-component-analysis-pca-102/" target="_blank" style="color: #3498db; text-decoration: none;"> Técnicas de Reducción de Dimensionalidad </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>11.   Sistemas de ecuaciones diferenciales  </span> 
                    <a href="https://cse.umn.edu/math/dynamical-systems-and-differential-equations" target="_blank" style="color: #3498db; text-decoration: none;">  Sistemas dinámicos y ecuaciones diferencialess  </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>12.   Círculos de Gershgorin  </span> 
                    <a href="https://nhigham.com/2022/11/22/what-is-gershgorins-theorem/" target="_blank" style="color: #3498db; text-decoration: none;">  Teorema de Gershgorin  </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>13.  Mínimos cuadrados </span> 
                    <a href="https://kenndanielso.github.io/mlrefined/blog_posts/8_Linear_regression/8_1_Least_squares_regression.html" target="_blank" style="color: #3498db; text-decoration: none;">  Método de ajuste por mínimos cuadrados  </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>14. Referencias</span> 
                    <a href="https://apastyle.apa.org/style-grammar-guidelines/references" target="_blank" style="color: #3498db; text-decoration: none;">References</a>
                </span>
            </p>
        </div>
    </div>
</div>






<hr>
