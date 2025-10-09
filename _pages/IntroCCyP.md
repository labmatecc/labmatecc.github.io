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

<h1>Introducción a las Ciencias de la Computación y la Programación</h1>

<hr>

</body>
</html>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
<div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/Intro_a_CC__Datos_Variables_Expresiones/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Datos, variables y expresiones
  </a>
</div>
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/1d62d017a815358d12572f9a03c70cf9c394f529/Im%C3%A1genes/Datos_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno introduce conceptos fundamentales de programación en Julia, comenzando con los tipos básicos de datos (números, cadenas y booleanos) y el uso de variables para almacenarlos. Explica cómo combinar datos y operadores en expresiones, realizar operaciones aritméticas, manipular cadenas y trabajar con tipos de datos utilizando funciones nativas. También aborda la interacción con el usuario mediante entrada de datos, operadores lógicos para realizar comparaciones y ejemplos prácticos como el cálculo del área de un círculo, utilizando fórmulas matemáticas y constantes predefinidas. Además, se enseña cómo realizar conversiones de tipos y definir constantes inmutables. Estos conceptos se presentan de manera progresiva, con ejemplos prácticos que facilitan su comprensión.
            </p>
        </div>
    </div>
</div>

<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
<div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/EnterosYFlotante/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Enteros y Punto Flotante
  </a>
</div>
    <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/470176d036020e5ef60c9e778b803cc62677ebf4/Im%C3%A1genes/Enteros_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno muestra la representación de números enteros y de punto flotante. Comienza mostrando cómo se representan los enteros utilizando bits, proporcionando ejemplos prácticos y conversiones de enteros a cadenas de bits. Luego, se muestran los números de punto flotante, explicando su representación detallada, incluyendo el signo, el exponente y el significando, y cómo estas representaciones pueden afectar los cálculos numéricos debido a errores de redondeo y límites de precisión. También se muestra una introducción al cálculo simbólico utilizando la librería Symbolics, mostrando cómo realizar operaciones simbólicas que no dependen de valores numéricos específicos.
            </p>
        </div>
    </div>
</div>

<hr>

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
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/Intro_a_CC__Estructuras_de_control/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Estructuras de control
  </a>
</div>
  <div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/956ece9e0b513b37f567056d02cf4c7d86cdb7ec/Im%C3%A1genes/Estructuras_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                El documento es un cuaderno interactivo diseñado para introducir y practicar el uso de estructuras de control en el lenguaje de programación Julia. A lo largo del material, se exploran diferentes estructuras como bucles (for y while), condicionales (if-else) y comandos avanzados (break y continue). Cada sección combina teoría con ejercicios prácticos que permiten al lector experimentar con el código directamente.

                Se presentan conceptos básicos, como iterar sobre listas y rangos, junto con ejemplos más avanzados, como bucles anidados para operar sobre matrices y el manejo de diccionarios. También incluye el uso de estructuras de control para manejar condiciones dinámicas y patrones comunes como tablas de multiplicar, triángulos de asteriscos y pirámides de números.

                Además, se introduce el manejo de excepciones con try-catch-finally, explicando cómo capturar y manejar errores en el código. Todo esto se acompaña de ejercicios prácticos que fomentan la comprensión y el dominio de estas herramientas clave en la programación.
            </p>
        </div>
    </div>
</div>

<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/Intro_a_CC__Listas_secuencias_arreglos/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Listas, secuencias y arreglos
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/79759e044772a8ad9c8e52aea907a9caac495e26/Im%C3%A1genes/Listas.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno interactivo introduce a los usuarios en el uso y la manipulación de listas, arreglos y secuencias en Julia, con un enfoque práctico y progresivo. Las listas, entendidas como colecciones unidimensionales que almacenan elementos de diferentes tipos, son el punto de partida. Se detalla cómo crearlas, acceder a sus elementos mediante índices, modificarlas dinámicamente y aplicar operaciones básicas como ordenarlas, invertirlas o calcular su longitud.

                El documento avanza hacia los arreglos multidimensionales, explicando cómo se pueden representar datos en dos o más dimensiones, como matrices. Aquí se explora cómo reorganizar datos con la función reshape(), acceder a elementos específicos utilizando índices, y realizar operaciones comunes como transponer matrices o calcular la suma total de sus elementos.

                También se abordan las secuencias, una estructura que facilita el manejo de rangos de números en Julia. Se muestra cómo aplicar funciones a los elementos de una secuencia utilizando map(), cómo filtrar valores con filter() y cómo convertir una secuencia en un arreglo manipulable con collect(). A esto se suma la introducción a técnicas más avanzadas, como el uso de reduce() para combinar elementos de una colección en un solo valor, unique() para eliminar duplicados y otras operaciones agregadas.

                El cuaderno incluye una serie de ejercicios prácticos que refuerzan cada concepto explicado. Entre ellos destacan la manipulación de listas mediante la adición y eliminación de elementos, la reorganización y operación sobre matrices, y el procesamiento de secuencias para transformar y filtrar datos. Además, se proponen ejercicios clásicos como invertir listas, eliminar duplicados y rotar elementos, que permiten aplicar las habilidades adquiridas de manera concreta.
            </p>
        </div>
    </div>
