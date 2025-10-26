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

# ╔═╡ d4fd49f0-a4d6-11ee-2ed0-87bf49ac3dbe
using PlutoUI

# ╔═╡ 2165ecbf-beda-449c-86cc-ec87c185378a
using LinearAlgebra

# ╔═╡ 4c72fa64-f63b-4fb1-9dbd-5a20b7013998
begin
	using Colors, ColorVectorSpace, ImageShow, FileIO, ImageIO
	using HypertextLiteral
	using Images, ImageTransformations
	using TestImages
	using Plots
end

# ╔═╡ 3035376d-38b4-4cc7-be0a-a01350cfebc3
PlutoUI.TableOfContents(title="Compresión de imágenes", aside=true)

# ╔═╡ bbdde380-96bd-4cec-9404-4a87e4ff20ad
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**.

Tu participación es fundamental para hacer de este curso una experiencia aún mejor.
"""

# ╔═╡ 0bc7f753-b24c-40c7-b177-8643afbe56f3
md"""Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo. """

# ╔═╡ 597f25a7-657e-496c-ab05-6dc2a17bd394
md"""Vamos a usar las siguientes librerías:"""

# ╔═╡ b7f28940-db8e-423a-abfb-d2452a461aea
md"""# Introducción"""

# ╔═╡ 29c53f25-89b8-44a2-a081-cd3b5e15989a
md"""Sea $T:V\to W$ una transformación lineal. En diversas aplicaciones resulta útil encontrar un vector $v$ en $V$ tal que $Tv$ y $v$ son paralelos, es decir, se busca un vector $v$ y un escalar $\lambda$ tal que $Tv=\lambda v$.

Si $v \neq 0$ y $\lambda$ satisface lo anterior, entonces $\lambda$ se denomina un valor propio de $T$ y $v$ un vector propio de $T$ correspondiente al valor propio $\lambda$. Si $V$ tiene dimensión finita, entonces $T$ se puede representar por una matriz $A_T$. Por esta razón se estudiarán los valores y los vectores propios de las matrices de $n \times n$, ver $[1-5]$.
"""

# ╔═╡ 3c11d286-ede4-4b20-a021-1a21a8e39a47
md"""### Valor y vector propio (Autovalor y autovector)

Sea $A$ una matriz de tamaño $n \times n$ con componentes reales $\mathcal{M}_{n}(\mathbb{R})$. El número $\lambda$ (real o complejo) se denomina valor propio (autovalor) de $A$ si existe un vector diferente de cero $v$ en $\mathbb{C}^n$ tal que

$Av = \lambda v.$

El vector $v \neq 0$ se denomina vector propio (autovector) de $A$ correspondiente al valor propio $\lambda$.
"""

# ╔═╡ 89954279-80f0-4f8d-91a8-87cd35a7e50f
md"""*Ejemplo*:

Sea $A = \begin{pmatrix}
10 & -18 \\
6 & -11
\end{pmatrix}$. Entonces 

$A \begin{pmatrix}
2 \\
1
\end{pmatrix} =
\begin{pmatrix}
10 & -18 \\
6 & -11
\end{pmatrix}
\begin{pmatrix}
2 \\
1
\end{pmatrix} = \begin{pmatrix}
2 \\
1
\end{pmatrix}.$

Así, $\lambda_1 = 1$ es un valor propio de $A$ con el correspondiente vector propio $v_1 = \begin{pmatrix}
2 \\
1
\end{pmatrix}$. De manera similar,

$A \begin{pmatrix}
3 \\
2
\end{pmatrix} =
\begin{pmatrix}
10 & -18 \\
6 & -11
\end{pmatrix}
\begin{pmatrix}
3 \\
2
\end{pmatrix} = \begin{pmatrix}
-6 \\
-4
\end{pmatrix} = -2 \begin{pmatrix}
3 \\
2
\end{pmatrix},$

de modo que $\lambda_2 = -2$ es un valor propio de $A$ con el correspondiente vector propio $v_2 = \begin{pmatrix}
3 \\
2
\end{pmatrix}$. Éstos son los únicos valores propios de $A$.
"""

# ╔═╡ 4c660259-fc08-45ce-869d-aa308db9a381
md"""**Teorema:**

Sea $A$ una matriz de tamaño $n \times n$. Entonces $\lambda$ es un valor propio de $A$ si y solo si

$p(\lambda) = \text{det}(A - \lambda I) = 0.$

La anterior ecuación se denomina ecuación característica de $A$ y $p(\lambda)$ se denomina el polinomio característico de $A$."""

# ╔═╡ 61e57d71-f1db-42fd-950e-1555e04dd25b
md"""Contando multiplicidades, toda matriz de $n \times n$ tiene exactamente $n$ valores propios. Esto se debe al teorema fundamental del álgebra, que establece que cualquier polinomio de grado $n$ con coeficientes reales o complejos tiene exactamente $n$ raíces (contando multiplicidades)."""

# ╔═╡ f7c800a7-5fd2-427a-87e1-e6dc3025f2bb
md"""*Ejemplo:*

Sea $A$ la matriz
$\begin{bmatrix}
4 & 2 \\
3 & 3
\end{bmatrix}.$
Entonces, el polinomio característico de $A$ es

$$\text{det}(A - \lambda I) =
\begin{vmatrix}
4-\lambda & 2 \\
3 & 3-\lambda
\end{vmatrix}
= (4-\lambda)(3-\lambda) - 6 = \lambda^2 - 7\lambda + 6 = (\lambda - 1)(\lambda - 6).$$

Así, $\lambda_1 = 1$ y $\lambda_2 = 6$. 

Para $\lambda_1 = 1$, la ecuación $(A - \lambda I)v = 0$ se resuelve como
$\begin{bmatrix}
3 & 2 \\
3 & 2
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2
\end{bmatrix}
=
\begin{bmatrix}
0 \\
0
\end{bmatrix}.$
Es claro que cualquier vector propio correspondiente a $\lambda_1 = 1$ satisface $3x_1 + 2x_2 = 0$. Un vector propio de este tipo es $v_1 = \begin{bmatrix} -2 \\ 3 \end{bmatrix}$. 

De manera similar, para $\lambda_2 = 6$, la ecuación $(A - \lambda_2 I)v = 0$ se resuelve como
$\begin{bmatrix}
-2 & 2 \\
3 & -3
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2
\end{bmatrix}
=
\begin{bmatrix}
0 \\
0
\end{bmatrix}.$
Entonces, $v_2 = \begin{bmatrix} 1 \\ 1 \end{bmatrix}$ es un vector propio correspondiente a $\lambda_2 = 6$. 

Observe que $v_1$ y $v_2$ son linealmente independientes ya que uno no es múltiplo del otro. Verifiquemos esto.
"""

# ╔═╡ d719095e-5c31-47e1-80ac-ca7a4fe02268
md"""Se define la matriz $A$ como"""

# ╔═╡ 30e643a1-96ea-4e35-b4a5-b6270d641b85
A₁=[4 2; 3 3]

# ╔═╡ ac999805-156a-4dc8-8bfb-448e5e13ec3c
md"""Calculamos los autovalores:"""

# ╔═╡ 54009f24-b5c6-4d19-8b0c-e7bf9c80eac1
eigvals(A₁)

# ╔═╡ 9753880a-4705-46db-8285-d09fd2cfcb4e
md"""Y ahora, calculamos los autovectores con la función $\texttt{eigvecs}$, esta función devuelve una matriz cuyas columnas son los vectores propios correspondientes a los valores propios de $A$."""

# ╔═╡ 3aa4aa35-8228-4768-aaa9-665fea64e66a
eigvecs(A₁)

# ╔═╡ 49c671e4-a9ac-4353-bd3d-ca7ca60c4bde
md"""
*Ejemplo:*

Sea $A$ una matriz de tamaño $2 \times 2$, tal que $A=\begin{bmatrix}
    2 & -1 \\
    -4 & 2 \\
\end{bmatrix}$, entonces de la ecuación $|A - \lambda I| = 0$, donde $I$ es la matriz identidad se sigue que los valores propios son $\lambda_1 = 0$ y $\lambda_2 = 4$. El espacio característico asociado a cero es simplemente el núcleo de la matriz $A$, que se calcula resolviendo el sistema de ecuaciones homogéneas $Av=0$, esto es
$\begin{bmatrix}
    2 & -1 \\
    -4 & 2 \\
\end{bmatrix}
\begin{bmatrix}
    x_1 \\
    x_2 \\
\end{bmatrix}
=
\begin{bmatrix}
    0 \\
    0 \\
\end{bmatrix},$
lo que resulta en la solución $2x_1 = x_2$, y un vector propio es $v = \begin{bmatrix} 1 \\ 2 \end{bmatrix}$. Por lo tanto, el espacio característico correspondiente a $\lambda_1 = 0$ es generado por $v$.

Al analizar lo que corresponde a $\lambda_2 = 4$, el sistema se expresa como
$\begin{bmatrix}
    -2 & -1 \\
    -4 & -2 \\
\end{bmatrix}
\begin{bmatrix}
    x_1 \\
    x_2 \\
\end{bmatrix}
=
\begin{bmatrix}
    0 \\
    0 \\
\end{bmatrix},$
lo que resulta en la solución $-2x_1 = x_2$. Por lo tanto, el vector propio asociado a $\lambda_2 = 4$ es $\begin{bmatrix} -1 \\ 2 \end{bmatrix}$. Verifiquemos esto.
"""

# ╔═╡ f262ae1f-12e6-4049-8710-f01100550394
md"""Se define la matriz"""

# ╔═╡ 44441b44-1c11-4d37-bb71-c5f02d8ce117
A₂=[2 -1; -4 2]

# ╔═╡ 43d138de-1de5-4ab4-b7b5-382c7de2bc61
md"""Calculamos los autovalores como:"""

# ╔═╡ 2edab60e-f215-4ff6-b8c9-4029fc398022
eigvals(A₂)

# ╔═╡ 7fa5236e-7a13-4d0a-a3c5-13079501c41f
md"""Calculamos los autovalores de la matriz."""

# ╔═╡ 5c362741-cf34-49bd-a012-ae0c32ed01b1
eigvecs(A₂)

# ╔═╡ 42b1874c-dbc6-4016-9ce3-b3b9b9a6cdd4
md"""*Ejemplo:*

Sea $A=\begin{bmatrix}
    -1 & -3 & -9\\
    0 & 5 & 18\\
	0 & -2 & -7
\end{bmatrix}$. Entonces definimos la matriz como"""

# ╔═╡ ab190fc1-8692-4eb2-9624-4f436aff6a3f
A₃=[-1 -3 -9; 0 5 18; 0 -2 -7] #Definimos la matriz

# ╔═╡ 084e38c9-504c-420b-8055-ab9726afcbdb
eigvals(A₃) #Calculamos los autovalores

# ╔═╡ ad524fa6-59ff-4b83-9f5d-d31fe78d0dd9
eigvecs(A₃) #Calculamos los autovectores

# ╔═╡ f3ade9f9-87c3-4319-b4e5-6314fda18f48
md""" ### Valores singulares

Sea $A \in \mathcal{M}_{m,n}(\mathbb{R})$, y $\lambda_1 \geq \lambda_2 \geq \cdots \geq \lambda_n \geq 0$ los valores propios de la matriz $A^tA$ ordenados de mayor a menor. Entonces $\sigma_i=\sqrt{\lambda_i}$ es el $i$-ésimo valor singular de la matriz $A$."""

# ╔═╡ 169d15f4-b07a-4a48-8ae6-7d7a2a1abf9c
md"""*Ejemplo:*

Sea $A=\begin{bmatrix}
    4 & 6 & 4 \\
    5 & 3 & 7 \\
    7 & 8 & 51 \\
    12 & 0 & 3
\end{bmatrix}$, hallemos sus valores singulares."""

