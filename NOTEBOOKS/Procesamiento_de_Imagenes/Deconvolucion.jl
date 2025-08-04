### A Pluto.jl notebook ###
# v0.20.5

using Markdown
using InteractiveUtils

# ╔═╡ 20737ad0-c3e9-11ef-3c60-8951d72fb0dd
using PlutoUI

# ╔═╡ 7f0d9d18-2286-4a0c-8f3b-14eec26a1a31
begin
	using Plots,LaTeXStrings,Colors,ColorVectorSpace,ImageShow,FileIO,ImageIO
	using HypertextLiteral
	using Images, ImageShow 
	using Statistics,  Distributions, LinearAlgebra
	using StatsBase, StatsPlots
end

# ╔═╡ dd989a69-1961-4fe0-98e5-2698a852d8e2
using TestImages, ImageFiltering

# ╔═╡ 7a337404-eb3a-4639-93f5-cd2c907b6422
PlutoUI.TableOfContents(title="Deconvolución", aside=true)

# ╔═╡ ff935e28-0b09-44c9-b80e-5f45fee7b400
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**.

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 471bba4a-305a-4123-a824-bb1f91e32348
md"""**Este cuaderno está basado en actividades del seminario Procesamiento de Imágenes de la Universidad Nacional de Colombia, sede Bogotá, dirigido por el profesor Jorge Mauricio Ruíz en 2024-2.**

Elaborado por Juan Galvis, Jorge Mauricio Ruíz."""

# ╔═╡ 3838a8ee-63f9-4f41-85f3-502603433098
md"""Vamos a usar las siguientes librerías:"""

# ╔═╡ 993aff42-0eb3-4cd1-9d99-333d5a2d2669
md"""
# Introducción
"""

# ╔═╡ 6ef479c7-e440-4e1f-8425-263288d152e8
md"""
La deconvolución es una técnica clave en el procesamiento de imágenes que busca restaurar imágenes afectadas por desenfoque, ruido y distorsiones introducidas durante su captura. Este proceso es crucial en campos como astronomía, microscopía e imágenes médicas, donde la calidad de la imagen impacta directamente el análisis. En este notebook, exploraremos los fundamentos y la implementación de métodos de deconvolución aplicándolos para mejorar imágenes degradadas y evaluando los resultados obtenidos.
"""

# ╔═╡ 2fffc9c6-1585-4a0b-b99e-353611d01551
md"""
A lo largo de este cuaderno se manejará la deconvolución como un problema inverso lineal construido a continuación: Suponga que tenemos las siguiente imagen de un camarógrafo.
"""

# ╔═╡ 4235ee49-5e71-476b-b32b-c790f029720d
camoriginal = testimage("cameraman.tif")

# ╔═╡ e0c13e70-41b5-439b-91ed-620adda4587d
md"""$\texttt{Figura 1. Camarógrafo}$"""

# ╔═╡ 7405c1ba-0dad-437e-a907-60b44e47bf80
md"""
Vamos a modificar esta imagen para que tenga una distorsión que simula el movimiento en el momento de la captura de la fotografía y además que se encuentre contaminada por ruido aditivo.

Para la distorsión usamos el kernel $K = u\cdot v^{\top} \in\mathbb{R}^{3\times 7}$ donde 

$u = \begin{pmatrix}
1\\
1\\
1\end{pmatrix}\in\mathbb{R}^{3\times 1} \quad \text{ y }\quad
v^{\top} = \frac{1}{21}\begin{pmatrix}
1 & 1 & \ldots & 1\end{pmatrix}\in\mathbb{R}^{1\times 7}.$
"""

# ╔═╡ ed6953b4-744c-4dbb-8ac3-69c506972554
begin
	u = (1/3)*ones(3)
	v = (1/7)*ones(7)
	K = u * v'
end

# ╔═╡ f32ad76c-7222-4ea5-b14d-c26978b60ab3
md"""
El resultado de la convolución se muestra en la figura 2. Se puede notar que la distorsión de este kernel genera un movimiento horizontal.
"""

# ╔═╡ 9955f70c-6636-4b95-b774-feaa57a6a8f5
camfilter0 = imfilter(imresize(camoriginal, (512, 512)), K)

# ╔═╡ 716cbf70-eee8-41ee-a735-06068498dd7a
md"""$\texttt{Figura 2.}$"""

# ╔═╡ e60ab5d6-f40e-4250-9b15-4f521c652472
md"""
Ahora agregamos un ruido aditivo gaussiano con media $\mu=0$ y desviación estándar $\sigma=0.1$ obteniendo la siguiente imagen.
"""

# ╔═╡ 22257c37-d113-4ebb-b392-8d4886dea5ca
camfilternoise0 = Gray.(channelview(camfilter0) + 0.1*randn(512,512))

# ╔═╡ 68650463-6f3b-4193-a2db-b85bf5532482
md"""$\texttt{Figura 3.}$"""

# ╔═╡ c05726ab-0ef1-40d7-96a9-64372f964b11
md"""
Ahora para reducir el tamaño de la imagen y no cometer un *crimen inverso* [1] regresamos a la dimensión original la imagen distorsionada sin y con ruido, sobre estas dos imágenes vamos a trabajar de ahora en adelante.
"""

# ╔═╡ da908f22-4f24-4768-bd58-1c07baf48506
begin
	camfilter = imresize(camfilter0, (512, 512))
	camfilternoise = imresize(camfilternoise0, (512, 512))
	p1 = plot(camfilter,axis=false, grid=false, title="Distorsión sin ruido")
	p2 = plot(camfilternoise,axis=false, grid=false, title="Distorsión con ruido")
	plot(p1,p2,layout=(1,2), size=(800,400))
end

# ╔═╡ 498b73ea-757e-4d5c-852f-20d0e8f4e105
md"""$\texttt{Figura 4.}$"""

# ╔═╡ c217bbc0-03e2-41d2-b382-77df0a3d9108
md"""
Nuestro objetivo de ahora en adelante será recuperar la imagen original del camarógrafo teniendo la imagen distorsionada con o sin ruido.
"""

# ╔═╡ 9468060a-3f5a-42ef-b5dc-8acecb6d0934
md"""
# Modelo lineal
"""

# ╔═╡ 8beb041e-60a1-4f42-bbbd-3db56c36dc6e
md"""
En la introducción se planteó el siguiente modelo:

$Y = K \ast X + \Theta,$

donde $K$ es el kernel de convolución, $\Theta$ es una matriz de ruido (que puede ser nulo cuando solo se considera la imagen distorsionada sin ruido o puede venir de una distribución normal cuando se tiene una imagen distorisionada con ruido), $X$ corresponde a la imagen original y $Y$ es la imagen procesada.

El problema de construir $Y$ a partir del conocimiento de $K$, $X$ y $\Theta$ es un problema directo y que no generó dificultades, no obstante, el problema de recuperar $X$ dado que conocemos $Y$, $K$ y $\theta$ es un problema inverso que posee dificultades que resaltaremos más adelante.

Por la linealidad de la convolución, el objetivo principal de esta sección será construir el modelo lineal que representa el comportamiento del modelo anteriormente mencionado.
"""

# ╔═╡ 81f38acc-4944-4b40-9f8a-83bb47ae63b5
md"""
## Convolución como una transformación lineal
"""

# ╔═╡ 9255bd4e-c2ed-4d31-b6be-d74c452e1d69
md"""
Dada una sucesión finita $h = (h_0, h_1, \dots, h_m)$, se puede representar esta sucesión en forma de vector columna:

$h = \begin{pmatrix} h_0 \\ h_1 \\ \vdots \\ h_m \end{pmatrix}$

Definimos la transformación $T_h : \mathbb{R}^n \to \mathbb{R}^{n+m-1}$ mediante la convolución de una señal $x$ con $h$:

$T_h(x) = x \ast h$

donde $\ast$ denota la operación de convolución. Esta transformación puede ser tanto **lineal** como **circular**, dependiendo de cómo tratemos los bordes de las matrices involucradas.

La propiedad distributiva de la convolución se expresa como:

$(x + y) \ast h = x \ast h + y \ast h$

Esta propiedad asegura que la operación es lineal, lo que implica que $T_h$ es una transformación lineal. Gracias a la propiedad lineal, podemos escribir la transformación $T_h$ como una multiplicación matricial:

$T_h(x) = Hx$

donde $H$ es la **matriz de convolución** asociada a la transformación $T_h$. La matriz $H$ se construye aplicando $T_h$ sobre los vectores básicos $e_1, e_2, \dots, e_n$, donde cada $e_i$ es un vector columna con un 1 en la $i$-ésima posición y 0 en las demás:

$e_1 = \begin{pmatrix} 1 \\ 0 \\ \vdots \\ 0 \end{pmatrix}, \quad e_2 = \begin{pmatrix} 0 \\ 1 \\ \vdots \\ 0 \end{pmatrix}, \quad \dots, \quad e_n = \begin{pmatrix} 0 \\ 0 \\ \vdots \\ 1 \end{pmatrix}$

**Ejemplo.** Consideremos el caso en el que $h = (1, -1)$ y la transformación lineal $T_h : \mathbb{R}^4 \to \mathbb{R}^5$ se define mediante la convolución lineal. La matriz de convolución $H$ para este caso específico se obtiene aplicando la convolución lineal sobre los vectores básicos $e_1, e_2, e_3, e_4$, y se tiene:

$H = \begin{pmatrix}
1 & 0 & 0 & 0 \\
-1 & 1 & 0 & 0 \\
0 & -1 & 1 & 0 \\
0 & 0 & -1 & 1 \\
0 & 0 & 0 & -1
\end{pmatrix}$

Esta matriz $H$ es el resultado de aplicar la transformación $T_h$ sobre los vectores base, y refleja la estructura de la convolución de la sucesión $h = (1, -1)$.
"""