</div>

<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/Intro_a_CC__Funciones/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Funciones
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/82727d9895b614a24184be989224b02e3ac2e6f8/Im%C3%A1genes/Funciones_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno interactivo explica el concepto y uso de funciones en Julia, desde lo básico hasta lo avanzado, destacando su papel en la modularidad y reutilización del código. Comienza con la definición de funciones básicas, incluyendo argumentos predeterminados y sintaxis compacta. Luego, explora el manejo de variables locales y globales, aclarando su impacto en el alcance y el rendimiento del código.

                Avanza hacia funciones intermedias y avanzadas, como el uso de argumentos con nombre, funciones anónimas y de orden superior, que permiten recibir o devolver otras funciones. Además, introduce herramientas como map, filter y reduce para manipular colecciones de datos de forma eficiente.

                El cuaderno incluye ejercicios prácticos y visualizaciones interactivas, como gráficos de funciones cuadráticas y senoidales, que ayudan a comprender cómo las funciones pueden modelar relaciones matemáticas y dinámicas. Es una guía completa y progresiva que proporciona una sólida base para trabajar con funciones en Julia de manera eficiente y organizada.
            </p>
        </div>
    </div>
</div>

<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/Intro_a_CC__Recursion/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Recursión
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/c8317bd94eb599fe9749f7b8fc197c1f33987e3d/Im%C3%A1genes/Recursion.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno interactivo explica a fondo la recursión en Julia, mostrando cómo resolver problemas dividiéndolos en subproblemas más pequeños. Comienza con ejemplos básicos como el cálculo del factorial y la suma de números hasta un valor dado, destacando la importancia de los casos base para evitar ciclos infinitos. 

                Se exploran conceptos intermedios como la sucesión de Fibonacci, que genera un árbol de cálculos, y el problema de las Torres de Hanoi, que muestra la lógica paso a paso. A nivel avanzado, se introducen la recursión de cola para optimizar funciones, la memoización para evitar cálculos repetitivos y el backtracking, utilizado en problemas como las N-reinas.

                El cuaderno incluye visualizaciones como el triángulo de Sierpinski, que demuestra cómo las funciones recursivas pueden generar patrones gráficos complejos. Es una guía completa que combina teoría, práctica y ejemplos interactivos, ideal para aprender y dominar la recursión en Julia.
            </p>
        </div>
    </div>
</div>

<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/Intro_a_CC__Clases_y_Objetos/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Clases y Objetos
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/f2a51757eebb7dc49a37c8620ea2c33fde05adcc/Im%C3%A1genes/Clases_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno interactivo explica cómo Julia implementa conceptos similares a clases y objetos a través de estructuras (struct) y tipos. Introduce estructuras inmutables y mutables para definir datos y métodos que operan sobre ellos, mostrando cómo asociar funciones a estructuras y sobrecargar funciones para diferentes tipos.

                También aborda constructores personalizados para crear instancias con lógica específica y el uso de tipos abstractos para jerarquías y polimorfismo. Se destaca la composición como alternativa a la herencia para combinar estructuras de manera modular.

                Incluye ejemplos prácticos como la creación de puntos, círculos y la visualización interactiva del área de un círculo mediante controles dinámicos. Este material combina teoría y práctica para enseñar conceptos clave de programación estructurada en Julia, enfatizando la claridad y la reutilización del código.
            </p>
        </div>
    </div>
</div>

<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/ModelacionMatematica/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Introducción a la modelación matemática
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/77ce77345373f90e86b4469c529862b45354eac9/Im%C3%A1genes/Modelacion_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno muestra una introducción a la modelación matemática. Se centra en el problema de estimar la cantidad de jugo en una naranja mediante un enfoque matemático. Se presenta un modelo matemático básico asumiendo la forma esférica de la naranja y propone un método numérico para estimar la cantidad de jugo. También se discute la implementación del método numérico y la importancia de determinar y validar los parámetros del modelo, así como de considerar y cuantificar los diferentes errores introducidos en el proceso de modelación.
            </p>
        </div>
    </div>
