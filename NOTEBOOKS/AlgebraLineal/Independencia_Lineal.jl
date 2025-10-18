### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 35c0a300-abed-11ee-1816-3d6ab9b18487
using PlutoUI

# ╔═╡ 79324bba-2c1a-498f-8bdf-a70e02106f86
using LinearAlgebra, DelimitedFiles, Plots

# ╔═╡ ad0e2661-ac54-4037-bda1-3e665dbecaf4
PlutoUI.TableOfContents(title="Independencia lineal I", aside=true)

# ╔═╡ b47f513f-114d-4b96-b866-0090c9f0d107
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 55a8d645-c175-4e72-9452-08bcaffa5ec1
md"""Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo."""

# ╔═╡ 4a709378-cf2c-4072-9e46-46b4c7237c1b
md"""Usaremos las siguientes librerías."""

# ╔═╡ 0097fe78-3013-4eaf-ae85-006d6c10c803
md"""# Introducción"""

# ╔═╡ f60001c4-b165-4ae3-a642-3d0464a6d2d7
md"""La independencia lineal es un concepto esencial en álgebra lineal que destaca la relación entre vectores. Ver $[1,2,3,4,5]$.

Se refiere a la propiedad de un conjunto de vectores donde ninguno puede expresarse como combinación lineal de los demás de manera trivial. Esta noción es clave en la resolución de sistemas de ecuaciones y análisis estructural.
"""

# ╔═╡ 711861fd-da33-4f4c-9237-402139b704d2
md"""**Dependencia e independencia lineal** se refieren a las relaciones entre vectores en un espacio vectorial $V$. Si $v_1, v_2, \ldots, v_n$ son $n$ vectores en $V$, entonces se consideran linealmente dependientes (l.d.) si existen escalares $c_1, c_2, \ldots, c_n$, no todos iguales a cero, tales que:

$c_1v_1 + c_2v_2 + \ldots + c_nv_n = 0.$

En caso de que los vectores no sean linealmente dependientes, se clasifican como linealmente independientes (l.i.).
"""

# ╔═╡ 158705aa-0e94-417a-a230-e50d538d606a
md"""Para expresarlo de manera alternativa, $v_1, v_2, \ldots, v_n$ son linealmente independientes si la ecuación $c_1v_1 + c_2v_2 + \ldots + c_nv_n = 0$ se satisface únicamente cuando $c_1 = c_2 = \ldots = c_n = 0$. En cambio, son linealmente dependientes si el vector cero en $V$ puede representarse como una combinación lineal de $v_1, v_2, \ldots, v_n$ con coeficientes no todos iguales a cero.
"""

# ╔═╡ 370e0299-7477-4054-9224-632f5c3d2c90
md"""**Teorema:**

Dos vectores en un espacio vectorial son linealmente dependientes si y solo si uno de ellos es un múltiplo escalar del otro.

Para detalles de la demostración, ver $[4]$ o $[6].$
"""

# ╔═╡ 7d5c788c-3a1d-4cf7-80ae-9aae5f4b0a95
md"""*Ejemplo:*

Los vectores $v_1 = \begin{pmatrix} 2 \\ -1 \\ 0 \\ 3 \end{pmatrix}$ y $v_2 = \begin{pmatrix} -6 \\ 3 \\ 0 \\ -9 \end{pmatrix}$ son linealmente dependientes, ya que $v_2 = -3v_1$.
"""

# ╔═╡ 90cb66de-990c-4de5-8fdb-6da4bc847273
v₁ = [2; -1; 0; 3] #Se define el vector v₁

# ╔═╡ 07ac532d-68b8-446b-82a4-e70449ba4a03
v₂ = [-6; 3; 0; -9] #Se define el vector v₂

# ╔═╡ 2f5cc080-b35b-4c71-bfc4-76172bb59aa8
md"""Verifiquemos la igualdad:"""

# ╔═╡ a0782db0-ab75-4756-a930-4bd8ecd3f1ba
v₂==-3*v₁

# ╔═╡ d168cd90-9578-49bf-abe9-90c2f562204e
md""" **Teorema:**

Sea
$A = \begin{pmatrix}
a_{11} & a_{12} & a_{1n} \\
a_{21} & a_{22} & a_{2n} \\
\vdots & \vdots & \vdots \\
a_{m1} & a_{m2} & a_{mn} \\
\end{pmatrix}$. Entonces las columnas de $A$ consideradas como vectores son linealmente dependientes si y sólo si el sistema, que se puede escribir como $Ac= 0$, tiene soluciones no triviales, donde $c=\begin{pmatrix}c_1\\c_2\\ \vdots\\c_n\end{pmatrix}$.
"""

