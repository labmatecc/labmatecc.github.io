### A Pluto.jl notebook ###
# v0.19.39

using Markdown
using InteractiveUtils

# ╔═╡ 35c0a300-abed-11ee-1816-3d6ab9b18487
using PlutoUI

# ╔═╡ 79324bba-2c1a-498f-8bdf-a70e02106f86
using LinearAlgebra

# ╔═╡ ad0e2661-ac54-4037-bda1-3e665dbecaf4
PlutoUI.TableOfContents(title="Independencia lineal I", aside=true)

# ╔═╡ b47f513f-114d-4b96-b866-0090c9f0d107
md"""Este cuaderno esta en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias por favor escribir a jcgalvisa@unal.edu.co

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 55a8d645-c175-4e72-9452-08bcaffa5ec1
md"""Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo."""

# ╔═╡ 4a709378-cf2c-4072-9e46-46b4c7237c1b
md"""Usaremos esta librería"""

# ╔═╡ 0097fe78-3013-4eaf-ae85-006d6c10c803
md"""# Introducción"""

# ╔═╡ f60001c4-b165-4ae3-a642-3d0464a6d2d7
md"""La independencia lineal es un concepto esencial en álgebra lineal que destaca la relación entre vectores. Se refiere a la propiedad de un conjunto de vectores donde ninguno puede expresarse como combinación lineal de los demás de manera trivial. Esta noción, clave en la resolución de sistemas de ecuaciones y análisis estructural.
"""

# ╔═╡ 711861fd-da33-4f4c-9237-402139b704d2
md"""**Dependencia e independencia lineal** se refieren a las relaciones entre vectores en un espacio vectorial $V$. Si $v_1, v_2, \ldots, v_n$ son $n$ vectores en $V$, entonces se consideran linealmente dependientes si existen escalares $c_1, c_2, \ldots, c_n$, no todos iguales a cero, tales que:

$c_1v_1 + c_2v_2 + \ldots + c_nv_n = 0$

En caso de que los vectores no sean linealmente dependientes, se clasifican como linealmente independientes.
"""

# ╔═╡ 158705aa-0e94-417a-a230-e50d538d606a
md"""Para expresarlo de manera alternativa, $v_1, v_2, \ldots, v_n$ son linealmente independientes si la ecuación $c_1v_1 + c_2v_2 + \ldots + c_nv_n = 0$ se satisface únicamente cuando $c_1 = c_2 = \ldots = c_n = 0$. En cambio, son linealmente dependientes si el vector cero en $V$ puede representarse como una combinación lineal de $v_1, v_2, \ldots, v_n$ con coeficientes no todos iguales a cero.
"""

# ╔═╡ 370e0299-7477-4054-9224-632f5c3d2c90
md"""**Teorema:**

Dos vectores en un espacio vectorial son linealmente dependientes si y sólo si uno de ellos es un múltiplo escalar del otro."""

# ╔═╡ 7d5c788c-3a1d-4cf7-80ae-9aae5f4b0a95
md"""*Ejemplo:*

Los vectores $v_1 = \begin{pmatrix} 2 \\ -1 \\ 0 \\ 3 \end{pmatrix}$ y $v_2 = \begin{pmatrix} -6 \\ 3 \\ 0 \\ -9 \end{pmatrix}$ son linealmente dependientes, ya que $v_2 = -3v_1$
"""

# ╔═╡ 90cb66de-990c-4de5-8fdb-6da4bc847273
v₁ = [2; -1; 0; 3] #Se define el vector v₁

# ╔═╡ 07ac532d-68b8-446b-82a4-e70449ba4a03
v₂ = [-6; 3; 0; -9] #Se define el vector v₂

# ╔═╡ 2f5cc080-b35b-4c71-bfc4-76172bb59aa8
md"""Verifiquemos la igualdad"""

# ╔═╡ a0782db0-ab75-4756-a930-4bd8ecd3f1ba
v₂==-3*v₁

# ╔═╡ d168cd90-9578-49bf-abe9-90c2f562204e
md""" Sea
$A = \begin{pmatrix}
a_{11} & a_{12} & a_{1n} \\
a_{21} & a_{22} & a_{2n} \\
\vdots & \vdots & \vdots \\
a_{m1} & a_{m2} & a_{mn} \\
\end{pmatrix}$. Entonces las columnas de $A$ consideradas como vectores son linealmente dependientes si y sólo si el sistema, que se puede escribir como $Ac= 0$, tiene soluciones no triviales, donde $c=\begin{pmatrix}c_1\\c_2\\ \vdots\\c_n\end{pmatrix}$.

Sea $A$ una matriz de $n\times n$. Entonces $\text{det} A\neq 0$ si y sólo si las columnas de $A$ son linealmente independientes."""