# ╔═╡ 3d6e43a4-ba0e-47f4-9cc1-3e436bfe8025
A₄ = [4 6 4; 5 3 7; 7 8 51; 12 0 3] #Definimos la matriz

# ╔═╡ 8816b4c2-cc7e-4d6c-aaec-48965ad7189b
md"""Calculamos ahora $A^tA$"""

# ╔═╡ b4d88e14-6f3c-4b61-8384-0d6c9ad4c4fb
B = transpose(A₄)*A₄

# ╔═╡ 7da14d7d-6d1c-4528-912f-d72f74866ef6
md"""Calculamos los valores propios de $B = A^tA$."""

# ╔═╡ b5e437ff-bb77-4431-b368-4e6242dcd921
valoresp = eigvals(B)

# ╔═╡ e23ba6a3-5127-4780-8609-5ed39ebb0ad0
md"""Ahora, sacamos la raíz cuadrada de cada uno de los valores propios anteriores."""

# ╔═╡ 126f8804-795a-424b-ba80-764e6aba54eb
valores = sqrt.(valoresp)

# ╔═╡ 0b218b88-db11-4105-94b7-ea59a99f27f6
md"""Por último, los ordenamos de mayor a menor, obteniendo así los valores singulares de la matriz $A$ ordenados."""

# ╔═╡ 054a669b-fc9f-4101-ad1d-5c49a49e46a8
sort(valores, rev=true)

# ╔═╡ 2b5a3dd2-3d43-40a9-9a06-e66620f7bb67
md"""Todo esto se puede hacer con la función $\texttt{svdvals}$."""

# ╔═╡ 1dcc9f3f-75b0-4c8d-8aca-f43baca7ad44
svdvals(A₄)

# ╔═╡ 8a759b36-b8d3-4883-8040-e53051d91501
md"""**Nota:** Los autovectores de $A^tA$ forman una base ortonormal de $\mathbb{R}^n$  $(\{v_1, v_2, \cdots, v_n\}).$"""

# ╔═╡ e7f0c5f6-f58d-460d-9059-c79f28dc3354
md"""# Descomposición en valores singulares (SVD)"""

# ╔═╡ d629b140-3356-48a6-886f-23686d3adc02
md"""Una descomposición en valores singulares de $A\in \mathcal{M}_{m, n}(\mathbb{R})$ es una factorización del tipo $A=U\Sigma V^t$ con $U \in \mathcal{M}_{m}(\mathbb{R})$, $V \in \mathcal{M}_{n}(\mathbb{R})$ matrices ortogonales y $\Sigma \in \mathcal{M}_{m,n}(\mathbb{R})$ una matriz formada con los valores singulares de $A$ en su diagonal principal ordenados de mayor a menor."""

# ╔═╡ 4d5f7c22-b3d5-4cf1-ae07-f8b2ad750499
md"""**Teorema:** Toda matriz $A \in \mathcal{M}_{m,n}(\mathbb{R})$ tiene una descomposición en valores singulares."""

# ╔═╡ 0440866d-cefc-4b48-9900-44ca8f22a721
md"""El conjunto $\{Av_1, \ldots, Av_n\}$ es ortogonal, y $Av_{r+1} = \cdots = Av_{m} = 0_{\mathbb{R}^m}$, donde $r$ es el rango de la matriz $A$. Consideremos $u_1 = \frac{Av_1}{\sigma_1}, \ldots, u_r = \frac{Av_r}{\sigma_r}$, se tiene que
$\{u_1, \ldots, u_r\}$ es un conjunto ortonormal. Entonces, si $r < m$, podemos completar con $\{u_{r+1}, \ldots, u_m\}$ hasta formar una base ortonormal de $\mathbb{R}^m$. Así,

$\begin{cases} Av_1 = \sigma_1 u_1, \\ \vdots \\ Av_r = \sigma_r u_r, \\ Av_{r+1} = 0_{\mathbb{R}^m}, \\ \vdots \\ Av_n = 0_{\mathbb{R}^m}. \end{cases}$

Reescribiendo este último sistema de ecuaciones de manera matricial con las matrices $V \in M_n(\mathbb{R})$ ortogonal y $\Sigma \in M_{m, n}(\mathbb{R})$ ortogonal se tiene que

$U\Sigma = \small \begin{pmatrix}|&&| \\ u_1 & \cdots & u_n \\ |&&| \end{pmatrix} \begin{pmatrix} \sigma_1 & 0 & \cdots & 0 & 0 & \cdots & 0 \\ 0 & \sigma_2 & \cdots & 0 & 0 & \cdots & 0 \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 0 & 0 & \cdots & \sigma_r & 0 & \cdots & 0 \\ 0 & 0 & \cdots & 0 & 0 & \cdots & 0 \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 0 & 0 & \cdots & 0 & 0 & \cdots & 0 \end{pmatrix}= \begin{pmatrix}|&&| & |&&| \\ \sigma_1 u_1 & \cdots & \sigma_r u_r & 0 & \cdots & 0 \\ |&&| & |&&| \end{pmatrix}.$

De aquí que, $AV = U\Sigma$ y, finalmente, como $V$ es una matriz ortogonal, $A = U\Sigma V^t$. Siendo esta la SVD de $A$.

*Nota:* De esta descomposición se observa que la matriz $A$ puede escribirse como combinación lineal de matrices de rango $1$ tal que:

$A = \sum_{i=1}^{r} \sigma_i u_i v_i^t.$
"""

# ╔═╡ 5a81f4f7-13b2-4e58-8235-f87994cfd335
md"""*Ejemplo:*

Si 
$A = \begin{pmatrix} 0 & 0 \\ 0 & 9 \\ 3 & 0 \end{pmatrix},$ entonces  $A^{T}A = \begin{pmatrix} 9 & 0 \\ 0 & 81 \end{pmatrix},$
cuyos autovalores son $\lambda_1 = 81$ y $\lambda_2 = 9$ asociados a los autovectores $v_1 = \begin{pmatrix} 0 \\ 1 \end{pmatrix}$ y $v_2 = \begin{pmatrix} 1 \\ 0 \end{pmatrix}$, respectivamente. Tal como se muestra a continuación. """

# ╔═╡ c1757f04-2da1-45dd-96f3-d88ebed49ad6
A₅ = [0 0; 0 9; 3 0] #Definimos la matriz

# ╔═╡ ae99d165-ea88-44e0-9117-b3e17228605c
eigen(transpose(A₅)*A₅) #Calculamos los autovalores y los autovectores de AᵗA

# ╔═╡ a4efc892-930c-4b52-8c91-132fba31cc70
md"""Entonces, los valores singulares de $A$ son $\sigma_1 = \sqrt{\lambda_1}=\sqrt{81}=9$ y $\sigma_2 =\sqrt{\lambda_2}=\sqrt{9}= 3$. Observe que, la cantidad de valores singulares distintos de cero concuerda con el rango de la matriz."""

# ╔═╡ 7d8859f3-02b7-4436-ab17-9c7c2211d405
md"""Ahora buscamos los vectores $\{u_1, u_2, u_3\}$ con $u_i \in \mathbb{R}^3$, que deben satisfacer

$\begin{cases} Av_1 = \sigma_1 u_1, \\ Av_2 = \sigma_2 u_2, \\ Av_3 = 0_{\mathbb{R}^3}. \end{cases}$"""

# ╔═╡ 5f63f86a-3251-4259-b3e4-bd0adfd988ef
u₁ = A₅*[0 1]'/9 #Calculamos u₁

# ╔═╡ fe7de800-92aa-457f-b041-a45f5532d3f6
u₂ = A₅*[1 0]'/3 #Calculamos u₂

# ╔═╡ 8a72ab17-1387-4c88-8ac3-a5c62235c7a9
md"""Esto es
$u_1 = \frac{Av_1}{\sigma_1} = \frac{1}{9} \begin{pmatrix} 0 \\ 9 \\ 0 \end{pmatrix} = \begin{pmatrix} 0 \\ 1 \\ 0 \end{pmatrix}$
y $u_2 = \frac{Av_2}{\sigma_2} = \frac{1}{3} \begin{pmatrix} 0 \\ 0 \\ 3 \end{pmatrix} = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix}.$
Entonces completamos una base ortonormal de $\mathbb{R}^3$ con $\{(0,1,0), (0,0,1), (1,0,0)\}.$

Por tanto,

$U = \begin{pmatrix} 0 & 0 & 1 \\ 1 & 0 & 0 \\ 0 & 1 & 0 \end{pmatrix},$

y

$V = \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix}.$

Y la matriz compuesta por los valores singulares ordenados:

$\Sigma = \begin{pmatrix} 9 & 0 \\ 0 & 3 \\ 0 & 0 \end{pmatrix}.$

Por lo tanto, la descomposición en valores singulares de $A$ es:

$A = U \Sigma V^T = \begin{pmatrix} 0 & 0 & 1 \\ 1 & 0 & 0 \\ 0 & 1 & 0 \end{pmatrix} \begin{pmatrix} 9 & 0 \\ 0 & 3 \\ 0 & 0 \end{pmatrix} \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix} = \begin{pmatrix} 0 & 0 \\ 0 & 9 \\ 3 & 0 \end{pmatrix}.$
"""

# ╔═╡ f34c0050-53e9-4e7b-b469-6632d0e7bfa6
md"""#### Descomposición en valores singulares reducida (SVD reducida)
"""

# ╔═╡ ed680832-48b0-4f83-8aa6-417ae2bda95a
md"""La Descomposición en Valores Singulares Reducida (SVD reducida) se presenta como una versión más concisa de la SVD, especialmente útil cuando la matriz es rectangular y su rango es menor que sus dimensiones.

Para una matriz $A$ de tamaño $m \times n$ con rango $r$, la SVD reducida se define de la siguiente manera:

$A = U_r \Sigma_r V_r^T,$ donde:

$U_{r} = \begin{pmatrix}|&&| \\ u_{1} & \cdots & u_{r} \\ |&&| \end{pmatrix}^t,$

$V_{r} = \begin{pmatrix}|&&| \\ v_{1} & \cdots & v_{r} \\ |&&| \end{pmatrix}^t,$

$\Sigma_{r} = \begin{pmatrix}
    \sigma_{1} & 0 & \cdots & 0 \\
    0 & \sigma_{2} & \cdots & 0 \\
    \vdots & \vdots & \ddots & \vdots \\
    0 & 0 & \cdots & \sigma_{r}
\end{pmatrix}.$
"""

# ╔═╡ dd6943b8-0b4a-456c-b02a-96bc3bb3cc6b
md"""*Ejemplo:* Continuando con el anterior ejemplo, recordemos que $A$ es la siguiente matriz."""

# ╔═╡ e5ca71e7-9999-4a91-b6f0-e2ef237278b7
A₅

# ╔═╡ 880fae25-acb7-4c10-a1d4-66465b845494
md"""Julia por defecto trabaja con la SVD reducida, y podemos hallarla con el siguiente codigo:"""

# ╔═╡ f6cf1f30-3020-489e-8783-d0ca69c2b7f8
svd(A₅)

# ╔═╡ 9ff5a87c-0de4-45d9-bdcf-438f109874fd
md"""Así, podemos acceder a $U, \Sigma$ y $V$ de las siguientes formas:"""

# ╔═╡ 82592100-5e3e-422c-8f05-eac9cd02262f
U₅ = svd(A₅).U

# ╔═╡ 249b606f-164d-4570-b92f-438fac15267a
S₅ = svd(A₅).S

# ╔═╡ 9be27f62-64dc-4ddd-9435-ceb965e7e344
V₅ = svd(A₅).V

# ╔═╡ d4d7b4d4-acf1-4fb8-bcfd-fcb7707116b9
md"""Observe así que:"""

# ╔═╡ 1db431eb-de14-4145-a1ab-ac211c3bcb09
U₅*Diagonal(S₅)*V₅'

# ╔═╡ 34f1f0d5-2a18-4729-b426-e64000345aa8
md"""En efecto, se verifica la igualdad."""

