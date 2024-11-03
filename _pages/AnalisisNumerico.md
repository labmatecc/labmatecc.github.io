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

<h1>Análisis Numérico</h1>

<hr>

</body>
</html>
<!-- Enteros y Punto Flotante -->
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AnalisisNumerico/EnterosYFlotante/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Enteros y Punto Flotante
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://www.profesionalreview.com/wp-content/uploads/2023/05/IEEE754.png" 
                 alt="Representación de Números" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Representación de Números Enteros y de Punto Flotante
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Enteros y Punto Flotante
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno muestra la representación de <strong>números enteros</strong> y de <strong>punto flotante</strong>. Comienza mostrando cómo se representan los enteros utilizando bits, proporcionando ejemplos prácticos y conversiones de enteros a cadenas de bits.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Luego, se muestran los números de punto flotante, explicando su representación detallada, incluyendo el signo, el exponente y el significando, y cómo estas representaciones pueden afectar los cálculos numéricos debido a errores de redondeo y límites de precisión.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                También se muestra una introducción al <strong>cálculo simbólico</strong> utilizando la librería <strong>Symbolics</strong>, mostrando cómo realizar operaciones simbólicas que no dependen de valores numéricos específicos.
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

<!-- Comparación asintótica -->
<hr>
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AnalisisNumerico/ComparacionAsintotica/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Comparación asintótica
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://media.geeksforgeeks.org/wp-content/uploads/20240329121436/big-o-analysis-banner.webp" 
                 alt="Comparación asintótica" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Comparación Asintótica de Sucesiones
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Comparación asintótica
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno comienza definiendo los conceptos de <strong>orden asintótico</strong> para sucesiones, como \(x_n = \mathcal{O}(\alpha_n)\) y \(x_n = \mathcal{o}(\alpha_n)\), que indican cómo las sucesiones \(x_n\) y \(\alpha_n\) convergen hacia cero en comparación. Proporciona ejemplos gráficos para ilustrar estas comparaciones, como \(\frac{n+1}{n^2}\) en relación con \(\frac{1}{n}\), y \(\frac{1}{n \log(n)}\) también en relación con \(\frac{1}{n}\), entre otros.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno también explora la velocidad de convergencia, describiendo la convergencia lineal y superlineal con ejemplos como \(x_n = 0.5^n\) y \(x_n = 0.5^{n^2}\). Además, aborda la convergencia de orden y cómo se puede demostrar mediante gráficos, como el caso de \(x_n = 0.5^{2^n}\).
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Finalmente, se introduce la <strong>expansión de Taylor</strong>, explicando cómo aproximar funciones mediante polinomios de Taylor y su error asociado. El cuaderno utiliza la librería <strong>TaylorSeries</strong> para generar y trabajar con estos polinomios.
            </p>
        </div>
    </div>
</div>
<!-- Ecuaciones No Lineales -->
<hr>
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AnalisisNumerico/EcuacionesNoLineales/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Ecuaciones No Lineales
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Applied_mathematics_and_computation-fig.png/500px-Applied_mathematics_and_computation-fig.png" 
                 alt="Métodos Numéricos" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Métodos Numéricos para Ecuaciones No Lineales
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Ecuaciones No Lineales
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno trata sobre métodos numéricos para encontrar las raíces de una función real \( f: \mathbb{R} \to \mathbb{R} \). Se exploran varios métodos, incluyendo el de bisección, el de Newton y el método del punto fijo. 
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El método de bisección se basa en la propiedad de cambio de signo de la función en un intervalo y se implementa para encontrar raíces de funciones continuas. El método de Newton utiliza la derivada para iterar hacia una raíz, y el método de punto fijo busca un valor \( x^* \) tal que \( F(x^*) = x^* \).
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno también presenta implementaciones y ejemplos prácticos usando la función \( \exp(x) - \sin(x) \) para ilustrar cada método.
            </p>
        </div>
    </div>
</div>
<!-- Ecuaciones No Lineales II -->
<hr>
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AnalisisNumerico/EcuacionesNoLinealesII/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Ecuaciones No Lineales II
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://tutorial.math.lamar.edu/classes/calci/NewtonsMethod_Files/image001.png" 
                 alt="Métodos Numéricos" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Métodos Numéricos para Ecuaciones No Lineales II
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Ecuaciones No Lineales II
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno aborda tres métodos para resolver ecuaciones no lineales y diferenciales: Newton, Euler y Picard. 
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El Método de Newton aproxima raíces de funciones no lineales, Euler resuelve ecuaciones diferenciales ordinarias con variantes explícita e implícita, y Picard utiliza aproximaciones iterativas basadas en integrales para garantizar la convergencia.
            </p>
        </div>
    </div>
