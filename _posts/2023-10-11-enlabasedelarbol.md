---
layout: single
title: "En la base del árbol: Teorema de compacidad."
excerpt: "La compacidad es el tronco de nuestro gran árbol que nos llevara a explorar distintas ramas del árbol cada una con sus peculiaridades. Por esto mismo es bueno que nos tomemos un momento para revisar bien que podemos encontrar en la base del tronco."
date: 2023-10-11
classes: wide
header:
  teaser: /assets/images/des.jpeg
  teaser_home_page: true
  icon: 
categories:
  - Nociones básicas
tags:
  - Compacidad
---

La compacidad es el tronco de nuestro gran árbol que nos llevara a explorar distintas ramas del árbol cada una con sus peculiaridades. Por esto mismo es bueno que nos tomemos un momento para revisar bien que podemos encontrar en la base del tronco.

En las ramas de nuestro gran árbol puede que encontremos lógicas que son compactas, las que no lo son, múltiples resultados derivados del teorema de compacidad e incluso la posibilidad de $$\textit{recuperar}$$ la compacidad en aquellas lógicas que no son compactas y de que manera se puede maniobrar en esas situaciones. Pero basta de mirar hacia arriba. concentrémonos en lo que tenemos al frente y escalemos con calma pero sin perder el rumbo.

El teorema de compacidad es nuestro gran aliado en la escalada y por eso mismo debemos apropiarnos muy bien de las nociones que el nos da, por eso mismo presentaremos algunos enunciaciones del mismo. evidentemente equivalentes pero que serán útiles respectivamente a lo largo de nuestra travesía.

- Sean $$L$$ un vocabulario y $$T$$ una $$L-$$Teoría. Si todos los subconjuntos finitos de $$T$$ tienen modelos, entonces $$T$$ tiene un modelo
- Sea $$\Gamma$$ un conjunto de sentencias no satisfacible entonces algún subconjunto finito $$\Gamma_0$$ de $$\Gamma$$ no es satisfacible.
- Si $$\Gamma\models\delta$$ entonces $$\Gamma_0\models\delta$$ con $$\Gamma_0$$ algún subconjunto finito.

Note que la segunda equivalencia es simplemente la contrarreciproca de la primera pero escrita en la noción de satisfacibilidad. Además la tercera equivalencia solo se tiene en lógicas donde existe la negación clásica $$\neg$$. Por ultimo si consideramos las nociones de un sistema deductivo y validez la ultima equivalencia la podemos escribir tal que, $$\textit{Si $\Gamma\vdash\delta$ entonces $\Gamma_0\vdash\delta$ con $\Gamma_0$ algún subconjunto finito.}$$

Estas son algunas de las reescrituras que nos permitirán entender con mucha mas solvencia todo lo que encontremos en las ramas que exploraremos de aquí en adelante. Si bien parece poco esta es una base robusta sobre la cual apoyarnos y estamos seguros de que no nos defraudara. En las siguientes entradas exploraremos múltiples ramas de este árbol las cuales serán aquellas cosas que nacen de la compacidad y que se nutren en mayor o menor medida de la misma.