# ╔═╡ f97eefca-c28a-4b97-8dd8-6139f905fa58
A₅ == U₅*Diagonal(S₅)*V₅'

# ╔═╡ 21e3d5a7-809b-4b07-84ad-5160bd251c2e
md"""*Ejemplo:*

Consideremos la siguiente matriz y realicemos su SVD."""

# ╔═╡ cce0135e-8a81-4d1c-9871-8bd628b0842e
A₆=[3.0 2.0 4.0; 12.0 3.0 7.0]

# ╔═╡ 59daa287-ef2a-467d-adcd-51d7f48b28ee
md"""Calculamos la descomposición en valores singulares de la matriz."""

# ╔═╡ 1aaeaa4c-bcac-49b1-bd75-46846f11911a
SVD₆=svd(A₆)

# ╔═╡ 12fea289-b26b-480e-a182-186d05ebc882
U₆=SVD₆.U #Visualizamos U

# ╔═╡ 5bac1f4b-29d9-434b-8d77-c9858ed964cd
S₆=SVD₆.S #Visualizamos los valores singulares

# ╔═╡ 6330d14a-f619-4fa4-b006-7b0021bdfd15
V₆=SVD₆.V #Visualizamos V

# ╔═╡ a8ca4dec-0d18-416b-a2ad-60112edc64e0
U₆ * Diagonal(S₆) * transpose(V₆) #Realizamos el producto U*Σ*Vᵗ

# ╔═╡ f7417595-9aa2-41f1-8512-053757880d04
md"""Para más detalles de la descomposición en valores singulares, ver $[1,2].$"""

# ╔═╡ b31f93c6-c2fa-41a4-8fd1-48f188deda48
md"""# Compresión de imágenes

La compresión de imágenes mediante SVD busca reducir el número de valores singulares utilizados en la descomposición, lo cual resulta en una aproximación de menor tamaño de la imagen original.
"""

# ╔═╡ 277e2fe3-4413-4e14-8cb7-f590f18fb13e
md"""Recordemos que una imagen se puede representar de manera matricial, ver $[6,7]$. Así podemos trabajar en cada canal de color de la imagen para comprimir la imagen. 

Para esto, vamos a considerar la matriz $A$ que representa uno de los tres canales de la imagen (R, G o B) y realizamos su descomposición en valores singulares $A=U\Sigma V^t$, y como, en la matriz $\Sigma$, los valores singulares se ordenan de mayor a menor, vamos a seleccionar solo los primeros $k$ valores singulares y truncaresmos las columnas de $U$ y $V$ correspondientes, esto reduce la dimensionalidad de la respresentación. Así, este canal quedara comprimido de la siguiente forma $A_k=U_k\Sigma_k V_k^t$. Este proceso lo repetimos para cada canal de color.

La cantidad de compresión lograda depende de cuántos valores singulares se seleccionen (es decir, el valor de $k$). Cuanto menor sea $k$, mayor será la compresión, pero también mayor será la pérdida de información y calidad de la imagen.
Esta técnica es especialmente eficaz en la compresión de imágenes cuando muchos de los valores singulares son insignificantes en términos de contribución a la información visual de la imagen.

Para tener esto más claro, veamos un par de ejemplos."""

# ╔═╡ 3aadd3a3-579a-4d92-b22e-66f6e116f614
md"""Usaremos las siguientes librerias."""

# ╔═╡ d94c49d1-e07e-4af0-9403-12c7570e2d6f
md"""Cargamos la imagen deseada, en este caso la de un tucan."""

# ╔═╡ 1ee06fb8-6c36-49af-a27d-9087aae981ee
url₁="https://upload.wikimedia.org/wikipedia/commons/1/11/Ramphastos_toco.jpg"

# ╔═╡ 4f88eeca-a049-445a-9ca3-0687c18f5856
md"""Ahora bajamos la imagen a la máquina local."""

# ╔═╡ 3cd07cfa-3676-4407-933f-0416af96f955
fname = download(url₁)

# ╔═╡ 13fdc708-1a0e-4382-a0e1-d1829fc4c063
md"""Ahora declaramos la variable "imag", que corresponde a un tipo de dato que representa imágenes."""

# ╔═╡ b06a24ff-e7cb-434d-80f7-b644b2943699
imag₁ = load(fname)

# ╔═╡ aba3666c-cd92-4da6-9414-4e5b85c9fbee
md"""El tamaño de la imágen es:"""

# ╔═╡ 8d0c171c-a0f0-461f-8c15-2eb4efeb0d88
imag_size₁= size(imag₁)

# ╔═╡ 50eb3a7f-a4a8-40ff-82d0-9967e11dee66
md"""La forma matricial de esta imagen, vista desde los 3 canales de color es la siguiente:"""

# ╔═╡ 9e0f8df9-44f3-45d0-8694-457144801903
matrix_image₁ =float.(channelview(imag₁))

# ╔═╡ 1da5c61e-a247-4858-8ae6-8e90b0133e75
md"""La matriz que representa en canal R (red) de la imagen es la siguiente:"""

# ╔═╡ 77674b80-09ef-4008-96b2-1bc806d16c42
redimage=red.(imag₁)

# ╔═╡ f374cb25-8ff7-43a2-8590-688e7ec56f84
function rotar(matriz)
    # Intercambiar las filas
    matriz_rotada = reverse(matriz, dims=1)
    return matriz_rotada
end

# ╔═╡ 80f711c0-8238-4ce2-bab6-39379aa806da
md"""Visualizamos dicho canal en la imagen."""

# ╔═╡ 6ab554ab-f687-47db-8726-1086b9f48b7e
heatmap(rotar(redimage), color=:reds, axis=false, legend=false)

# ╔═╡ 78ef7478-4bca-42a8-b6b2-ad674092e697
md"""De igual forma, la matriz que representa el canala B (blue) es la siguiente:"""

# ╔═╡ e4f34663-1950-4081-b448-44b80b5c7621
blueimage=blue.(imag₁)

# ╔═╡ 0d407ef7-cd6a-4a39-bf13-2d2508325acc
md"""Al visualizar dicho canal obtenemos la siguiente imagen."""

# ╔═╡ 54212b2e-2161-498a-a14f-60941bda3921
heatmap(rotar(blueimage), color=:blues, axis=false, legend=false)

# ╔═╡ a06c8fab-0313-4a03-8c3c-18769ccd8ebe
md"""Por ultimo, la matriz que representa el canal G (green) es la siguiente:"""

# ╔═╡ 6f6dc966-bccb-4460-acd0-182f08c0b458
greenimage=green.(imag₁)

# ╔═╡ a405d1c8-3fd1-4076-b9bb-16e255db2cd0
md"""Y, de este canal se tiene la siguiente imagen."""

# ╔═╡ c73440a9-3551-4be8-8730-322e9a1bc50f
heatmap(rotar(greenimage), color=:greens, axis=false, legend=false)

# ╔═╡ 142d7155-a438-4b58-aef1-d2d67368b1a1
md"""Vamos a realizar la decomposición en valores singulares de cada matriz (R, G, B)."""

# ╔═╡ 7a759b90-1758-4173-bc33-c04e69e3c74f
begin
	#Canal R
	Ur=svd(redimage).U
	Σr=svd(redimage).S
	Vr=svd(redimage).V
	#Canal G
	Ug=svd(greenimage).U
	Σg=svd(greenimage).S
	Vg=svd(greenimage).V
	#Canal B
	Ub=svd(blueimage).U
	Σb=svd(blueimage).S
	Vb=svd(blueimage).V
end

# ╔═╡ d43420d5-e552-426b-88e6-60a7d4eb2b01
md"""Definimos cuántos valores singulares vamos a usar:"""

# ╔═╡ 3284ca43-d8f5-453e-856f-ecfff8af9b20
K= @bind k Slider(1:1:size(Σg)[1], show_value=true, default=10)

# ╔═╡ 3ecf24e3-b676-42f8-9f3b-4fdd2e1cc89c
md"""y truncamos cada matriz."""

# ╔═╡ aeabb688-7043-4227-8d12-81cc3427ce1f
Mr = Ur[:, 1:k] * Diagonal(Σr[1:k]) * transpose(Vr[:, 1:k]);

# ╔═╡ 1c901f4b-123d-48dc-a713-e34178964264
heatmap(rotar(Mr), color=:reds, axis=false, legend=false)

# ╔═╡ ff4ea15f-1a01-421b-9076-6fc7df638fe9
Mg = Ug[:, 1:k] * Diagonal(Σg[1:k]) * transpose(Vg[:, 1:k]);

# ╔═╡ 8250d63a-12c0-4f87-839f-c45ea54bb4a8
heatmap(rotar(Mg), color=:greens, axis=false, legend=false)

# ╔═╡ 6571e75b-fd06-4075-9c65-2a036be9c5b2
Mb = Ub[:, 1:k] * Diagonal(Σb[1:k]) * transpose(Vb[:, 1:k]);

# ╔═╡ 3074097c-b8de-4301-beee-ebfa7cd46354
heatmap(rotar(Mb), color=:blues, axis=false, legend=false)

# ╔═╡ cccb52fa-2041-4cc8-bed8-c3891381bc52
md"""Juntamos los tres canales, para obtener la imagen en formato RGB."""

# ╔═╡ 8e489736-426d-489a-90ae-072d2e90a87a
imagen_RGB = permutedims(cat(dims=3, Mr, Mg, Mb), [3, 1, 2]);

# ╔═╡ 04a5cee1-67ee-41bb-9d98-4bfc9e2b7fe6
colorview(RGB, imagen_RGB)

# ╔═╡ dd21192e-06fc-4fb3-993c-a793b50b4003
md"""Una vez explicado esto, creemos una función:"""

# ╔═╡ cc465e20-0fc8-41e4-88b7-0d70f1aab07d
function compresion(imag, k)
	channels=float.(channelview(imag));
	svdfactors = svd.(eachslice(channels; dims=1));
		Ur=svdfactors[1].U;
		Σr=svdfactors[1].S;
		Vr=svdfactors[1].V;
		Ug=svdfactors[2].U;
		Σg=svdfactors[2].S;
		Vg=svdfactors[2].V;
		Ub=svdfactors[3].U;
		Σb=svdfactors[3].S;
		Vb=svdfactors[3].V;
	Mr = Ur[:, 1:k] * Diagonal(Σr[1:k]) * transpose(Vr[:, 1:k]);
	Mg = Ug[:, 1:k] * Diagonal(Σg[1:k]) * transpose(Vg[:, 1:k]);
	Mb = Ub[:, 1:k] * Diagonal(Σb[1:k]) * transpose(Vb[:, 1:k]);
	imagen_RGB = cat(dims=3, Mr, Mg, Mb)
	imagen= permutedims(imagen_RGB, [3, 1, 2])
	imagencomprida = colorview(RGB, imagen)
	return imagencomprida
end

# ╔═╡ 1fbdad93-58d0-4e08-9dc9-f2decca5c549
md"""Para ver que porcentaje de la imagen original obtenemos al truncar la iamgen, podemos realizar:

$\frac{\displaystyle\sum_{i=1}^{k} \sigma_i^2}{\displaystyle\sum_{i=1}^{r} \sigma_i^2} \times 100\%.$

Donde $k$ es la cantidad de valores singulares usados, $r$ es el rango original de la matriz, que es la cantidad total de valores singulares en la descomposición SVD original, y $\sigma_i$ son los valores singulares.

Definimos así la siguiente función:
"""

# ╔═╡ c0e95730-169d-4887-80fd-15d9d23f1c30
function porcentaje(imag, k)
	channels=float.(channelview(imag));
	svdfactors = svd.(eachslice(channels; dims=1));
		Σr=svdfactors[1].S;
		Σg=svdfactors[2].S;
		Σb=svdfactors[3].S;
	sr=(sum(Σr[1:k] .^ 2))/(sum(Σr .^ 2))
	sg=(sum(Σg[1:k] .^ 2))/(sum(Σg .^ 2))
	sb=(sum(Σb[1:k] .^ 2))/(sum(Σb .^ 2))
	println("$(round(100*Float64((sr+sg+sb)/3), sigdigits=4))%")