# ╔═╡ 1ee9790e-db27-4315-81d2-ddce95597e9a
md""" **Teorema:** 

Sea $A$ una matriz de $n \times n$. Entonces $\text{det} A \neq 0$ si y sólo si las columnas de $A$ son linealmente independientes.

Para detalles de la demostración, ver $[6]$."""

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
md"""**Teorema:** Cualquier conjunto de $n$ vectores linealmente independiente en $\mathbb{R}^n$ genera a $\mathbb{R}^n$.

Para detalles de la demostración, ver $[6]$."""

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

Para más detalles de esto ver $[4,6].$
"""

# ╔═╡ 3a6a24fe-f07b-4ad8-b951-45d36a73cef3
md"""*Ejemplo:*

Al considerar el conjunto de vectores $\left\{\begin{pmatrix} 1 \\ 0\\0\end{pmatrix}, \begin{pmatrix} 0 \\ 1\\ 0\end{pmatrix}, \begin{pmatrix} 0 \\ 0\\1\end{pmatrix}\right\}$, notamos que este es linealmente independiente, ya que el determinante de la matriz asociada es distinto de 0.
"""

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

$u_i \cdot u_j = 0 \quad \text{si } i \neq j,$

$u_i \cdot u_i = 1.$
"""

# ╔═╡ de51ac23-ab98-4f96-97d4-5de9c44167ee
md"""*Ejemplo:*

Consideremos el siguiente conjunto de vectores $\left\{\begin{pmatrix} 0 \\ 0\\-1\end{pmatrix},\begin{pmatrix} 1/\sqrt{2} \\ 1/\sqrt{2}\\0\end{pmatrix}, \begin{pmatrix} 1/\sqrt{2} \\ -1/\sqrt{2}\\0\end{pmatrix}\right\}.$"""

# ╔═╡ 30b23e0d-0471-44d5-a81e-d5f49bb862ac
a1 = [0,0,-1]; a2 = [1,1,0]/sqrt(2); a3 = [1,-1,0]/sqrt(2); #Definimos los vectores

# ╔═╡ e338c272-3372-4eda-8491-298067134968
md"""Verifiquemos que los vectores tengan norma $1$."""

# ╔═╡ 0a2cddc8-c6a7-4c7c-8cd2-5c748088ed02
norm(a1), norm(a2), norm(a3)

# ╔═╡ 0cb55c9b-1f62-44ad-8c79-af2a8d08be58
md"""Por último veamos si son ortogonales entre sí."""

# ╔═╡ 6ae8c85f-8a1e-4510-a801-4f4591daf123
a1'*a2, a1'*a3, a2'*a3

# ╔═╡ 3cb31960-52cd-43c2-89c1-9822da58df4e
md"""Como satisfacen las condiciones mencionadas, dicho conjunto de vectores es ortonormal."""

# ╔═╡ 68590ad2-5fa5-4138-9fa3-a843be78be82
md"""Podemos transformar un conjunto de vectores linealmente independientes en un conjunto de vectores ortonormales. Así, cualquier base en $\mathbb{R}^n$ se puede "convertir" en una base ortonormal; esto se realiza con el proceso de ortonormalización de Gram-Schmidt.
"""

# ╔═╡ b92bc7b3-f302-4099-b304-be5f12c8f737
md"""### Proceso de ortonormalización de Gram-Schmidt Clásico"""