</div>
<hr>
<!-- Ecuaciones Lineales -->
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AnalisisNumerico/EcuacionesLineales/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Ecuaciones Lineales
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://escholarium.educarex.es/useruploads/r/a/3743703/1.JPG" 
                 alt="Ecuaciones Lineales" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Métodos Numéricos para Ecuaciones Lineales
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Ecuaciones Lineales
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno comienza con una introducción al sistema de ecuaciones lineales representado por la ecuación \( A x = b,\) donde \( A \) es una matriz y \( x \) y \( b \) son vectores. Luego, explora cómo calcular diferentes normas de vectores y matrices en Julia, proporcionando ejemplos prácticos de cómo obtener normas subordinadas y de Frobenius.
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Luego, se presenta la factorización LU, incluyendo un algoritmo para descomponer una matriz en productos de matrices triangulares y cómo implementarlo en Julia. Se presentan ejemplos de factorización LU con matrices específicas, incluyendo la verificación de la precisión de la factorización mediante normas. También se discute la factorización PA=LU con pivoteo, utilizando ejemplos adicionales como la matriz de Hilbert y matrices diagonales dominantes. Luego de esto, el cuaderno aborda la factorización de Cholesky para matrices simétricas y definidas positivas, y cómo resolver sistemas lineales en Julia usando el operador backslash.
            </p>
        </div>
    </div>
</div>
<hr>


<!-- Interpolación -->
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AnalisisNumerico/Interpolacion" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Interpolación
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://opinionessobreciencia.wordpress.com/wp-content/uploads/2016/04/extrapolacion-interpolacion.png" 
                 alt="Interpolación" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Métodos de Interpolación
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Interpolación
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno muestra, primero el problema de encontrar un polinomio de menor grado que pase por un conjunto de puntos dados \((x_i, y_i)\), es decir, la interpolación polinomial, y se describen las formas de Newton y Lagrange para calcular este polinomio. 
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Además, se explora la interpolación por splines, que utiliza polinomios de grado \(k\) en intervalos distintos, garantizando suavidad en las derivadas de orden \(k-1\) en los puntos de unión. Se muestran ejemplos de la aplicación de splines constantes, lineales y cúbicos en datos caligráficos.
            </p>
        </div>
    </div>
  </div>
<hr>


<!-- Ajuste de Curvas -->
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AnalisisNumerico/AjusteDeCurvas/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Ajuste de curvas
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://pro.arcgis.com/es/pro-app/latest/tool-reference/space-time-pattern-mining/GUID-B80C73D2-5464-4A95-97CA-777A9D025546-web.png" 
                 alt="Ajuste de Curvas" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Métodos de Ajuste de Curvas
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Ajuste de Curvas
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno aborda el ajuste de curvas y datos, explorando métodos para encontrar modelos que describan con precisión el comportamiento de datos observados, centrándose en el crecimiento de tumores en ratones. 
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Se discuten varios enfoques, como el ajuste lineal, polinómico cúbico, redes neuronales artificiales y ecuaciones diferenciales, específicamente el modelo de Von Bertalanffy. El ajuste de curvas busca establecer relaciones entre variables optimizando los parámetros del modelo para minimizar el desajuste entre datos observados y generados, utilizando la técnica de mínimos cuadrados basada en la norma euclidiana.
            </p>
        </div>
    </div>
  </div>
<!-- Integración Numérica I -->
<hr>
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AnalisisNumerico/IntegracionNumericaI/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Integración Numérica I
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://www.lifeder.com/wp-content/uploads/2020/03/Simpson-01.jpg" 
                 alt="Integración Numérica" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Métodos de Integración Numérica
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Integración Numérica I
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                En este cuaderno se estudian métodos de integración numérica como las sumas de Riemann, la regla del trapecio y la regla de Simpson. 
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Estos métodos dividen un intervalo \([a,b]\) en subintervalos y aproximan el área bajo una curva utilizando rectángulos o trapecios. Se ejemplifica con las funciones \(y=x^2\) en \([0,3]\) y \(y=e^{x^2}\) en \([0,1]\), mostrando cómo estas técnicas convergen hacia el área exacta conforme se aumenta el número de subintervalos. Estos métodos son esenciales para calcular áreas bajo curvas cuando la función no tiene una integral elemental.
            </p>
        </div>
    </div>
  </div>
<hr>

<!-- Método de Elementos Finitos -->
<div class="button-container">
  <a href="https://labmatecc.github.io/Notebooks/AnalisisNumerico/FEM/" 
     class="button" 
     style="padding: 10px 20px; color: white; border: none; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Método de elementos finitos
  </a>
</div>

