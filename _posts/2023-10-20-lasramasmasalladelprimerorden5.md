---
layout: single
title: "Las ramas mas allá del primer orden: Lógica infinitaria Parte 2."
excerpt: "En el post previo nos preguntábamos si Las lógicas infinitarias son no compactas, aquí la respuesta es clara; en efecto no son compactas y esto lo mostraremos dando un argumento que se puede extrapolar de aquí en adelante y además de que la escénica del mismo es bastante sencilla de comprender."
date: 2023-10-20
classes: wide
header:
  teaser: /assets/images/des.jpeg
  teaser_home_page: true
  icon: 
categories:
  - Mas allá del primer orden
tags:
  - Otras lógicas
  - Lógicas infinitarias
---

En el post previo nos preguntábamos si Las lógicas infinitarias $$L_{\kappa,\lambda}$$ son no compactas cuando $$\kappa>\omega$$, aquí la respuesta es clara; en efecto no son compactas y esto lo mostraremos dando un argumento para $$L_{\omega_1,\omega}$$ pero que se puede extrapolar de aquí en adelante y además de que la escénica del mismo es bastante sencilla de comprender.

$$\mathbf{L_{\omega_1,\omega}}$$ **es no compacta:** Consideremos el conjunto de constantes $$\{c_i:i<\omega_1\}$$, luego consideremos el conjunto con las siguientes sentencias:

$$\{\neg(c=c_i):i\in\omega\}\cup\left\{\bigvee_{i\in\omega} c=c_i\right\}$$

Note que este conjunto de sentencias es finitamente satifacible. Ya que tendríamos un numero finito de $$\neg(c=c_i)$$ por lo que basta tomar una mas para cumplir la sentencia. Pero note que no es satisfacible en general, ya que si lo fuera tendríamos un elemento tal que $$c=c_i$$ y al mismo tiempo $$\neg(c=c_i)$$.

$$\square$$

Así mostramos que esta  lógica es no compacta. Note que con unos cuantos arreglos este argumento también vale para $$L_{\kappa,\lambda}$$ con $$\kappa>\omega$$ por lo tanto mostramos  que toda lógica con una cantidad infinita de disyunciones siempre sera no compacta.

Al igual que en segundo orden volvemos a estar en aprietos, encontramos lo que queríamos pero hay forma de seguir? Aunque no lo parezca si la hay y es una que ya habíamos mencionado previamente que es la de jugar un poco con la noción de la compacidad y alterarla para así de pronto satisfacer alguna que otra necesidad en este nuevo esquema de referencia.