end

# ╔═╡ dd1b86dd-d66b-458b-bbcd-7d99d40d0e7e
md"""Luego, en la imagen del tucan, se tiene que el porcenatje de retención de la imagen original al usar $10$ valores singulares es"""

# ╔═╡ 742e34f2-68bc-4951-807a-a6eb25312b0a
porcentaje(imag₁, 10)

# ╔═╡ fbe342f6-ecc6-4baf-968b-97ffcdc6c3f0
md"""Aquí se tienen diferentes imágenes para probar el procesamiento de una imagen, dichas imágenes están disponibles en los URL indicados. Descomente la que desee trabajar."""

# ╔═╡ b5ec77e8-cbba-4324-9f52-79d217a6f635
md"""Imagen de un fractal:"""

# ╔═╡ e8a1a2c6-1559-4bd6-b29b-3de6a3ea8a32
#url₂="https://upload.wikimedia.org/wikipedia/commons/3/3a/Fractal471763.jpg"

# ╔═╡ e43911fe-4039-48cd-8ffe-c312b5ab3914
md"""Imagen de la plaza Ché:"""

# ╔═╡ dae57016-5a48-4c49-8181-7d11774bdc09
#url₂="https://upload.wikimedia.org/wikipedia/commons/7/73/Plaza_Che%2C_Bogot%C3%A1.jpg"

# ╔═╡ 89d5b7d7-8913-4ba8-b965-9d87c59b9a0c
md"""Imagen de la cinta de Möbius:"""

# ╔═╡ 057d25ee-79a9-40f5-8d25-45d27c16429b
#url₂="https://upload.wikimedia.org/wikipedia/commons/d/d9/M%C3%B6bius_strip.jpg"

# ╔═╡ 5edba1b3-2178-47c7-9160-11c7b80cd667
md"""Imagen de Lenna:"""

# ╔═╡ e3ba24c0-f01f-4889-9bba-08b1c747031d
url₂="https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png"

# ╔═╡ 62491b66-b441-49d8-b5ed-63162dd72449
fname₂ = download(url₂)

# ╔═╡ 587d2271-8f17-42c6-9112-668bba9665e2
imag₂ = load(fname₂)

# ╔═╡ 7601a463-0548-4e66-a1fe-4d8164b6146a
begin
	K₁= @bind k₁ Slider(1:1:size(imag₂)[1], show_value=true, default=2)
	K₂= @bind k₂ Slider(1:1:size(imag₂)[1], show_value=true, default=20)
	K₃= @bind k₃ Slider(1:1:size(imag₂)[1], show_value=true, default=100)
end;

# ╔═╡ a1537f49-9174-4d8b-83e6-2a80092c2e2e
md""" k₁ = $K₁,  	k₂ = $K₂,  	k₃ = $K₃\
"""

# ╔═╡ 6f5f13d0-c4b4-4e41-9cdf-20d68132736d
[compresion(imag₂, k₁) compresion(imag₂, k₂) compresion(imag₂, k₃)]

# ╔═╡ 8cc3fde2-8b71-4655-8037-9878b30be723
[porcentaje(imag₂, k₁) porcentaje(imag₂, k₂) porcentaje(imag₂, k₃)];

# ╔═╡ 88a8bad8-456e-46a6-b7de-96e1b9337c6e
md"""# Marca de agua digital utilizando SVD"""

# ╔═╡ 38f2cb06-1040-4a63-bab9-517f314d704e
md"""La esteganografía es un método que se emplea para esconder datos dentro de diferentes tipos de archivos, tales como imágenes, archivos de audio, videos, texto, u otros documentos, con el objetivo de que la presencia de la información oculta no sea detectada por observadores externos. A diferencia de la criptografía, que se concentra en salvaguardar el contenido de la información, la esteganografía se dedica a ocultar la existencia misma de dicha información.

La aplicación de la Descomposición en Valores Singulares (SVD) en la creación de marcas de agua digitales es un enfoque diseñado para insertar datos adicionales de forma imperceptible en una imagen, con el propósito de reconocer y salvaguardar la propiedad intelectual o autenticar la imagen en cuestión. La estrategia se basa en aprovechar la singularidad de la SVD para incorporar la información de la marca de agua sin generar un impacto sustancial en la calidad visual de la imagen original.

En este caso para crear la marca de agua, vamos a realizar la descomposicipon en valores singulares de la imagen de deseamos marcar $I=U\Sigma V^t$ y en la matriz $V$ vamos a sumar nuestra marca de agua transpuesta multiplicada por un valor muy pequeño, de tal manera que la perturbación no afecte la imagen.
"""

# ╔═╡ 6d4de4e0-f80a-4dd9-aedc-771ea3264db0
md"""Es decir, nuestra imagen con la marca de agua la creamos de la siguiente forma:

$I'=U\Sigma (V+\alpha M^t)^t = U\Sigma V^t + \alpha U\Sigma M = I + \alpha U\Sigma M,$

donde $M$ es la marca que añadimos, y $\alpha \approx 0$. Además, $\alpha U\Sigma M$ se conoce como perrturbación."""

# ╔═╡ f729d8a9-be99-40ba-bf15-179c308cd2f6
md"""Cargamos la imagen que desamos marcar"""

# ╔═╡ b70ab468-2f40-465b-91a5-08c7b65fa17c
url₃="https://upload.wikimedia.org/wikipedia/commons/c/c9/PlazaCheoSantanderUNAL.JPG"

# ╔═╡ 9e22f50f-2829-405d-a896-068d06a1f10e
md"""La bajamos a la maquina local"""

# ╔═╡ 6205dc45-9bc1-4dfb-873c-d926b5ed46a1
fname₃ = download(url₃)

# ╔═╡ f7d7ab32-ae5e-43eb-aea1-038fc9f9c269
imag₃ = load(fname₃)

# ╔═╡ a59e0196-cbe1-4658-a2c0-ea30ed375dcf
md"""Cargamos nuestra marca de agua."""

# ╔═╡ d44206c2-6e37-4ebf-aeb4-302672dba634
url₄="https://upload.wikimedia.org/wikipedia/commons/2/25/Auditorio_Leon_de_Greiff.jpeg"

# ╔═╡ db61f2a8-e5e7-46e0-8417-400dfecd9f1d
md"""La bajamos a la maquina local."""

# ╔═╡ be1af825-0fee-479c-8507-845b45e57c55
fname₄ = download(url₄)

# ╔═╡ ef57ba8b-b33a-438a-8f4f-bb4578a65b4a
imag₄ = load(fname₄)

# ╔═╡ 9134d1b0-445e-4f4f-a79e-2b2cd111565a
md"""Debemos asegurarnos que nuestras imagenes tengan el mismo tamaño."""

# ╔═╡ 5779c684-d516-4448-87fe-1968e3006342
size(imag₃)

# ╔═╡ be4d9dfd-cc72-4b01-815c-75cf3e8fc4d9
size(imag₄)

# ╔═╡ cf8bc1e2-cd9e-4e21-bded-6363b6d427e9
md"""Dado que la segunda imagen es más grande, la vamos a recortar un poco, para que queden ambas del mismo tamaño."""

# ╔═╡ baa3b61b-301d-4e13-b7bb-2a22eeec945f
imag₅=imag₄[1:1224,1:1632]

# ╔═╡ 573f22f4-0719-4f01-97b4-2aa84e1bae50
size(imag₅)

# ╔═╡ e37f5658-f8a4-435f-9400-8e4e8c53617a
md"""Realizamos la decomposición en valores singulares de cada matriz (R, G, B)."""

# ╔═╡ f2ab002a-ecec-4bfb-b0d9-8417fdad0a85
begin
	channels₁=float.(channelview(imag₃));
	svdfactors₁ = svd.(eachslice(channels₁; dims=1));
		Ur₁=svdfactors₁[1].U
		Σr₁=svdfactors₁[1].S
		Vr₁=svdfactors₁[1].V
		Ug₁=svdfactors₁[2].U
		Σg₁=svdfactors₁[2].S
		Vg₁=svdfactors₁[2].V
		Ub₁=svdfactors₁[3].U
		Σb₁=svdfactors₁[3].S
		Vb₁=svdfactors₁[3].V
end;

# ╔═╡ d2a374d8-b43f-4112-a00b-eaf1d4172ea8
size(Vg₁)

# ╔═╡ 72185093-bdc8-4761-84de-652a5bd4b215
md"""Ahora, consideramos las matrices que representan cada canal de color de la imagen que usaremos como marca de agua."""

# ╔═╡ 316f5946-c46f-4c74-a58c-86998fbdfca3
begin
	Ir₁=red.(imag₅)
	Ig₁=green.(imag₅)
	Ib₁=blue.(imag₅)
end;

# ╔═╡ ad989a4a-dfb1-4964-be2e-51f5a125d57a
size(Ir₁)

# ╔═╡ 3df63bf8-21e9-4200-b4f9-f366ac085e54
md"""Ahora vamos a definir un $\alpha$ que sea muy cercano a cero, para no modifique la imagen."""

# ╔═╡ 99c748a9-e96e-43c8-a4f8-e68f4cd4f364
α=0.0001

# ╔═╡ f070b44b-2c42-4f5c-b843-e8eceb8f82dc
md"""Ahora, para cada canal de color, vamos a tomar $V$ de la descomposición en valores singulares de la imagen original y vamos a sumar la marca de agua transpuesta multiplicada por $\alpha$."""

# ╔═╡ 2dca66ed-d3d4-49f2-8123-61ee29d4b345
begin
	VR=Vr₁+α*Ir₁'
	VG=Vg₁+α*Ig₁'
	VB=Vb₁+α*Ib₁'
end;

# ╔═╡ bfa7cd3a-f9d9-4a8f-8d12-ec760a3e39e4
md"""Así, cada canal de color con la marca de agua se ve de la siguiente forma:"""

# ╔═╡ d3d65431-184a-43f2-a27f-5a0d90e6f3d6
begin
	MR = Ur₁ * Diagonal(Σr₁) * transpose(VR);
	MG = Ug₁ * Diagonal(Σg₁) * transpose(VG);
	MB = Ub₁ * Diagonal(Σb₁) * transpose(VB);
end;

# ╔═╡ 646bfe90-87b3-4808-aa50-fa8abc62e6c7
heatmap(rotar(MR), color=:reds, axis=false, legend=false)

# ╔═╡ d8ec3fe6-2dbd-4606-a7ff-5b720efe3a0f
heatmap(rotar(MG), color=:greens, axis=false, legend=false)

# ╔═╡ 6a1613aa-acd1-4f41-8f8b-41999198afd2
heatmap(rotar(MB), color=:blues, axis=false, legend=false)

# ╔═╡ 2366e8ce-4bb3-4724-98db-d89b3ceea149
md"""Finalmente, juntamos los tres canales para obtener la imagen en formato RGB. La marca de agua es invisible, y la imagen marcada al ojo humano es identica a la orginal."""

# ╔═╡ 493381a4-fd08-497c-b2b1-533641e61eeb
imagenmarcada=colorview(RGB, permutedims(cat(dims=3, MR, MG, MB), [3, 1, 2]))

# ╔═╡ c0d4ff63-5b07-4353-8c20-e8edf71006cf
md"""Una vez explicado todos los pasos para marcar una imagen, creamos la siguiente función, donde se introduce la imagen a marcar, la marca y el valor $\alpha$ deseado."""