# ╔═╡ f659a285-b849-4c98-8783-e633feeaf8f8
md"""*Ejemplo:*

Veamos si los vectores $\begin{pmatrix} 1 \\ -2 \\ 3 \end{pmatrix}$, $\begin{pmatrix} 2 \\ -2 \\ 0 \end{pmatrix}$, y $\begin{pmatrix} 0 \\ 1 \\ 7 \end{pmatrix}$ son linealmente independientes o dependientes.
"""

# ╔═╡ 782ef9e9-3605-4864-8220-5c03accb7a19
md"""Definimos la matriz"""

# ╔═╡ 7997ae23-f4fe-460e-9232-f90b3516eb1a
A₁ = [1 2 0; -2 -2 1; 3 0 7]

# ╔═╡ 00750fbe-297e-4f6c-9a9a-6060f717d5c2
md"""Calculamos su determinante"""

# ╔═╡ 5bf6f082-11f9-4e1d-bac5-0f6df7dcb993
det(A₁)

# ╔═╡ 4df7fa1f-fb6e-451e-8838-b0f0856d21ea
md"""Como el determinante de la matriz $A$ es diferente de cero entonces las columnas de $A$ son linealmente independientes."""

# ╔═╡ f0435b3b-0e6e-406c-bcb2-4febfe476470
md"""*Ejemplo:*

Consideremos los siguientes vectores $\begin{pmatrix} 2 \\ 2 \\ 9\\ 1\\ 11 \end{pmatrix}$, $\begin{pmatrix} 34 \\ 8 \\ 2\\ 3\\ 10 \end{pmatrix}$, $\begin{pmatrix} 21 \\ 0 \\ 72\\ 48\\ 72 \end{pmatrix}$, $\begin{pmatrix} 2 \\ 4 \\ 8\\ 17\\ 12 \end{pmatrix}$, $\begin{pmatrix} 4 \\ 14 \\ 1\\ 0\\ 15 \end{pmatrix}$ veamos si son l.i. o l.d."""

# ╔═╡ 87cb5d96-7a2d-4790-8af3-b9445669b8ba
md"""Definimos la matriz"""

# ╔═╡ cfed83a0-6e97-480c-a199-01d19f45d591
A₂ = [2 34 21 2 4; 2 8 0 4 14; 9 2 72 8 1; 1 3 48 17 0; 11 10 72 12 15]

# ╔═╡ 70a98272-7d97-4049-b3b4-71d0f1824875
md"""Calculamos su determinante"""

# ╔═╡ e604d0fc-61f8-4690-9f18-74da1cdaaf7a
det(A₂)

# ╔═╡ 1143b84f-0625-40ed-82e9-b5ba5e6738f0
md"""Dado que el determinante de la matriz $A$ es cero entonces las columnas de $A$ son linealmente dependientes, por tanto el conjunto de vectores es l.d."""

# ╔═╡ 6955fb57-042f-4190-9c34-0a60c2c3d102
md"""**Teorema:** Cualquier conjunto de $n$ vectores linealmente independiente en $\mathbb{R}^n$ genera a $\mathbb{R}^n$."""

# ╔═╡ e76c3ab7-a182-456b-a067-6c8cdd2deff1
md"""*Ejemplo:*

Consideremos el siguiente conjunto de vectores $\left\{\begin{pmatrix} 2 \\ 2\end{pmatrix}, \begin{pmatrix} 0 \\ 5\end{pmatrix}\right\}$. Definamos la matriz asociada a ellos"""

# ╔═╡ fbdafbd4-01d8-4387-8c8a-ae1e84c1d6bd
A₃ = [2 0; 2 5]

# ╔═╡ 3e061584-d7c1-4ef5-a3a3-b6eb80ce2dd2
md"""Calculemos su determinante"""

# ╔═╡ 864f49a9-690f-43fd-92ff-383051dfacfa
det(A₃)

# ╔═╡ e635b25a-a589-4628-8b01-0abe76d9101a
md"""Como el determinante de la matriz es diferente de cero, entonces las columnas son linealmente independientes. Por tanto, dicho conjunto de vectores genera a $\mathbb{R}^2$."""