</div>

<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/EcuacionesNoLineales/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Ecuaciones No Lineales
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/bf017b00f2afb10fbaa0ba66668eef5507280045/Im%C3%A1genes/NoLineales.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno trata sobre métodos numéricos para encontrar las raíces de una función real \( f: \mathbb{R} \to \mathbb{R} \). Se exploran varios métodos, incluyendo el de bisección, el de Newton y el método del punto fijo. El método de bisección se basa en la propiedad de cambio de signo de la función en un intervalo y se implementa para encontrar raíces de funciones continuas. El método de Newton utiliza la derivada para iterar hacia una raíz, y el método de punto fijo busca un valor \( x^* \) tal que \( F(x^*) = x^* \). El cuaderno también presenta implementaciones y ejemplos prácticos usando la función \( \exp(x) - \sin(x) \) para ilustrar cada método.
            </p>
        </div>
    </div>
</div>

<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/AjusteDeCurvas/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Ajuste de curvas
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/de0a5296db0038c623d076e91f70c2fc1df519b7/Im%C3%A1genes/Ajuste_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno aborda el ajuste de curvas y datos, explorando métodos para encontrar modelos que describan con precisión el comportamiento de datos observados, centrándose en el crecimiento de tumores en ratones. Se discuten varios enfoques, como el ajuste lineal, polinómico cúbico, redes neuronales artificiales y ecuaciones diferenciales, específicamente el modelo de Von Bertalanffy. El ajuste de curvas busca establecer relaciones entre variables optimizando los parámetros del modelo para minimizar el desajuste entre datos observados y generados, utilizando la técnica de mínimos cuadrados basada en la norma euclidiana.
            </p>
        </div>
    </div>
</div>

<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/Intro_a_CC__Grafos/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Grafos
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/41435bd9ba076939143535e454ffb286f8956ccc/Im%C3%A1genes/Grafos_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                La teoría de grafos estudia cómo los objetos están relacionados entre sí mediante nodos y aristas. Los grafos pueden ser dirigidos (con relaciones unidireccionales) o no dirigidos (relaciones bidireccionales) y se utilizan para modelar situaciones como redes sociales, sistemas de transporte y conexiones en sistemas complejos. 

                Propiedades clave incluyen el grado de los nodos (número de conexiones), la conexidad (si todos los nodos están interconectados), los ciclos (rutas cerradas) y las componentes conexas (subgrafos donde todos los nodos están conectados entre sí). 

                Los algoritmos como BFS (búsqueda en amplitud) y DFS (búsqueda en profundidad) permiten explorar y analizar grafos, encontrar caminos y detectar patrones. La representación visual de grafos facilita el análisis y su aplicación en áreas como redes computacionales, optimización de rutas y biología, mostrando su relevancia práctica en múltiples disciplinas.
            </p>
        </div>
    </div>
</div>
<hr>

<!-- Botón de optimización -->

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/Intro_a_CC__Optimizacion/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Optimización
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/bf017b00f2afb10fbaa0ba66668eef5507280045/Im%C3%A1genes/Optimizacion_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                La optimización es un proceso para encontrar los valores máximos o mínimos de una función, con o sin restricciones. Es fundamental en áreas como la economía, la ingeniería y la ciencia de datos, donde se busca maximizar eficiencia, minimizar costos o resolver problemas complejos.

                En la optimización sin restricciones, el objetivo es localizar extremos locales o globales de una función, mientras que en la optimización con restricciones se añaden condiciones que deben cumplirse, como límites en los valores de las variables. Se emplean ejemplos como funciones cuadráticas simples y funciones no lineales con múltiples puntos óptimos, como la función de Himmelblau.

                Los gráficos ayudan a visualizar el comportamiento de las funciones y los puntos óptimos, reforzando la comprensión de las técnicas de optimización. Este enfoque permite aplicar métodos para resolver problemas prácticos en distintos contextos.
            </p>
        </div>
    </div>
</div>

<hr>

<!-- Botón de Complejidad computacional -->