<div class="container" style="background-color: #f4f4f9; padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen representativa centrada con sombras (opcional) -->
            <img src="https://www.researchgate.net/profile/Jose-Gallardo-2/publication/321158466/figure/fig33/AS:838109642113032@1576832318232/Figura-310-Solucion-de-la-ecuacion-de-Poisson-desplazamiento-transversal-de-una_Q320.jpg" 
                 alt="Método de Elementos Finitos" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <!-- Pie de página -->
            <footer style="text-align: center; margin-top: 2px; font-family: 'Arial', sans-serif; color: #7f8c8d; font-size: 16px;">
                Estudio del Método de Elementos Finitos
            </footer>
            <!-- Título destacado para hacer el texto más llamativo -->
            <h2 style="font-family: 'Arial', sans-serif; color: #2C3E50; font-weight: bold; margin-bottom: 15px;">
                Método de Elementos Finitos
            </h2>
            <!-- Texto llamativo con colores, espaciado y negrita -->
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno se centra en el método de elementos finitos. En primer lugar, se estudia el comportamiento de la cuerda elástica en una dimensión. 
            </p>
            <p style="font-family: 'Arial', sans-serif; color: #34495e; font-size: 18px; line-height: 1.6; margin-bottom: 15px;">
                Aquí, discretizamos el dominio y resolvemos ecuaciones lineales con condiciones de frontera específicas. Observamos cómo los resultados varían según ajustamos los parámetros del problema. En la segunda parte, se muestra como resolver la ecuación de Poisson de manera numérica en un dominio bidimensional usando elementos finitos, esto con la ayuda de la librería Gridap.
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
                    <span>1.  Enteros y Punto Flotante </span> 
                    <a href="https://www.profesionalreview.com/2023/06/10/coma-flotante/" target="_blank" style="color: #3498db; text-decoration: none;"> Representación de Números Enteros y de Punto Flotante  </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>2.   Comparación asintótica  </span> 
                    <a href="https://www.geeksforgeeks.org/analysis-algorithms-big-o-analysis/" target="_blank" style="color: #3498db; text-decoration: none;"> Comparación Asintótica de Sucesiones  </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>3.  Ecuaciones No Lineales I  </span> 
                    <a href="https://es.wikipedia.org/wiki/Método_del_punto_fijo" target="_blank" style="color: #3498db; text-decoration: none;">   Métodos Numéricos para Ecuaciones No Lineales  </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>4.   Ecuaciones No Lineales II  </span> 
                    <a href="https://www.google.com/url?sa=i&url=https%3A%2F%2Ftutorial.math.lamar.edu%2Fclasses%2Fcalci%2Fnewtonsmethod.aspx&psig=AOvVaw3tzvGWiLFcpnZC6kimGqbu&ust=1730738644301000&source=images&cd=vfe&opi=89978449&ved=0CBgQ3YkBahcKEwiY4_CCzsCJAxUAAAAAHQAAAAAQBA" target="_blank" style="color: #3498db; text-decoration: none;">  Métodos Numéricos para Ecuaciones No Lineales II  </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>5.   Ecuaciones Lineales  </span> 
                    <a href="https://www.google.com/url?sa=i&url=https%3A%2F%2Fescholarium.educarex.es%2FCursos%2Fc84719_c3743703__Sistemas_de_ecuaciones_lineales_con_GeoGebra.php&psig=AOvVaw0LvXsypu6DIHBD-uH0jM_h&ust=1730739958304000&source=images&cd=vfe&opi=89978449&ved=0CBcQjhxqFwoTCMCK-ILTwIkDFQAAAAAdAAAAABAR" target="_blank" style="color: #3498db; text-decoration: none;">  Métodos Numéricos para Ecuaciones Lineales </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>6.   Interpolación  </span> 
                    <a href="https://opinionessobreciencia.wordpress.com/2016/04/06/cuales-son-las-diferencias-entre-prediccion-extrapolacion-e-interpolacion/" target="_blank" style="color: #3498db; text-decoration: none;">  Métodos de Interpolación  </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>7.   Ajuste de Curvas  </span> 
                    <a href="https://pro.arcgis.com/es/pro-app/latest/tool-reference/space-time-pattern-mining/GUID-B80C73D2-5464-4A95-97CA-777A9D025546-web.png" target="_blank" style="color: #3498db; text-decoration: none;">  Métodos de Ajuste de Curvas  </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>8.    Integración Numérica I   </span> 
                    <a href="https://www.lifeder.com/regla-de-simpson/" target="_blank" style="color: #3498db; text-decoration: none;">  Métodos de Integración Numérica   </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>9.    Método de Elementos Finitos   </span> 
                    <a href="https://www.researchgate.net/figure/Figura-310-Solucion-de-la-ecuacion-de-Poisson-desplazamiento-transversal-de-una_fig33_321158466" target="_blank" style="color: #3498db; text-decoration: none;">   Estudio del Método de Elementos Finitos   </a>
                </span>
                <span style="display: flex; justify-content: space-between;">
                    <span>10. Referencias</span> 
                    <a href="https://apastyle.apa.org/style-grammar-guidelines/references" target="_blank" style="color: #3498db; text-decoration: none;">References</a>
                </span>
            </p>
        </div>
    </div>
</div>






<hr>