# ╔═╡ 0ace1896-b6a3-4fde-bd82-bd1e789d3337
md"""# Bases

Un conjunto finito de vectores $\{v_1, v_2, \ldots, v_n\}$ es una **base** para un espacio vectorial $V$ si:

i) $\{v_1, v_2, \ldots, v_n\}$ es linealmente independiente.

ii) $\{v_1, v_2, \ldots, v_n\}$ genera a $V$.
"""

# ╔═╡ 3a6a24fe-f07b-4ad8-b951-45d36a73cef3
md"""*Ejemplo:*

Al considerar el conjunto de vectores $\left\{\begin{pmatrix} 1 \\ 0\\0\end{pmatrix}, \begin{pmatrix} 0 \\ 1\\ 0\end{pmatrix}, \begin{pmatrix} 0 \\ 0\\1\end{pmatrix}\right\}$, notamos que este es linealmente independiente, ya que el determinante de la matriz asociada es distinto de 0."""

# ╔═╡ b1690ca3-7ee2-4d62-a39a-6b4727fd4b12
A₄ = [1 0 0; 0 1 0; 0 0 1]

# ╔═╡ f1b92eaa-ad6b-4dea-80e2-35a12236d26c
det(A₄)

# ╔═╡ b823582d-6105-437f-abdf-cf24b7810721
md"""Y además dicho conjunto genera a $\mathbb{R}^3$, por tanto es una base de $\mathbb{R}^3$. Esta base es conocida como base canónica, ya que es generada por los vectores canónicos del espacio."""

# ╔═╡ c3af4f4f-4117-4afe-bc42-7738d8c3bbb9
md"""# Vectores ortonormales"""

# ╔═╡ b3dfa9a1-67a8-4ab2-a0c9-e03462b8184e
md"""Se dice que un conjunto de vectores $\{u_1, u_2, \ldots, u_k\}$ en $\mathbb{R}^n$ es un conjunto ortonormal si y sólo si cumple las siguientes condiciones:

$u_i \cdot u_j = 0 \quad \text{si } i \neq j$

$u_i \cdot u_i = 1$"""

# ╔═╡ de51ac23-ab98-4f96-97d4-5de9c44167ee
md"""*Ejemplo:*

Consideremos el siguiente conjunto de vectores $\left\{\begin{pmatrix} 0 \\ 0\\-1\end{pmatrix},\begin{pmatrix} 1/\sqrt{2} \\ 1/\sqrt{2}\\0\end{pmatrix}, \begin{pmatrix} 1/\sqrt{2} \\ -1/\sqrt{2}\\0\end{pmatrix}\right\}$"""

# ╔═╡ 30b23e0d-0471-44d5-a81e-d5f49bb862ac
a1 = [0,0,-1]; a2 = [1,1,0]/sqrt(2); a3 = [1,-1,0]/sqrt(2); #Definimos los vectores

# ╔═╡ e338c272-3372-4eda-8491-298067134968
md"""Verifiquemos que los vectores tengan norma 1"""

# ╔═╡ 0a2cddc8-c6a7-4c7c-8cd2-5c748088ed02
norm(a1), norm(a2), norm(a3)

# ╔═╡ 0cb55c9b-1f62-44ad-8c79-af2a8d08be58
md"""Por último veamos si son ortogonales entre si"""

# ╔═╡ 6ae8c85f-8a1e-4510-a801-4f4591daf123
a1'*a2, a1'*a3, a2'*a3

# ╔═╡ 3cb31960-52cd-43c2-89c1-9822da58df4e
md"""Como satisfacen las condiciones mencionadas, dicho conjunto de vectores es ortonormal."""

# ╔═╡ 68590ad2-5fa5-4138-9fa3-a843be78be82
md""" Podemos transformar un conjunto de vectores linealmente independientes en un conjunto de vectores ortonormales. Así cualquier base en $\mathbb{R}^n$ se puede “convertir” en una base ortonormal, esto se realiza con el proceso de ortonormalización de Gram-Schmidt.
"""

# ╔═╡ b92bc7b3-f302-4099-b304-be5f12c8f737
md"""### Proceso de ortonormalización de Gram-Schmidt Clásico"""