# ╔═╡ fdce2ba9-da8e-4095-88ef-65e889b3703f
md"""Sea $H$ un subespacio de dimensión $m$ de $\mathbb{R}^n$. Sea $S=\{v_1, v_2, \cdots, v_m\}$ una base de $H$, construyamos una base ortonormal a partir de los vectores en $S$.

Primero, vamos a definir $q_1=\frac{v_1}{\|v_1\|}$. Ahora debemos elegir un segundo vector ortogonal a $q_1$. Tomemos $\hat{q}_2=v_2-(v_2\cdot q_1)q_1$, entonces 

$\hat{q}_2 \cdot q_1 = v_2\cdot q_1 - (v_2 \cdot q_1) \cdot (q_1\cdot q_1)= v_2\cdot q_1 -(v_2\cdot q_1)(1)=0,$

así $\hat{q}_2$ es ortogonal a $q_1$, además es claro que $q_1$ y $\hat{q}_2$ son linealmente independientes. Así el segundo vector unitario es $q_2=\frac{\hat{q}_2}{\|\hat{q}_2\|}$.

Entonces $\{q_1, q_2\}$ es un conjunto ortonormal.

Supongamos que se han construido los vectores $q_1, q_2,\cdots, q_k$ (donde $k<m$) y que forman un conjunto ortonormal. Veamos ahora cómo construir $q_{k+1}$. Sea

$\hat{q}_{k+1} = v_{k+1} - (v_{k+1} \cdot q_1) q_1 - (v_{k+1} \cdot q_2) q_2 - \ldots - (v_{k+1} \cdot q_k) q_k.$

Entonces, para $i = 1, 2, \ldots, k$ se sigue que

$\hat{q}_{k+1} \cdot q_i = v_{k+1} \cdot q_i - (v_{k+1} \cdot q_1) (q_1 \cdot q_i) - (v_{k+1} \cdot q_2) (q_2 \cdot q_i) - \ldots - (v_{k+1} \cdot q_k) (q_k \cdot q_i).$

Pero $q_j \cdot q_i = 0$ si $j \neq i$ y $q_i \cdot q_i = 1$. Por lo tanto,

$v'_{k+1} \cdot q_i = v_{k+1} \cdot q_i - v_{k+1} \cdot q_i = 0.$

Así, $\{q_1, q_2, \ldots, q_k, \hat{q}_{k+1}\}$ es un conjunto linealmente independiente y ortogonal, donde $\hat{q}_{k+1} \neq 0$.

Dado que $q_{k+1} = \frac{\hat{q}_{k+1}}{\|\hat{q}_{k+1}\|}$, es claro que $\{q_1, q_2, \ldots, q_k, q_{k+1}\}$ forma un conjunto ortonormal. Este proceso puede repetirse hasta que $k+1 = m$, obteniendo así un conjunto ortonormal a partir de los vectores $\{v_1, v_2, \cdots, v_{m}\}$.
"""

# ╔═╡ f395839e-21d0-4b31-85b6-9a6293c0eece
md"""Para más detalles y ejemplos ver $[1,2, 6]$.

De lo anterior se tiene el siguiente algoritmo:"""

# ╔═╡ 9f0f52c0-5858-4bed-9f66-fe86bde5c42b
md"""**ALGORITMO Gram-Schmidt**:

1. Calcular $r_{11} := \|v_1\|$. Si $r_{11} = 0$, detenerse; de lo contrario, calcular $q_1 := \frac{v_1}{r_{11}}.$
2. Para $j = 2, \ldots, m$:
3. Calcular $r_{ij} := (v_j, q_i)$ para $i = 1, 2, \ldots, j - 1$.
4.   $\hat{q} := v_j - \displaystyle\sum_{i=1}^{j-1} r_{ij} q_i$.
5.   $r_{jj} := \|\hat{q}\|$.
6. Si $r_{jj} = 0$, detenerse; de lo contrario, $q_j := \frac{\hat{q}}{r_{jj}}$.
7. Fin."""

# ╔═╡ 5b344ec4-2312-41c5-b7bd-ae1f9cfef374
md"""Programando el algoritmo, se obtiene la siguiente función:"""

# ╔═╡ f313579d-e31e-44fc-8c1a-29e708825514
function CGS(v)
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
u = CGS(v) #Se genera el nuevo conjunto de vectores

# ╔═╡ feb39913-bc19-4e14-91c3-2b1e6bc82d31
md"""### Proceso de ortonormalización de Gram-Schmidt Modificado"""

# ╔═╡ 969d8800-1e8d-46b8-a3cb-2039f8cd2788
md""" Existen formulaciones alternativas del algoritmo que tienen mejores propiedades numéricas. La más conocida de ellas es el algoritmo de Gram-Schmidt Modificado. Dicho algoritmo busca mejorar la estabilidad numérica al evitar la proyección sobre todos los vectores anteriores en cada paso, reduciendo así los errores de redondeo. Ver $[1,2,6]$.

Dicho algoritmo es el siguiente:"""

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
10. Fin."""

# ╔═╡ 186e2a7c-d0b5-4f3f-b018-2f1730d862df
function MGS(v)
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
md"""Trabajando con el ejemplo anterior se tiene lo siguiente:"""

# ╔═╡ 801a01c9-d082-4653-86ab-7f025fb80ffb
u1 = MGS(v)

# ╔═╡ ea1bfd30-5ac5-4049-b49f-406edb47f93e
md"""Podemos hallar la diferencia de la solución usando el algoritmo de Gram-Schmidt clásico y el modificado. Esto de la siguiente manera."""

# ╔═╡ 7c96682f-8470-4a9e-875e-1fa9c3991cd1
norm(u-u1)

# ╔═╡ 01f0e576-9fd8-4ab3-b9e3-49a80ad7c72c
md"""Note que la norma de la diferencia es $0$, por tanto ambas soluciones son iguales."""

# ╔═╡ 20589af8-2c27-4abe-9cef-b41fe29013f8
md"""**Matriz ortogonal:**

