---
layout: single
title: "Las ramas mas allá del primer orden: Lógica infinitaria Parte I."
excerpt: "Damos paso a una nueva rama, esta se encuentra incluso mas lejos y nos dará una nueva manera de continuar la escalada ya que continuaremos partir de esta por el camino de alterar la noción de compacidad, pero no nos adelantemos, concentrémonos en lo que tenemos al frente."
date: 2023-10-19
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

Damos paso a una nueva rama, esta se encuentra incluso mas lejos y nos dará una nueva manera de continuar la escalada ya que continuaremos partir de esta por el camino de alterar la noción de compacidad, pero no nos adelantemos, concentrémonos en lo que tenemos al frente.

La idea de tener conjunciones o disyunciones infinitas es algo bastante natural, incluso conseguir concatenar una cantidad infinita de cuantificadores y lo natural seria pensar que solo para cantidades numerables, pero por que detenerse ahí?

Fijemos un vocabulario $$\tau.$$ Dados $$\kappa\geq\lambda$$ un par de cardinales infinitos, la lógica $$L_{\kappa,\lambda}(\tau)$$ es la mínima lógica que contiene $$\tau-$$formulas atómicas y es cerrada bajo negaciones, conjunciones y disyunciones respectivamente de la forma $$\bigwedge_{i<\gamma}\varphi_i$$ y $$\bigvee_{i<\gamma}\varphi_i$$ para $$\gamma<\kappa$$ y cadenas de universales y existenciales respectivamente de la forma $$\forall v_0\dots\forall v_j\dots\varphi_j$$ y $$\exists v_0\dots\exists v_j\dots\varphi_j$$ donde $$j<\theta<\lambda$$. Normalmente se abusa del lenguaje y no se tiene en cuenta en que vocabulario especifico se esta trabajando por lo que este tipo de lógicas solemos escribirlas tal que $$L_{\kappa,\lambda}$$. Note que estos dos cardinales que denotamos en el subíndice son el jugo de estas lógicas ya que $$\kappa$$ es nuestra cota superior de cuantas conjunciones o disyunciones podemos agregar a nuevas formulas mientras que $$\gamma$$ es nuestra cota para el uso de los dos cuantificadores clásicos.

De esta forma por ejemplo nuestra lógica clásica de primer orden en esta notación se ve descrita por $$L_{\omega,\omega}$$ y la lógica infinitaria mas conocida es $$L_{\omega_1,\omega}$$ donde agregamos el poder de expresar nociones con una cantidad contable de conjunciones y disyunciones. Además note que es irrelevante considerar lógicas donde $$\kappa<\lambda$$ ya que tenemos mas cuantificadores que posibles conjunciones de variables libres las cuales cuantificar, entonces tenemos una cantidad $$\textit{desperdiciada}$$ de cuantificadores. Ahora viene la gran pregunta es esta lógica compacta?
