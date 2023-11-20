---
layout: single
title: "Las ramas mas allá del primer orden: Generalización de Compacidad y Grandes cardinales."
excerpt: "Como vimos previamente el teorema de compacidad usual falla cuando entramos a las lógicas infinitarias, por lo que nace cierto interés en ver si de alguna manera podemos modificar la noción de compacidad y que de esa manera estas nuevas lógicas de gran interés posean estas propiedades, curiosamente surge una conexión natural entre esta pregunta y los **grandes cardinales** que se estudian en la teoría de conjuntos."
date: 2023-10-21
classes: wide
header:
  teaser: /assets/images/des.jpeg
  teaser_home_page: true
  icon: 
categories:
  - Mas allá del primer orden
tags:
  - Grandes Cardinales
---

Como vimos previamente el teorema de compacidad usual falla cuando entramos a las lógicas infinitarias, por lo que nace cierto interés en ver si de alguna manera podemos modificar la noción de compacidad y que de esa manera estas nuevas lógicas de gran interés posean estas propiedades, curiosamente surge una conexión natural entre esta pregunta y los $$\textit{grandes cardinales}$$ que se estudian en la teoría de conjuntos.

**Definición:** Sea $$\kappa$$ un cardinal infinito, Un lenguaje $$L$$ se dice que es débilmente $$\kappa$$-compacto si dado un conjunto $$\Gamma$$ de $$L$$-sentencias de cardinal menor o igual a $$\kappa$$ tenemos que cada subconjunto de $$\Gamma$$ con cardinal menor a $$\kappa$$ tiene modelos, entonces $$\Gamma$$ también tiene modelos.

Note que bajo esta nueva definición el teorema de compacidad usual en la lógica de primer orden es precisamente el hecho de que esta misma es débilmente $$\omega-$$compacta. Ahora, si bien definimos esta nueva noción para tener un poco mas de espacio algo que resulta sorprendente es que la mayoría de lógicas $$L_{\kappa,\lambda}$$ fallan incluso el ser débilmente $$\kappa$$-compactas, y para aquellas que lo son se requiere que $$\kappa$$ se un gran cardinal especifico, pero para esto necesitamos mas definiciones.

**Definición:** Decimos que un cardinal $$\kappa$$ es débilmente inaccesible si:

- Dado $$\lambda<\kappa$$ entonces $$\lambda^+<\kappa$$
- Dado $$I$$ conjunto de índices con cardinal menor a $$\kappa$$, y  $$\lambda_i<\kappa$$ para todo $$i\in I$$ entonces $$\sum_{i\in I}\lambda_i<\kappa$$


Si además de esto tenemos que si dado $$\lambda<\kappa$$ entonces $$2^\lambda<\kappa$$ decimos que $$\kappa$$ es $$\textit{fuertemente inaccesible}$$ o simplemente inaccesible. Ahora como arbitrariamente es natural que $$\aleph_0$$ sea inaccesible nos concentramos en ver que cardinales no contables cumplen estas propiedades $$\textit{si es que existen}$$. De igual manera por el teorema de incompletitud tenemos que no se puede probar la existencia de estos desde ZFC.

Ahora decimos que un cardinal $$\kappa$$ es débilmente compacto si el lenguaje $$L_{\kappa,\kappa}$$ es débilmente $$\kappa-$$compacto. De aquí tenemos los siguientes resultados

- Si $$\kappa$$ es débilmente compacto entonces $$L_{\kappa,\omega}$$ es débilmente $$\kappa-$$compacto entonces $$\kappa$$ es débilmente inaccesible.
- Suponga que $$\kappa$$ es inaccesible, luego $$\kappa$$ es débilmente compacto si y solo si $$L_{\kappa,\omega}$$ es débilmente $$\kappa$$-compacto.

Por ultimo es importante resaltar que lo esencial de estos resultados es que la compacidad falla desastrosamente en lógicas $$L_{\kappa,\lambda}$$ donde $$\kappa\geq\omega_1$$.
