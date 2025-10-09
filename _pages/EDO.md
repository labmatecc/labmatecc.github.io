---
title: "Ecuaciones Diferenciales Ordinarias"
permalink: /Notebooks/EDO/
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

<h1>Ecuaciones Diferenciales Ordinarias</h1>

<hr>

</body>
</html>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/ModelacionMatematica/" 
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
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno muestra una introducción a la modelación matemática. Se centra en el problema de estimar la cantidad de jugo en una naranja mediante un enfoque matemático. Se presenta un modelo matemático básico asumiendo la forma esférica de la naranja y propone un método numérico para estimar la cantidad de jugo. También se discute la implementación del método numérico y la importancia de determinar y validar los parámetros del modelo, así como de considerar y cuantificar los diferentes errores introducidos en el proceso de modelación.
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
  <a href="https://labmatecc.github.io/Notebooks/EDO/IntroduccionALasEDOs/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Introducción a las ecuaciones diferenciales
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                En este notebook, se presenta una introducción a las ecuaciones diferenciales ordinarias, se muestran diferentes formas de abordar las ecuaciones diferenciales. Cómo resolver ecuaciones de primer orden con dos ejemplos, resolvemos un problema de calefacción, investigamos un modelo de crecimiento de tumores, resolvemos un sistema de ecuaciones diferenciales, mostramos también las ecuaciones de Lorenz y su solución y, para finalizar, se modela y resuelve el problema físico del péndulo doble.
                Por otro lado, es importante reconocer que las ecuaciones diferenciales siguen siendo un campo dinámico de investigación hoy en día, con muchas preguntas abiertas interesantes.
            </p>
        </div>
    </div>
</div>
<hr>