# ╔═╡ 019b3f98-d94a-4418-bb99-f734c0c4cad2
function cifrado(imag,marca, α)
	channels1=float.(channelview(imag));
	svdfactors1 = svd.(eachslice(channels1; dims=1));
		Ur1=svdfactors1[1].U;
		Σr1=svdfactors1[1].S;
		Vr1=svdfactors1[1].V;
		Ug1=svdfactors1[2].U;
		Σg1=svdfactors1[2].S;
		Vg1=svdfactors1[2].V;
		Ub1=svdfactors1[3].U;
		Σb1=svdfactors1[3].S;
		Vb1=svdfactors1[3].V;
	Ir=red.(marca)
	Ig=green.(marca)
	Ib=blue.(marca)
	Vr=Vr1+α*Ir'
	Vg=Vg1+α*Ig'
	Vb=Vb1+α*Ib'
	Mr = Ur1 * Diagonal(Σr1) * transpose(Vr);
	Mg = Ug1 * Diagonal(Σg1) * transpose(Vg);
	Mb = Ub1 * Diagonal(Σb1) * transpose(Vb);
	imagen_RGB = cat(dims=3, Mr, Mg, Mb)
	imagen= permutedims(imagen_RGB, [3, 1, 2])
	imagenconmarca = colorview(RGB, imagen)
	return imagenconmarca
end

# ╔═╡ 4051a1ac-136a-4722-81d4-ad579becba8f
md"""Realicemos ejemplos con diferentes valores de $\alpha$, observe que entre más grande sea dicho valor, la imagen cambia y ya no se parece a la original."""

# ╔═╡ 199a7aa6-4013-45f9-9da8-54ad8e81e490
begin
	α₂= @bind a₂ Slider(0:1e-10:1, show_value=true, default=1e-10)
	α₃= @bind a₃ Slider(0:1e-10:1, show_value=true, default=1e-6)
	α₄= @bind a₄ Slider(0:1e-10:1, show_value=true, default=0.01)
end;

# ╔═╡ 733da229-e2e0-415f-b97c-ab96e4e17841
md""" a₂ = $α₂,  	a₃ = $α₃,  	a₄ = $α₄\
"""

# ╔═╡ c946776b-1549-400b-8da9-59781d659ab0
[imag₃     cifrado(imag₃,imag₅, a₂)
cifrado(imag₃,imag₅, a₃)     cifrado(imag₃,imag₅, a₄)]

# ╔═╡ 25bce086-374e-42a3-9eea-4c7a973aeaa6
md"""Con la siguiente función podemos hallar la diferencia (error) entre dos imagenes."""

# ╔═╡ 08bf2c08-5c67-4a3d-86dd-e4eedced16aa
function error(imagen1, imagen2)
	error_red = norm(red.(imagen1)-red.(imagen2)) #Error del canal R
	error_green = norm(green.(imagen1)-green.(imagen2)) #Error del canal G
	error_blue = norm(blue.(imagen1)-blue.(imagen2)) #Error del canal B
	error_tot = (error_red + error_green + error_blue)/3 #Promedio de los tres errores
	println("$(round(Float64(error_tot), sigdigits=2))")
end

# ╔═╡ 78e948d0-0337-4cef-bcf6-b48106b7257e
md"""Usando dicha función, obtenemos los siguientes errores:"""

# ╔═╡ b9be03a4-9fb3-4b9a-8d59-9617310fc923
error(imag₃, cifrado(imag₃,imag₅, a₂))

# ╔═╡ d9b34145-fefc-4201-9de0-7dd5fe9ce82c
error(imag₃, cifrado(imag₃,imag₅, a₃))

# ╔═╡ 8249ce67-9182-43f1-8ba5-f6a62de1ad0c
error(imag₃, cifrado(imag₃,imag₅, a₄))

# ╔═╡ 1fe751ec-42f0-416c-b4e9-4bbccdec613b
md""" ### Recuperación de la marca de agua"""

# ╔═╡ f94e51ef-65ed-4b7d-9d51-2e33cf7a9af5
md"""Supongamos que se tiene ya la imagen marcada $I'$, y se conoce el valor de $\alpha$ y queremos recuperar la marca de agua. Es muy sencillo, solo debemos realizar la SVD de la imagen original $I$, es decir $I=U\Sigma V$ y como sabemos que

$I'= I + \alpha U \Sigma M,$

entonces 

$M=\dfrac{(U\Sigma)^{-1}(I'-I)}{\alpha}.$"""

# ╔═╡ 7b398636-fd71-42ae-9486-6e1d7a6615d8
md"""A continuación se crea una función que recupera la marca."""