<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/Complejidad_computacional/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Complejidad computacional
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Complejidad_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                El contenido de este documento se centra en la complejidad computacional, un área de estudio que evalúa la eficiencia de los algoritmos en términos de tiempo y espacio. Se explican conceptos fundamentales como las notaciones de complejidad O-grande (para el peor caso), Omega-grande (para el mejor caso), y Theta (para casos promedio), utilizadas para describir el comportamiento de los algoritmos a medida que crece el tamaño de los datos de entrada.

                Se destacan ejemplos prácticos, como la búsqueda secuencial (complejidad lineal, O(n)) y la búsqueda binaria (complejidad logarítmica, O(log n)). Además, se incluyen ejercicios y visualizaciones que comparan estas técnicas, mostrando gráficamente cómo varía su rendimiento.

                El documento también aborda la complejidad espacial, explicando cuánta memoria utilizan los algoritmos, especialmente los recursivos, que consumen más espacio debido al uso de la pila de llamadas. Se introducen algoritmos clásicos de ordenamiento como el ordenamiento burbuja O(n^2) y el ordenamiento rápido O(n log n).

                Finalmente, se exploran problemas más avanzados, como los problemas P y NP, con ejemplos como el Problema del Viajante de Comercio y el Problema de la Mochila, explicando su dificultad computacional y cómo estas soluciones pueden verificarse en tiempo polinómico. Se utilizan gráficos, ejemplos prácticos y visualizaciones para hacer comprensibles estos conceptos teóricos y su aplicabilidad.
            </p>
        </div>
    </div>
</div>
<hr>

<!-- Botón de Introducción a la criptografía -->

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/Introduccion_a_la_criptografia/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Introducción a la criptografía
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Cripto_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno ofrece una introducción exhaustiva a los pilares de la criptografía, repasando su evolución histórica, sus aplicaciones y los desafíos que enfrenta en la actualidad. En él se explica cómo la criptografía garantiza la seguridad de la información mediante propiedades como la confidencialidad, la integridad, la autenticación y el no repudio, e ilustra técnicas clásicas (por ejemplo, el cifrado César o el de transposición) para comprender sus limitaciones frente a los métodos modernos. A continuación se profundiza en los distintos enfoques criptográficos: la criptografía simétrica, que emplea una única clave (por ejemplo, AES); la criptografía asimétrica, basada en pares de claves públicas y privadas (como RSA o criptografía de curvas elípticas); y las funciones hash, que generan resúmenes irreversibles de datos para usos como firmas digitales o protección de contraseñas.

                Además, el cuaderno incluye ejemplos prácticos de implementación de algoritmos (desde operaciones de XOR hasta esquemas completos de AES y RSA) y aborda conceptos avanzados como la criptografía poscuántica, analizando los retos que plantea la llegada de la computación cuántica. Para facilitar el aprendizaje, se proponen ejercicios y visualizaciones interactivas que muestran cómo estas técnicas protegen la información en aplicaciones modernas, desde blockchain y transacciones electrónicas hasta el aseguramiento de redes seguras.
            </p>
        </div>
    </div>
</div>
<hr>



<!-- Botón de Modelamiento 3D -->

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/IntroCCyP/Intro_a_CC__Modelamiento3D/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Introducción al modelamiento 3D
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                El contenido explora el modelado tridimensional y la representación de datos en 3D usando PlutoPlotly, centrándose en la creación y análisis de gráficos interactivos. Comienza con la introducción de puntos tridimensionales definidos por coordenadas (x, y, z), visualizados mediante gráficos de dispersión que permiten analizar la distribución de datos en un espacio tridimensional. Estos gráficos pueden personalizarse con marcadores, líneas y combinaciones de ambos.

                Se aborda la creación de mallas y superficies, estructuras que conectan puntos mediante caras triangulares para formar representaciones más complejas, como superficies topográficas. Estas herramientas permiten observar características clave como relieves y contornos, destacando variaciones en los datos.

                Los gráficos de dispersión y burbujas se utilizan para mostrar relaciones entre varias dimensiones de datos, como el tamaño y color de los puntos que representan información adicional. Esto es útil para analizar datos multivariados en áreas como demografía, economía o astrofísica.

                También se exploran gráficos de líneas tridimensionales que conectan puntos para mostrar tendencias o evoluciones en el tiempo. Además, se simulan movimientos aleatorios, como el movimiento Browniano, para ilustrar comportamientos dinámicos en 3D.

                Finalmente, el contenido se enfoca en la personalización de gráficos, como el ajuste de colores, transparencias y ejes, junto con el uso de cámaras dinámicas que permiten explorar los gráficos desde diferentes perspectivas. Este enfoque combina teoría y práctica para enseñar cómo usar herramientas tridimensionales para visualizar y analizar datos complejos de manera efectiva.
            </p>
        </div>
    </div>
</div>
<hr>