Una matriz $Q$ de tamaño $n\times n$ es ortogonal si $Q$ es invertible y $Q^{-1}=Q^t$.

Observe que si $Q^{-1}=Q^t$, entonces $Q^tQ=I$.
"""

# ╔═╡ 0b7a3178-c725-4888-89d6-f586bc4c8376
md"""**Teorema:**

La matriz $Q$ de $n\times n$ es ortogonal si y solo si las columnas de $Q$ forman una base ortonormal para $\mathbb{R}^n$."""

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
md"""Esto se verifica fácilmente, ya que $Q^tQ=I$."""

# ╔═╡ 08b5e338-b3f6-4377-801e-164dde541669
Q'*Q

# ╔═╡ 95d1b33a-b0ed-4082-bd6c-fdf6e064751a
md"""# Comparación entre CGS y MGS"""

# ╔═╡ 4ebd3b53-f5cb-41ad-b90a-b34c8ba5b8c5
md""" 
A continuación se comparan los métodos CGS y MGS por su eficiencia en términos de tiempo. Vamos a realizar el proceso de ortogonormalización $100$ veces para vectores aleatorios con ambos algoritmos.
"""

# ╔═╡ 0efb3405-821c-4f87-838d-fdbc3455a55c
n= @bind N Slider(5:1:200, show_value=true, default=100)

# ╔═╡ 6fe2f5bc-d71c-4189-b860-27215b38d22c
begin
	TC = [] #tiempo en ejecutar el alg. de Gram-Schmidt Clásico
	TM = [] #tiempo en ejecutar el alg. de Gram-Schmidt Modificado
	for i in collect(2:N)
		a=0
		b=0
		vector = [rand(i) for k in 1:i]
		for j=1:30 #Se repite 30 veces para aproximar la duración real
			a += (@timed CGS(vector))[2]
			b += (@timed MGS(vector))[2]
		end
		append!(TC, a/30)
		append!(TM, b/30)
	end
end

# ╔═╡ 218cd115-bb63-4f66-8f7e-9b7ddc1ecc9e
plot(collect(2:N),[TC,TM], label=["CGS" "MGS"], title="Comparación en tiempo", xlabel="Orden del vector", ylabel="Tiempo en segundos")