# ╔═╡ fdce2ba9-da8e-4095-88ef-65e889b3703f
md"""
Sea $H$ un subespacio de dimensión $m$ de $\mathbb{R}^n$. Sea $S=\{v_1, v_2, \cdots, v_m\}$ una base de $H$, construyamos una base ortonormal a partir de los vectores en $S$.

Primero, vamos a definir $q_1=\frac{v_1}{\|v_1\|}$, ahora debemos elegir un segundo vector ortogonal a $q_1$. Tomemos $\hat{q}_2=v_2-(v_2\cdot  q_1)q_1$, entonces 

$\hat{q}_2 \cdot q_1 = v_2\cdot q_1 - (v_2 \cdot q_1) \cdot (q_1\cdot q_1)= v_2\cdot q_1 -(v_2\cdot q_1)(1)=0$

así $\hat{q}_2$ es ortogonal a $q_1$, además es claro que $q_1$ y $\hat{q}_2$ son linealmente independientes. Así el segundo vector unitario es $q_2=\frac{\hat{q}_2}{\|\hat{q}_2\|}$.

Entonces $\{q_1, q_2\}$ es un conjunto ortonormal.

Supongamos que se han construido los vectores $q_1, q_2,\cdots, q_k (k< m)$ y que forman un conjunto ortonormal. Veamos ahora como construir $q_{k+1}$. Sea

$\hat{q}_{k+1} = v_{k+1} - (v_{k+1} \cdot q_1) u_1 - (v_{k+1} \cdot q_2) q_2 - \ldots - (v_{k+1} \cdot q_k) q_k$

Entonces, para $i = 1, 2, \ldots, k$ se sigue que

$\hat{q}_{k+1} \cdot q_i = v_{k+1} \cdot q_i - (v_{k+1} \cdot q_1) (u_1 \cdot q_i) - (v_{k+1} \cdot q_2) (q_2 \cdot q_i) - \ldots - (v_{k+1} \cdot q_i) (q_k \cdot q_i)-\ldots - (v_{k+1}\cdot q_k)(q_k\cdot q_i)$

Pero $q_j \cdot q_i = 0$ si $j \neq i$ y $q_i \cdot q_i = 1$. Por lo tanto,

$v'_{k+1} \cdot q_i = v_{k+1} \cdot q_i - v_{k+1} \cdot q_i = 0$

Así, $\{q_1, q_2, \ldots, q_k, \hat{q}_{k+1}\}$ es un conjunto linealmente independiente, ortogonal y $\hat{q}_{k+1} \neq 0$.

Dado que $q_{k+1} = \frac{\hat{q}_{k+1}}{\|\hat{q}_{k+1}\|}$, es claro que $\{q_1, q_2, \ldots, q_k, q_{k+1}\}$ forma un conjunto ortonormal. Este proceso puede repetirse hasta que $k+1 = m$. Obteniendo así un conjunto ortonormal a partir de los vectores $\{v_1, v_2, \cdots, v_{m}\}$
"""

# ╔═╡ f395839e-21d0-4b31-85b6-9a6293c0eece
md"""De lo anterior se tiene el siguiente algoritmo:"""

# ╔═╡ 9f0f52c0-5858-4bed-9f66-fe86bde5c42b
md"""**ALGORITMO Gram-Schmidt**:

1. Calcular $r_{11} := \|v_1\|$. Si $r_{11} = 0$, detenerse; de lo contrario, calcular $q_1 := \frac{v_1}{r_{11}}.$
2. Para $j = 2, \ldots, m$:
3. Calcular $r_{ij} := (v_j, q_i)$ para $i = 1, 2, \ldots, j - 1$.
4.   $\hat{q} := v_j - \displaystyle\sum_{i=1}^{j-1} r_{ij} q_i$.
5.   $r_{jj} := \|\hat{q}\|$.
6. Si $r_{jj} = 0$, detenerse; de lo contrario, $q_j := \frac{\hat{q}}{r_{jj}}$.
7. Fin"""

# ╔═╡ 5b344ec4-2312-41c5-b7bd-ae1f9cfef374
md"""Programando el algoritmo, se obtiene la siguiente función"""

# ╔═╡ f313579d-e31e-44fc-8c1a-29e708825514
function Gram_Schmidt(v)
    q = []
	if norm(v[1])==0
		return nothing
	else
    for j = 1:length(v)
        qtilde = v[j]
        for i = 1:j-1
			rij = dot(v[j],q[i])
            qtilde -= rij * q[i]
		end
			rjj = norm(qtilde)
			if rjj==0
				return nothing
			else
				push!(q, qtilde/norm(qtilde))
        	end
	end
    return q
	end
