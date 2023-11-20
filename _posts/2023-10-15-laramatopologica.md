---
layout: single
title: "La rama Topológica."
excerpt: "Cuando pensamos en la compacidad, es natural remitirse al concepto conocido en topología y preguntarse ¿Tiene este concepto topológico alguna relación con la compacidad en Lógica? A continuación, nos disponemos a buscar respuesta a esta pregunta."
date: 2023-10-15
classes: wide
header:
  teaser: /assets/images/des.jpeg
  teaser_home_page: true
  icon: 
categories:
  - Relación Topológica
tags:
  - Compacidad
  - Topología de Stone
---

Cuando pensamos en la compacidad, es natural remitirse al concepto conocido en topología y preguntarse ¿Tiene este concepto topológico alguna relación con la compacidad en Lógica? A continuación, nos disponemos a buscar respuesta a esta pregunta.

Considere $$L$$ un lenguaje. Existe una clase de las $$L-$$Estructuras, que llamaremos $$M$$, y un conjunto $$S$$ de las  $$L-$$sentencias. Si $$\sigma \in S$$, podemos definir:
$$
\begin{align*}
    M(\sigma)=\{T\in M\hspace{0.2cm}\mid \hspace{0.2cm}T \models \sigma\},
\end{align*}
$$

y para $$T \in M$$, podemos definir:
$$
\begin{align*}
    H(T)=\{\sigma \in S \hspace{0.2cm}\mid \hspace{0.2cm} T \models \sigma\}.
\end{align*}
$$

Ahora, si $$\Gamma \subseteq S$$ y $$\Omega \subseteq M$$, definimos
$$
\begin{align*}
    M(\Gamma)=\bigcap_{\sigma \in \Gamma} M(\sigma) \hspace{0.5cm} \text{ y } \hspace{0.5cm} H(\Omega)=\bigcap_{T \in \Omega} H(T)
\end{align*}
$$

Las clases $$M(\Gamma)$$ se llaman $$\textit{clases elementales}$$ y las clases $$H(\Omega)$$ se llaman $$\textit{teorías}$$. Las funciones $$\Gamma \longmapsto M(\Gamma)$$ y $$\Omega \longmapsto H(\Omega)$$ definen una correspondencia entre las teorías y las clases elementales, llamada $$\textit{correspondencia de Galois}$$.

No es difícil ver que:
$$
\begin{align*}
    M(\sigma \lor \tau)=M(\sigma)\cup M(\tau).
\end{align*}
$$

Las clases elementales son los conjuntos cerrados de una topología en $$M$$ (la generada por los correspondientes abiertos a estos cerrados). Más aún, una base para esta topología son los complementos de las clases $$M(\sigma)$$.

Anteriormente dimos varias definiciones y con estas, construimos una topología pero ¿con qué motivo? Veamos.

Decir que una $$L-$$Teorías cumple el **Teorema de Compacidad**, es equivalente a que dado $$\Gamma \subseteq S$$, si cualquier subconjunto finito de $$\Gamma$$ tiene modelos, entonces $$\Gamma$$ tiene modelos. Esto quiere decir que si $$\{M(\sigma) \hspace{0.2cm}\mid \hspace{0.2cm} \sigma \in \Gamma\}$$ cumple la $$\textit{Propiedad de Intersecciones Finitas}$$, entonces $$\displaystyle \bigcap_{\sigma \in \Gamma} M(\sigma) \neq \emptyset$$, es decir, $$M$$ es un espacio topológico compacto.

$$M$$ es llamado espacio de Stone de $$L$$ y, como vimos anteriormente, si una $$L-$$Teoría cumple el Teorema de Compacidad, implica que el espacio $$M$$ es compacto. Sin embargo, el recíproco no siempre es cierto, por ejemplo, cuando salimos de la lógica de primer orden, lo que da paso a la siguiente sección.
