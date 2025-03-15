---
title: "Procesamiento de Imágenes"
permalink: /Notebooks/ProcesamientoDeImagenes/
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

<h1>Procesamiento de Imágenes</h1>

<hr>

</body>
</html>

<div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/ProcesamientoDeImagenes/Conceptosbasicos/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Conceptos básicos
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://mismat.wordpress.com/wp-content/uploads/2023/03/96165-blog.png" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Triángulo de Sierpinski
            </footer>
        <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">El cuaderno aborda conceptos básicos y aplicaciones del procesamiento de imágenes digitales en escala de grises y a color. Introduce formatos como RGB, CMY y YCbCr, y analiza cómo las imágenes pueden representarse como matrices de valores de píxeles. Además, explora cómo manipular imágenes mediante ajustes de brillo, contrastes y operaciones matemáticas en matrices.</p>
        <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">Se presentan ejemplos prácticos, como la visualización y modificación de imágenes en escala de grises, y la construcción de objetos geométricos, desde figuras simples hasta fractales como el triángulo de Sierpinski. También se explica la importancia del análisis estadístico de imágenes mediante histogramas para evaluar características como brillo y contraste.</p>
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
<div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/ProcesamientoDeImagenes/Metricas/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Métricas en imágenes
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://www.ivanandrei.com/wp-content/uploads/2022/06/rgb-ycbcr.png" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                RGB y YCbC
            </footer>
        <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">Se presentan métricas con referencia completa, como el Error Cuadrático Medio (MSE) y la Relación Señal-Ruido de Pico (PSNR), que comparan imágenes procesadas con una referencia ideal para cuantificar la distorsión. Además, se analizan métricas sin referencia, como el Índice de Similitud Estructural (SSIM) y su extensión Multi-SSIM, que evalúan la calidad visual considerando luminancia, contraste y estructura sin necesidad de una imagen ideal. También se discute el error estructural y su relación con estas métricas, proporcionando ejemplos numéricos y cálculos aplicados a imágenes de prueba.</p>
      </div>
    </div>
</div>

<hr>


<div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/ProcesamientoDeImagenes/FuncionesElementales/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Aplicaciones y funciones elementales
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://www.ivanandrei.com/wp-content/uploads/2022/06/rgb-ycbcr.png" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                RGB y YCbCr
            </footer>
        <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">El cuaderno aborda aplicaciones de funciones elementales en el procesamiento de imágenes digitales, centrándose en transformaciones potenciales, exponenciales y logarítmicas para mejorar la iluminación y el contraste. Presenta técnicas como la corrección gamma, que ajusta el brillo de imágenes mal expuestas mediante funciones de potencia. También incluye herramientas para transformar imágenes entre espacios de color RGB y YCbCr, aplicando correcciones específicas en el canal de luminancia (Y). Además, se implementan funciones para visualizar histogramas y ajustar niveles de brillo y contraste. El cuaderno utiliza imágenes subexpuestas y sobreexpuestas como ejemplos, mostrando sus respectivas transformaciones y resultados.</p>
      </div>
    </div>
</div>

<hr>

<div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/ProcesamientoDeImagenes/TranformacionesLineales/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Transformaciones lineales y automatización del proceso
  </a>
</div>
<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://loqueopino.com/wp-content/uploads/2023/07/Mejorar-la-calidad-de-una-foto.webp" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Mejora en la calidad de la imagen
            </footer>
        <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">Este cuaderno aborda el procesamiento de imágenes mediante transformaciones lineales y técnicas de automatización para mejorar la calidad visual. Se presentan funciones auxiliares en Julia para realizar tareas como la conversión entre espacios de color RGB y YCbCr, ajuste de valores de píxeles, creación de histogramas y transformaciones específicas para mejorar el contraste. Se introduce la trasformación lineal como una herramienta para expandir el rango de valores de los píxeles y mejorar significativamente el contraste de las imágenes. Además, se describe una variación de esta técnica que utiliza transformaciones lineales a trozos para ajustar los percentiles de los píxeles a intervalos uniformemente distribuidos. El cuaderno incluye ejemplos visuales que muestran los efectos de estas transformaciones.</p>
      </div>
    </div>
</div>

<hr>

<div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/ProcesamientoDeImagenes/Probabilidad/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Probabilidad en el procesamiento de imágenes
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://i.ytimg.com/vi/BC31_smmFEs/maxresdefault.jpg" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Ecualización del Histograma
            </footer>
        <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">Este cuaderno aborda conceptos de probabilidad y variables aleatorias aplicados al procesamiento de imágenes, con un enfoque particular en los histogramas. El objetivo principal es aprender a especificar y diseñar histogramas deseados mediante herramientas probabilísticas, logrando mejorar la calidad visual de imágenes digitales.</p>
        <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">Se define la relación entre imágenes digitales y variables aleatorias, donde cada píxel representa un valor que puede ser modelado como una variable aleatoria con una distribución de probabilidad. Se detalla cómo los histogramas de las imágenes representan gráficamente estas distribuciones, y cómo pueden transformarse para cumplir ciertos objetivos mediante técnicas como la ecualización del histograma. Este procedimiento busca lograr distribuciones uniformes, garantizando que todos los tonos de gris estén representados equitativamente. Además, el cuaderno introduce el teorema de transformación de variables aleatorias, explicando cómo modificar una variable aleatoria con una función de densidad conocida para que adopte otra distribución deseada.</p>
      </div>
    </div>
</div>

<hr>