<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/TunelDehormigas/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Construcción de un túnel de hormigas
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                En este cuaderno, se plantea la pregunta de cuánto tiempo le toma a una hormiga construir un túnel. Para abordar esta cuestión, se introducen variables como la longitud del túnel construido por una hormiga \(x\) y el tiempo que le toma a la hormiga \((T(x))\) construir dicho túnel. Se proponen diversas funciones candidatas para \(T(x)\) y se analizan supuestos que simplifican el modelo matemático. Luego, se busca una expresión para el tiempo que lleva una hormiga en extender el túnel desde una distancia \(x\) hasta \(x + h\). Se enumeran las variables que podrían afectar esta expresión y se plantean varios modelos matemáticos para la relación. Se convierte la expresión en una ecuación diferencial con condiciones iniciales y se resuelve para determinar el tiempo que lleva construir un túnel de longitud \(L\).
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/ProblemaDelConejo/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Atrapando al conejo
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                En este cuaderno, se aborda el problema del conejo, donde se plantea la situación de un conejo que corre hacia arriba en el eje \(y\) con velocidad constante y un perro que lo persigue desde un punto inicial en el plano. La pregunta principal es la trayectoria que sigue el perro en su intento por atrapar al conejo. Utilizando conceptos como la derivada y la ecuación diferencial, se modela y comprende la interacción entre ambos objetos en movimiento en un espacio bidimensional.
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/TrayectoriasOrtogonales/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Trayectorias ortogonales
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                En este cuaderno, se aborda el tema de las familias de curvas y las trayectorias ortogonales. Las familias de curvas son conjuntos de curvas relacionadas por ecuaciones generales con parámetros variables, mientras que las trayectorias ortogonales son curvas que tienen tangentes perpendiculares entre sí en cada punto de intersección con otra curva. Se presentan ejemplos ilustrativos de familias de curvas, como la familia de círculos con centros en el origen, junto con la resolución de ecuaciones diferenciales para encontrar trayectorias ortogonales.
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/ProblemaDeLosDosCuerpos/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    El problema de los dos cuerpos
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno se centra en el problema de los dos cuerpos, explorando la deducción de las leyes planetarias de Kepler a partir de la ley de gravitación universal de Newton. Aborda el movimiento de un planeta bajo la influencia gravitatoria de una gran partícula fija. También discute la órbita de la Tierra alrededor del Sol y proporciona referencias bibliográficas para profundizar en el tema.
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/CrecimientoDePoblaciones/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Crecimiento de poblaciones
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                En este notebook, exploramos dos modelos fundamentales de ecuaciones diferenciales ordinarias (EDOs) utilizados en la modelización matemática de fenómenos naturales y sociales: el modelo de crecimiento exponencial y el modelo de crecimiento logístico. El modelo de crecimiento exponencial describe el crecimiento de una cantidad en función del tiempo, mientras que el modelo de crecimiento logístico considera una capacidad de carga o límite para el crecimiento. Utilizando ejemplos prácticos, resolvemos las EDOs asociadas a cada modelo y analizamos situaciones específicas, como calcular el momento en que una población de peces alcanza un cierto tamaño o determinar cuánto tiempo tomará para que una población de bacterias alcance el \(90\%\) de su capacidad de carga en un entorno limitado. Además, visualizamos las soluciones generales de las EDOs y los campos de vectores asociados para comprender mejor la dinámica de crecimiento en estos contextos.
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/CrecimientoDePoblaciones/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Crecimiento de poblaciones
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                En este notebook, exploramos dos modelos fundamentales de ecuaciones diferenciales ordinarias (EDOs) utilizados en la modelización matemática de fenómenos naturales y sociales: el modelo de crecimiento exponencial y el modelo de crecimiento logístico. El modelo de crecimiento exponencial describe el crecimiento de una cantidad en función del tiempo, mientras que el modelo de crecimiento logístico considera una capacidad de carga o límite para el crecimiento. Utilizando ejemplos prácticos, resolvemos las EDOs asociadas a cada modelo y analizamos situaciones específicas, como calcular el momento en que una población de peces alcanza un cierto tamaño o determinar cuánto tiempo tomará para que una población de bacterias alcance el \(90\%\) de su capacidad de carga en un entorno limitado. Además, visualizamos las soluciones generales de las EDOs y los campos de vectores asociados para comprender mejor la dinámica de crecimiento en estos contextos.
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/OsciladorArmonico/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Oscilador Armónico
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                El cuaderno aborda el concepto del oscilador armónico en física, describiendo el movimiento periódico de un sistema alrededor de un punto de equilibrio bajo la influencia de una fuerza restauradora proporcional al desplazamiento, siguiendo la Ley de Hooke. Se discuten casos específicos como el oscilador con un resorte y un bloque, y con dos resortes y un bloque, abordando ecuaciones diferenciales y soluciones para entender el comportamiento del sistema en diferentes situaciones. Además, se menciona el péndulo simple y su relación con el movimiento armónico simple en situaciones donde la amplitud de oscilación es pequeña.
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/AjusteDeParametros/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Ajuste de parámetros
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                EEl cuaderno muestra el ajuste de curvas o ajuste de datos, dicho ajuste consiste en buscar una relación entre ellos. Es decir, si tenemos datos correspondientes a dos variables, la idea es encontrar una relación que describa de manera precisa y concisa el comportamiento de dichos datos.
                Para optimizar los valores de los parámetros del modelo, creamos una función que calcule el tamaño del desajuste entre los datos observados y los generados por los posibles modelos. Esta función recibe los datos y los valores válidos de los parámetros del modelo, y devuelve la norma del residuo. Podemos utilizar, por ejemplo, la medida de desajuste de mínimos cuadrados (norma Euclidiana). Posteriormente, empleamos una biblioteca de optimización para calcular el valor del parámetro óptimo aproximado. Otra manera de realizar la estimación de dichos parámetros es usando técnicas bayesianas, para esto se introdujeron algunos conceptos importantes relacionados con probabilidad y estadística que son necesarios para el entendimiento de los ejemplos realizados para el modelo logístico.
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/VaciadoDeTanque/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Vaciado de tanque
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                El notebook recopila datos de dos videos que muestran el vaciado de tanques. Se presenta además el modelo de la ley de Torricelli que modela dicho fenómeno, deseamos ajustar los datos hallados a este modelo. Para  optimizar los valores de los parámetros del modelo, se crea una función que calcule el tamaño del desajuste entre los datos observados y los generados por los posibles modelos, luego calculamos el valor del parámetro óptimo aproximado. También, estimamos dichos parámetros es usando técnicas bayesianas.
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/ModeloPresa-Depredador/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Modelo Presa-Depredador
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                Este cuaderno se centra en el análisis dinámico de interacciones entre especies predatorias y presas a través de las ecuaciones de Lotka-Volterra. Se explora cómo las poblaciones de presas y depredadores evolucionan en función del tiempo, resaltando que las oscilaciones en la población de depredadores ocurren después de las de las presas. Se presentan gráficos y soluciones para diferentes condiciones iniciales, mostrando cómo las variaciones en la disponibilidad de alimentos influyen en el ciclo de crecimiento y disminución de ambas poblaciones.
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/DosificacionDeUnMedicamento/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Dosificación de un medicamento
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                
                El notebook presenta un modelo matemático para la dosificación de acetaminofén en el cuerpo humano, considerando un sistema de dos compartimentos para el tracto digestivo y la sangre. Se plantean ecuaciones diferenciales para la concentración del fármaco en cada compartimento, se resuelven y se analizan las concentraciones a lo largo del tiempo, incluyendo la vida media del fármaco, concentración después de múltiples dosis y en intervalos cortos, así como la concentración mínima efectiva y máxima permitida.
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/Teorema_de_existencia_y_unicidad/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Teorema de existencia y unicidad
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                ...
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/Analisis_unidimensional/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Análisis cualitativo unidimensional
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                ...
            </p>
        </div>
    </div>
</div>
<hr>

<div class="container" style="background-color: rgb(246, 255, 240); padding: 20px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <div class="button-container" style="text-align: center; margin: 20px 0;">
  <a href="https://labmatecc.github.io/Notebooks/EDO/Analisis_bidimensional/" 
     class="button" 
     style="padding: 10px 20px; 
            color: white; 
            background-color: rgb(127, 161, 105); 
            border: none; 
            border-radius: 5px; 
            text-decoration: none; 
            font-weight: bold;">
    Análisis cualitativo bidimensional
  </a>
</div>
<div class="person">
        <div class="info" style="text-align: center; max-width: 900px; margin: 0 auto;">
            <!-- Imagen centrada -->
            <img src="https://raw.githubusercontent.com/labmatecc/labmatecc.github.io/5f4f79a0a49475fb6aa13f52bb2141ccbc0abf31/Im%C3%A1genes/Model3D_CC.png" 
                 alt="Descripción de la imagen" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); margin-bottom: 20px;">
            <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">
                ...
            </p>
        </div>
    </div>
</div>
<hr>