end

# ╔═╡ 691272c4-c627-48d3-bf26-6dc30868540a
md"""*Ejemplo:* 

Sabemos que $\{v_1, v_2, v_3\} = \left\{ \begin{pmatrix} 1\\ 1\\ 0 \end{pmatrix}, \begin{pmatrix} 0\\ 1\\ 1 \end{pmatrix}, \begin{pmatrix} 1\\ 0\\ 1 \end{pmatrix} \right\}$ es una base en $\mathbb{R}^3$, construyamos una base ortonormal con Gram-Schmidt."""

# ╔═╡ 769d1d28-f7bb-4e73-8673-fa4eb3106d66
v = [ [1, 1, 0], [0, 1, 1], [1, 0, 1] ] #Definimos los vectores

# ╔═╡ 99bc6fa2-5802-4911-a3ec-4c1eef038631
u = Gram_Schmidt(v) #Se genera el nuevo conjunto de vectores

# ╔═╡ feb39913-bc19-4e14-91c3-2b1e6bc82d31
md"""### Proceso de ortogonalización de Gram-Schmidt Modificado"""

# ╔═╡ 969d8800-1e8d-46b8-a3cb-2039f8cd2788
md""" Existen formulaciones alternativas del algoritmo que tienen mejores propiedades numéricas. La más conocida de ellas es el algoritmo de Gram-Schmidt Modificado. Dicho algoritmo busca mejorar la estabilidad numérica al evitar la proyección sobre todos los vectores anteriores en cada paso, reduciendo así los errores de redondeo. Dicho algoritmo es el siguiente"""

# ╔═╡ 19340c28-048d-4a05-89fa-22a9ec74c82e
md"""**ALGORITMO Gram-Schmidt Modificado:**

1. Definir $r_{11} := \|v_1\|$. Si $r_{11} = 0$, detenerse; de lo contrario, $q_1 := \frac{v_1}{r_{11}}$.
2. Para $j = 2, \ldots, m$:
3. Definir $\hat{q} := v_j$.
4. Para $i = 1, \ldots, j - 1$, hacer:
5.   $r_{ij} := (\hat{q}, q_i)$.
6.   $\hat{q} := \hat{q} - r_{ij}q_i$.
7. Fin
8. Calcular $r_{jj} := \|\hat{q}\|$.
9. Si $r_{jj} = 0$, detenerse; de lo contrario, $q_j := \frac{\hat{q}}{r_{jj}}$.
10. Fin"""

# ╔═╡ 186e2a7c-d0b5-4f3f-b018-2f1730d862df
function Modified_Gram_Schmidt(v)
    q = []
    r11 = norm(v[1])
	if r11==0
		return nothing
	else
		push!(q, v[1]/r11)
		for j = 2:length(v)
			qtilde = v[j]
			for i = 1:j-1
				rij = qtilde'*q[i]
				qtilde -= rij*q[i]
			end
			rjj = norm(qtilde)
			if rjj==0
				return nothing
			else
				push!(q, qtilde/rjj)
			end
		end
	end
    return q
end

# ╔═╡ 5f29a619-037a-4ae1-a016-7a5a018dd1c2
md"""Trabajando con el ejemplo anterior se tiene lo siguiente"""

# ╔═╡ 801a01c9-d082-4653-86ab-7f025fb80ffb
u1 = Modified_Gram_Schmidt(v)

# ╔═╡ ea1bfd30-5ac5-4049-b49f-406edb47f93e
md"""Podemos hallar la diferencia de la solución usando el algoritmo de Gram-Schmidt clásico y el modificado. Esto de la siguiente manera."""

# ╔═╡ 7c96682f-8470-4a9e-875e-1fa9c3991cd1
norm(u-u1)

# ╔═╡ 01f0e576-9fd8-4ab3-b9e3-49a80ad7c72c
md"""Note que la norma de la diferencia es 0, por tanto ambas soluciones son iguales."""

# ╔═╡ 20589af8-2c27-4abe-9cef-b41fe29013f8
md"""**Matriz ortogonal:**

Una matriz $Q$ de tamaño $n\times n$ es ortogonal si $Q$ es invertible y $Q^{-1}=Q^t$.

Observe que si $Q^{-1}=Q^t$, entonces $Q^tQ=I$.
"""