# ╔═╡ f6c7c4d9-f096-435d-a8bd-f275700d0bc2
begin
	function matriz_convolucion(h, n)
	    m = length(h)
	    H = zeros(Float64, m + n - 1, n)  
	    for i in 1:(m + n - 1)
	        for j in 1:n
	            if 1 <= i + 1 - j <= m
	                H[i, j] = h[i - j + 1] 
	            end
	        end
	    end
	    return H
	end
	
	# Ejemplo de uso con h = (1, -1) y n = 4
	h = [1, -1]
	H = matriz_convolucion(h, 4)	
end

# ╔═╡ d6e429b4-5b3a-4642-ad7c-74acc57cb016
function matriz_convolucion_trunc(h, n)
	m = length(h)
	H = zeros(Float64, n, n)  
	for i in 1:n
		for j in 1:n
			if 1 <= i + 1 - j <= m
				H[i, j] = h[i - j + 1] 
			end
		end
	end
	return H
end

# ╔═╡ 0a9ac857-92ab-4d99-b600-2c9f100444c1
matriz_convolucion_trunc(h, 4)

# ╔═╡ 0ebba0e0-dd44-4e5c-9293-d9620e9c192f
md"""
**Extensión a matrices.** La transformación lineal mediante convolución también puede extenderse al caso de matrices, donde se aplica un kernel de convolución $K$ sobre una matriz de entrada $X$. Si el kernel de convolución $K$ es **separable**, esta operación puede representarse como una serie de transformaciones lineales unidimensionales en las filas y columnas de $X$.

Un **kernel separable** es un kernel que puede expresarse como el producto externo de dos vectores:

$K = v \cdot w^T$

donde $v \in \mathbb{R}^p$ y $w \in \mathbb{R}^q$. Esto implica que la convolución de $X$ con $K$ puede descomponerse en dos pasos: primero aplicar la convolución unidimensional con $v$ a las filas de $X$, y luego aplicar la convolución unidimensional con $w$ a las columnas del resultado.

Esta propiedad reduce significativamente el costo computacional de la convolución en matrices y permite representar la transformación como una combinación de dos transformaciones lineales, una para las filas y otra para las columnas.


"""

# ╔═╡ f2c4ee61-2d0a-4612-93d1-0cfd3b176e72
md"""
Para demostrar lo anteriormente dicho, en primer lugar es fácil ver que si el kernel de convolución es una matriz fila, su efecto se limita a las filas de la matriz de entrada. De manera similar, si el kernel es una matriz columna, únicamente afectará las columnas de la matriz de entrada.

Por ejemplo, supongamos que tenemos la siguiente matriz de entrada $X$ y un kernel $K$ como matriz fila:

$X = \begin{pmatrix}
x_{11} & x_{12} \\
x_{21} & x_{22}\\
\end{pmatrix}$

$K = \begin{pmatrix}
k_{11} & k_{12}
\end{pmatrix}$

En este caso, la convolución de $X$ con $K$ afectará únicamente las filas de $X$. La operación de convolución se aplica deslizando $K$ sobre cada fila de $X$, operando de forma similar a una multiplicación punto por punto.

El resultado de la convolución de $X$ con $K$ sobre las filas de la matriz sería:

$K\ast X = \begin{pmatrix}
k_{11}x_{11} & k_{12}x_{11} + k_{11}x_{12} & k_{12}x_{12}\\
k_{11}x_{21} & k_{12}x_{21} + k_{11}x_{22} & k_{12}x_{22}
\end{pmatrix}$

$K\ast X = \begin{pmatrix}
x_{11} & x_{12} \\
x_{21} & x_{22}\\
\end{pmatrix}\begin{pmatrix}
k_{11} & 0\\
k_{12} & k_{11}\\
0 & k_{12}\\
\end{pmatrix}^{\top}$

En este ejemplo, el kernel fila $K$ solo afecta las filas de la matriz $X$, realizando la operación de convolución en cada una de ellas, como se evidenció en la última ecuación esta convolución con el kernel fila se puede reescribir como:

$K\ast X = X \cdot T_{K}^{\top},$

haciendo más visible la transformación lineal que solo afecta a las filas y también redescubriendo la matriz asociada a la transformación lineal de la convolución unidimensional con kernel $K$.


Se puede de la misma manera que si el kernel $K$ es una columna entonces únicamente afectará a la matriz $X$ en sus columnas y además las convolución puede ser escrita como:

$K\ast X = T_{K} \cdot X.$

"""

# ╔═╡ 58624620-c6ae-4235-b3fb-5ce90610308f
md"""
En segundo lugar, tenemos el siguiente teorema: 

**Teorema.** Sea $A$ una matriz y $K=u\cdot v^{\top}$ un kernel separable. Entonces 

$K\ast A = u \ast v^{\top} \ast A = T_{u} \cdot A \cdot T_{v}^{\top}$

*Demostración*. Nótese que:

$\begin{align*}
(K\ast A)_{i,j} &= \sum_{s}\sum_{t}K_{s,t} A_{i-s,j-t}\\
&= \sum_{s}\sum_{t}(u\cdot v^{\top})_{s,t} A_{i-s,j-t}\\
&= \sum_{s}\sum_{t}u_{s} v^{\top}_{t} A_{i-s,j-t}\\
&= \sum_{s}u_{s}\sum_{t} v^{\top}_{t} A_{i-s,j-t}\\
&= \sum_{s}u_{s} (v^{\top}\ast A)_{i-s,j}\\
&= (u \ast v^{\top} \ast A)_{i,j},
\end{align*}$
como las expresiones son iguales componente a componente y sus dimensiones son las mismas entonces $K\ast A = u \ast v^{\top} \ast A$. La igualdad $u \ast v^{\top} \ast A = T_{u} \cdot A \cdot T_{v}^{\top}$ se sigue de lo discutido previamente.
"""

# ╔═╡ 4c7b7434-edb0-4925-a07f-a7e68ab205e0
md"""
Para finalizar y crear el modelo lineal es importante vectorizar la imagen y notar que la expresión $T_{u} \cdot A \cdot T_{v}^{\top}$ se encuentra directamente relacionada con $vec(A)$ y con el producto de Kronecker $T_{u} \otimes T_{v}$. 


**Definición** *(Vectorización)*. Si $A$ es una matriz de tamaño $m \times n$, la vectorización de $A$, denotada generalmente como ${vec}(A)$, es el proceso de convertir la matriz en un vector de tamaño $mn$, donde los elementos de la matriz se colocan columna por columna o fila por fila en el vector.

Por ejemplo, supongamos que tenemos la siguiente matriz $A$ de $2 \times 3$:

$A = \begin{pmatrix}
1 & 2 & 3 \\
4 & 5 & 6
\end{pmatrix}$

La **vectorización** de $A$, denotada como ${vec}(A)$, será:

${vec}(A) = \begin{pmatrix}
1 \\
4 \\
2 \\
5 \\
3 \\
6
\end{pmatrix}.$
"""

# ╔═╡ c6664ddb-8a11-4129-87b7-6e40a18fedd0
A = [1 2 3; 4 5 6]

# ╔═╡ 526c3a2f-a985-4933-ac19-58b11488fde0
vec(A)

# ╔═╡ f54f2815-23d2-4967-a78b-adef2e0a578d
md"""
**Definición** *(Producto de Kronecker)*. Si $A = \begin{pmatrix} a_{ij} \end{pmatrix}$ es una matriz $m \times n$ y $B = \begin{pmatrix} b_{kl} \end{pmatrix}$ es una matriz $p \times q$, entonces el producto de Kronecker $A \otimes B$ es una matriz $mp \times nq$ dada por:

$A \otimes B = \begin{pmatrix}
a_{11} B & a_{12} B & \dots & a_{1n} B \\
a_{21} B & a_{22} B & \dots & a_{2n} B \\
\vdots & \vdots & \ddots & \vdots \\
a_{m1} B & a_{m2} B & \dots & a_{mn} B
\end{pmatrix}$
"""

# ╔═╡ 632f0ec5-e149-4965-9d1c-0d4cd48b7574
B = [1 0 0; 0 1 0; 0 0 0]

# ╔═╡ d2dc41fb-7211-4d62-b138-847412b951b4
kron(A,B)

