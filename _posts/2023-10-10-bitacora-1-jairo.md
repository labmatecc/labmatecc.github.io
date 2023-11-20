---
layout: single
title: Bitácora 1 (Jairo Sebastián Niño Castro) 
excerpt: "Cuando consultamos con el profesor Andrés sobre bibliografía que nos podía ayudar a orientar el proyecto (queríamos encontrar conexiones con el análisis funcional), debo decir que me llevé una sorpresa cuando sugirió que indagáramos sobre el teorema de compacidad, el cual era un tema que realmente se relacionaba con el contenido del curso. Y... ¿por qué una sorpresa? Bueno, cuando leí el teorema por primera vez, la pregunta que me hice fue ´´¿Por qué se llama teorema de compacidad?¿Qué tiene que ver con la definición de compacidad que vi en análisis real?´´. Aunque esta pregunta no la he terminado de responder, debo decir que si me ha motivado en la indagación sobre el tema." 
date: 2023-10-10
classes: wide
header:
  teaser: /assets/images/jairo.jpeg
  teaser_home_page: true
  icon: 
categories:
  - Bitácora
tags:  
  - Motivación
  - Compacidad
---

# Bitácora

## Indagación del tema: ¿Ruptura del libro de arena?

Conviene ahora (aunque varios de mis compañeros también lo han hecho en sus respectivas bitácoras) enunciar el teorema de compacidad. En primer lugar, enunciaré la primera forma del teorema que encontré en [2], la cual de cierta manera me llevó a la sorpresa que describí en la introducción.

- **Sea $$\Gamma$$ un subconjunto finitamente satisfactible de $$L-teoría$$. Entonces $$\Gamma$$ es satisfactible; más aún, $$\Gamma$$ tiene un modelo de cardinal menor o igual que $$\mid L\mid+\aleph_0$$.**

Tal vez una manera que me ubicó de mejor manera, fue la siguiente equivalencia del teorema que me ubicó de mejor manera (ver [1]).

- **Sean $$L$$ un vocabulario y $$T$$ una $$L-teoría$$. Si todos los subconjuntos finitos de $$T$$ tienen modelos, entonces $$T$$ tiene un modelo.**

Los resultados que este teorema nos deja son increíblemente ricas. Una de las primeras cosas que se encuentra sobre este teorema es su validez en lógica de primer orden pero el fallo que tiene en lógicas de orden superior. Parte del objetivo del proyecto es mirar cómo se puede 'recuperar' en estas lógicas. Pero es acá donde tal vez no he hecho la investigación que en principio debía hacer y me ido por un lado más 'egoísta': ¿Por qué no revisar algunos resultados de este teorema en lógica de primer orden?

Sin duda alguna lo que más me llamó la atención de este teorema es que permite la construcción de modelos no estándar de la aritmética de Peano y de la teoría de los números reales. En [2] se encuentra un buen resumen sobre la construcción de estos modelos, la cual cito a continuación:

- **Sea $$\mathbb{N}=\{\mathbb{N},+,\cdot,0,1\}$$ sea la estructura habitual de los números naturales en el lenguaje de la aritmética, $$L_1Ar$$ La teoría $$Th(\mathbb{N})$$ es llamada aritmética completa (para distinguirse de la aritmética de Peano, dada por un sistema de axiomas incompleto).**

Cualquier modelo de $$Th(\mathbb{N})$$ distinto de $$\mathbb{N}$$ es llamado una aritmética no estándar. La existencia de uno es inmediato del teorema de compacidad considerando el conjunto de $$L_1Ar-teoría$$ y 

$$
\begin{align*}
     \Gamma=\{Th(\mathbb{N}\}\cup \{\neg c=n: n=0,1,...\}
\end{align*}
$$

Claramente, $$\Gamma$$ es finitamente satisfactible. Representado $$L(c)$$ como la extensión de la teoría por el simbolo $$c$$. Luego, se puede mostrar que $$c\geq n$$ para todo $$n$$ natural. Basicamente tenemos que los elementos no estándar de la aritmética son "naturales infinitos".

Una construcción similar se puede hacer sobre la estructura usual de los reales en el lenguaje de la aritmética ($$\mathbb{R}=\{\mathbb{R},+,\cdot,0,1,<\}$$) mostrando que en cualquier modelo no estándar de los reales posee un elemento $$\alpha$$ tal que:

$$
\begin{align*}
    0<\alpha<\dfrac{1}{n}
\end{align*}
$$

para todo $$n$$ número natural diferente a $$0$$: No tenemos la propiedad arquimediana!!

- Ruptura del libro de arena (hiperreales).

<img src="/assets/images/bitacora-1-jairo/im1.png" width="600px" heigth=auto>

La primera impresión que me dejó esto se relaciona mucho con un cuento de Jorge Luis Borges llamado el libro de arena. En síntesis, se tiene un libro en el cual el número de páginas es infinito y no es posible ubicar la primera página. Pero con este modelo, es como si me permitiera obtener un 'separador mágico' el cual puedo colocar entre la portada (representado al número 0) y la primera página. Naturalmente, después descubriría que este 'separador mágico' también está compuesto por infinitas hojas delgadas (números infinitesimales). La situación se visualiza un 'poco' mejor en la figura.

Esta 'ruptura' del libro de arena a la que hago mención y en general de la bien conocida, propiedad arquimediana de los números reales se recuperará en la lógica de segundo orden a un costo: El teorema de compacidad no será válido.

## Bibliografía

- Väänänen, J. Villaveces, A. (2019). Lenguaje, teorías y modelos (2019). Eudeba, Buenos Aires

- Manin, Y. (2010).A Course in Mathematical Logic (2010). Second Edition. Springer Verlag, U.S.A.

