---
layout: single
title: "Las ramas mas allá del primer orden: Dos lógicas intermedias."
excerpt: "En las anteriores entradas habíamos visto la lógica de primer orden, algunas extensiones muy especificas de la misma donde cambiábamos el alcance de los cuantificadores, las cuales están bastante cerca y son muy similares a la lógica de primer orden y luego estaba la lógica de segundo orden, que ya era un mundo completamente distinto de expresabilidad, a continuación presentaremos dos lógicas que siguen siento extensiones de primer orden pero están en un punto mas intermedio entre el primer y segundo orden."
date: 2023-10-18
classes: wide
header:
  teaser: /assets/images/des.jpeg
  teaser_home_page: true
  icon: 
categories:
  - Mas allá del primer orden
tags:
  - Otras lógicas
  - Lógicas intermediarias
---

En las anteriores entradas habíamos visto la lógica de primer orden, algunas extensiones muy especificas de la misma donde cambiábamos el alcance de los cuantificadores, las cuales están bastante cerca y son muy similares a la lógica de primer orden y luego estaba la lógica de segundo orden, que ya era un mundo completamente distinto de expresabilidad, a continuación presentaremos dos lógicas que siguen siento extensiones de primer orden pero están en un punto mas $$\textit{intermedio}$$ entre el primer y segundo orden.

- La lógica $$L(I)$$ extiende la lógica de la siguiente manera:
    $$Ix_0y_0\phi(x_0,\dots,x_n)\psi(y_0,\dots,y_n)$$
    Con el significado: Dados $$a_1,\dots,a_n$$ y $$b_1,\dots,b_n$$, la cardinalidad del conjunto de elementos $$x_0$$ que satisfacen $$\phi(x_0,\dots,a_n)$$ es la misma que la de el conjunto de elementos $$y_0$$ que satisfacen $$\psi(y_0,\dots,b_n)$$. Esta es conocida como la lógica de $$\textit{Equicardinalidad}$$.
- La lógica $$L(Q^{ec})$$ extiende las formulas de la siguiente forma:
    $$Q^{ec}x_0x_1y_0y_1\phi(x_0,\dots,x_n)\psi(y_0,\dots,y_n)$$
    Con el significado: Dados $$a_2,\dots,a_n$$ y $$b_2,\dots,b_n$$, ambos conjuntos de parejas de elementos $$x_0,x_1$$ que satisfacen $$\phi(x_0,x_1,\dots,a_n)$$ y el de parejas $$y_0,y_1$$ que satisfacen $$\psi(y_0,y_1,\dots,b_n)$$, cumplen ser ordenes lineales y mas aun tener la misma cofinalidad. Esta es conocida como la lógica de $$\textit{Equicofinalidad}$$.

Estas dos lógicas son un tanto enigmáticas en el sentido de que si bien son un paso intermedio no se sabe si están mas cerca de ser primer o segundo orden. De la primera se conoce que esta muy lejos de ser compacta, y de la segunda se conoce muy poco pero el matemático $$\textit{Shela}$$ conjetura que si lo es.

<img src="/assets/images/esquemaextensionlogica.png">