# ╔═╡ 0f325bfb-738a-4bbf-b67d-8154f4453786
function recuperacion(imag, imagorginal, α)
	channels=float.(channelview(imagorginal));
	svdfactors = svd.(eachslice(channels; dims=1));
		Ur=svdfactors[1].U;
		Σr=svdfactors[1].S;
		Vr=svdfactors[1].V;
		Ug=svdfactors[2].U;
		Σg=svdfactors[2].S;
		Vg=svdfactors[2].V;
		Ub=svdfactors[3].U;
		Σb=svdfactors[3].S;
		Vb=svdfactors[3].V;
	Ir=red.(imag)
	Ig=green.(imag)
	Ib=blue.(imag)
	marcar = ( inv(Ur*Diagonal(Σr))*(Ir - (Ur*Diagonal(Σr)*Vr')) )/α
	marcag = ( inv(Ug*Diagonal(Σg))*(Ig - (Ug*Diagonal(Σg)*Vg')) )/α
	marcab = ( inv(Ub*Diagonal(Σb))*(Ib - (Ub*Diagonal(Σb)*Vb')) )/α
	imagen_RGB = cat(dims=3, marcar, marcag, marcab)
	marca= permutedims(imagen_RGB, [3, 1, 2])
	marcarec = colorview(RGB, marca)
	return marcarec
end

# ╔═╡ dedff45c-9c7b-4451-8900-57d8033e459c
md"""De la imagen que marcamos antes (Plaza Che) recuperemos su marca."""

# ╔═╡ 8dedde3a-23a7-4673-a90e-cf1d9c6e0866
imag_recuperada = recuperacion(imagenmarcada, imag₃, 0.0001)

# ╔═╡ 2fe63769-c3f3-4cd5-be25-17852f616414
md"""Visualmente no hay gran diferencia entre la marca original y la recuperada."""

# ╔═╡ 2b7f17fa-1f37-455a-a98f-883600c174d1
[imag₅     imag_recuperada]

# ╔═╡ e4f95ac4-9745-46d2-ae47-4d281139e3e9
md"""El error entre ellas es de:"""

# ╔═╡ e1873086-ea1e-4d36-95b1-293c710c5acc
norm(imag₅-imag_recuperada)

# ╔═╡ aa027eda-3321-4720-8d95-8d84d9b0f0be
md"""# Referencias"""

# ╔═╡ 0cfe4c26-edf2-441c-95e1-f5f852b18090
md"""[1] Strang, G. (2016). Introduction to Linear Algebra (5ta ed.). Wellesley-Cambridge Press.

[2] Axler, S. (2014). Linear Algebra Done Right (3ra ed.). Springer.

[3] Martínez R., H. J., & Sanabria R., A. M. (2014). Álgebra Lineal. Programa Editorial Universidad del Valle.

[4] Boyd, S., & Vandenberghe, L. (2021). Introduction to Applied Linear Algebra: Vectors, Matrices, and Least Squares - Julia Language Companion. Cambridge University Press.

[5] Grossman, S. I., & Flores Godoy, J. J. (2012). Álgebra Lineal (7a ed.). McGraw-Hill.

[6] Labmatecc. Introducción al procesamiento de imágenes. Algebra Lineal. Recuperado de [https://labmatecc.github.io/Notebooks/AlgebraLineal/Introduccionalprocesamientodeimagenes/](https://labmatecc.github.io/Notebooks/AlgebraLineal/Introduccionalprocesamientodeimagenes/)

[7] MIT Computational Thinking. (2023). Images Abstractions. Recuperado de [https://computationalthinking.mit.edu/Fall22/images_abstractions/images/](https://computationalthinking.mit.edu/Fall22/images_abstractions/images/)"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ColorVectorSpace = "c3611d14-8923-5661-9e6a-0046d554d3a4"
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
ImageIO = "82e4d734-157c-48bb-816b-45c225c6df19"
ImageShow = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
ImageTransformations = "02fcd773-0e25-5acc-982a-7f6622650795"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
TestImages = "5e47fb64-e119-507b-a336-dd2b206d9990"

[compat]
ColorVectorSpace = "~0.10.0"
Colors = "~0.12.10"
FileIO = "~1.16.1"
HypertextLiteral = "~0.9.5"
ImageIO = "~0.6.7"
ImageShow = "~0.3.8"
ImageTransformations = "~0.10.0"
Images = "~0.26.0"
Plots = "~1.39.0"
PlutoUI = "~0.7.54"
TestImages = "~1.8.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "29c064cc0f6289fb7683e6c9e2884704522e6df1"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"
weakdeps = ["ChainRulesCore", "Test"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"
    AbstractFFTsTestExt = "Test"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "7e35fca2bdfba44d797c53dfe63a51fabf39bfc0"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.4.0"
weakdeps = ["SparseArrays", "StaticArrays"]

    [deps.Adapt.extensions]
    AdaptSparseArraysExt = "SparseArrays"
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "d57bd3762d308bded22c3b82d033bff85f6195c6"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.4.0"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra"]
git-tree-sha1 = "d81ae5489e13bc03567d4fbbb06c546a5e53c857"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.22.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = ["CUDSS", "CUDA"]
    ArrayInterfaceChainRulesCoreExt = "ChainRulesCore"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceMetalExt = "Metal"
    ArrayInterfaceReverseDiffExt = "ReverseDiff"
    ArrayInterfaceSparseArraysExt = "SparseArrays"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CUDSS = "45b445bb-4962-46a0-9369-b4df9d0f772e"
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    Metal = "dde4c033-4e86-420c-a63e-0dd931031962"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "01b8ccb13d68535d73d2b0c23e39bd23155fb712"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.1.0"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "4126b08903b777c88edf1754288144a0492c05ad"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.8"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.BitTwiddlingConvenienceFunctions]]
deps = ["Static"]
git-tree-sha1 = "f21cfd4950cb9f0587d5067e69405ad2acd27b87"
uuid = "62783981-4cbd-42fc-bca8-16325de8dc4b"
version = "0.1.6"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CPUSummary]]
deps = ["CpuId", "IfElse", "PrecompileTools", "Preferences", "Static"]
git-tree-sha1 = "f3a21d7fc84ba618a779d1ed2fcca2e682865bab"
uuid = "2a0fbf3d-bb9c-48f3-b0a9-814d99fd7ab9"
version = "0.2.7"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "e4c6a16e77171a5f5e25e9646617ab1c276c5607"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.26.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.ChunkCodecCore]]
git-tree-sha1 = "51f4c10ee01bda57371e977931de39ee0f0cdb3e"
uuid = "0b6fb165-00bc-4d37-ab8b-79f91016dbe1"
version = "1.0.0"

[[deps.ChunkCodecLibZlib]]
deps = ["ChunkCodecCore", "Zlib_jll"]
git-tree-sha1 = "cee8104904c53d39eb94fd06cbe60cb5acde7177"
uuid = "4c0bbee4-addc-4d73-81a0-b6caacae83c8"
version = "1.0.0"

[[deps.ChunkCodecLibZstd]]
deps = ["ChunkCodecCore", "Zstd_jll"]
git-tree-sha1 = "34d9873079e4cb3d0c62926a225136824677073f"
uuid = "55437552-ac27-4d47-9aa3-63184e8fd398"
version = "1.0.0"

[[deps.CloseOpenIntervals]]
deps = ["Static", "StaticArrayInterface"]
git-tree-sha1 = "05ba0d07cd4fd8b7a39541e31a7b0254704ea581"
uuid = "fb6a15b2-703c-40df-9091-08a04967cfa9"
version = "0.1.13"

[[deps.Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "Random", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "3e22db924e2945282e70c33b75d4dde8bfa44c94"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.15.8"

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
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "362a287c3aa50601b0bc359053d5c2468f0e7ce0"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.11"

[[deps.CommonWorldInvalidations]]
git-tree-sha1 = "ae52d1c52048455e85a387fbee9be553ec2b68d0"
uuid = "f70d9fcc-98c5-4d4a-abd7-e4cdeebd8ca8"
version = "1.0.0"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "9d8a54ce4b17aa5bdce0ea5c34bc5e7c340d16ad"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

[[deps.ConstructionBase]]
git-tree-sha1 = "b4b092499347b18a015186eae3042f72267106cb"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.6.0"
weakdeps = ["IntervalSets", "LinearAlgebra", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "a692f5e257d332de1e554e4566a4e5a8a72de2b2"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.4"

[[deps.CpuId]]
deps = ["Markdown"]
git-tree-sha1 = "fcbb72b032692610bfbdb15018ac16a36cf2e406"
uuid = "adafc99b-e345-5852-983c-f28acb93d879"
version = "0.3.1"

[[deps.CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

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

[[deps.Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "c7e3a542b999843086e2f29dac96a618c105be1d"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.12"
weakdeps = ["ChainRulesCore", "SparseArrays"]

    [deps.Distances.extensions]
    DistancesChainRulesCoreExt = "ChainRulesCore"
    DistancesSparseArraysExt = "SparseArrays"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

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
git-tree-sha1 = "27af30de8b5445644e8ffe3bcb0d72049c089cf1"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.7.3+0"

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

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "Libdl", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "97f08406df914023af55ade2f843c39e99c5d969"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.10.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6d6219a004b8cf1e0b4dbe27a2860b8e04eba0be"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.11+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "2dd20384bf8c6d411b5c7370865b1e9b26cb2ea3"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.6"
weakdeps = ["HTTP"]

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

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

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "fcb0584ff34e25155876418979d4c8971243bb89"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+2"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "27442171f28c952804dede8ff72828a96f2bfc1f"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.10"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "025d171a2847f616becc0f84c8dc62fe18f0f6dd"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.10+0"

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

[[deps.Giflib_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6570366d757b50fabae9f4315ad74d2e40c0560a"
uuid = "59f7168a-df46-5410-90c8-f2779963d0ec"
version = "5.2.3+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "50c11ffab2a3d50192a228c313f05b5b5dc5acb2"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.86.0+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "a641238db938fff9b2f60d08ed9030387daf428c"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.3"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "7a98c6502f4632dbe9fb1973a4244eaa3324e84d"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.13.1"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "5e6fe50ae7f23d171f44e311c2960294aaa0beb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.19"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

[[deps.HashArrayMappedTries]]
git-tree-sha1 = "2eaa69a7cab70a52b9687c8bf950a5a93ec895ae"
uuid = "076d061b-32b6-4027-95e0-9a2c6f6d7e74"
version = "0.2.0"

[[deps.HistogramThresholding]]
deps = ["ImageBase", "LinearAlgebra", "MappedArrays"]
git-tree-sha1 = "7194dfbb2f8d945abdaf68fa9480a965d6661e69"
uuid = "2c695a8d-9458-5d45-9878-1b8a99cf7853"
version = "0.3.1"

[[deps.HostCPUFeatures]]
deps = ["BitTwiddlingConvenienceFunctions", "IfElse", "Libdl", "Static"]
git-tree-sha1 = "8e070b599339d622e9a081d17230d74a5c473293"
uuid = "3e5b6fbb-0976-4d2c-9146-d79de83f2fb0"
version = "0.1.17"

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
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "e12629406c6c4442539436581041d372d69c55ba"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.12"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "eb49b82c172811fd2c86759fa0553a2221feb909"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.7"

[[deps.ImageBinarization]]
deps = ["HistogramThresholding", "ImageCore", "LinearAlgebra", "Polynomials", "Reexport", "Statistics"]
git-tree-sha1 = "33485b4e40d1df46c806498c73ea32dc17475c59"
uuid = "cbc4b850-ae4b-5111-9e64-df94c024a13d"
version = "0.3.1"

[[deps.ImageContrastAdjustment]]
deps = ["ImageBase", "ImageCore", "ImageTransformations", "Parameters"]
git-tree-sha1 = "eb3d4365a10e3f3ecb3b115e9d12db131d28a386"
uuid = "f332f351-ec65-5f6a-b3d1-319c6670881a"
version = "0.3.12"

[[deps.ImageCore]]
deps = ["ColorVectorSpace", "Colors", "FixedPointNumbers", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "PrecompileTools", "Reexport"]
git-tree-sha1 = "8c193230235bbcee22c8066b0374f63b5683c2d3"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.10.5"

[[deps.ImageCorners]]
deps = ["ImageCore", "ImageFiltering", "PrecompileTools", "StaticArrays", "StatsBase"]
git-tree-sha1 = "24c52de051293745a9bad7d73497708954562b79"
uuid = "89d5987c-236e-4e32-acd0-25bd6bd87b70"
version = "0.1.3"

[[deps.ImageDistances]]
deps = ["Distances", "ImageCore", "ImageMorphology", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "08b0e6354b21ef5dd5e49026028e41831401aca8"
uuid = "51556ac3-7006-55f5-8cb3-34580c88182d"
version = "0.2.17"

[[deps.ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageBase", "ImageCore", "LinearAlgebra", "OffsetArrays", "PrecompileTools", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "52116260a234af5f69969c5286e6a5f8dc3feab8"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.12"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs", "WebP"]
git-tree-sha1 = "696144904b76e1ca433b886b4e7edd067d76cbf7"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.9"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "8e64ab2f0da7b928c8ae889c514a52741debc1c2"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.4.2"

[[deps.ImageMagick_jll]]
deps = ["Artifacts", "Ghostscript_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "OpenJpeg_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "afde851466407a99d48829051c36ac80749d8d7c"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "7.1.1048+0"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "2a81c3897be6fbcde0802a0ebe6796d0562f63ec"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.10"

[[deps.ImageMorphology]]
deps = ["DataStructures", "ImageCore", "LinearAlgebra", "LoopVectorization", "OffsetArrays", "Requires", "TiledIteration"]
git-tree-sha1 = "895205d762ae24a01689f8cc7ad584b55f1fd005"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.4.7"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "LazyModules", "OffsetArrays", "PrecompileTools", "Statistics"]
git-tree-sha1 = "783b70725ed326340adf225be4889906c96b8fd1"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.7"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "8071ca812183ee9acb8e93e8d59c66a7d8742d5c"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.10.0"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "3b5344bcdbdc11ad58f3b1956709b5b9345355de"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.8"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "dfde81fafbe5d6516fb864dc79362c5c6b973c82"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.10.2"

[[deps.Images]]
deps = ["Base64", "FileIO", "Graphics", "ImageAxes", "ImageBase", "ImageBinarization", "ImageContrastAdjustment", "ImageCore", "ImageCorners", "ImageDistances", "ImageFiltering", "ImageIO", "ImageMagick", "ImageMetadata", "ImageMorphology", "ImageQualityIndexes", "ImageSegmentation", "ImageShow", "ImageTransformations", "IndirectArrays", "IntegralArrays", "Random", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "TiledIteration"]
git-tree-sha1 = "a49b96fd4a8d1a9a718dfd9cde34c154fc84fcd5"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.26.2"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0936ba688c6d201805a83da835b55c61a180db52"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.11+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "d1b1b796e47d94588b3757fe84fbf65a5ec4a80d"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.5"

[[deps.IntegralArrays]]
deps = ["ColorTypes", "FixedPointNumbers", "IntervalSets"]
git-tree-sha1 = "b842cbff3f44804a84fda409745cc8f04c029a20"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.6"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "ec1debd61c300961f98064cfb21287613ad7f303"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2025.2.0+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "65d505fa4c0d7072990d659ef3fc086eb6da8208"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.16.2"

    [deps.Interpolations.extensions]
    InterpolationsForwardDiffExt = "ForwardDiff"
    InterpolationsUnitfulExt = "Unitful"

    [deps.Interpolations.weakdeps]
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.IntervalSets]]
git-tree-sha1 = "5fbb102dcb8b1a858111ae81d56682376130517d"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.11"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.IrrationalConstants]]
git-tree-sha1 = "b2d91fe939cae05960e760110b328288867b5758"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.6"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.JLD2]]
deps = ["ChunkCodecLibZlib", "ChunkCodecLibZstd", "FileIO", "MacroTools", "Mmap", "OrderedCollections", "PrecompileTools", "ScopedValues"]
git-tree-sha1 = "da2e9b4d1abbebdcca0aa68afa0aa272102baad7"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.6.2"
weakdeps = ["UnPack"]

    [deps.JLD2.extensions]
    UnPackExt = "UnPack"

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

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "9496de8fb52c224a2e3f9ff403947674517317d9"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.6"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

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

[[deps.LayoutPointers]]
deps = ["ArrayInterface", "LinearAlgebra", "ManualMemory", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "a9eaadb366f5493a5654e843864c13d8b107548c"
uuid = "10f19ff3-798f-405d-979b-55457f8fc047"
version = "0.1.17"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"
version = "1.11.0"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

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
git-tree-sha1 = "3acf07f130a76f87c041cfb2ff7d7284ca67b072"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.2+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2a7a12fc0a4e7fb773450d17975322aa77142106"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.2+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LittleCMS_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll"]
git-tree-sha1 = "fa7fd067dca76cadd880f1ca937b4f387975a9f5"
uuid = "d3a379c0-f9a3-5b72-a4c0-6bf4d2e8af0f"
version = "2.16.0+0"

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
git-tree-sha1 = "f00544d95982ea270145636c181ceda21c4e2575"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.2.0"

[[deps.LoopVectorization]]
deps = ["ArrayInterface", "CPUSummary", "CloseOpenIntervals", "DocStringExtensions", "HostCPUFeatures", "IfElse", "LayoutPointers", "LinearAlgebra", "OffsetArrays", "PolyesterWeave", "PrecompileTools", "SIMDTypes", "SLEEFPirates", "Static", "StaticArrayInterface", "ThreadingUtilities", "UnPack", "VectorizationBase"]
git-tree-sha1 = "a9fc7883eb9b5f04f46efb9a540833d1fad974b3"
uuid = "bdcacae8-1622-11e9-2a5c-532679323890"
version = "0.12.173"

    [deps.LoopVectorization.extensions]
    ForwardDiffExt = ["ChainRulesCore", "ForwardDiff"]
    ForwardDiffNNlibExt = ["ForwardDiff", "NNlib"]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.LoopVectorization.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    NNlib = "872c559c-99b0-510c-b3b7-b6c96a88d5cd"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "oneTBB_jll"]
git-tree-sha1 = "282cadc186e7b2ae0eeadbd7a4dffed4196ae2aa"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2025.2.0+0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.ManualMemory]]
git-tree-sha1 = "bcaef4fc7a0cfe2cba636d84cda54b5e4e4ca3cd"
uuid = "d125e4d3-2237-4719-b19c-fa641b8a4667"
version = "0.1.8"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

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

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "3a8f462a180a9d735e340f4e8d5f364d411da3a4"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.8.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "ca7e18198a166a1f3eb92a3650d53d94ed8ca8a1"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.22"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OffsetArrays]]
git-tree-sha1 = "117432e406b5c023f665fa73dc26e79ec3630151"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.17.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "97db9e07fe2091882c765380ef58ec553074e9c7"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.3"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "8292dd5c8a38257111ada2174000a33745b06d4e"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.2.4+0"

[[deps.OpenJpeg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libtiff_jll", "LittleCMS_jll", "libpng_jll"]
git-tree-sha1 = "215a6666fee6d6b3a6e75f2cc22cb767e2dd393a"
uuid = "643b3616-a352-519d-856d-80112ee9badc"
version = "2.5.5+0"

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
git-tree-sha1 = "f19301ae653233bc88b1810ae908194f07f8db9d"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

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

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "cf181f0b1e6a18dfeb0ee8acc4a9d1672499626c"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.4"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1f7f9bbd5f7a2e5a9f7d96e51c9754454ea7f60b"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.4+0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

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

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

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
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "ccee59c6e48e6f2edf8a5b64dc817b6729f99eb5"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.39.0"

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
git-tree-sha1 = "3faff84e6f97a7f18e0dd24373daa229fd358db5"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.73"

[[deps.PolyesterWeave]]
deps = ["BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "Static", "ThreadingUtilities"]
git-tree-sha1 = "645bed98cd47f72f67316fd42fc47dee771aefcd"
uuid = "1d0040c9-8b98-4ee7-8388-3f51789ca0ad"
version = "0.2.2"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "OrderedCollections", "RecipesBase", "Requires", "Setfield", "SparseArrays"]
git-tree-sha1 = "972089912ba299fba87671b025cd0da74f5f54f7"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "4.1.0"

    [deps.Polynomials.extensions]
    PolynomialsChainRulesCoreExt = "ChainRulesCore"
    PolynomialsFFTWExt = "FFTW"
    PolynomialsMakieExt = "Makie"
    PolynomialsMutableArithmeticsExt = "MutableArithmetics"

    [deps.Polynomials.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    FFTW = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
    Makie = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
    MutableArithmetics = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"

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

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "fbb92c6c56b34e1a2c4c36058f68f332bec840e7"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "8b3fc30bc0390abdce15f8822c889f669baed73d"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.1"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "37b7bb7aabf9a085e0044307e1717436117f2b3b"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.5.3+1"

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random", "RealDot"]
git-tree-sha1 = "994cc27cdacca10e68feb291673ec3a76aa2fae9"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.7.6"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.RealDot]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9f0a1b71baaf7650f4fa8a1d168c7fb6ee41f0c9"
uuid = "c1ae055f-0cd5-4b69-90a6-9a35b1a98df9"
version = "0.1.0"

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

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

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

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays"]
git-tree-sha1 = "5680a9276685d392c87407df00d57c9924d9f11e"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.7.1"
weakdeps = ["RecipesBase"]

    [deps.Rotations.extensions]
    RotationsRecipesBaseExt = "RecipesBase"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "e24dc23107d426a096d3eae6c165b921e74c18e4"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.7.2"

[[deps.SIMDTypes]]
git-tree-sha1 = "330289636fb8107c5f32088d2741e9fd7a061a5c"
uuid = "94e857df-77ce-4151-89e5-788b33177be4"
version = "0.1.0"

[[deps.SLEEFPirates]]
deps = ["IfElse", "Static", "VectorizationBase"]
git-tree-sha1 = "456f610ca2fbd1c14f5fcf31c6bfadc55e7d66e0"
uuid = "476501e8-09a2-5ece-8869-fb82de89a1fa"
version = "0.6.43"

[[deps.SciMLPublic]]
git-tree-sha1 = "ed647f161e8b3f2973f24979ec074e8d084f1bee"
uuid = "431bcebd-1456-4ced-9d72-93c2757fff0b"
version = "1.0.0"

[[deps.ScopedValues]]
deps = ["HashArrayMappedTries", "Logging"]
git-tree-sha1 = "c3b2323466378a2ba15bea4b2f73b081e022f473"
uuid = "7e506255-f358-4e82-b7e4-beb19740aa63"
version = "1.5.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "c5391c6ace3bc430ca630251d02ea9687169ca68"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.2"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"
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

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "be8eeac05ec97d379347584fa9fe2f5f76795bcb"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.5"

[[deps.SimpleWeightedGraphs]]
deps = ["Graphs", "LinearAlgebra", "Markdown", "SparseArrays"]
git-tree-sha1 = "3e5f165e58b18204aed03158664c4982d691f454"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.5.0"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "0494aed9501e7fb65daba895fb7fd57cc38bc743"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.5"

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

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "be1cf4eb0ac528d96f5115b4ed80c26a8d8ae621"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.2"

[[deps.Static]]
deps = ["CommonWorldInvalidations", "IfElse", "PrecompileTools", "SciMLPublic"]
git-tree-sha1 = "49440414711eddc7227724ae6e570c7d5559a086"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "1.3.1"

[[deps.StaticArrayInterface]]
deps = ["ArrayInterface", "Compat", "IfElse", "LinearAlgebra", "PrecompileTools", "Static"]
git-tree-sha1 = "96381d50f1ce85f2663584c8e886a6ca97e60554"
uuid = "0d7ed370-da01-4f52-bd93-41d350b8b718"
version = "1.8.0"
weakdeps = ["OffsetArrays", "StaticArrays"]

    [deps.StaticArrayInterface.extensions]
    StaticArrayInterfaceOffsetArraysExt = "OffsetArrays"
    StaticArrayInterfaceStaticArraysExt = "StaticArrays"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "b8693004b385c842357406e3af647701fe783f98"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.15"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6ab403037779dae8c514bad259f32a447262455a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.4"

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
git-tree-sha1 = "a136f98cefaf3e2924a66bd75173d1c891ab7453"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.7"

[[deps.StringDistances]]
deps = ["Distances", "StatsAPI"]
git-tree-sha1 = "5b2ca70b099f91e54d98064d5caf5cc9b541ad06"
uuid = "88034a9c-02f8-509d-84a9-84ec65e18404"
version = "0.11.3"

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

[[deps.TestImages]]
deps = ["AxisArrays", "ColorTypes", "FileIO", "ImageIO", "ImageMagick", "OffsetArrays", "Pkg", "StringDistances"]
git-tree-sha1 = "0567860ec35a94c087bd98f35de1dddf482d7c67"
uuid = "5e47fb64-e119-507b-a336-dd2b206d9990"
version = "1.8.0"

[[deps.ThreadingUtilities]]
deps = ["ManualMemory"]
git-tree-sha1 = "d969183d3d244b6c33796b5ed01ab97328f2db85"
uuid = "8290d209-cae3-49c0-8002-c8c24d57dab5"
version = "0.5.5"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "PrecompileTools", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "98b9352a24cb6a2066f9ababcc6802de9aed8ad8"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.11.6"

[[deps.TiledIteration]]
deps = ["OffsetArrays", "StaticArrayInterface"]
git-tree-sha1 = "1176cc31e867217b06928e2f140c90bd1bc88283"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.5.0"

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

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

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

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "d1d9a935a26c475ebffd54e9c7ad11627c43ea85"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.72"

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

[[deps.WebP]]
deps = ["CEnum", "ColorTypes", "FileIO", "FixedPointNumbers", "ImageCore", "libwebp_jll"]
git-tree-sha1 = "aa1ca3c47f119fbdae8770c29820e5e6119b83f2"
uuid = "e3aaa7dc-3e4b-44e0-be63-ffb868ccd7c1"
version = "0.1.3"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c1a7aa6219628fcd757dede0ca95e245c5cd9511"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "1.0.0"

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
git-tree-sha1 = "75e00946e43621e09d431d9b95818ee751e6b2ef"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.2+0"

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
git-tree-sha1 = "9750dc53819eba4e9a20be42349a6d3b86c7cdf8"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.6+0"

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
git-tree-sha1 = "371cc681c00a3ccc3fbc5c0fb91f58ba9bec1ecf"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.13.1+0"

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

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "libpng_jll"]
git-tree-sha1 = "c1733e347283df07689d71d61e14be986e49e47a"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.5+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.libwebp_jll]]
deps = ["Artifacts", "Giflib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libglvnd_jll", "Libtiff_jll", "libpng_jll"]
git-tree-sha1 = "ccbb625a89ec6195856a50aa2b668a5c08712c94"
uuid = "c5f90fcd-3b7e-5836-afba-fc50a0988cb2"
version = "1.4.0+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.oneTBB_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "1350188a69a6e46f799d3945beef36435ed7262f"
uuid = "1317d2d5-d96f-522e-a858-c73665f53c3e"
version = "2022.0.0+1"

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
# ╟─d4fd49f0-a4d6-11ee-2ed0-87bf49ac3dbe
# ╟─3035376d-38b4-4cc7-be0a-a01350cfebc3
# ╟─bbdde380-96bd-4cec-9404-4a87e4ff20ad
# ╟─0bc7f753-b24c-40c7-b177-8643afbe56f3
# ╟─597f25a7-657e-496c-ab05-6dc2a17bd394
# ╠═2165ecbf-beda-449c-86cc-ec87c185378a
# ╟─b7f28940-db8e-423a-abfb-d2452a461aea
# ╟─29c53f25-89b8-44a2-a081-cd3b5e15989a
# ╟─3c11d286-ede4-4b20-a021-1a21a8e39a47
# ╟─89954279-80f0-4f8d-91a8-87cd35a7e50f
# ╟─4c660259-fc08-45ce-869d-aa308db9a381
# ╟─61e57d71-f1db-42fd-950e-1555e04dd25b
# ╟─f7c800a7-5fd2-427a-87e1-e6dc3025f2bb
# ╟─d719095e-5c31-47e1-80ac-ca7a4fe02268
# ╠═30e643a1-96ea-4e35-b4a5-b6270d641b85
# ╟─ac999805-156a-4dc8-8bfb-448e5e13ec3c
# ╠═54009f24-b5c6-4d19-8b0c-e7bf9c80eac1
# ╟─9753880a-4705-46db-8285-d09fd2cfcb4e
# ╠═3aa4aa35-8228-4768-aaa9-665fea64e66a
# ╟─49c671e4-a9ac-4353-bd3d-ca7ca60c4bde
# ╟─f262ae1f-12e6-4049-8710-f01100550394
# ╠═44441b44-1c11-4d37-bb71-c5f02d8ce117
# ╟─43d138de-1de5-4ab4-b7b5-382c7de2bc61
# ╠═2edab60e-f215-4ff6-b8c9-4029fc398022
# ╟─7fa5236e-7a13-4d0a-a3c5-13079501c41f
# ╠═5c362741-cf34-49bd-a012-ae0c32ed01b1
# ╟─42b1874c-dbc6-4016-9ce3-b3b9b9a6cdd4
# ╠═ab190fc1-8692-4eb2-9624-4f436aff6a3f
# ╠═084e38c9-504c-420b-8055-ab9726afcbdb
# ╠═ad524fa6-59ff-4b83-9f5d-d31fe78d0dd9
# ╟─f3ade9f9-87c3-4319-b4e5-6314fda18f48
# ╟─169d15f4-b07a-4a48-8ae6-7d7a2a1abf9c
# ╠═3d6e43a4-ba0e-47f4-9cc1-3e436bfe8025
# ╟─8816b4c2-cc7e-4d6c-aaec-48965ad7189b
# ╠═b4d88e14-6f3c-4b61-8384-0d6c9ad4c4fb
# ╟─7da14d7d-6d1c-4528-912f-d72f74866ef6
# ╠═b5e437ff-bb77-4431-b368-4e6242dcd921
# ╟─e23ba6a3-5127-4780-8609-5ed39ebb0ad0
# ╠═126f8804-795a-424b-ba80-764e6aba54eb
# ╟─0b218b88-db11-4105-94b7-ea59a99f27f6
# ╠═054a669b-fc9f-4101-ad1d-5c49a49e46a8
# ╟─2b5a3dd2-3d43-40a9-9a06-e66620f7bb67
# ╠═1dcc9f3f-75b0-4c8d-8aca-f43baca7ad44
# ╟─8a759b36-b8d3-4883-8040-e53051d91501
# ╟─e7f0c5f6-f58d-460d-9059-c79f28dc3354
# ╟─d629b140-3356-48a6-886f-23686d3adc02
# ╟─4d5f7c22-b3d5-4cf1-ae07-f8b2ad750499
# ╟─0440866d-cefc-4b48-9900-44ca8f22a721
# ╟─5a81f4f7-13b2-4e58-8235-f87994cfd335
# ╠═c1757f04-2da1-45dd-96f3-d88ebed49ad6
# ╠═ae99d165-ea88-44e0-9117-b3e17228605c
# ╟─a4efc892-930c-4b52-8c91-132fba31cc70
# ╟─7d8859f3-02b7-4436-ab17-9c7c2211d405
# ╠═5f63f86a-3251-4259-b3e4-bd0adfd988ef
# ╠═fe7de800-92aa-457f-b041-a45f5532d3f6
# ╟─8a72ab17-1387-4c88-8ac3-a5c62235c7a9
# ╟─f34c0050-53e9-4e7b-b469-6632d0e7bfa6
# ╟─ed680832-48b0-4f83-8aa6-417ae2bda95a
# ╟─dd6943b8-0b4a-456c-b02a-96bc3bb3cc6b
# ╠═e5ca71e7-9999-4a91-b6f0-e2ef237278b7
# ╟─880fae25-acb7-4c10-a1d4-66465b845494
# ╠═f6cf1f30-3020-489e-8783-d0ca69c2b7f8
# ╟─9ff5a87c-0de4-45d9-bdcf-438f109874fd
# ╠═82592100-5e3e-422c-8f05-eac9cd02262f
# ╠═249b606f-164d-4570-b92f-438fac15267a
# ╠═9be27f62-64dc-4ddd-9435-ceb965e7e344
# ╟─d4d7b4d4-acf1-4fb8-bcfd-fcb7707116b9
# ╠═1db431eb-de14-4145-a1ab-ac211c3bcb09
# ╟─34f1f0d5-2a18-4729-b426-e64000345aa8
# ╠═f97eefca-c28a-4b97-8dd8-6139f905fa58
# ╟─21e3d5a7-809b-4b07-84ad-5160bd251c2e
# ╠═cce0135e-8a81-4d1c-9871-8bd628b0842e
# ╟─59daa287-ef2a-467d-adcd-51d7f48b28ee
# ╠═1aaeaa4c-bcac-49b1-bd75-46846f11911a
# ╠═12fea289-b26b-480e-a182-186d05ebc882
# ╠═5bac1f4b-29d9-434b-8d77-c9858ed964cd
# ╠═6330d14a-f619-4fa4-b006-7b0021bdfd15
# ╠═a8ca4dec-0d18-416b-a2ad-60112edc64e0
# ╟─f7417595-9aa2-41f1-8512-053757880d04
# ╟─b31f93c6-c2fa-41a4-8fd1-48f188deda48
# ╟─277e2fe3-4413-4e14-8cb7-f590f18fb13e
# ╟─3aadd3a3-579a-4d92-b22e-66f6e116f614
# ╠═4c72fa64-f63b-4fb1-9dbd-5a20b7013998
# ╟─d94c49d1-e07e-4af0-9403-12c7570e2d6f
# ╠═1ee06fb8-6c36-49af-a27d-9087aae981ee
# ╟─4f88eeca-a049-445a-9ca3-0687c18f5856
# ╠═3cd07cfa-3676-4407-933f-0416af96f955
# ╟─13fdc708-1a0e-4382-a0e1-d1829fc4c063
# ╠═b06a24ff-e7cb-434d-80f7-b644b2943699
# ╟─aba3666c-cd92-4da6-9414-4e5b85c9fbee
# ╠═8d0c171c-a0f0-461f-8c15-2eb4efeb0d88
# ╟─50eb3a7f-a4a8-40ff-82d0-9967e11dee66
# ╠═9e0f8df9-44f3-45d0-8694-457144801903
# ╟─1da5c61e-a247-4858-8ae6-8e90b0133e75
# ╠═77674b80-09ef-4008-96b2-1bc806d16c42
# ╟─f374cb25-8ff7-43a2-8590-688e7ec56f84
# ╟─80f711c0-8238-4ce2-bab6-39379aa806da
# ╠═6ab554ab-f687-47db-8726-1086b9f48b7e
# ╟─78ef7478-4bca-42a8-b6b2-ad674092e697
# ╠═e4f34663-1950-4081-b448-44b80b5c7621
# ╟─0d407ef7-cd6a-4a39-bf13-2d2508325acc
# ╠═54212b2e-2161-498a-a14f-60941bda3921
# ╟─a06c8fab-0313-4a03-8c3c-18769ccd8ebe
# ╠═6f6dc966-bccb-4460-acd0-182f08c0b458
# ╟─a405d1c8-3fd1-4076-b9bb-16e255db2cd0
# ╠═c73440a9-3551-4be8-8730-322e9a1bc50f
# ╟─142d7155-a438-4b58-aef1-d2d67368b1a1
# ╠═7a759b90-1758-4173-bc33-c04e69e3c74f
# ╟─d43420d5-e552-426b-88e6-60a7d4eb2b01
# ╟─3284ca43-d8f5-453e-856f-ecfff8af9b20
# ╟─3ecf24e3-b676-42f8-9f3b-4fdd2e1cc89c
# ╠═aeabb688-7043-4227-8d12-81cc3427ce1f
# ╠═1c901f4b-123d-48dc-a713-e34178964264
# ╠═ff4ea15f-1a01-421b-9076-6fc7df638fe9
# ╠═8250d63a-12c0-4f87-839f-c45ea54bb4a8
# ╠═6571e75b-fd06-4075-9c65-2a036be9c5b2
# ╠═3074097c-b8de-4301-beee-ebfa7cd46354
# ╟─cccb52fa-2041-4cc8-bed8-c3891381bc52
# ╠═8e489736-426d-489a-90ae-072d2e90a87a
# ╠═04a5cee1-67ee-41bb-9d98-4bfc9e2b7fe6
# ╟─dd21192e-06fc-4fb3-993c-a793b50b4003
# ╠═cc465e20-0fc8-41e4-88b7-0d70f1aab07d
# ╟─1fbdad93-58d0-4e08-9dc9-f2decca5c549
# ╠═c0e95730-169d-4887-80fd-15d9d23f1c30
# ╟─dd1b86dd-d66b-458b-bbcd-7d99d40d0e7e
# ╟─742e34f2-68bc-4951-807a-a6eb25312b0a
# ╟─fbe342f6-ecc6-4baf-968b-97ffcdc6c3f0
# ╟─b5ec77e8-cbba-4324-9f52-79d217a6f635
# ╠═e8a1a2c6-1559-4bd6-b29b-3de6a3ea8a32
# ╟─e43911fe-4039-48cd-8ffe-c312b5ab3914
# ╠═dae57016-5a48-4c49-8181-7d11774bdc09
# ╟─89d5b7d7-8913-4ba8-b965-9d87c59b9a0c
# ╠═057d25ee-79a9-40f5-8d25-45d27c16429b
# ╟─5edba1b3-2178-47c7-9160-11c7b80cd667
# ╟─e3ba24c0-f01f-4889-9bba-08b1c747031d
# ╠═62491b66-b441-49d8-b5ed-63162dd72449
# ╠═587d2271-8f17-42c6-9112-668bba9665e2
# ╟─7601a463-0548-4e66-a1fe-4d8164b6146a
# ╟─a1537f49-9174-4d8b-83e6-2a80092c2e2e
# ╠═6f5f13d0-c4b4-4e41-9cdf-20d68132736d
# ╟─8cc3fde2-8b71-4655-8037-9878b30be723
# ╟─88a8bad8-456e-46a6-b7de-96e1b9337c6e
# ╟─38f2cb06-1040-4a63-bab9-517f314d704e
# ╟─6d4de4e0-f80a-4dd9-aedc-771ea3264db0
# ╟─f729d8a9-be99-40ba-bf15-179c308cd2f6
# ╠═b70ab468-2f40-465b-91a5-08c7b65fa17c
# ╟─9e22f50f-2829-405d-a896-068d06a1f10e
# ╠═6205dc45-9bc1-4dfb-873c-d926b5ed46a1
# ╠═f7d7ab32-ae5e-43eb-aea1-038fc9f9c269
# ╟─a59e0196-cbe1-4658-a2c0-ea30ed375dcf
# ╠═d44206c2-6e37-4ebf-aeb4-302672dba634
# ╟─db61f2a8-e5e7-46e0-8417-400dfecd9f1d
# ╠═be1af825-0fee-479c-8507-845b45e57c55
# ╠═ef57ba8b-b33a-438a-8f4f-bb4578a65b4a
# ╟─9134d1b0-445e-4f4f-a79e-2b2cd111565a
# ╠═5779c684-d516-4448-87fe-1968e3006342
# ╠═be4d9dfd-cc72-4b01-815c-75cf3e8fc4d9
# ╟─cf8bc1e2-cd9e-4e21-bded-6363b6d427e9
# ╠═baa3b61b-301d-4e13-b7bb-2a22eeec945f
# ╠═573f22f4-0719-4f01-97b4-2aa84e1bae50
# ╟─e37f5658-f8a4-435f-9400-8e4e8c53617a
# ╠═f2ab002a-ecec-4bfb-b0d9-8417fdad0a85
# ╠═d2a374d8-b43f-4112-a00b-eaf1d4172ea8
# ╠═ad989a4a-dfb1-4964-be2e-51f5a125d57a
# ╟─72185093-bdc8-4761-84de-652a5bd4b215
# ╠═316f5946-c46f-4c74-a58c-86998fbdfca3
# ╟─3df63bf8-21e9-4200-b4f9-f366ac085e54
# ╠═99c748a9-e96e-43c8-a4f8-e68f4cd4f364
# ╟─f070b44b-2c42-4f5c-b843-e8eceb8f82dc
# ╠═2dca66ed-d3d4-49f2-8123-61ee29d4b345
# ╟─bfa7cd3a-f9d9-4a8f-8d12-ec760a3e39e4
# ╠═d3d65431-184a-43f2-a27f-5a0d90e6f3d6
# ╠═646bfe90-87b3-4808-aa50-fa8abc62e6c7
# ╠═d8ec3fe6-2dbd-4606-a7ff-5b720efe3a0f
# ╠═6a1613aa-acd1-4f41-8f8b-41999198afd2
# ╟─2366e8ce-4bb3-4724-98db-d89b3ceea149
# ╠═493381a4-fd08-497c-b2b1-533641e61eeb
# ╟─c0d4ff63-5b07-4353-8c20-e8edf71006cf
# ╠═019b3f98-d94a-4418-bb99-f734c0c4cad2
# ╟─4051a1ac-136a-4722-81d4-ad579becba8f
# ╟─199a7aa6-4013-45f9-9da8-54ad8e81e490
# ╟─733da229-e2e0-415f-b97c-ab96e4e17841
# ╠═c946776b-1549-400b-8da9-59781d659ab0
# ╟─25bce086-374e-42a3-9eea-4c7a973aeaa6
# ╠═08bf2c08-5c67-4a3d-86dd-e4eedced16aa
# ╟─78e948d0-0337-4cef-bcf6-b48106b7257e
# ╠═b9be03a4-9fb3-4b9a-8d59-9617310fc923
# ╠═d9b34145-fefc-4201-9de0-7dd5fe9ce82c
# ╠═8249ce67-9182-43f1-8ba5-f6a62de1ad0c
# ╟─1fe751ec-42f0-416c-b4e9-4bbccdec613b
# ╟─f94e51ef-65ed-4b7d-9d51-2e33cf7a9af5
# ╟─7b398636-fd71-42ae-9486-6e1d7a6615d8
# ╠═0f325bfb-738a-4bbf-b67d-8154f4453786
# ╟─dedff45c-9c7b-4451-8900-57d8033e459c
# ╠═8dedde3a-23a7-4673-a90e-cf1d9c6e0866
# ╟─2fe63769-c3f3-4cd5-be25-17852f616414
# ╠═2b7f17fa-1f37-455a-a98f-883600c174d1
# ╟─e4f95ac4-9745-46d2-ae47-4d281139e3e9
# ╠═e1873086-ea1e-4d36-95b1-293c710c5acc
# ╟─aa027eda-3321-4720-8d95-8d84d9b0f0be
# ╟─0cfe4c26-edf2-441c-95e1-f5f852b18090
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