# ╔═╡ 27cf6249-d18f-422f-bede-569cb22d101c
md"""
**Teorema.**  Sean $A\in\mathbb{R}^{m\times n}$, $B\in\mathbb{R}^{s\times t}$ y $X\in\mathbb{R}^{t\times n}$ entonces 

$(A\otimes B){vec}(X) = vec(B\cdot X \cdot A^{\top})\in\mathbb{R}^{ms}$
"""

# ╔═╡ b43e75ab-4b11-4add-bb80-4c053086e07b
md"""
*Demostración.* Escribamos $X$ haciendo explícitas sus columnas:

$X = \begin{pmatrix}
| & | &  & | \\
X_1 & X_{2} & \ldots & X_{n}\\
| & | &  & | \\
\end{pmatrix}$

con $X_{i}\in\mathbb{R}^{t}$ para $i=1,\ldots, n$, de esta manera 

$vec(X) = \begin{pmatrix}
X_1 \\
X_2 \\
\vdots \\
X_n\\
\end{pmatrix}.$
Empecemos la demostración desde el lado izquierdo:

$\begin{align*}
(A\otimes B){vec}(X) &= \begin{pmatrix}
a_{11} B & a_{12} B & \dots & a_{1n} B \\
a_{21} B & a_{22} B & \dots & a_{2n} B \\
\vdots & \vdots & \ddots & \vdots \\
a_{m1} B & a_{m2} B & \dots & a_{mn} B
\end{pmatrix}\begin{pmatrix}
X_1 \\
X_2 \\
\vdots \\
X_n\\
\end{pmatrix}\\
&= \begin{pmatrix}
\sum_{k=1}^{t}a_{1k}BX_k \\
\sum_{k=1}^{t}a_{2k}BX_k  \\
\vdots \\
\sum_{k=1}^{t}a_{nk}BX_k \\
\end{pmatrix}\\
&= vec\begin{pmatrix}
| & | &  & | \\
\sum_{k=1}^{t}a_{1k}BX_k & \sum_{k=1}^{t}a_{2k}BX_k & \ldots & \sum_{k=1}^{t}a_{nk}BX_k\\
| & | &  & | \\
\end{pmatrix}\\
&= vec\left(B\begin{pmatrix}
| & | &  & | \\
\sum_{k=1}^{t}a_{1k}X_k & \sum_{k=1}^{t}a_{2k}X_k & \ldots & \sum_{k=1}^{t}a_{nk}X_k\\
| & | &  & | \\
\end{pmatrix}\right)\\
&= vec\left(B\begin{pmatrix}
| & | &  & | \\
X_1 & X_{2} & \ldots & X_{n}\\
| & | &  & | \\
\end{pmatrix} \begin{pmatrix}
a_{11}  & a_{21}  & \dots & a_{m1}  \\
a_{12}  & a_{22}  & \dots & a_{m2}  \\
\vdots & \vdots & \ddots & \vdots \\
a_{1n}  & a_{2n}  & \dots & a_{mn} 
\end{pmatrix}\right)\\
&=vec\left(B\cdot X \cdot A^{\top}\right)
\end{align*}$
"""

# ╔═╡ 0fbbc63b-1cae-4200-b0a6-ef00ec8e5169
md"""
De esta manera, si tenemos una imagen $X$ y le hacemos convolución con un kernel separable $K = u \cdot v^{\top}$ entonces tenemos que:

$vec(K\ast X) = vec(T_{u} \cdot X \cdot T_{v}^{\top})  = (T_{v}\otimes T_{u}) vec(X).$

Identificamos la matriz $T_{v}\otimes T_{u}$ por $M_{K} = M_{u\cdot v^{\top}}$.
"""

# ╔═╡ b844e8b4-df96-422d-9466-7903082e5498
md"""
En el ejemplo del camarógrafo como la imagen tiene un tamaño de $512\times 512$ entonces, según la notación de teorema anterior $m = n = s = t = 512$. 

Con el anterior teorema nos es posible expresar el modelo de manera lineal 

$vec(Y) = M_{K} \cdot vec(X) + \theta$

donde $Y$ es la imagen procesada, $X$ es la imagen original y $\theta$ es el vector de ruido.

La matriz $T_{u}$ es:
"""

# ╔═╡ 9609181b-e749-4e65-9e6f-5bff49231527
Tᵤ = matriz_convolucion_trunc(u, 512)

# ╔═╡ 28532792-37df-40d5-81a8-0b61694171ae
md"""
La matriz $T_{v}$ es:
"""

# ╔═╡ d25c9f96-c97c-49d1-a657-f7746bd58e61
Tᵥ = matriz_convolucion_trunc(v, 512)

# ╔═╡ 22445287-af01-4a2a-99b4-9a46c510ad8b
md"""
Con el fin de conocer algunas propiedades de la matriz $M_{u\cdot v^{\top}} = T_{v}\otimes T_{u}$ es necesario hacer uso del siguiente teorema:
"""

# ╔═╡ f84b8b24-251a-4f33-a724-0481b257a1a4
md"""
**Teorema.** *(Producto mixto)* Sean ${A}\in\mathbb{R}^{m \times p}$, ${B}\in\mathbb{R}^{q \times r}$, ${C}\in\mathbb{R}^{p \times n}$, y ${D}\in\mathbb{R}^{r \times s}$ matrices. Entonces, el siguiente producto de Kronecker se puede expandir como:

$({A}\cdot {C}) \otimes ({B}\cdot {D}) = ({A} \otimes {B})\cdot({C} \otimes {D}).$

*Demostración.* Esto es fácil de demostrar si usamos la multiplicación de matrices para matrices bloque. Podemos escribir el lado derecho (RHS) como

$(A\cdot C) \otimes (B\cdot D) = \begin{pmatrix} (A\cdot C)_{11} (B\cdot D) & \dots & (A\cdot C)_{1n} (B\cdot D) \\ \vdots & \ddots & \vdots \\ (A\cdot C)_{m1} (B\cdot D) & \dots & (A\cdot C)_{mn} (B\cdot D) \end{pmatrix}.$

El lado izquierdo (LHS) se puede expandir como

$(A \otimes B)\cdot(C \otimes D) = \begin{pmatrix} a_{11} B & \dots & a_{1p} B \\ \vdots & \ddots & \vdots \\ a_{m1} B & \dots & a_{mp} B \end{pmatrix} \cdot\begin{pmatrix} c_{11} D & \dots & c_{1n} D \\ \vdots & \ddots & \vdots \\ c_{p1} D & \dots & c_{pn} D \end{pmatrix}.$

Usando la multiplicación de matrices bloque, el bloque $(i,j)$-ésimo de la LHS es

$(\text{LHS})_{ij} = \sum_{k=1}^p (a_{ik} B) \cdot(c_{kj} D).$

Esto se puede reescribir como

$(\text{LHS})_{ij} = \sum_{k=1}^p (a_{ik} c_{kj}) (B \cdot D).$

Finalmente, podemos reconocer que la expresión $\sum_{k=1}^p (a_{ik} c_{kj})$ es precisamente el $(i,j)$-ésimo elemento de la matriz $A C$, por lo que obtenemos

$(\text{LHS})_{ij} = (A \cdot C)_{ij} (B\cdot D).$

Por lo tanto, concluimos que

$(A\cdot C) \otimes (B\cdot D) = (A \otimes B)\cdot(C \otimes D).$

**Corolario.** El producto de Kronecker preserva la descomposición en valores singulares.

"""

# ╔═╡ 2cb6f484-a392-405c-8a17-1c75f56b96fa
md"""
El producto mixto entre el producto de Kronecker y el producto común de matrices nos permite hacer lo siguiente: Si tenemos la descomposición en valores singulares de $T_{u}$ y $T_{v}$
-  $T_{u}  = U_{u}\Sigma_{u}V_{u}^{\top}$
-  $T_{v}  = U_{v}\Sigma_{v}V_{v}^{\top}$
entonces la descomposición en valores singulares de $M_{u\cdot v^{\top}}$ es 

$M_{u\cdot v^{\top}} = U \Sigma V^{\top}$ 

donde

-  $U = U_{v}\otimes U_{u}$
-  $\Sigma = \Sigma_{v}\otimes \Sigma_{u}$
-  $V = V_{v}\otimes V_{u}$
"""

# ╔═╡ a7724f6d-5b36-4993-9982-627a73d41243
Uᵤ, Σᵤ, Vᵤ = svd(Tᵤ)

# ╔═╡ 6afed8e7-49e9-4a73-8aee-795e15deaba0
Uᵥ, Σᵥ, Vᵥ = svd(Tᵥ)

# ╔═╡ 0770dd5d-f843-4b3a-bf46-847b467ef9ff
md"""
Graficamos los valores singulares de las matrices $T_u$ y $T_v$.
"""

# ╔═╡ 5690a382-23ef-4b13-9daa-d8ab45870ad7
begin
	plot(Σᵤ,label="Tᵤ",xlabel="Índice",ylabel="Valor singular",lw=2)
	plot!(Σᵥ,label="Tᵥ",xlabel="Índice",lw=2)
