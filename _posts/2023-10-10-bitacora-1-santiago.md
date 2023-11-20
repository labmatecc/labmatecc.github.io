---
layout: single
title: Bitácora 1 (Edgar Santiago Ochoa Quiroga) 
excerpt: "Personalmente al ver el contenido inicial del curso pensé que de una manera muy directa podría relacionar los conceptos que vi en el curso de la teoría de la computación, sobretodo la parte final del mismo donde se habla acerca de maquinas de Turing, pensé que de pronto por ese lado encaminaría el proyecto del semestre pero ese pensamiento cambio completamente, en el momento en que el grupo fue conformado, fue claro cual seria el punto de partida. El análisis era la única rama que todos teníamos en común que nos interesara lo suficiente (a unos mas que otros) para poder hacer el proyecto, ese fue nuestro punto de partida, empezamos por buscar conexiones en el análisis funcional y en la teoría de Ramsey pero no lográbamos extraer de ahí algo genuinamente relacionado al curso, siendo sincero estábamos en un bache por que no sabíamos muy bien que dirección tomar hasta que nos topamos con el teorema de compacidad." 
date: 2023-10-10
classes: wide
header:
  teaser: /assets/images/santiago.jpeg
  teaser_home_page: true
  icon: 
categories:
  - Bitácora
tags:  
  - Motivación
  - Compacidad
---

# Bitácora
## Inicio: Motivación y el punto de partida

<img src="/assets/images/bitacora-1-santiago/1.jpeg" width="600px" heigth=auto>

Por la presentación inicial las personas que están en el curso ya saben el porque terminamos escogiendo estos temas, pero no esta de mas entrar un poco, pero solo un poco en detalle y contar mas sobre esto desde mi visión.
Personalmente al ver el contenido inicial del curso pensé que de una manera muy directa podría relacionar los conceptos que vi en el curso de la teoría de la computación, sobretodo la parte final del mismo donde se habla acerca de maquinas de Turing, pensé que de pronto por ese lado encaminaría el proyecto del semestre pero ese pensamiento cambio completamente, en el momento en que el grupo fue conformado, fue claro cual seria el punto de partida. El análisis era la única rama que todos teníamos en común que nos interesara lo suficiente (a unos mas que otros) para poder hacer el proyecto, ese fue nuestro punto de partida, empezamos por buscar conexiones en el análisis funcional y en la teoría de Ramsey pero no lográbamos extraer de ahí algo genuinamente relacionado al curso, siendo sincero estábamos en un bache por que no sabíamos muy bien que dirección tomar hasta que nos topamos con el teorema de compacidad.

## Primeros pasos: El teorema de Compacidad

<img src="/assets/images/bitacora-1-santiago/2.jpeg" width="600px" heigth=auto>

Dependiendo de la rama de las matemáticas en la uno este interesado, al escuchar la palabra **compacidad** se le pueden venir enunciados completamente distintos. Particularmente para mi a pesar de que mis mayores intereses están en el álgebra y en la teoría de la computación, la primera noción de compacidad en la que pienso es la que se brinda en el primer curso de análisis.

- **Dado un subconjunto $$S$$ en un espacio métrico, decimos que es compacto si todo cubrimiento abierto de $$S$$ admite un subcubrimiento finito.**

Aunque este es un curso de lógica así que de esto no podemos estar hablando $$\dots$$ ¿o si?

El teorema de compacidad en la lógica tiene muchas formas distintas, pero equivalentes de enunciarlo. La primera defunción encontrada en la investigación fue:

- **Si $$\Gamma$$  es un conjunto de enunciados finitamente satisfacible, entonces $$\Gamma$$ tiene un modelo de cardinal menor o igual que $$\mid\Gamma\mid$$ $$+\aleph_0$$.**
 
Visto de esta forma a uno no se le ocurre inmediatamente una conexión muy directa de la razón por la cual esta noción también lleva el nombre de compacidad, después de todo en matemáticas usualmente los nombres que se dan tienen un motivo detrás pero pareciera que en este caso no. Así pensaba yo hasta que leí la siguiente forma de enunciarlo, que hace claro la razón del nombre:

- **Una $$L$$-teoria $$T$$ tiene modelos si todo subconjunto finito $$T_0$$ de $$T$$ tiene modelos.**

Aquí podemos realizar una analogía donde con la compacidad del análisis donde los modelos son el *cubrimiento* mientras que los modelos de el subconjunto finito son el *subcubirmiento finito*. Si bien esto no es nada riguroso y claramente faltan muchos detalles para hacer un símil apropiado, fue la forma en que interprete una relación entre los dos teoremas dado que llevan el mismo nombre. Este teorema es fundamental para construir modelos pero no ahondare en esto ya que no es de particular interes para el proyecto.

## Subiendo la colina: Lógicas compactas

<img src="/assets/images/bitacora-1-santiago/3.jpeg" width="600px" heigth=auto>

Si bien el principal interés de este proyecto es encontrar si hay maneras de recuperar la compacidad en lógicas donde no la hay, no esta de mas conocer y entender un poco algunos ejemplos de lógicas que si lo son.

### Lógica proposicional

Esta lógica es seguro que todos aquellos que leerán este blog la conocen, después de todo es la que los estudiantes de matemáticas nos presentan desde los primeros días de la carrera. Esta lógica viene compuesta de un conjunto de sentencias básicas que normalmente son llamadas *átomos* y un conjunto completo de conectivos Booleanos que tienen alguna manera de determinar que es verdad y que no, el mas clásico seria el conjunto de $$\{\neg,\lor,\land\}$$. Este sistema siempre sera compacto independientemente de la cantidad de sentencias básicas y de conectores booleanos.

### Lógica de primer orden

