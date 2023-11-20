---
layout: single
title: Bitácora 1 (Andrés David Cadena Simons) 
excerpt: "Las lógicas de segundo orden son una extensión bastante natural e intuitiva de las lógicas de primer orden, mantenemos todas las nociones que ya conocemos de las lógicas de primer orden, es decir sentencias atómicas, reglas de conjunción y la parte crucial de todo el asunto, **los cuanticadores**. En primer orden los cuantificadores solo tienen alcance de las **variables** pero por ejemplo no se puede cuantificar algo como una relación $$n$$-aria, pero en la lógica de segundo orden si, los cuantificadores tienen el alcance de todo tipo de relaciones. Esta peculiaridad que si bien da un alcance mucho mayor a la forma de escribir sentencias y argumentos. Esta pequeña pero sustancial diferencia ocasiona que la lógica de segundo orden no sea Compacta." 
date: 2023-10-10
classes: wide
header:
  teaser: /assets/images/andres.jpg
  teaser_home_page: true
  icon: 
categories:
  - Bitácora
tags:  
  - Motivación
  - Compacidad
---

# Bitácora

## Lógicas de segundo Orden

Las lógicas de segundo orden son una extensión bastante natural e intuitiva de las lógicas de primer orden, mantenemos todas las nociones que ya conocemos de las lógicas de primer orden, es decir sentencias atómicas, reglas de conjunción y la parte crucial de todo el asunto, **los cuanticadores**. En primer orden los cuantificadores solo tienen alcance de las **variables** pero por ejemplo no se puede cuantificar algo como una relación $$n$$-aria, pero en la lógica de segundo orden si, los cuantificadores tienen el alcance de todo tipo de relaciones. Esta peculiaridad que si bien da un alcance mucho mayor a la forma de escribir sentencias y argumentos. Esta pequeña pero sustancial diferencia ocasiona que la lógica de segundo orden no sea Compacta.

Para construir el argumento consideramos el **dominio de interpretación** que es básicamente el lugar de donde tomaremos nuestras **variables**. Consideramos primero el siguiente conjunto de sentencias de una teoría:

$$\{\varphi_{\geq n}:n\in\mathbb{N}\}$$

Donde $$\varphi_{\geq n}=\exists x_1\exists x_1\dots\exists x_n(\neg(x_1=x_2)\land\dots\land\neg(x_i=x_j)\land\dots\land\neg(x_{n-1}=x_n))$$, básicamente las sentencias que nos dicen que existen al menos $$n$$ elementos. Estas sentencias son de la lógica de primer orden pero como ella es una sublogica también son de segundo orden. Ahora consideremos $$R$$ una relación binaria, que ahora si esta bajo el alcance de cuantificadores y podemos definir la siguiente sentencia:

$$\exists R((\forall x\exists!y(xRy))\land (\forall x\forall y\forall z((xRz\land yRz)\to x=y))\land \neg(\forall y\exists x(xRy))$$

Sabemos que se puede ver algo complicada pero en esencia estamos definiendo una sentencia que dice que existen relaciones tales que primero son funciones, segundo que son inyectivas y por ultimo que NO son sobreyectivas. Ahora observe que el siguiente argumento es valido en la lógica de segundo orden:

<center>
    $$\varphi_{\geq 1}$$
    $$\varphi_{\geq 2}$$
    $$\vdots$$
    $$\varphi_{\geq n}$$
    $$\vdots$$
    $$\Downarrow$$
    $$\exists R((\forall x\exists!y(xRy))\land (\forall x\forall y\forall z((xRz\land yRz)\to x=y))\land \neg(\forall y\exists x(xRy))$$
</center>

Pero es claro que ningún subconjunto finito de estas premisas puede llegar a esa conclusión, ya que si tomamos un subconjunto finito y consideramos un modelo de tamaño el máximo $$m$$ de los $$\varphi_{\geq i}$$, cumple todas las premisas pero al tener $$m$$ elementos toda función de dominio finito que es inyectiva tiene que ser sobreyectiva. Así concluimos que la lógica de segundo orden no es compacta.