end

# ╔═╡ 991edf6d-e61a-4a10-a1f4-d98e9014e756
md"""$\texttt{Figura 5.}$"""

# ╔═╡ c4ac11fd-99fd-4315-8698-1c6216af4eb1
md"""
Calculamos los valores singulares de la matriz $M_{u\cdot v^{\top}}$ y luego los graficamos.
"""

# ╔═╡ f9d0918b-78aa-4836-87fe-ced9d9e91239
Σ = kron(Σᵥ,Σᵤ)

# ╔═╡ 50a9c393-6fb5-447c-add6-08bd622e950c
Σᵤ

# ╔═╡ 37266eb1-d5dc-4bef-b31d-7f967c88df66
plot(Σ,label=false, xlabel="Índice", ylabel="Valor singular", title="Valores singulares de la matriz del problema inverso")

# ╔═╡ c1db2105-49ab-4768-86d2-cf10ac1abf97
md"""$\texttt{Figura 6.}$"""

# ╔═╡ 1333f1d1-0516-470e-bda6-3e11b8f76e8a
md"""
Puede observarse que de los $512^2$ valores singulares de la matriz $M_{u\cdot v^{\top}}$ los valores con más masa corresponden a los primeros $50000$ valores, después de estos, los valores singulares no aportan mucha información al problema inverso puesto que se encuentran muy cerca a cero.
"""

# ╔═╡ 264f4e99-4173-4ce1-80db-0e6eef38695f
md"""
Se debe tener cuidado dado que, a pesar de que el producto de Kronecker conserva la de descomposición en valores singulares, la matriz $\Sigma$ **no** tiene los valores ordenados de manera descendente en su diagonal. Para probar esto graficamos los primeros $512\cdot 5 = 2560$ valores en la diagonal de $\Sigma$ y evidenciamos que no hay un comportamiento descendente.
"""

# ╔═╡ 5014f95d-4222-411c-a481-0fcd8755c220
plot(Σ[1:2560],label=false, xlabel="Índice", ylabel="Valor singular", title=L"Valores singulares de la matriz $\Sigma$")

# ╔═╡ b62391fc-feaf-477d-9243-9af33610b60e
md"""$\texttt{Figura 7.}$"""

# ╔═╡ 6791a7c5-fef6-4f93-848c-dfb4ac441092
md"""
Considerando el modelo $vec(Y) = M_{K}\cdot {vec}(X)$ sin ruido, invertimos el operador $M_K$ para recuperar $vec(X)$ de la siguiente manera:

$\begin{align*}
vec(Y) &= M_{K}\cdot vec(X)\\
vec(Y) &= U\cdot\Sigma\cdot V^{\top}\cdot vec(X)\\
V\cdot\Sigma^{\dagger}\cdot U^{\top}\cdot vec(Y) &=  vec(X)\\
((V_{v}\cdot\Sigma_{v}^{\dagger}\cdot U_{v}^{\top})\otimes(V_{u}\cdot\Sigma_{u}^{\dagger}\cdot U_{u}^{\top}))\cdot vec(Y) &=  vec(X),\\
\end{align*}$

por tanto,


$vec(X) = vec\left((V_{u}\cdot\Sigma_{u}^{\dagger}\cdot U_{u}^{\top}) \cdot Y\cdot (V_{v}\cdot\Sigma_{v}^{\dagger}\cdot U_{v}^{\top})^{\top}\right)$

$vec(X) = vec\left((V_{u}\cdot\Sigma_{u}^{\dagger}\cdot U_{u}^{\top}) \cdot Y\cdot (U_{v}\cdot\Sigma_{v}^{\dagger}\cdot V_{v}^{\top})\right)$

$X = (V_{u}\cdot\Sigma_{u}^{\dagger}\cdot U_{u}^{\top}) \cdot Y\cdot (U_{v}\cdot\Sigma_{v}^{\dagger}\cdot V_{v}^{\top})$
"""

# ╔═╡ daf569d1-f5e0-4422-aa08-d1b06d8e8073
md"""
En la siguiente función hacemos la recuperación de $X$ por medio de la última ecuación.
"""

# ╔═╡ 45594130-a939-4673-b69c-cf82a816799e
function inverse(img)
	Y = channelview(img)
	left = Vᵤ * diagm(1 ./ Σᵤ) * Uᵤ'
	right = Uᵥ * diagm(1 ./ Σᵥ) * Vᵥ'
	X = left * Y * right
	return X
end

# ╔═╡ 4d79fbd1-47b6-47f5-8814-c60b722dbbbb
md"""
Los resultados para la recuperación partiendo de la imagen procesada sin ruido y con ruido se muestran a continuación.
"""

# ╔═╡ e4bba822-23bf-4fef-b1e5-2178c6e6821b
begin
	p3 = plot(Gray.(inverse(camfilter)),axis=false, grid=false, title="Recuperación sin ruido")
	p4 = plot(Gray.(inverse(camfilternoise)),axis=false, grid=false, title="Recuperación con ruido")
	plot(p3,p4,layout=(1,2), size=(800,400))
end

# ╔═╡ b7e279ad-4400-4013-a363-2bbc104913b7
md"""$\texttt{Figura 8.}$"""

# ╔═╡ f68d17e2-719d-4d58-807c-041bc2c44602
md"""
Cualitativamente la solución directa por medio de la matriz del modelo lineal no asegura buenos resultados para recuperar la imágen original. Esto ocurre dado que la matriz presenta valores singulares muy cercanos a cero, por ende en la inversión, estos valores casi nulos dañan la solución dado que añaden ruido en la recuperación de la imagen original. A continuación se muestran los primeros 2560 valores singulares de la matriz $\Sigma$.
"""

# ╔═╡ b1070518-aacc-44f5-ad26-52fa4c1c6107
scatter( 1 ./Σ[1:2560],label=false, xlabel="Índice", ylabel="Valor singular", title=L"Valores singulares de la matriz $\Sigma^{-1}$")

# ╔═╡ b5839619-5456-4215-a682-9d87c6095e86
md"""$\texttt{Figura 9.}$"""

# ╔═╡ 85f4c493-63e1-42ce-b6b5-eaa0cdc52bce
md"""
# Modelo lineal con regularización
"""

# ╔═╡ 05489b85-4612-4498-b57d-7f6ab3d5e960
md"""
Como se pudo evidenciar en la sección anterior no se obtuvieron buenos resultados al intentar recuperar la imagen original $X$, en esta sección se presentan algunos métodos para afrontar esta dificultad.

Para simplicar la notación denominaremos $x= vec(X)$ y $y=vec(Y)$.
"""

# ╔═╡ 2a5beb83-1635-4ed3-8a8c-1e27e157b0f0
md"""
## Regularización de Tikhonov
"""

# ╔═╡ 88357769-7764-4354-bf1a-86980b345c7a
md"""
Considere un número real $\alpha$ positivo. Una manera de regularizar el problema inverso para encontrar $X$ es hallando el vector $x$ que es minimizador del siguiente problema de optimización:

$\underset{x}{min}\ \frac{1}{2}\|y - M_{k}x\|_{2}^{2} + \frac{\alpha}{2}\|x\|_{2}^{2}$

usando la descomposición en valores singulares de $M_{K}$ se puede transformar el anterior problema:

$\underset{\hat{x}}{min}\ \frac{1}{2}\|\hat{y} - \Sigma \hat{x}\|_{2}^{2} + \frac{\alpha}{2}\|\hat{x}\|_{2}^{2}$

en donde $\hat{x}= V^{\top}x$ y $\hat{y}= U^{\top}y$. Este problema tiene una solución explícita y se puede ver que es igual a 

$\hat{x}_{minimizador} = \left(\Sigma^{\top}\Sigma + \alpha I\right)^{-1}\Sigma^{\top}\hat{y},$

así, $x_{minimizador} = V \hat{x}_{minimizador}$.
"""

# ╔═╡ c81938a2-7720-4b2c-a620-9d82189b8e0f
md"""
Seleccionamos el valor de $\alpha$:
"""

# ╔═╡ 578af934-0c6e-424c-88c1-7f8c69c5b881
α = 0.01

# ╔═╡ d61b8630-83ef-4743-981a-bed47ed5bd79
md"""
Graficamos los valores en la diagonal de la matriz diagonal $(\Sigma^\top \Sigma + \alpha I)^{-1}\Sigma^\top$:
"""

# ╔═╡ 3acdef8b-ea7f-4e0e-bea4-86e951450788
begin
	Sigmaaux = 1 ./(Σ .^2 .+ α) .* Σ
	plot(Sigmaaux[1:2560], label=false, xlabel="Índices", ylabel="Valor singular", title=L"Valores singulares de la matriz $(\Sigma^\top \Sigma + \alpha I)^{-1}\Sigma^\top$")
end

# ╔═╡ d6c2bc4e-c624-4475-ae16-7105703f25b8
md"""$\texttt{Figura 10.}$"""