Una forma interesante de entender esta lógica, que es la canónica que manejamos a día de hoy, es verla como una extensión de la lógica proposicional en la cual agregamos la existencia de cuantificadores a nuestras formulas compuestas de sentencias atómicas y operaciones booleanas. OJO! la particularidad de estos cuantificadores es que solo tienen a su alcance variables, no consideran por ejemplo predicados completos en su construcción. El hecho de que esta lógica sea compacta es de gran importancia para para la lógica y sus aplicaciones.

## La vista del paisaje: Implicaciones de la Compacidad

<img src="/assets/images/bitacora-1-santiago/4.jpeg" width="600px" heigth=auto>

En los últimos días en el curso hemos visto algunas implicaciones de la compacidad en la lógica de primer orden que aquí recordare y daré una breve idea de las pruebas de las mismas, además de alguna que otra nueva que enunciare.

* **Inexpresabilidad de la finitud e infinitud.**

Cualquier lógica compacta que sea una extensión de la lógica de primer orden no puede expresar la noción de que un modelo sea finito o infinito. La idea de esta prueba consiste en considerar una sentencia $$\Psi$$ que es cierta en una estructura si y solo si el modelo $$A$$ es finito. Se considera luego la teoría $$\{\Psi\}\cup\{\varphi_{\geq n}:n\in\mathbb{N}\}$$ donde la $$\varphi_{\geq n}$$ es la sentencia que dice que hay al menos una cantidad $$n$$ de elementos en el modelo. Luego esta teoría es finitamente satisfacible, pero claramente no tiene modelos de tamaño $$\aleph_0$$ o mas ya que si así fuera deberían satisfacer la finitud de $$\Psi$$ y la infinitud ya que para cada $$n$$ tiene $$n$$ o mas elementos. Esto demuestra de forma meramente informal el no poder definir la finitud, pero la construcción para la infinitud es similar.

Este *esquema* de demostración es muy usado y de hecho una idea similar se puede usar para la prueba del siguiente item. Note que este esquema nos dice que no hay una manera general de definir la finitud o infinitud, pero pueden haber casos donde existan sentencias que definan la infinitud de un modelo en especifico.

* **Inexpresabilidad del Buen orden.**

Al igual que en la anterior esto nos dice que no existe una sentencia en general que pueda definir la noción de buen orden.

* **Construcción de modelos no estándar.**

No me adentrare en la construcciones de estos modelos, pero los mas conocidos son modelos no estándar de la aritmética y de la teoría de los números reales, eso si les puedo asegurar que es algo bastante interesante de leer.

* Dados dos conjuntos de sentencias $$U,V$$ de una lógica compacta, en donde la negación y la conjunción son definibles y con la particularidad de que cada modelo cumple $$U$$ ó cumple $$V$$, Por compacidad existe una sentencia $$\sigma$$ tal que $$U$$ y $$\{\sigma\}$$ tienen los mismos modelos (o son lógicamente equivalentes) y $$V$$ y $$\{\neg\sigma\}$$ tienen los mismos modelos.

Podría continuar dando mas y mas implicaciones de la compacidad pero siento que con esto es sufriente para dar el punto al que quería llegar, que es la importancia que tiene la compacidad en la lógica.

## Una mirada hacia adelante: El lenguaje natural

<img src="/assets/images/bitacora-1-santiago/5.jpeg" width="600px" heigth=auto>

Un ejemplo que a mi parecer fue bastante curioso al momento de leerlo fue el de si un lenguaje natural como el español, ingles, árabe o algún otro es compacto?. Primero es importante aclarar el que significa esta pregunta dentro del contexto. Para un lenguaje natural decimos que es compacto si para un argumento lógico valido, existe un argumento lógico finito que es subconjunto del original y tiene la misma conclusión. Ahora que seria un argumento valido y que no lo es, además como se conforman esos argumentos, veamos un ejemplo clásico:

$$
\begin{align*}
    \textit{Hypatia es una mujer}&& \textit{Hypatia es mortal}\\
    \textit{Todas las mujeres son mortales} && \textit{Todas las mujeres son mortales}\\
     \Downarrow&&\Downarrow\\
    \textit{Hypatia es moratl}&&\textit{Hypatia es mujer}
\end{align*}
$$

El ejemplo de la izquierda es un argumento lógicamente valido, mientras que el de la derecha no lo es. Ahora este tipo de argumentos podemos definirlos de manera *recursiva* tal que por ejemplo pueda tener cadenas de argumentos validos como:


<center>
    Mi abuelo era alto <br>
    Mi tataraabuelo era alto <br>
    Mi tataratataraabuelo era alto <br>
    $$\vdots$$
</center>


Si bien esto puede ser un tanto vago (y la idea es mas clara vista en el idioma ingles) el punto al que queremos llegar es que podemos definir un argumento en el español de la siguiente manera:

<center>
    Hay al menos un planeta <br>
    Hay al menos dos planetas <br>
    $$\vdots$$
    Hay al menos $$n$$ planetas <br>
    $$\vdots$$
    $$\Downarrow$$
    Hay infinitos planetas
</center>

Este argumento claramente es lógicamente valido en el español, pero no existiría un subconjunto finito que llegara a la misma conclusión y bajo nuestra definición El lenguaje natural no seria compacto.

Alrededor de este argumento hay bastante debate por parte de lógicos, lingüistas y filósofos, que rechazan esta idea ya que se asumen cosas del lenguaje que podrían no ser así. como por ejemplo el que un argumento tiene una única consecuencia. Por lo que de de momento es mejor dejar estas ideas como una curiosidad, pero como un acercamiento valido al problema de la no compacidad ya que un argumento similar sera usado para las lógicas de segundo orden.

Saludos,

Edgar Santiago Ochoa Quiroga (eochoaq@unal.edu.co).
