---
layout: single
title: "Las ramas mas allá del primer orden: ¿Que pasa con Löwenheim-Skolem?"
excerpt: "El teorema de Löwenheim-Skolem es uno de los mas útiles en primer orden siendo un resultado directo de la existencia de compacidad en esas lógicas, luego es natural preguntarse si ambas versiones del mismo tanto la ascendente como la descendente todavía valen en lógicas de mayor orden, en este caso en infinitarias, mas específicamente el caso anteriormente mencionado que es de las que mejor comportamiento tiene pero nos deprimió un poco el fallo de generalizar la compacidad allí de forma realmente útil."
date: 2023-10-22
classes: wide
header:
  teaser: /assets/images/des.jpeg
  teaser_home_page: true
  icon: 
categories:
  - Mas allá del primer orden
tags:
  - El teorema de Löwenheim-Skolem
---

El teorema de Löwenheim-Skolem es uno de los mas útiles en primer orden siendo un resultado directo de la existencia de compacidad en esas lógicas, luego es natural preguntarse si ambas versiones del mismo tanto la ascendente como la descendente todavía valen en lógicas de mayor orden, en este caso en infinitarias, mas específicamente el caso de $$L_{\omega_1,\omega}$$ que es de las que mejor comportamiento tiene pero nos deprimió un poco el fallo de generalizar la compacidad allí de forma realmente útil.

En primera instancia encontramos que se puede generalizar de manera muy similar a la lógica de primer orden la versión descendente del mismo. En particular para $$L_{\omega_1,\omega}$$ se puede mostrar en un estilo muy similar al de la prueba original que dado un conjunto de $$\L_{\omega_1.\omega}$$-sentencias que tenga un modelo infinito entonces este tiene un modelo contable. Caso contrario es el del teorema en el sentido ascendente ya que la sentencia que caracteriza el modelo estándar de la aritmética en $$L_{\omega_1,\omega}$$ tiene modelos contables pero no de cardinal mayor. El hecho de que la versión ascendente falle es algo usual en lógicas $$L_{\kappa,\omega}$$ con $$\kappa\geq\omega_1$$ pero no es motivo alguno para deprimirse ya que esto se puede sortear por medio de los $$\textit{Números de Hanf.}$$

Definimos al numero de Hanf de un lenguaje $$L$$ como el menor cardinal $$\kappa$$ tal que si dada una $$\L$$-sentencia existe un modelo de cardinal $$\kappa$$ tiene modelos de cardinales arbitrarios. Este numero lo denotamos por $$h(L)$$. Además para cada $$L$$-sentencia $$sigma$$ que no tenga modelos de cardinal arbitrario definimos $$\kappa(\sigma)$$ como el menor cardinal $$\kappa$$ tal que $$\sigma$$ no posee modelos de ese cardinal. Luego si $$\lambda$$ es el supremo de todos los $$\kappa(\sigma)$$ entonces si una sentencia de $$L$$ tiene modelo de cardinal $$\lambda$$ entonces tiene modelos arbitrariamente grandes. Luego podemos definir recursivamente los siguientes cardinales:

- $$\mu(0)=\aleph_0$$
- $$\mu(\alpha+1)=2^{\mu(\alpha)}$$
- $$\mu(\lambda)=\sum_{\alpha_\lambda}\mu(\alpha)$$ para $$\lambda$$ limite.

Se puede mostrar que $$h(L_{\omega_1,\omega})=\mu(\omega_1)$$. Si bien esta extensión es valida resulta nuevamente aparatosa cuando consideramos lenguajes donde pueden haber cantidades infinitas de cuantificadores el numero de Hanf se vuelve sensible a los grandes cardinales nuevamente.
