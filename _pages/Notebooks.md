---
title: "Notebooks"
permalink: /Notebooks/
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

    .dropdown {
      position: relative;
      display: inline-block;
    }

    .dropdown-content {
      display: none;
      position: absolute;
      background-color: #f9f9f9;
      min-width: 160px;
      box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
      z-index: 1;
    }

    .dropdown-content a {
      color: black;
      padding: 12px 16px;
      text-decoration: none;
      display: block;
    }

    .dropdown-content a:hover {
      background-color: #f1f1f1;
    }

    .dropdown:hover .dropdown-content {
      display: block;
    }

    .dropdown button {
      background-color: #4CAF50;
      color: white;
      padding: 10px;
      font-size: 16px;
      border: none;
      cursor: pointer;
    }

    .dropdown button:hover {
      background-color: #3e8e41;
    }
  </style>
</head>
<body>

<h1>Ejemplo de Dropdown</h1>

<div class="dropdown">
  <button onclick="toggleDropdown()">HubSpot Resources</button>
  <div class="dropdown-content" id="dropdownContent">
    <a href="https://blog.hubspot.com/">Blog</a>
    <a href="https://academy.hubspot.com/">Academy</a>
    <a href="https://www.youtube.com/user/hubspot">YouTube</a>
  </div>
</div>

<script>
  function toggleDropdown() {
    var dropdownContent = document.getElementById("dropdownContent");
    dropdownContent.classList.toggle("show");
  }

  // Cierra el desplegable si se hace clic fuera de él
  window.onclick = function(event) {
    if (!event.target.matches('.dropdown button')) {
      var dropdowns = document.getElementsByClassName("dropdown-content");
      for (var i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show')) {
          openDropdown.classList.remove('show');
        }
      }
    }
  }
</script>

</body>
</html>

<h1>NOTEBOOKS</h1>

<hr>

</body>
</html>

<div class="button-container">
  <a href="https://laboratoriodealgebralineal.github.io/Notebooks/AlgebraLineal/" class="button">Álgebra Lineal</a>
</div>

  <div class="container">
    <div class="person">
      <div class="info">
        <p>Hola </p>
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
  <a href="https://laboratoriodealgebralineal.github.io/Notebooks/EDO/" class="button">Ecuaciones Diferenciales Ordinarias</a>
</div>

<div class="container">
    <div class="person">
      <div class="info">
        <p>hola </p>

        <p>hola.</p>
      </div>
    </div>
  </div>

<hr>