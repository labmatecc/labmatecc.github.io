---
layout: single
title: "La rama  del primer orden: Resultados clásicos II."
excerpt: "Un resultado realmente sorprendente corresponde al siguiente teorema Si ZFC es satisfactible, entonces ZFC tiene un modelo contable."
date: 2023-10-14
classes: wide
header:
  teaser: /assets/images/des.jpeg
  teaser_home_page: true
  icon: 
categories:
  - Resultados Clásicos
tags:
  - Compacidad
  - Lógicas de primer orden
---

# ZFC y la existencia de un modelo contable

Un resultado realmente sorprendente corresponde al siguiente teorema
$$
\begin{align*}
  \text{"Si ZFC es satisfactible, entonces ZFC tiene un modelo contable"}
\end{align*}
$$

Note lo sorprendente que es este teorema: Un modelo contable de este tipo (llámelo $$\mathcal{M}$$ por ejemplo), debe ser contable y aún así, modelar la existencia de conjuntos no contables como $$\mathbb{R}$$, $$\wp(\mathbb{R})$$, etc. La pregunta que surge es cómo obtenemos este resultado a partir de teorema de compacidad: La respuesta se encuentra en el **Teorema de Löwenheim-Skolem**, a partir del cual, el teorema que mencionamos se sigue como corolario.

$$\textit{Teorema de Löwenheim-Skolem}$$: Sea T una teoría en un lenguaje contable $$\mathcal{L}$$, con algún modelo infinito A. Entonces para todo cardinal infinito $$\kappa$$, existe un modelo **B** de T de cardinal igual a $$\kappa$$.

La demostración de este teorema se basa en dos pasos. Primero, se muestra que dado un modelo infinito $$\mathcal{U}$$ y $$X\subseteq A$$, existe $$\mathcal{B}$$ tal que $$X\subseteq A \prec \mathcal{U}$$ y $$\mid \mathcal{B}\mid \leq\mid X\mid +\aleph_0+\mid L\mid $$. A esto se le llama **Löwenheim-Skolem descendente**.

En segundo lugar, se muestra que para cada cardinal infinito $$\kappa$$, existe un modelo **B'** de T de cardinal mayor o igual a $$\kappa$$: **Löwenheim-Skolem ascendente**. Luego, aplicando Löwenheim-Skolem descendente, el modelo **B'** tiene un submodelo elemental (**B**) de tamaño exactamente $$\kappa$$. La compacidad entra **\textit{justamente}** en la demostración de Löwenheim-Skolem ascendente en donde se construye una extensión $$\mathcal{L'}=\mathcal{L} \cup \{c_i \mid  i<k\}$$ y se define $$T'$$ la $$\mathcal{L'}$$-teoría como $$T'=T \cup \{c_i\neq c_j \mid  i<j<k\}$$. Posteriormente se muestra que $$T'$$ es finitamente satisfactible y luego por compacidad, $$T'$$ es satisfactible. Este es un paso fundamental en la demostración y por ello, hablamos que Löwenheim-Skolem (ascendente) es consecuencia de compacidad.

# Extensión de ordenes parciales

Una aplicación final del teorema de compacidad se puede ver en el teorema de extensión de Szpilrajn que nos dice que cualquier orden parcial está contenido en un orden total; dicho de otra forma, cualquier orden parcial se puede extender a uno lineal. La demostración clásica de este teorema utiliza el lema de Zorn pero no deja de ser interesante ver que también se puede demostrar a través del teorema de compacidad. La demostración se realiza por inducción sobre el cardinal del dominio (conjunto) muestra que todo orden parcial con un dominio finito puede extenderse a un orden lineal. Entonces podemos usar el teorema de la compacidad para demostrar que todo orden parcial puede extenderse a un orden lineal, cualquiera que sea el tamaño del dominio, ya sea finito o infinito (los detalles de la prueba se pueden consultar en <a href="https://iep.utm.edu/compactness/#three"> https://iep.utm.edu/compactness/#three </a>).


## Bibliografía
- Paseau, A. Leek, R. (s.f). The Compactness Theorem. Disponible en <a href="https://iep.utm.edu/compactness/#three"> https://iep.utm.edu/compactness/#three </a>.