# ╔═╡ 3df3f4ab-1758-49b6-92b2-579e745e6940
md"""
Como se esperaba, el MGS, al usar más operaciones que el CGS, es el algoritmo que más gasta tiempo.
"""

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
DelimitedFiles = "8bb1440f-4735-579b-a4ab-409b98df4dab"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
DelimitedFiles = "~1.9.1"
Plots = "~1.40.4"
PlutoUI = "~0.7.54"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "e12b76619182ca6f51de41348a3c78ec8ca18926"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b0fd3f56fa442f81e0a47815c92245acfaaa4e34"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.31.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "6c72198e6a101cccdd4c9731d3985e904ba26037"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7bb1361afdb33c7f2b085aa49ea8fe1b0fb14e58"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.7.1+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "83dc665d0312b41367b7263e8a4d172eac1897f4"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.4"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "3a948313e7a41eb1db7a1e733e6335f17b4ab3c4"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "7.1.1+0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "f85dac9a96a01087df6e3a749840015a0ca3817d"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.17.1+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "2c5512e11c791d1baed2049c5652441b28fc6a31"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "fcb0584ff34e25155876418979d4c8971243bb89"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+2"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "1828eb7275491981fa5f1752a5e126e8f26f8741"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.17"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "27299071cc29e409488ada41ec7643e0ab19091f"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.17+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "50c11ffab2a3d50192a228c313f05b5b5dc5acb2"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.86.0+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "ed5e9c58612c4e081aecdb6e1a479e18462e041e"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "e2222959fbc6c19554dc15174c81bf7bf3aa691c"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.4"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4255f0032eafd6451d707a51d5f0248b8a165e4d"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.3+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aaafe88dccbd957a8d82f7d05be9b69172e0cee3"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.1+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eb62a3deb62fc6d8822c0c4bef73e4412419c5d8"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.8+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "44f93c47f9cd6c7e431f2f2091fcba8f01cd7e8f"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.10"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "706dfd3c0dd56ca090e86884db6eda70fa7dd4af"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.1+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "4ab7581296671007fc33f07a721631b8855f4b1d"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.1+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d3c8af829abaeba27181db4acb485b18d15d89c6"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.1+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f02b56007b064fbfddb4c9cd60161b6dd0f40df3"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.1.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "f1a7e086c677df53e064e0fdd2c9d0b0833e3f6e"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.5.0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2ae7d4ddec2e13ad3bddf5c0796f7547cf682391"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.2+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c392fc5dd032381919e3b22dd32d6443760ce7ea"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.5.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1f7f9bbd5f7a2e5a9f7d96e51c9754454ea7f60b"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.4+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "bfe839e9668f0c58367fb62d8757315c0eac8777"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.20"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "8329a3a4f75e178c11c1ce2342778bcbbbfa7e3c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.71"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "eb38d376097f47316fe089fc62cb7c6d85383a52"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.8.2+1"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll"]
git-tree-sha1 = "da7adf145cce0d44e892626e647f9dcbe9cb3e10"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.8.2+1"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "9eca9fc3fe515d619ce004c83c31ffd3f85c7ccf"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.8.2+1"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "e1d5e16d0f65762396f9ca4644a5f4ddab8d452b"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.8.2+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "64d974c2e6fdf07f8155b5b2ca2ffa9069b608d9"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.2"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "95af145932c2ed859b63329952ce8d633719f091"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9d72a13a3f4dd3795a195ac5a44d7d6ff5f552ff"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.1"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "2c962245732371acd51700dbb268af311bddd719"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.6"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "372b90fe551c019541fafc6ff034199dc19c8436"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.12"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "6258d453843c466d84c17a58732dda5deeb8d3af"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.24.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    ForwardDiffExt = "ForwardDiff"
    InverseFunctionsUnitfulExt = "InverseFunctions"
    PrintfExt = "Printf"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"
    Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "af305cc62419f9bd61b6644d19170a4d258c7967"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.7.0"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee71455b0aaa3440dfdd54a9a36ccef829be7d4"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.1+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "b5899b25d17bf1889d25906fb9deed5da0c15b3b"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.12+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a4c0ee07ad36bf8bbce1c3bb52d21fb1e0b987fb"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.7+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "9caba99d38404b285db8801d5c45ef4f4f425a6d"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.1+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "a376af5c7ae60d29825164db40787f15c80c7c54"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.3+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a5bc75478d323358a90dc36766f3c99ba7feb024"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.6+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "aff463c82a773cb86061bce8d53a0d976854923e"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.5+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "e3150c7400c41e207012b41659591f083f3ef795"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.3+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "c5bf2dad6a03dfef57ea0a170a1fe493601603f2"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.5+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "801a858fc9fb90c11ffddee1801bb06a738bda9b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.7+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "00af7ebdc563c9217ecc67776d1bbf037dbcebf4"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.44.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4bba74fa59ab0755167ad24f98800fe5d727175b"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.12.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "125eedcb0a4a0bba65b657251ce1d27c8714e9d6"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.4+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "07b6a107d926093898e82b3b1db657ebe33134ec"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.50+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "fbf139bce07a534df0e699dbb5f5cc9346f95cc1"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.9.2+0"
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
# ╟─1ee9790e-db27-4315-81d2-ddce95597e9a
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
# ╟─95d1b33a-b0ed-4082-bd6c-fdf6e064751a
# ╟─4ebd3b53-f5cb-41ad-b90a-b34c8ba5b8c5
# ╟─0efb3405-821c-4f87-838d-fdbc3455a55c
# ╠═6fe2f5bc-d71c-4189-b860-27215b38d22c
# ╟─218cd115-bb63-4f66-8f7e-9b7ddc1ecc9e
# ╟─3df3f4ab-1758-49b6-92b2-579e745e6940
# ╟─504dd8a0-0539-4162-83ba-d6a38819b2ea
# ╟─3c8225c5-1939-4aae-b868-8dc69b72bd9b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