# ╔═╡ 0b7a3178-c725-4888-89d6-f586bc4c8376
md"""**Teorema:**

La matriz $Q$ de $n\times n$ es ortogonal si y sólo si las columnas de $Q$ forman una base ortonormal para $\mathbb{R}^n$."""

# ╔═╡ acbb988d-4878-4418-a8c4-e0afd04390e4
md"""*Ejemplo:*

Los vectores"""

# ╔═╡ ed048bba-c998-4431-9419-1c9485462585
u

# ╔═╡ 7f18e5f1-a87c-4481-a431-bd5e38502d6d
md"""forman una base ortonormal en $\mathbb{R}^3$. Así, la siguiente matriz es una matriz ortogonal"""

# ╔═╡ f6ec5d5a-41c3-4008-9f48-1dfd03a4d4aa
Q=[u[1] u[2] u[3]]

# ╔═╡ 49c416f3-ab47-441c-9f44-1d3e8b76a1fe
md"""Esto se verifica facilmente, ya que $Q^tQ=I$"""

# ╔═╡ 08b5e338-b3f6-4377-801e-164dde541669
Q'*Q

# ╔═╡ 504dd8a0-0539-4162-83ba-d6a38819b2ea
md"""# Referencias"""

# ╔═╡ 3c8225c5-1939-4aae-b868-8dc69b72bd9b
md"""[1] Strang, G. (2016). Introduction to Linear Algebra (5ta ed.). Wellesley-Cambridge Press.

[2] Saad, Y. (2003). Iterative methods for sparse linear systems (2nd ed.). Society for Industrial and Applied Mathematics.

[4] Martínez R., H. J., & Sanabria R., A. M. (2014). Álgebra Lineal. Programa Editorial Universidad del Valle.

[5] Boyd, S., & Vandenberghe, L. (2021). Introduction to Applied Linear Algebra: Vectors, Matrices, and Least Squares - Julia Language Companion. Cambridge University Press.

[6] Grossman, S. I., & Flores Godoy, J. J. (2012). Álgebra Lineal (7a ed.). McGraw-Hill."""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.54"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.3"
manifest_format = "2.0"
project_hash = "df096654961dc96e3629b8ea2e427860c9eeccd0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "c278dfab760520b8bb7e9511b968bf4ba38b7acc"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "bd7c69c7f7173097e7b5e1be07cee2b8b7447f51"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.54"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─35c0a300-abed-11ee-1816-3d6ab9b18487
# ╟─ad0e2661-ac54-4037-bda1-3e665dbecaf4
# ╟─b47f513f-114d-4b96-b866-0090c9f0d107
# ╟─55a8d645-c175-4e72-9452-08bcaffa5ec1
# ╟─4a709378-cf2c-4072-9e46-46b4c7237c1b
# ╠═79324bba-2c1a-498f-8bdf-a70e02106f86
# ╟─0097fe78-3013-4eaf-ae85-006d6c10c803
# ╟─f60001c4-b165-4ae3-a642-3d0464a6d2d7
# ╟─711861fd-da33-4f4c-9237-402139b704d2
# ╟─158705aa-0e94-417a-a230-e50d538d606a
# ╟─370e0299-7477-4054-9224-632f5c3d2c90
# ╟─7d5c788c-3a1d-4cf7-80ae-9aae5f4b0a95
# ╠═90cb66de-990c-4de5-8fdb-6da4bc847273
# ╠═07ac532d-68b8-446b-82a4-e70449ba4a03
# ╟─2f5cc080-b35b-4c71-bfc4-76172bb59aa8
# ╠═a0782db0-ab75-4756-a930-4bd8ecd3f1ba
# ╟─d168cd90-9578-49bf-abe9-90c2f562204e
# ╟─f659a285-b849-4c98-8783-e633feeaf8f8
# ╟─782ef9e9-3605-4864-8220-5c03accb7a19
# ╠═7997ae23-f4fe-460e-9232-f90b3516eb1a
# ╟─00750fbe-297e-4f6c-9a9a-6060f717d5c2
# ╠═5bf6f082-11f9-4e1d-bac5-0f6df7dcb993
# ╟─4df7fa1f-fb6e-451e-8838-b0f0856d21ea
# ╟─f0435b3b-0e6e-406c-bcb2-4febfe476470
# ╟─87cb5d96-7a2d-4790-8af3-b9445669b8ba
# ╠═cfed83a0-6e97-480c-a199-01d19f45d591
# ╟─70a98272-7d97-4049-b3b4-71d0f1824875
# ╠═e604d0fc-61f8-4690-9f18-74da1cdaaf7a
# ╟─1143b84f-0625-40ed-82e9-b5ba5e6738f0
# ╟─6955fb57-042f-4190-9c34-0a60c2c3d102
# ╟─e76c3ab7-a182-456b-a067-6c8cdd2deff1
# ╠═fbdafbd4-01d8-4387-8c8a-ae1e84c1d6bd
# ╟─3e061584-d7c1-4ef5-a3a3-b6eb80ce2dd2
# ╠═864f49a9-690f-43fd-92ff-383051dfacfa
# ╟─e635b25a-a589-4628-8b01-0abe76d9101a
# ╟─0ace1896-b6a3-4fde-bd82-bd1e789d3337
# ╟─3a6a24fe-f07b-4ad8-b951-45d36a73cef3
# ╠═b1690ca3-7ee2-4d62-a39a-6b4727fd4b12
# ╠═f1b92eaa-ad6b-4dea-80e2-35a12236d26c
# ╟─b823582d-6105-437f-abdf-cf24b7810721
# ╟─c3af4f4f-4117-4afe-bc42-7738d8c3bbb9
# ╟─b3dfa9a1-67a8-4ab2-a0c9-e03462b8184e
# ╟─de51ac23-ab98-4f96-97d4-5de9c44167ee
# ╠═30b23e0d-0471-44d5-a81e-d5f49bb862ac
# ╟─e338c272-3372-4eda-8491-298067134968
# ╠═0a2cddc8-c6a7-4c7c-8cd2-5c748088ed02
# ╟─0cb55c9b-1f62-44ad-8c79-af2a8d08be58
# ╠═6ae8c85f-8a1e-4510-a801-4f4591daf123
# ╟─3cb31960-52cd-43c2-89c1-9822da58df4e
# ╟─68590ad2-5fa5-4138-9fa3-a843be78be82
# ╟─b92bc7b3-f302-4099-b304-be5f12c8f737
# ╟─fdce2ba9-da8e-4095-88ef-65e889b3703f
# ╟─f395839e-21d0-4b31-85b6-9a6293c0eece
# ╟─9f0f52c0-5858-4bed-9f66-fe86bde5c42b
# ╟─5b344ec4-2312-41c5-b7bd-ae1f9cfef374
# ╠═f313579d-e31e-44fc-8c1a-29e708825514
# ╟─691272c4-c627-48d3-bf26-6dc30868540a
# ╠═769d1d28-f7bb-4e73-8673-fa4eb3106d66
# ╠═99bc6fa2-5802-4911-a3ec-4c1eef038631
# ╟─feb39913-bc19-4e14-91c3-2b1e6bc82d31
# ╟─969d8800-1e8d-46b8-a3cb-2039f8cd2788
# ╟─19340c28-048d-4a05-89fa-22a9ec74c82e
# ╠═186e2a7c-d0b5-4f3f-b018-2f1730d862df
# ╟─5f29a619-037a-4ae1-a016-7a5a018dd1c2
# ╠═801a01c9-d082-4653-86ab-7f025fb80ffb
# ╟─ea1bfd30-5ac5-4049-b49f-406edb47f93e
# ╠═7c96682f-8470-4a9e-875e-1fa9c3991cd1
# ╟─01f0e576-9fd8-4ab3-b9e3-49a80ad7c72c
# ╟─20589af8-2c27-4abe-9cef-b41fe29013f8
# ╟─0b7a3178-c725-4888-89d6-f586bc4c8376
# ╟─acbb988d-4878-4418-a8c4-e0afd04390e4
# ╠═ed048bba-c998-4431-9419-1c9485462585
# ╟─7f18e5f1-a87c-4481-a431-bd5e38502d6d
# ╠═f6ec5d5a-41c3-4008-9f48-1dfd03a4d4aa
# ╟─49c416f3-ab47-441c-9f44-1d3e8b76a1fe
# ╠═08b5e338-b3f6-4377-801e-164dde541669
# ╟─504dd8a0-0539-4162-83ba-d6a38819b2ea
# ╟─3c8225c5-1939-4aae-b868-8dc69b72bd9b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
