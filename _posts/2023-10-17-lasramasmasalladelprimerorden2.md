---
layout: single
title: "Las ramas mas allá del primer orden: Lógica de segundo orden."
excerpt: "He aquí el primer encuentro fuerte y directo con una lógica que no es compacta pero que además se hace bastante natural la forma en la que opera. Ya que si bien las extensiones previas de la lógica de primer orden no son difíciles de comprender, la noción de cuantificar sobre la cantidad de elementos que cumplen una cierta propiedad es extraña, mas aun cuando esa cantidad puede ser un cardinal arbitrario."
date: 2023-10-17
classes: wide
header:
  teaser: /assets/images/des.jpeg
  teaser_home_page: true
  icon: 
categories:
  - Mas allá del primer orden
tags:
  - Otras lógicas
  - Lógicas de segundo orden
---

He aquí el primer encuentro fuerte y directo con una lógica que no es compacta pero que además se hace bastante natural la forma en la que opera. Ya que si bien las extensiones previas de la lógica de primer orden no son difíciles de comprender, la noción de cuantificar sobre la cantidad de elementos que cumplen una cierta propiedad es extraña, mas aun cuando esa cantidad puede ser un cardinal arbitrario. La lógica de segundo orden mantiene las mismas bases de la lógica de primer orden pero le da un mayor alcance a sus cuantificadores, y este es poder cuantificar sobre relaciones o funciones, es decir admite cuantificaciones como $$\forall R\phi$$ o $$\exists R\phi$$, donde $$R$$ es una relación o incluso función, en primera instancia puede parecer un cambio pequeño que no afecta mucho la expresabilidad del lenguaje, pero cuantos enunciados uno no se ha encontrado a lo largo de su vida donde la conclusión es mostrar la existencia de una función o que como hipótesis se supone que para toda función se cumple una propiedad en especifico.

Este poder de expresabilidad si bien arregla muchas cosas también nos cohíbe en el sentido de que el teorema de compacidad no se cumple aquí.

**La lógica de segundo Orden NO es compacta:** Para construir el argumento consideramos el **\textit{dominio de interpretación}** que es básicamente el lugar de donde tomaremos nuestras **\textit{variables}**. Consideramos primero el siguiente conjunto de sentencias de una teoría:

$$\{\varphi_{\geq n}:n\in\mathbb{N}\}$$

Donde $$\varphi_{\geq n}=\exists x_0\exists x_1\dots\exists x_n(\neg(x_1=x_2)\land\dots\land\neg(x_i=x_j)\land\dots\land\neg(x_{n-1}=x_n))$$, básicamente las sentencias que nos dicen que existen al menos $$n$$ elementos. Estas sentencias son de la lógica de primer orden pero como ella es una sublogica también son de segundo orden. Ahora consideremos $$R$$ una relación binaria, que ahora si esta bajo el alcance de cuantificadores y podemos definir la siguiente sentencia:

$$\exists R((\forall x\exists!y(xRy))\land (\forall x\forall y\forall z((xRz\land yRz)\to x=y))\land \neg(\forall y\exists x(xRy))$$

Sabemos que se puede ver algo complicada pero en esencia estamos definiendo una sentencia que dice que existen relaciones tales que primero son funciones, segundo que son inyectivas y por ultimo que NO son sobreyectivas. Ahora observe que el siguiente argumento es valido en la lógica de segundo orden:

$$
\begin{align*}
  &\varphi_{\geq 1}\\
  &\varphi_{\geq 2}\\
  &\vdots\\
  &\varphi_{\geq n}\\
  &\cdot\\
  &\Downarrow\\
  \exists R((\forall x\exists!y(xRy))\land (\forall x\forall y\forall& z((xRz\land yRz)\to x=y))\land \neg(\forall y\exists x(xRy))
\end{align*}
$$

Pero es claro que ningún subconjunto finito de estas premisas puede llegar a esa conclusión, ya que si tomamos un subconjunto finito y consideramos un modelo de tamaño el máximo $$m$$ de los $$\varphi_{\geq i}$$, cumple todas las premisas pero al tener $$m$$ elementos toda función de dominio finito que es inyectiva tiene que ser sobreyectiva. Así concluimos que la lógica de segundo orden no es compacta.
$$\square$$

De esta forma probamos que esta lógica es no compacta, por lo que esto ya genera una distancia considerable de la lógica de primer orden, pero es importante no perderla de vista ya que sigue siendo nuestro punto de partida.
