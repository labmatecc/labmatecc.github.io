---
layout: single
title: "La rama  del primer orden: Resultados clásicos I."
excerpt: "Una primera rama en la que nos debemos detener corresponde a la lógica del primer orden. Hasta el momento hemos hablado de que el teorema de compacidad vale en la lógica de primer orden pero falla en lógica de segundo orden (y en general para lógicas infinitarias; al menos en nuestra noción estándar de compacidad), pero la pregunta natural que surge es: ¿Por qué nos interesa saber si el teorema de compacidad vale o no, en cierta lógica? ¿A cuáles resultados conlleva este teorema?"
date: 2023-10-13
classes: wide
header:
  teaser: /assets/images/des.jpeg
  teaser_home_page: true
  icon: 
categories:
  - Resultados Clásicos
tags:
  - Modelos no estándar
  - Lógicas de primer orden
---

Una primera rama en la que nos debemos detener corresponde a la lógica del primer orden. Hasta el momento hemos hablado de que el teorema de compacidad vale en la lógica de primer orden pero falla en lógica de segundo orden (y en general para lógicas infinitarias; al menos en nuestra noción estándar de compacidad), pero la pregunta natural que surge es: $$¿\textit{Por qué}$$ nos interesa saber si el teorema de compacidad vale o no, en cierta lógica? $$¿\textit{A cuáles}$$ resultados conlleva este teorema?

Nuestra aproximación clásica a estas preguntas es considerar algunos resultados que se tienen en lógica de primer orden.

# Existencia de modelos no estándar

Tal vez uno de las aplicaciones del teorema de compacidad que se ve con mayor frecuencia corresponde a la existencia de modelos no estándar de teorías como la aritmética de los naturales. Vale la pena hacer un pequeño esbozo de la construcción:

Sea $$\mathbb{N}=\{\mathbb{N},+,\cdot,0,1\}$$ la estructura habitual de los números naturales en el lenguaje de la aritmética, $$L_1Ar$$. La teoría $$Th(\mathbb{N})$$ es llamada aritmética completa (para distinguirse de la aritmética de Peano, dada por un sistema de axiomas incompleto).

Cualquier modelo de $$Th(\mathbb{N})$$ distinto de $$\mathbb{N}$$ es llamado una aritmética no estándar. La existencia de uno es inmediato del teorema de compacidad considerando el conjunto de $$L_1Ar-teoría$$ y

$$
\begin{align*}
     \Gamma=\{Th(\mathbb{N}\}\cup \{\neg c=n: n=0,1,...\}
 \end{align*}
$$

Claramente, $$\Gamma$$ es finitamente satisfactible (por lo se aplica el teorema). Representado $$L(c)$$ como la extensión de la teoría por el símbolo $$c$$. Luego, se puede mostrar que $$c\geq n$$ para todo n natural. Es decir que podemos pensar este nuevo modelo como $$\mathbb{N}$$ con un nuevo elemento $$c$$, y que por ende también debe estar $$c-1$$, $$c+1$$, $$10c$$, etc. Básicamente tenemos que los elementos no estándar de la aritmética son "naturales infinitos".
