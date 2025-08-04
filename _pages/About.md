---
title: "Acerca del laboratorio"
permalink: /About/
date: 2024-09-30
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
        h1 {
            text-align: center;
            color: rgba(72, 133, 45, 0.76);
        }

        .container {
          max-width: 900px;
          margin: 20px auto;
          display: flex;
          flex-wrap: wrap;
          justify-content: space-between;
        }

        /* El primer .person ocupa todo el ancho para la descripción */
        .container .person:first-child {
          width: 100%;
          text-align: justify;
          margin-bottom: 40px;
          box-sizing: border-box;
        }

        /* Los demás perfiles ocupan 30% para 3 por fila */
        .container .person:not(:first-child) {
          width: 30%;
          margin-bottom: 40px;
          text-align: center;
          box-sizing: border-box;
        }

        .person img {
          width: 150px;
          height: 150px;
          object-fit: cover;
          border-radius: 50%;
          margin-bottom: 10px;
        }

        .person h3 {
          margin: 0 0 5px 0;
          font-size: 1.1em;
          color: #333;
        }

        .person p {
          margin: 0;
          color: #555;
          line-height: 1.4em;
        }

        a {
          color: #318233;
          text-decoration: none;
        }
        a:hover {
          text-decoration: underline;
        }

        hr {
          border: none;
          height: 1px;
          background-color: #CCCCCC;
          margin: 20px 0;
        }

        @media (max-width: 768px) {
          .container .person:not(:first-child) {
            width: 45%;
          }
        }

        @media (max-width: 480px) {
          .container .person:not(:first-child) {
            width: 100%;
          }
        }
    </style>
</head>
<body>

<hr>
<h1>Acerca del laboratorio</h1>
<hr>

<div class="container">

  <!-- Bloque de descripción original -->
  <div class="person">
    <div class="info">
      <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">El Laboratorio Virtual de Matemáticas es una iniciativa de varios profesores de los programas de Matemáticas y Ciencias de la Computación, creada con el objetivo de complementar los cursos del Departamento de Matemáticas a través de herramientas computacionales que faciliten la comprensión de conceptos matemáticos y su aplicación en problemas prácticos.</p>
      <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">En esta fase inicial, se está recopilando material proporcionado por los docentes del Departamento de Matemáticas. Las versiones alfa (2024) y beta (2025) del Laboratorio Virtual fueron desarrolladas y editadas por Yessica Trujillo, Carlos Nosa, Juan Galvis, Francisco Gómez, Freddy Hernández, Eduards Chipatecua y Sergio Nuñez, con el apoyo del Área Curricular de Matemáticas, bajo la dirección de Carolina Neira, durante los años 2023 y 2024.</p>
      <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Para cualquier duda, sugerencia o comentario, pueden contactarnos en: <a href="mailto:labmatecc_bog@unal.edu.co">labmatecc_bog@unal.edu.co</a>.</p>
    </div>
  </div>

  <div class="person">
    <a href="https://sites.google.com/view/jgalvis/">
      <img src="https://labmatecc.github.io/images/juan_galvis.jpeg" alt="Juan Galvis">
    </a>
    <h3><a href="https://sites.google.com/view/jgalvis/">Juan Galvis</a></h3>
    <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Docente a cargo</p>
    <p><a href="mailto:jcgalvisa@unal.edu.co">jcgalvisa@unal.edu.co</a></p>
  </div>

  <div class="person">
    <a href="https://sites.google.com/site/fagomezj/">
      <img src="https://labmatecc.github.io/images/francisco_gomez.jpeg" alt="Francisco Gómez">
    </a>
    <h3><a href="https://sites.google.com/site/fagomezj/">Francisco Gómez</a></h3>
    <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Docente colaborador</p>
    <p><a href="mailto:fagomezj@unal.edu.co">fagomezj@unal.edu.co</a></p>
  </div>

  <div class="person">
    <a href="https://sites.google.com/unal.edu.co/fohernandezr">
      <img src="https://labmatecc.github.io/images/freddy_hernandez.png" alt="Freddy Hernández">
    </a>
    <h3><a href="https://sites.google.com/unal.edu.co/fohernandezr">Freddy Hernández</a></h3>
    <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Docente colaborador</p>
    <p><a href="mailto:fohernandezr@unal.edu.co">fohernandezr@unal.edu.co</a></p>
  </div>

  <div class="person">
    <a href="#">
      <img src="https://labmatecc.github.io/images/carolina_neira.jpeg" alt="Carolina Neira">
    </a>
    <h3><a href="#">Carolina Neira</a></h3>
    <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Directora</p>
    <p><a href="mailto:cneiraj@unal.edu.co">cneiraj@unal.edu.co</a></p>
  </div>

  <div class="person">
    <a href="https://ytrujillol.github.io/">
      <img src="https://labmatecc.github.io/images/yessica_trujillo.jpg" alt="Yessica Trujillo">
    </a>
    <h3><a href="https://ytrujillol.github.io/">Yessica Trujillo</a></h3>
    <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Colaboradora</p>
    <p><a href="mailto:ytrujillol@unal.edu.co">ytrujillol@unal.edu.co</a></p>
  </div>

  <div class="person">
    <a href="https://cnosa.github.io/">
      <img src="https://labmatecc.github.io/images/carlos_nosa.jpg" alt="Carlos Nosa">
    </a>
    <h3><a href="https://cnosa.github.io/">Carlos Nosa</a></h3>
    <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Colaborador</p>
    <p><a href="mailto:cnosa@unal.edu.co">cnosa@unal.edu.co</a></p>
  </div>

  <div class="person">
    <a href="https://eguar11011.github.io/">
      <img src="https://labmatecc.github.io/images/eduards_mendez.jpg" alt="Eduards Mendez">
    </a>
    <h3><a href="https://eguar11011.github.io/">Eduards Mendez</a></h3>
    <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Colaborador</p>
    <p><a href="mailto:emendezc@unal.edu.co">emendezc@unal.edu.co</a></p>
  </div>

  <div class="person">
    <a href="#">
      <img src="https://labmatecc.github.io/images/sergio_nunez.png" alt="Sergio Nuñez">
    </a>
    <h3><a href="#">Sergio Nuñez</a></h3>
    <p style="font-family: 'Arial', sans-serif; color: #013220; font-size: 16px; line-height: 1.6; margin-bottom: 15px;">Colaborador</p>
    <p><a href="mailto:snunezs@unal.edu.co">snunezs@unal.edu.co</a></p>
  </div>
</div>

</body>
</html>