# ╔═╡ 5b1ff33a-4754-4a5b-8123-5aceb4b52cca
md"""
A continuación creamos la función que toma la imagen procesada y devuelve una aproximación a la imagen original por medio de la regularización de Tikhonov.
"""

# ╔═╡ dee9b6f8-43d1-4ee8-8c67-c423ee6263bd
function inverseTikhonov(img,α)
	Y = channelview(img)
	yhat = vec(Uᵤ' * Y * Uᵥ)
	Matrix = (1 ./(Σ .^2 .+ α)) .* Σ
	xhat = Matrix .* yhat
	Xhat = reshape(xhat, (512,512))
	X = Vᵤ * Xhat * Vᵥ'
	return X
end

# ╔═╡ d92230f4-7922-4e0b-9cf1-b9bc808bc4f1
begin
	p5 = plot(Gray.(inverseTikhonov(camfilter, α)),axis=false, grid=false, title="Recuperación sin ruido")
	p6 = plot(Gray.(inverseTikhonov(camfilternoise, α)),axis=false, grid=false, title="Recuperación con ruido")
	plot(p5,p6,layout=(1,2), size=(800,400))
end

# ╔═╡ d627e42e-20f1-428c-a9a7-f8ddb4d3395d
md"""$\texttt{Figura 11.}$"""

# ╔═╡ fcd1857a-22c2-498c-9842-db4b87405c4d
md"""
## Regularización con descomposición en valores singulares truncada
"""

# ╔═╡ 526bdc20-e0c8-4b05-a5d1-6f409f338c38
md"""
Recordemos que cuando no se tenía en cuenta la regularización para resolver el problema inverso se tenía que:

$V\cdot\Sigma^{\dagger}\cdot U^{\top}\cdot y =  x,$

esto puede ser reescrito como

$\sum_{i=1}^{512^2}\frac{v_i\cdot u_{i}^{\top}}{\sigma_i} y = x,$

donde $v_i$ y $u_i$ son las $i$-ésimas columnas de $V$ y $U$, respectivamente. De esta manera

$\begin{align*}
\sum_{i=1}^{512^2}\frac{v_i\cdot u_{i}^{\top}}{\sigma_i} y &=  \sum_{i=1}^{512^2}\frac{V\cdot e_i\cdot e_{i}^{\top}\cdot U^{\top}}{\sigma_i} y\\
&= V \sum_{i=1}^{512^2}\frac{e_i\cdot e_{i}^{\top}}{\sigma_i} \hat{y}\\
&= V \sum_{i=1}^{512^2}\frac{e_i^{\top}\cdot \hat{y}}{\sigma_i} e_{i}\\
&= V \sum_{i=1}^{512^2}\frac{\hat{y}_{i}}{\sigma_i} e_{i}\\
&= V \begin{pmatrix}\hat{y}_{1}/\sigma_1 \\
\hat{y}_{2}/\sigma_2\\
\vdots\\
\hat{y}_{512^2}/\sigma_{512^2}
\end{pmatrix}
\end{align*}$
"""

# ╔═╡ 960aa457-7913-46d9-913d-cabe186ed71d
md"""
Para realizar el truncamiento se elige un valor $p$ de tal manera que $1\leq p \leq 512^2$ para truncar la anterior representación y obtener:

$\sum_{i=1}^{p}\frac{v_i\cdot u_{i}^{\top}}{\sigma_i} y = V \begin{pmatrix}\hat{y}_{1}/\sigma_1 \\
\vdots\\
\hat{y}_{p}/\sigma_p\\
0\\
\vdots\\
0
\end{pmatrix}$
"""

# ╔═╡ 5d7aabf3-927d-4540-9611-4dd8c6deb194
md"""
No obstante, el método de truncamiento asume que los valores singulares se encuentran ordenados de manera descendiente y dado que nuestra matriz del problema lineal viene de un producto de Kronecker entonces este ordenamiento no se tiene, como se evidenció anteriormente.

Recordemos que la inversión sin ningún método de regularización es la siguiente:

$X = (V_{u}\cdot\Sigma_{u}^{\dagger}\cdot U_{u}^{\top}) \cdot Y\cdot (U_{v}\cdot\Sigma_{v}^{\dagger}\cdot V_{v}^{\top});$

para aplicar la regularización TSVD en este contexto se propone tomar $p_1$ valores singulares de $T_u$ y $p_2$ valores singulares de la matriz $T_v$, para de esta manera asegurar que se seleccionan valores que no se encuentran cerca a cero y corregir el problema de la inversión sin ninguna regularización.
"""

# ╔═╡ 8407e0e7-2722-4371-b4c2-1b25f6284d60
function inverseTSVD(img,p)
	Y = channelview(img)
	yhat = vec(Uᵤ' * Y * Uᵥ)
	Σᵤ_tr = [Σᵤ[1:p[1]]; zeros(512-p[1])]
	Σᵥ_tr = [Σᵥ[1:p[2]]; zeros(512-p[2])]
	Σ_tr = kron(Σᵥ_tr,Σᵤ_tr)
	InvΣ_tr = [x == 0 ? 0 : 1 / x for x in Σ_tr]
	Yhat_S = reshape(yhat .* InvΣ_tr, (512,512))
	X = Vᵤ * Yhat_S * Vᵥ' 
	return X	
end

# ╔═╡ 0da5c31e-b334-4eb4-a911-fdddc2fe32a5
begin
	p₁ = 250
	p₂ = 50
end

# ╔═╡ e675a394-02d4-49af-aff8-56636d2d2d79
md"""
A continuación se muestra el resultado del método de inversión regularizado por truncamiento.
"""

# ╔═╡ ec368cbb-49ea-45db-838c-56b461396dee
begin
	p9 = plot(Gray.(inverseTSVD(camfilter,[p₁,p₂])),axis=false, grid=false, title="Recuperación sin ruido")
	p10 = plot(Gray.(inverseTSVD(camfilternoise,[p₁,p₂])),axis=false, grid=false, title="Recuperación con ruido")
	plot(p9,p10,layout=(1,2), size=(800,400))
end

# ╔═╡ 05b8fb8d-2d94-416f-98ff-808145fac041
md"""$\texttt{Figura 12.}$"""

# ╔═╡ cecd20e5-5b7e-4061-92d0-dff450931a96
md"""
# Referencias
"""

# ╔═╡ 3d19f24e-2990-4da6-b5a2-58ea8c6e717c
md"""
[1] Kaipio, J., & Somersalo, E. (2006). Statistical and computational inverse problems. Springer Science & Business Media.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ColorVectorSpace = "c3611d14-8923-5661-9e6a-0046d554d3a4"
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
ImageFiltering = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
ImageIO = "82e4d734-157c-48bb-816b-45c225c6df19"
ImageShow = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
StatsPlots = "f3b207a7-027a-5e70-b257-86293d7955fd"
TestImages = "5e47fb64-e119-507b-a336-dd2b206d9990"

[compat]
ColorVectorSpace = "~0.11.0"
Colors = "~0.13.0"
Distributions = "~0.25.113"
FileIO = "~1.16.6"
HypertextLiteral = "~0.9.5"
ImageFiltering = "~0.7.9"
ImageIO = "~0.6.9"
ImageShow = "~0.3.8"
Images = "~0.26.1"
LaTeXStrings = "~1.4.0"
Plots = "~1.40.7"
PlutoUI = "~0.7.23"
Statistics = "~1.11.1"
StatsBase = "~0.34.3"
StatsPlots = "~0.15.7"
TestImages = "~1.9.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "8b40a704aa821c7ab7038216dcbe57169de54d18"

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
git-tree-sha1 = "50c3c56a52972d78e8be9fd135bfb91c9574c140"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.1.1"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
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

[[deps.Arpack]]
deps = ["Arpack_jll", "Libdl", "LinearAlgebra", "Logging"]
git-tree-sha1 = "9b9b347613394885fd1c8c7729bfc60528faa436"
uuid = "7d9fca2a-8960-54d3-9f78-7d1dccf2cb97"
version = "0.5.4"

[[deps.Arpack_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "OpenBLAS_jll", "Pkg"]
git-tree-sha1 = "5ba6c757e8feccf03a1554dfaf3e26b3cfc7fd5e"
uuid = "68821587-b530-5797-8361-c406ea357684"
version = "3.5.1+1"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra"]
git-tree-sha1 = "017fcb757f8e921fb44ee063a7aafe5f89b86dd1"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.18.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = "CUDSS"
    ArrayInterfaceChainRulesCoreExt = "ChainRulesCore"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
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
git-tree-sha1 = "16351be62963a67ac4083f748fdb3cca58bfd52f"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.7"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "35abeca13bc0425cff9e59e229d971f5231323bf"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+3"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CPUSummary]]
deps = ["CpuId", "IfElse", "PrecompileTools", "Static"]
git-tree-sha1 = "5a97e67919535d6841172016c9530fd69494e5ec"
uuid = "2a0fbf3d-bb9c-48f3-b0a9-814d99fd7ab9"
version = "0.2.6"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "009060c9a6168704143100f36ab08f06c2af4642"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.2+1"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "3e4b134270b372f2ed4d4d0e936aabaefc1802bc"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.25.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CloseOpenIntervals]]
deps = ["Static", "StaticArrayInterface"]
git-tree-sha1 = "05ba0d07cd4fd8b7a39541e31a7b0254704ea581"
uuid = "fb6a15b2-703c-40df-9091-08a04967cfa9"
version = "0.1.13"

[[deps.Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "Random", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "9ebb045901e9bbf58767a9f34ff89831ed711aae"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.15.7"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "bce6804e5e6044c6daab27bb533d1295e4a2e759"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.6"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "c785dfb1b3bfddd1da557e861b919819b82bbe5b"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.27.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "c7acce7a7e1078a20a285211dd73cd3941a871d6"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.0"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "64e15186f0aa277e174aa81798f7eb8598e0157e"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.0"

[[deps.CommonWorldInvalidations]]
git-tree-sha1 = "ae52d1c52048455e85a387fbee9be553ec2b68d0"
uuid = "f70d9fcc-98c5-4d4a-abd7-e4cdeebd8ca8"
version = "1.0.0"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
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
git-tree-sha1 = "f36e5e8fdffcb5646ea5da81495a5a7566005127"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.3"

[[deps.ConstructionBase]]
git-tree-sha1 = "76219f1ed5771adbb096743bff43fb5fdd4c1157"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.8"
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
git-tree-sha1 = "f9d7112bfff8a19a3a4ea4e03a8e6a91fe8456bf"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.3"

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
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fc173b380865f70627d7dd1190dc2fce6cc105af"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.14.10+0"

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

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "4b138e4643b577ccf355377c2bc70fa975af25de"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.115"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

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
git-tree-sha1 = "f42a5b1e20e009a43c3646635ed81a9fcaccb287"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.4+2"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "53ebe7511fa11d33bec688a9178fac4e49eeee00"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.2"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "4820348781ae578893311153d69049a93d05f39d"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.8.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "5cf2433259aa3985046792e2afc01fcec076b549"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+2"

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

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "6a70198746448456524cb442b8af316927ff3e1a"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.13.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "21fac3c77d7b5a9fc03b0ec503aa1a6392c34d2b"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.15.0+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "786e968a8d2fb167f2e4880baba62e0e26bd8e4e"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.3+1"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "846f7026a9decf3679419122b49f8a1fdb48d2d5"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.16+0"

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
git-tree-sha1 = "8e2d86e06ceb4580110d9e716be26658effc5bfd"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.8"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "da121cbdc95b065da07fbb93638367737969693f"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.8+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "43ba3d3c82c18d88471cfd2924931658838c9d8f"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.0+4"

[[deps.Giflib_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7141135f9073f135e68c5ee8df44fb0fb80689b8"
uuid = "59f7168a-df46-5410-90c8-f2779963d0ec"
version = "5.2.2+1"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "b0036b392358c80d2d2124746c2bf3d48d457938"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.82.4+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "a641238db938fff9b2f60d08ed9030387daf428c"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.3"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "01979f9b37367603e2848ea225918a3b3861b606"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+1"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "1dc470db8b1131cfc7fb4c115de89fe391b9e780"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.12.0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "c67b33b085f6e2faf8bf79a61962e7339a81129c"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.15"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "55c53be97790242c29031e5cd45e8ac296dadda3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.0+0"

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

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "b1c2585431c382e3fe5805874bda6aea90a95de9"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.25"

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
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

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
git-tree-sha1 = "33cb509839cc4011beb45bde2316e64344b0f92b"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.9"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs", "WebP"]
git-tree-sha1 = "696144904b76e1ca433b886b4e7edd067d76cbf7"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.9"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "c5c5478ae8d944c63d6de961b19e6d3324812c35"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.4.0"

[[deps.ImageMagick_jll]]
deps = ["Artifacts", "Ghostscript_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "OpenJpeg_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fa01c98985be12e5d75301c4527fff2c46fa3e0e"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "7.1.1+1"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "2a81c3897be6fbcde0802a0ebe6796d0562f63ec"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.10"

[[deps.ImageMorphology]]
deps = ["DataStructures", "ImageCore", "LinearAlgebra", "LoopVectorization", "OffsetArrays", "Requires", "TiledIteration"]
git-tree-sha1 = "6f0a801136cb9c229aebea0df296cdcd471dbcd1"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.4.5"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "LazyModules", "OffsetArrays", "PrecompileTools", "Statistics"]
git-tree-sha1 = "783b70725ed326340adf225be4889906c96b8fd1"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.7"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "b217d9ded4a95052ffc09acc41ab781f7f72c7ba"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.8.3"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "3b5344bcdbdc11ad58f3b1956709b5b9345355de"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.8"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "e0884bdf01bbbb111aea77c348368a86fb4b5ab6"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.10.1"

[[deps.Images]]
deps = ["Base64", "FileIO", "Graphics", "ImageAxes", "ImageBase", "ImageBinarization", "ImageContrastAdjustment", "ImageCore", "ImageCorners", "ImageDistances", "ImageFiltering", "ImageIO", "ImageMagick", "ImageMetadata", "ImageMorphology", "ImageQualityIndexes", "ImageSegmentation", "ImageShow", "ImageTransformations", "IndirectArrays", "IntegralArrays", "Random", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "TiledIteration"]
git-tree-sha1 = "12fdd617c7fe25dc4a6cc804d657cc4b2230302b"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.26.1"

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
git-tree-sha1 = "10bd689145d2c3b2a9844005d01087cc1194e79e"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2024.2.1+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "88a101217d7cb38a7b481ccd50d21876e1d1b0e0"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.15.1"
weakdeps = ["Unitful"]

    [deps.Interpolations.extensions]
    InterpolationsUnitfulExt = "Unitful"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "PrecompileTools", "Requires", "TranscodingStreams"]
git-tree-sha1 = "f1a1c1037af2a4541ea186b26b0c0e7eeaad232b"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.5.10"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "71b48d857e86bf7a1838c4736545699974ce79a2"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.9"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "a007feb38b422fbdab534406aeca1b86823cb4d6"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "fa6d0bcff8583bac20f1ffa708c3913ca605c611"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.5"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3447a92280ecaad1bd93d3fce3d408b6cfff8913"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.0+1"

[[deps.KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "7d703202e65efa1369de1279c162b915e245eed1"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.9"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "170b660facf5df5de098d866564877e119141cbd"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.2+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "78211fb6cbc872f77cad3fc0b6cf647d923f4929"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "16e6ec700154e8004dba90b4aec376f68905d104"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.2+2"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "ce5f5621cac23a86011836badfedf664a612cee4"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.5"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "27ecae93dd25ee0909666e6835051dd684cc035e"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+2"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "8be878062e0ffa2c3f67bb58a595375eda5de80b"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.11.0+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "ff3b4b9d35de638936a525ecd36e86a8bb919d11"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "dc4e8d10d4c6c11bf8d52dfd7213c09863c38cd5"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.51.0+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "61dfdba58e585066d8bce214c5a51eaa0539f269"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d841749621f4dcf0ddc26a27d1f6484dfc37659a"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.40.2+1"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "9d630b7fb0be32eeb5e8da515f5e8a26deb457fe"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.2+1"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LittleCMS_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg"]
git-tree-sha1 = "110897e7db2d6836be22c18bffd9422218ee6284"
uuid = "d3a379c0-f9a3-5b72-a4c0-6bf4d2e8af0f"
version = "2.12.0+0"

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

[[deps.LoopVectorization]]
deps = ["ArrayInterface", "CPUSummary", "CloseOpenIntervals", "DocStringExtensions", "HostCPUFeatures", "IfElse", "LayoutPointers", "LinearAlgebra", "OffsetArrays", "PolyesterWeave", "PrecompileTools", "SIMDTypes", "SLEEFPirates", "Static", "StaticArrayInterface", "ThreadingUtilities", "UnPack", "VectorizationBase"]
git-tree-sha1 = "8084c25a250e00ae427a379a5b607e7aed96a2dd"
uuid = "bdcacae8-1622-11e9-2a5c-532679323890"
version = "0.12.171"

    [deps.LoopVectorization.extensions]
    ForwardDiffExt = ["ChainRulesCore", "ForwardDiff"]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.LoopVectorization.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "oneTBB_jll"]
git-tree-sha1 = "f046ccd0c6db2832a9f639e2c669c6fe867e5f4f"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2024.2.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

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
git-tree-sha1 = "e9650bea7f91c3397eb9ae6377343963a22bf5b8"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.8.0"

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

[[deps.MultivariateStats]]
deps = ["Arpack", "Distributions", "LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI", "StatsBase"]
git-tree-sha1 = "816620e3aac93e5b5359e4fdaf23ca4525b00ddf"
uuid = "6f286f6a-111f-5878-ab1e-185364afe411"
version = "0.10.3"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "8a3271d8309285f4db73b4f662b1b290c715e85e"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.21"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Observables]]
git-tree-sha1 = "7438a59546cf62428fc9d1bc94729146d37a7225"
uuid = "510215fc-4207-5dde-b226-833fc4488ee2"
version = "0.5.5"

[[deps.OffsetArrays]]
git-tree-sha1 = "5e1897147d1ff8d98883cda2be2187dcf57d8f0c"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.15.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libtiff_jll", "LittleCMS_jll", "Pkg", "libpng_jll"]
git-tree-sha1 = "76374b6e7f632c130e78100b166e5a48464256f8"
uuid = "643b3616-a352-519d-856d-80112ee9badc"
version = "2.4.0+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "38cb508d080d21dc1128f7fb04f20387ed4c0af4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.3"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ad31332567b189f508a3ea8957a2640b1147ab00"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.23+1"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "418e63d434f5ca12b188bbb287dfbe10a5af1da4"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+1"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6703a85cb3781bd5909d48730a67205f3f31a575"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.3+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "12f1439c4f986bb868acda6ea33ebc78e19b95ad"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.7.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "949347156c25054de2db3b166c52ac4728cbad65"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.31"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "67186a2bc9a90f9f85ff3cc8277868961fb57cbd"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.3"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ed6834e95bd326c52d5675b4181386dfbe885afb"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.55.5+0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "35621f10a7531bc8fa58f74610b1bfb70a3cfc6b"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.43.4+0"

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
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "f202a1ca4f6e165238d8175df63a7e26a51e04dc"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.7"

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
deps = ["AbstractPlutoDingetjes", "Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "5152abbdab6488d5eec6a01029ca6697dff4ec8f"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.23"

[[deps.PolyesterWeave]]
deps = ["BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "Static", "ThreadingUtilities"]
git-tree-sha1 = "645bed98cd47f72f67316fd42fc47dee771aefcd"
uuid = "1d0040c9-8b98-4ee7-8388-3f51789ca0ad"
version = "0.2.2"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "OrderedCollections", "RecipesBase", "Requires", "Setfield", "SparseArrays"]
git-tree-sha1 = "adc25dbd4d13f148f3256b6d4743fe7e63a71c4a"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "4.0.12"

    [deps.Polynomials.extensions]
    PolynomialsChainRulesCoreExt = "ChainRulesCore"
    PolynomialsFFTWExt = "FFTW"
    PolynomialsMakieCoreExt = "MakieCore"
    PolynomialsMutableArithmeticsExt = "MutableArithmetics"

    [deps.Polynomials.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    FFTW = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
    MakieCore = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
    MutableArithmetics = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "8f6bc219586aef8baf0ff9a5fe16ee9c70cb65e4"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.10.2"

[[deps.PtrArrays]]
git-tree-sha1 = "77a42d78b6a92df47ab37e177b2deac405e1c88f"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.2.1"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "8b3fc30bc0390abdce15f8822c889f669baed73d"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.1"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "cda3b045cf9ef07a08ad46731f5a3165e56cf3da"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.1"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

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
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "852bd0f55565a9e973fcfee83a84413270224dc4"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.8.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

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
git-tree-sha1 = "52af86e35dd1b177d051b12681e1c581f53c281b"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.7.0"

[[deps.SIMDTypes]]
git-tree-sha1 = "330289636fb8107c5f32088d2741e9fd7a061a5c"
uuid = "94e857df-77ce-4151-89e5-788b33177be4"
version = "0.1.0"

[[deps.SLEEFPirates]]
deps = ["IfElse", "Static", "VectorizationBase"]
git-tree-sha1 = "456f610ca2fbd1c14f5fcf31c6bfadc55e7d66e0"
uuid = "476501e8-09a2-5ece-8869-fb82de89a1fa"
version = "0.6.43"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "712fb0231ee6f9120e005ccd56297abbc053e7e0"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.8"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

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
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.SimpleWeightedGraphs]]
deps = ["Graphs", "LinearAlgebra", "Markdown", "SparseArrays"]
git-tree-sha1 = "4b33e0e081a825dbfaf314decf58fa47e53d6acb"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.4.0"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "2da10356e31327c7096832eb9cd86307a50b1eb6"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "64cca0c26b4f31ba18f13f6c12af7c85f478cfde"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.5.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "83e6cce8324d49dfaf9ef059227f91ed4441a8e5"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.2"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.Static]]
deps = ["CommonWorldInvalidations", "IfElse", "PrecompileTools"]
git-tree-sha1 = "87d51a3ee9a4b0d2fe054bdd3fc2436258db2603"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "1.1.1"

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
git-tree-sha1 = "47091a0340a675c738b1304b58161f3b0839d454"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.10"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

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
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "29321314c920c26684834965ec2ce0dacc9cf8e5"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.4"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "b423576adc27097764a90e163157bcfc9acf0f46"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.2"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StatsPlots]]
deps = ["AbstractFFTs", "Clustering", "DataStructures", "Distributions", "Interpolations", "KernelDensity", "LinearAlgebra", "MultivariateStats", "NaNMath", "Observables", "Plots", "RecipesBase", "RecipesPipeline", "Reexport", "StatsBase", "TableOperations", "Tables", "Widgets"]
git-tree-sha1 = "3b1dcbf62e469a67f6733ae493401e53d92ff543"
uuid = "f3b207a7-027a-5e70-b257-86293d7955fd"
version = "0.15.7"

[[deps.StringDistances]]
deps = ["Distances", "StatsAPI"]
git-tree-sha1 = "5b2ca70b099f91e54d98064d5caf5cc9b541ad06"
uuid = "88034a9c-02f8-509d-84a9-84ec65e18404"
version = "0.11.3"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableOperations]]
deps = ["SentinelArrays", "Tables", "Test"]
git-tree-sha1 = "e383c87cf2a1dc41fa30c093b2a19877c83e1bc1"
uuid = "ab02a1b2-a7df-11e8-156e-fb1833f50b87"
version = "1.2.0"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "598cd7c1f68d1e205689b1c2fe65a9f85846f297"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.0"

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
git-tree-sha1 = "fc32a2c7972e2829f34cf7ef10bbcb11c9b0a54c"
uuid = "5e47fb64-e119-507b-a336-dd2b206d9990"
version = "1.9.0"

[[deps.ThreadingUtilities]]
deps = ["ManualMemory"]
git-tree-sha1 = "eda08f7e9818eb53661b3deb74e3159460dfbc27"
uuid = "8290d209-cae3-49c0-8002-c8c24d57dab5"
version = "0.5.2"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "3c0faa42f2bd3c6d994b06286bba2328eae34027"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.11.2"

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
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

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
git-tree-sha1 = "01915bfcd62be15329c9a07235447a89d588327c"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.21.1"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "975c354fcd5f7e1ddcc1f1a23e6e091d99e99bc8"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.4"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "4ab62a49f1d8d9548a1c8d1a75e5f55cf196f64e"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.71"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "85c7811eddec9e7f22615371c3cc81a504c508ee"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+2"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "5db3e9d307d32baba7067b13fc7b5aa6edd4a19a"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.36.0+0"

[[deps.WebP]]
deps = ["CEnum", "ColorTypes", "FileIO", "FixedPointNumbers", "ImageCore", "libwebp_jll"]
git-tree-sha1 = "aa1ca3c47f119fbdae8770c29820e5e6119b83f2"
uuid = "e3aaa7dc-3e4b-44e0-be63-ffb868ccd7c1"
version = "0.1.3"

[[deps.Widgets]]
deps = ["Colors", "Dates", "Observables", "OrderedCollections"]
git-tree-sha1 = "e9aeb174f95385de31e70bd15fa066a505ea82b9"
uuid = "cc8bc4a8-27d6-5769-a93b-9d913e69aa62"
version = "0.6.7"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c1a7aa6219628fcd757dede0ca95e245c5cd9511"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "1.0.0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "a2fccc6559132927d4c5dc183e3e01048c6dcbd6"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.5+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "7d1671acbe47ac88e981868a078bd6b4e27c5191"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.42+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "ff1fdd02e71717c7418deb1c42f487529d0b9574"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+2"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7966eb654d74306e553ce28b9aea17969fc1966c"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+2"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "807c226eaf3651e7b2c468f687ac788291f9a89b"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.3+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6a0d3b4248b01faa44509c5ea363881d3ad3f5eb"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+2"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "fb3f116a4efb81aecf8c415e9423869c6ee0f21f"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+2"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "6fcc21d5aea1a0b7cce6cab3e62246abd1949b86"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.0+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "984b313b049c89739075b8e2a94407076de17449"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.2+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a1a7eaf6c3b5b05cb903e35e8372049b107ac729"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.5+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "b6f664b7b2f6a39689d822a6300b14df4668f0f4"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.4+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a490c6212a0e90d2d55111ac956f7c4fa9c277a6"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+1"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "9c7539767c23ed0db32fd50916d8f5807ee11af8"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+2"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4678b3c5ee394ae6422c415b231b8015c85542f"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.0+2"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "dbc53e4cf7701c6c7047c51e17d6e64df55dca94"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+1"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "ab2221d309eda71020cdda67a973aa582aa85d69"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+1"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "26ded386f85de26df35524639e525c2018f68ddd"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+2"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7dc5adc3f9bfb9b091b7952f4f6048b7e37acafc"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.6+2"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6e50f145003024df4f5cb96c7fce79466741d601"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.56.3+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1827acba325fdcdf1d2647fc8d5301dd9ba43a9d"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.9.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e17c115d55c5fbb7e52ebedb427a0dca79d4484e"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.2+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a22cf860a7d27e4f3498a0fe0811a7957badb38"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.3+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "9c42636e3205e555e5785e902387be0061e7efc1"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.44+1"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "80c5ae2c7b5163441018f4666b179f1ffca194c1"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+2"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "490376214c4721cdaca654041f635213c6165cb3"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+2"

[[deps.libwebp_jll]]
deps = ["Artifacts", "Giflib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libglvnd_jll", "Libtiff_jll", "libpng_jll"]
git-tree-sha1 = "ccbb625a89ec6195856a50aa2b668a5c08712c94"
uuid = "c5f90fcd-3b7e-5836-afba-fc50a0988cb2"
version = "1.4.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.oneTBB_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7d0ea0f4895ef2f5cb83645fa689e52cb55cf493"
uuid = "1317d2d5-d96f-522e-a858-c73665f53c3e"
version = "2021.12.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "63406453ed9b33a0df95d570816d5366c92b7809"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+2"
"""

# ╔═╡ Cell order:
# ╟─20737ad0-c3e9-11ef-3c60-8951d72fb0dd
# ╟─7a337404-eb3a-4639-93f5-cd2c907b6422
# ╟─ff935e28-0b09-44c9-b80e-5f45fee7b400
# ╟─471bba4a-305a-4123-a824-bb1f91e32348
# ╟─3838a8ee-63f9-4f41-85f3-502603433098
# ╠═7f0d9d18-2286-4a0c-8f3b-14eec26a1a31
# ╠═dd989a69-1961-4fe0-98e5-2698a852d8e2
# ╟─993aff42-0eb3-4cd1-9d99-333d5a2d2669
# ╟─6ef479c7-e440-4e1f-8425-263288d152e8
# ╟─2fffc9c6-1585-4a0b-b99e-353611d01551
# ╟─4235ee49-5e71-476b-b32b-c790f029720d
# ╟─e0c13e70-41b5-439b-91ed-620adda4587d
# ╟─7405c1ba-0dad-437e-a907-60b44e47bf80
# ╠═ed6953b4-744c-4dbb-8ac3-69c506972554
# ╟─f32ad76c-7222-4ea5-b14d-c26978b60ab3
# ╟─9955f70c-6636-4b95-b774-feaa57a6a8f5
# ╟─716cbf70-eee8-41ee-a735-06068498dd7a
# ╟─e60ab5d6-f40e-4250-9b15-4f521c652472
# ╟─22257c37-d113-4ebb-b392-8d4886dea5ca
# ╟─68650463-6f3b-4193-a2db-b85bf5532482
# ╟─c05726ab-0ef1-40d7-96a9-64372f964b11
# ╟─da908f22-4f24-4768-bd58-1c07baf48506
# ╟─498b73ea-757e-4d5c-852f-20d0e8f4e105
# ╟─c217bbc0-03e2-41d2-b382-77df0a3d9108
# ╟─9468060a-3f5a-42ef-b5dc-8acecb6d0934
# ╟─8beb041e-60a1-4f42-bbbd-3db56c36dc6e
# ╟─81f38acc-4944-4b40-9f8a-83bb47ae63b5
# ╟─9255bd4e-c2ed-4d31-b6be-d74c452e1d69
# ╠═f6c7c4d9-f096-435d-a8bd-f275700d0bc2
# ╠═d6e429b4-5b3a-4642-ad7c-74acc57cb016
# ╠═0a9ac857-92ab-4d99-b600-2c9f100444c1
# ╟─0ebba0e0-dd44-4e5c-9293-d9620e9c192f
# ╟─f2c4ee61-2d0a-4612-93d1-0cfd3b176e72
# ╟─58624620-c6ae-4235-b3fb-5ce90610308f
# ╟─4c7b7434-edb0-4925-a07f-a7e68ab205e0
# ╠═c6664ddb-8a11-4129-87b7-6e40a18fedd0
# ╠═526c3a2f-a985-4933-ac19-58b11488fde0
# ╟─f54f2815-23d2-4967-a78b-adef2e0a578d
# ╠═632f0ec5-e149-4965-9d1c-0d4cd48b7574
# ╠═d2dc41fb-7211-4d62-b138-847412b951b4
# ╟─27cf6249-d18f-422f-bede-569cb22d101c
# ╟─b43e75ab-4b11-4add-bb80-4c053086e07b
# ╟─0fbbc63b-1cae-4200-b0a6-ef00ec8e5169
# ╟─b844e8b4-df96-422d-9466-7903082e5498
# ╠═9609181b-e749-4e65-9e6f-5bff49231527
# ╟─28532792-37df-40d5-81a8-0b61694171ae
# ╠═d25c9f96-c97c-49d1-a657-f7746bd58e61
# ╟─22445287-af01-4a2a-99b4-9a46c510ad8b
# ╟─f84b8b24-251a-4f33-a724-0481b257a1a4
# ╟─2cb6f484-a392-405c-8a17-1c75f56b96fa
# ╠═a7724f6d-5b36-4993-9982-627a73d41243
# ╠═6afed8e7-49e9-4a73-8aee-795e15deaba0
# ╟─0770dd5d-f843-4b3a-bf46-847b467ef9ff
# ╟─5690a382-23ef-4b13-9daa-d8ab45870ad7
# ╟─991edf6d-e61a-4a10-a1f4-d98e9014e756
# ╟─c4ac11fd-99fd-4315-8698-1c6216af4eb1
# ╠═f9d0918b-78aa-4836-87fe-ced9d9e91239
# ╠═50a9c393-6fb5-447c-add6-08bd622e950c
# ╟─37266eb1-d5dc-4bef-b31d-7f967c88df66
# ╟─c1db2105-49ab-4768-86d2-cf10ac1abf97
# ╟─1333f1d1-0516-470e-bda6-3e11b8f76e8a
# ╟─264f4e99-4173-4ce1-80db-0e6eef38695f
# ╟─5014f95d-4222-411c-a481-0fcd8755c220
# ╟─b62391fc-feaf-477d-9243-9af33610b60e
# ╟─6791a7c5-fef6-4f93-848c-dfb4ac441092
# ╟─daf569d1-f5e0-4422-aa08-d1b06d8e8073
# ╠═45594130-a939-4673-b69c-cf82a816799e
# ╟─4d79fbd1-47b6-47f5-8814-c60b722dbbbb
# ╟─e4bba822-23bf-4fef-b1e5-2178c6e6821b
# ╟─b7e279ad-4400-4013-a363-2bbc104913b7
# ╟─f68d17e2-719d-4d58-807c-041bc2c44602
# ╟─b1070518-aacc-44f5-ad26-52fa4c1c6107
# ╟─b5839619-5456-4215-a682-9d87c6095e86
# ╟─85f4c493-63e1-42ce-b6b5-eaa0cdc52bce
# ╟─05489b85-4612-4498-b57d-7f6ab3d5e960
# ╟─2a5beb83-1635-4ed3-8a8c-1e27e157b0f0
# ╟─88357769-7764-4354-bf1a-86980b345c7a
# ╟─c81938a2-7720-4b2c-a620-9d82189b8e0f
# ╠═578af934-0c6e-424c-88c1-7f8c69c5b881
# ╟─d61b8630-83ef-4743-981a-bed47ed5bd79
# ╟─3acdef8b-ea7f-4e0e-bea4-86e951450788
# ╟─d6c2bc4e-c624-4475-ae16-7105703f25b8
# ╟─5b1ff33a-4754-4a5b-8123-5aceb4b52cca
# ╠═dee9b6f8-43d1-4ee8-8c67-c423ee6263bd
# ╟─d92230f4-7922-4e0b-9cf1-b9bc808bc4f1
# ╟─d627e42e-20f1-428c-a9a7-f8ddb4d3395d
# ╟─fcd1857a-22c2-498c-9842-db4b87405c4d
# ╟─526bdc20-e0c8-4b05-a5d1-6f409f338c38
# ╟─960aa457-7913-46d9-913d-cabe186ed71d
# ╟─5d7aabf3-927d-4540-9611-4dd8c6deb194
# ╠═8407e0e7-2722-4371-b4c2-1b25f6284d60
# ╠═0da5c31e-b334-4eb4-a911-fdddc2fe32a5
# ╟─e675a394-02d4-49af-aff8-56636d2d2d79
# ╟─ec368cbb-49ea-45db-838c-56b461396dee
# ╟─05b8fb8d-2d94-416f-98ff-808145fac041
# ╟─cecd20e5-5b7e-4061-92d0-dff450931a96
# ╟─3d19f24e-2990-4da6-b5a2-58ea8c6e717c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