<div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/ProcesamientoDeImagenes/Matrices/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Matrices y transformaciones lineales
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://comprimeme.wordpress.com/wp-content/uploads/2014/12/lenna-600x197.png" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Compresión de una imagen
            </footer>
        <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">El cuaderno explora cómo las matrices y las transformaciones lineales pueden aplicarse en el procesamiento de imágenes. El contenido incluye operaciones básicas con matrices, como la generación del negativo de una imagen, la transposición para rotaciones y reflejos, la sobreposición mediante la suma de matrices, y el producto de matrices para efectos como compresión y resaltado de bordes. También se describen métodos para segmentar partes específicas de imágenes usando matrices personalizadas. Se muestra también como modificar imágenes mediante rotaciones y cambios de perspectiva utilizando coordenadas homogéneas y proyectivas.</p>
      </div>
    </div>
</div>

<hr>

<div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/ProcesamientoDeImagenes/Difuminado-Ruido/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Difuminado y ruido
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://solucioningenieril.com/imagenes/asignaturas/vision_artificial/tema_9/9.png" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Aplicación de Filtros a una Imagen
            </footer>
        <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">El cuaderno explora técnicas de restauración de imágenes afectadas por ruido. Aborda tres tipos de ruido: AWGN (variaciones aleatorias normales), sal y pimienta (píxeles dispersos blancos y negros) y speckle (ruido multiplicativo típico en imágenes médicas). Se muestran métodos de difuminado, como el promedio simple, gaussiano y convolución, que suavizan imágenes reduciendo ruido. También se explican técnicas de filtrado como el filtrado de mediana, efectivo contra el ruido sal y pimienta, y el filtrado por variación total, que equilibra reducción de ruido y preservación de detalles. Cada método es evaluado en imágenes con diferentes tipos de ruido, destacando sus fortalezas según el caso. Incluye referencias útiles y es una guía práctica para aprender y aplicar procesamiento de imágenes.</p>
      </div>
    </div>
</div>

<hr>

<div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/ProcesamientoDeImagenes/Convolucion/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Convolución y filtros
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
      <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
      <!-- Imagen más grande y centrada con sombras -->
            <img src="https://eng.libretexts.org/@api/deki/files/20283/CircularConvolution-display.png" 
                 alt="Espacio Euclídeo" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Convolución Circular
            </footer>
        <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">Este cuaderno trata sobre el uso de la convolución y el filtrado de imágenes. Se inicia con una introducción a diferentes variantes de convoluciones (continuas, discretas, lineales, circulares, entre otras) y se centra en las convoluciones lineales y circulares, tanto para secuencias como para matrices. Posteriormente, se muestra cómo se aplica la convolución en el procesamiento de imágenes. Esto incluye el uso de kernels (también llamados filtros) que permiten realizar transformaciones locales, como suavizado, detección de bordes y mejora de detalles en imágenes. Ejemplos prácticos muestran cómo utilizar la convolución para modificar matrices asociadas a imágenes y obtener efectos específicos. Además, se exploran diferentes tipos de kernels y sus aplicaciones. Entre ellos se incluyen filtros de identidad, detección de bordes, realce, desenfoque y gradientes, con ejemplos que ilustran cómo aplicarlos mediante la función imfilter.</p>
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
            Créditos de las imágenes
        </footer>
        <!-- Título más grande -->
        <h2 style="font-family: 'Arial', sans-serif; font-size: 28px; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
            Imágenes tomadas de
        </h2>
        <div class="references" style="text-align: start; max-width: 900px; margin: 0 auto; font-size: 16px; color: #34495e;">
            <!-- Uso de flex para alinear el texto y el enlace -->
            <p style="font-family: 'Arial', sans-serif; line-height: 1.6;">
                <span style="display: flex; justify-content: space-between;">
                    <span>1. Conceptos básicos</span> 
                    <a href="https://mismat.wordpress.com/2023/03/01/el-triangulo-de-sierpinski/" target="_blank" style="color: #3498db; text-decoration: none;">El triángulo de Sierpinski</a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>2. Aplicaciones y funciones elementales</span> 
                    <a href="https://www.ivanandrei.com/rgb-vs-ycbcr-cual-es-mejor-en-una-conexion-hdmi/" target="_blank" style="color: #3498db; text-decoration: none;">RGB vs YCbCr</a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>3. Automatización del proceso</span> 
                    <a href="https://loqueopino.com/como-mejorar-la-calidad-de-una-foto-online/" target="_blank" style="color: #3498db; text-decoration: none;">Cómo mejorar la calidad de una foto</a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>4. Transformaciones lineales</span> 
                    <a href="https://comprimeme.wordpress.com/compresion-con-perdida-y-sin-perdida/" target="_blank" style="color: #3498db; text-decoration: none;">Compresión con pérdida y sin pérdida</a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>5. Probabilidad</span> 
                    <a href="https://www.youtube.com/watch?v=BC31_smmFEs" target="_blank" style="color: #3498db; text-decoration: none;">Video sobre probabilidad eb el procesamiento de imágenes</a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>6. Filtros y Ruido</span> 
                    <a href="https://solucioningenieril.com/vision_artificial/filtros_en_imagenes" target="_blank" style="color: #3498db; text-decoration: none;"> Aplicación de Filtros a una Imagen </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>7. Convolución</span> 
                    <a href="https://espanol.libretexts.org/Ingenieria/Se%C3%B1ales_y_Sistemas_%28Baraniuk_et_al.%29/07%3A_Serie_Discreta_de_Fourier_de_Tiempo_%28DTFS%29/7.05%3A_Convoluci%C3%B3n_Circular_de_Tiempo_Discreto_y_el_DTFS" target="_blank" style="color: #3498db; text-decoration: none;">Convolución circular de tiempo discreto</a>
                </span>
            </p>
        </div>
    </div>
</div>
