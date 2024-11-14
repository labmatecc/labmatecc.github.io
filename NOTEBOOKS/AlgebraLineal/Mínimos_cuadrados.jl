### A Pluto.jl notebook ###
# v0.19.39

using Markdown
using InteractiveUtils

# ╔═╡ 020a4153-bcfe-4be3-a72c-0a5a40f23416
using PlutoUI

# ╔═╡ b02f4a16-7a15-4520-a540-dde4f3876d1d
begin
	using LinearAlgebra, GLMakie
	using Colors, ColorVectorSpace, ImageShow, FileIO, ImageIO
end

# ╔═╡ c9f06b65-74a2-4b8d-8b27-c580a02d25e6
PlutoUI.TableOfContents(title="Mínimos cuadrados", aside=true)

# ╔═╡ b81c330f-dcf7-4dfe-9b87-5cd802dde242
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**.

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ cd328cd6-eee3-402a-b04d-1b72db08bb18
md"""**Este cuaderno está basado en actividades del curso Modelos Matemáticos de la Universidad Nacional de Colombia, sede Bogotá, dictado por el profesor Jorge Mauricio Ruiz en 2023-2.**

Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo."""

# ╔═╡ d732b26f-f0ec-47ca-9383-9a4930c444ed
md"""Usaremos las siguientes librerías:"""

# ╔═╡ 0d636a16-354a-4580-aaff-2be57f10781b
md"""# Introducción"""

# ╔═╡ 64e2e390-bbc0-11ee-02c2-6f5e15ce2274
md"""El problema de mínimos cuadrados se desea resolver para encontrar las soluciones a un sistema de ecuaciones sobredeterminado. Este sistema se puede escribir de forma matricial de la siguiente forma, $A x = b$, con $A\in\mathcal{M}_{n,m}(\mathbb{R})$, esto es, 

$\begin{equation}
\begin{bmatrix}
    a_{11} & a_{12} & \ldots & a_{1n} \\
    a_{21} & a_{22} & \ldots & a_{2n} \\
    \vdots & \vdots & \ddots & \vdots \\
    a_{m1} & a_{m2} & \ldots & a_{mn}
\end{bmatrix}\begin{bmatrix}
x_0\\
x_1\\
\vdots\\
x_n
\end{bmatrix}
= 
\begin{bmatrix}
b_1\\
b_2\\
\vdots\\
b_m
\end{bmatrix}
\end{equation}$
"""

# ╔═╡ 4eeb1395-45ba-405f-a53d-85897ecc2472
md"""El método de mínimos cuadrados consiste en modificar el problema de manera que no sea necesario que la ecuación matricial $Ax=b$ se satisfaga. En cambio, se busca un vector $x^*$ en $\mathbb{R}^n$, tal que $Ax^*$ sea tan cercano a $b$ como sea posible. Si $W$ es el espacio generado por las columnas de $A$, se tiene que el vector en $W$ más cercano a $b$ es $\text{proy}_W b$. Es decir, $\|b - w\|$, para $w$ en $W$, se minimiza cuando $w = \text{proy}_W b$. En consecuencia, si encontramos $x^*$ tal que $Ax^* = \text{proy}_W b$, estamos seguros de que $\|b - Ax^*\|$ será lo más pequeña posible. Y como $b - \text{proy}_W b = b - Ax^*$ es ortogonal a todo vector en $W$. Esto implica que $b - Ax^*$ es ortogonal a cada columna de $A$.  En términos de la formulación matricial, esto se expresa como

$Ax^*=b$
luego,

$A^TAx^*=A^Tb.$
De aquí que $x^*$ es una solución para

$A^TAx=A^Tb$

Cualquier solución de este sistema se conoce como solución por mínimos cuadrados.
"""

# ╔═╡ 2bf31546-c2b0-4768-b47c-e71700fb205c
md"""**Teorema:**
Si $A$ es una matriz de tamaño $m \times n$ (con $n<m$) tal que $\text{rango } A = n$, entonces $A^TA$ es no singular y el sistema lineal $Ax = b$ tiene una única solución por mínimos cuadrados, dada por

$x^* = (A^TA)^{-1}A^Tb.$

Es decir, el sistema normal de ecuaciones tiene una única solución.
"""

# ╔═╡ 157e4703-1f0b-409d-a031-a6b40da58697
md"""*Ejemplo:*

Determinemos la solución por mínimos cuadrados de $Ax=b$, donde:

$A=\begin{bmatrix}
    1 & 2 & 4 & 5 \\
    1 & 4 & 5 & 6 \\
    1 & 4 & 6 & 8 \\
    7 & 50 & 2 & 5 \\
    75 & 5 & 9 & 3 \\
\end{bmatrix}
\quad\quad\quad b=\begin{bmatrix}
    0\\
    3\\
    4\\
    10\\
    0\\
\end{bmatrix}$"""

# ╔═╡ fa95acb9-1d1f-4a09-b066-ba0612774745
A₁ = [1 2 4 5; 1 4 5 6; 1 4 6 8; 7 50 2 5; 75 5 9 3]

# ╔═╡ 3f5d3f6f-042b-4e6a-b94a-18e47497b93b
b₁ = [0; 3; 4; 10; 0]

# ╔═╡ ec7ebb9a-4c47-4c63-a654-7cfccd8e3b39
md"""Note que el rango de $A$ es $4$ que coincide con $n$."""

# ╔═╡ 2723ef6c-8e52-4d35-a44e-efd50b74bd6f
rank(A₁)

# ╔═╡ 1234e1eb-f1e1-4ffb-bfa1-dabe0e4e9184
md"""Por tanto, la solución por mínimos cuadrados es única, y esta dada por:"""

# ╔═╡ 3fb61103-6abb-4e32-9781-618e479117fb
xsol₁ = inv(A₁'*A₁)*A₁'*b₁

# ╔═╡ 02c1a646-844a-4c0d-80fc-828506cee796
md"""En Julia, la solución de mínimos cuadrados está integrada en el operador de backslash $(\textbackslash)$. Por lo tanto, si estamos interesados en obtener la solución de un sistema lineal sobredeterminado para un lado derecho dado, simplemente necesitamos realizar: $x = A\textbackslash b$. Observe:"""

# ╔═╡ 10ca8a0f-e6e5-437c-a226-ce2659100d47
x₁ = A₁\b₁

# ╔═╡ 52da8e95-c2bc-4d7d-921c-3b4a6c6f67b5
md"""# Ajuste por mínimos cuadrados"""

# ╔═╡ 87599952-8da8-409a-b94e-534425a82d08
md"""El ajuste por mínimos cuadrados es comúnmente utilizado en regresión lineal, donde se busca modelar la relación entre una variable independiente y una variable dependiente. Este método proporciona una manera robusta y eficiente de estimar los parámetros del modelo."""

# ╔═╡ bd6ab1c5-42c6-4479-affb-da84da0575e6
md"""## Ejemplo ajuste polinomial

Este método, diseñado para calcular la aproximación polinómica por mínimos cuadrados para un conjunto de puntos dado, se puede generalizar fácilmente para abordar el problema de encontrar un polinomio de grado específico que se ajuste de manera óptima a los datos proporcionados.

Supongamos que se nos dan $n$ puntos $(x_1, y_1), (x_2, y_2), ..., (x_n, y_n)$, donde al menos $m + 1$ de los $x_i$ son distintos. Queremos construir un modelo matemático de la forma

$y = a_m x^m + a_{m-1} x^{m-1} + \ldots + a_1 x + a_0, \quad m \leq n - 1,$

que se ajuste de la mejor manera posible a estos datos. Debido a que algunos de los $n$ puntos de datos no coinciden exactamente con la gráfica del polinomio de mínimos cuadrados, tenemos

$y_i = a_m x_i^m + a_{m-1} x_i^{m-1} + \ldots + a_1 x_i + a_0 + d_i, \quad i = 1, 2, \ldots, n.$

Si definimos el vector $b$ como

$b = \begin{bmatrix} y_1 \\ y_2 \\ \vdots \\ y_n \end{bmatrix}$

y escribimos las $n$ ecuaciones anteriores como la ecuación matricial $b = Ax + d$, donde

$A = \begin{bmatrix} x_1^m & x_1^{m-1} & \ldots & 1 \\ x_2^m & x_2^{m-1} & \ldots & 1 \\ \vdots & \vdots & \ddots & \vdots \\ x_n^m & x_n^{m-1} & \ldots & 1 \end{bmatrix}, \quad x = \begin{bmatrix} a_m \\ a_{m-1} \\ \vdots \\ a_0 \end{bmatrix}, \quad d = \begin{bmatrix} d_1 \\ d_2 \\ \vdots \\ d_n \end{bmatrix}$

entonces, una solución del sistema normal $A^TAx = A^Tb$ proporciona una solución por mínimos cuadrados de $Ax = b$. Con esta solución, podemos garantizar que $\|d\| = \|b - Ax\|$ se minimiza, ya que $d$ se acerca al vector nulo.
"""

# ╔═╡ 68fb33db-7f68-4ab5-bb03-c0dd919091de
md""" *Ejemplo:*

Consideremos los siguientes datos:

| $x_i$ | $y_i$|
| -------- | -------- |
| 1 | 0.5 |
| 1.5 | 0.85 |
| 2 | 1.2 |
| 2.5 | 1.05 |
| 3 | 0.7 |
| 3.5 | -0.2 |

Grafiquemos estos datos:
"""

# ╔═╡ 6e95ca33-6e68-422e-99a2-53dabb333f03
begin
	x_i = [1, 1.5, 2, 2.5, 3, 3.5]
	y_i = [0.5, 0.85, 1.2, 1.05, 0.7, -0.2]
	fig = Figure()
	ax = Axis(fig[1, 1])

	scatter!(ax, x_i, y_i, markersize=10, color=:blue, label="datos")
	fig
end

# ╔═╡ dafca4b3-ff96-4eba-9143-f59e9c8d6ae7
md"""Viendo la gráfica de los puntos, podemos sugerir ajustar los datos a un polinomio cuadrático

$y = a_2x^2+a_1x+a_0.$

Así, si evaluamos cada uno de los datos vamos a tener el siguiente sistema de ecuaciónes

$\begin{align*}
0.5 &= a_2(1)^2+a_1(1)+a_0\\
0.85 &= a_2(1.5)^2+a_1(1.5)+a_0\\
1.2 &= a_2(2)^2+a_1(2)+a_0\\
1.05 &= a_2(2.5)^2+a_1(2.5)+a_0\\
0.7 &= a_2(3)^2+a_1(3)+a_0\\
-0.2 &= a_2(3.5)^2+a_1(3.5)+a_0\\
\end{align*}$

lo que implica el siguiente sistema matricial $Ax=b$, donde:
$A =\begin{bmatrix}
1^2 & 1 & 1 \\
(1.5)^2 & 1.5 & 1 \\
2^2 & 2 & 1 \\
(2.5)^2 & 2.5 & 1 \\
3^2 & 3 & 1 \\
(3.5)^2 & 3.5 & 1 \\
\end{bmatrix}, x = \begin{bmatrix}
a_2 \\
a_1 \\
a_0 \\
\end{bmatrix},b = \begin{bmatrix}
0.5 \\
0.85 \\
1.2 \\
1.05 \\
0.7 \\
-0.2 \\
\end{bmatrix}.$

Resolvamos esto con mínimos cuadrados.
"""

# ╔═╡ dec4e152-10c4-4364-8f19-f3f383c6678f
A₂ = [x_i.^2 x_i ones(length(x_i))] #definimos A

# ╔═╡ dd7a5f4e-3763-4d5e-8c99-b5786acf79f2
b₂ = y_i #Definimos b

# ╔═╡ 64cd5de6-9be8-4a98-aa92-dd732811a9e6
x₂ = A₂\b₂ #Resolvemos el sistema

# ╔═╡ 61285f8b-b306-40b6-bdfb-ed7f4bc5f7d3
println("Por tanto, el polinomio cuadrático que ajusta los datos es: ", x₂[1], "x^2 + ", x₂[2], "x + ", x₂[3])

# ╔═╡ 5a72baac-2d77-407d-9322-a46b99a44c8c
md"""Visualicemos la gráfica de este junto a los datos."""

# ╔═╡ cc7369b7-d0bb-4e63-9402-bf8aa7b4dc93
let
	fig = Figure()
	ax = Axis(fig[1, 1])

	scatter!(ax, x_i, y_i, markersize=10, color=:blue, label="datos")

	xx = range(1, 3.5, length=10000)
	polinomial(x) = x₂[1]*x.^2 .+ x₂[2]*x .+ x₂[3]

	lines!(ax, xx, polinomial(xx), label="Ajuste")
	fig
end

# ╔═╡ d8180bd6-8a0d-4647-a084-366705f2a4d7
md"""## Ajuste por ecuaciones cuadráticas"""

# ╔═╡ 005e3d8f-b411-4088-936e-59473fb00f6d
md"""El ajuste se puede realizar no solo con funciones como cuadráticas, exponenciales, etc, sino también con ecuaciones cuadráticas en las variables $x$ e $y$, estás son de la siguiente forma:

$a'x^2+2b'xy+c'y^2+d'x+e'y+f'=0,$
donde $a',b',c',d',e'$ y $f'$ son números reales. La gráfica de la ecuación anterior es una sección cónica, se llama así ya que se obtiene al intersecar un plano con un cono circular recto de dos hojas, ver la siguiente Figura."""

# ╔═╡ 925a3293-94a3-4e25-b0af-4d57f87812f0
begin
	url = "https://upload.wikimedia.org/wikipedia/commons/c/cc/TypesOfConicSections.jpg"	
	fname = download(url)
	imag = load(fname)
end

# ╔═╡ 222ce78d-40d2-4c6a-b692-322c680b90bc
md"""$\texttt{Figura 1. Secciones cónicas. Imagen tomada de Wikipedia.}$"""

# ╔═╡ abc2a459-9dd8-4cfe-9c51-82d493574da2
md"""Una formulación alternativa de la ecuación anterior es

$ax^2+bxy+cy^2+dx+ey=1,$
donde $a,b,c,d$ y $e$ son números reales, esto se obtiene normalizando la primera ecuación. El ajuste se realiza de la misma manera que en el caso del ajuste polinomial."""

# ╔═╡ ea01b6cc-e60f-406a-bf7c-323df4c3d44e
md"""*Ejemplo:*

Consideremos loa siguientes datos:

| $x_i$ | $y_i$|
| -------- | -------- |
| 4.78 | 0.37 |
| 3.98 | 0.66 |
| 2.65 | 0.1 |
| 1.44 | -0.83 |
| 0.96 | -2.08 |
| 1.48 | -2.5 |
| 2.74 | -2.28 |
| 3.92 | -1.6 |
| 4.78 | -0.49 |
| 4.81 | 0.18 |

Grafiquemos:
"""

# ╔═╡ 8c079ee9-dafc-4101-b6d2-8181fa9c0b76
begin
	x₃ = [4.78, 3.98, 2.65, 1.44, 0.96, 1.48, 2.74, 3.92, 4.78, 4.81]
	y₃ = [0.37, 0.66, 0.1, -0.83, -2.08, -2.5, -2.28, -1.6, -0.49, 0.18]
	fig1 = Figure()
	aax = Axis(fig1[1, 1])

	scatter!(aax, x₃, y₃, markersize=10, color=:blue, label="datos")
	fig1
end

# ╔═╡ 6bb2ec6f-0e17-45e7-b4dc-171c91426582
md"""De esto se observa que los datos se pueden ajustar mediante una elipse, usaremos la ecuación

$ax^2+bxy+cy^2+dx+ey=1,$
y buscaremos los parámetros $a,b,c,d$ y $e$. Al evaluar cada uno de los datos vamos a obtener el siguiente sistema de ecuaciones

$\begin{align*}
(4.78)^2a + (4.78)(0.37)b + (0.37)^2c + 4.78d + 0.37e &= 1 \\
(3.98)^2a + (3.98)(0.66)b + (0.66)^2c + 3.98d + 0.66e &= 1 \\
(2.65)^2a + (2.65)(0.1)b + (0.1)^2c + 2.65d + 0.1e &= 1 \\
(1.44)^2a + (1.44)(-0.83)b + (-0.83)^2c + 1.44d - 0.83e &= 1 \\
(0.96)^2a + (0.96)(-2.08)b + (-2.08)^2c + 0.96d - 2.08e &= 1 \\
(1.48)^2a + (1.48)(-2.5)b + (-2.5)^2c + 1.48d - 2.5e &= 1 \\
(2.74)^2a + (2.74)(-2.28)b + (-2.28)^2c + 2.74d - 2.28e &= 1 \\
(3.92)^2a + (3.92)(-1.6)b + (-1.6)^2c + 3.92d - 1.6e &= 1 \\
(4.78)^2a + (4.78)(-0.49)b + (-0.49)^2c + 4.78d - 0.49e &= 1 \\
(4.81)^2a + (4.81)(0.18)b + (0.18)^2c + 4.81d + 0.18e &= 1 \\
\end{align*}.$

Podemos escribir esto de manera matricial como $Ax=b$, donde

$A = \begin{bmatrix}
    (4.78)^2 & (4.78)(0.37) & (0.37)^2 & 4.78 & 0.37 \\
    (3.98)^2 & (3.98)(0.66) & (0.66)^2 & 3.98 & 0.66 \\
    (2.65)^2 & (2.65)(0.1) & (0.1)^2 & 2.65 & 0.1 \\
    (1.44)^2 & (1.44)(-0.83) & (-0.83)^2 & 1.44 & -0.83 \\
    (0.96)^2 & (0.96)(-2.08) & (-2.08)^2 & 0.96 & -2.08 \\
    (1.48)^2 & (1.48)(-2.5) & (-2.5)^2 & 1.48 & -2.5 \\
    (2.74)^2 & (2.74)(-2.28) & (-2.28)^2 & 2.74 & -2.28 \\
    (3.92)^2 & (3.92)(-1.6) & (-1.6)^2 & 3.92 & -1.6 \\
    (4.78)^2 & (4.78)(-0.49) & (-0.49)^2 & 4.78 & -0.49 \\
    (4.81)^2 & (4.81)(0.18) & (0.18)^2 & 4.81 & 0.18 \\
\end{bmatrix},
x = \begin{bmatrix}
    a \\
    b \\
    c \\
    d \\
    e \\
\end{bmatrix},
b = \begin{bmatrix}
    1 \\
    1 \\
    1 \\
    1 \\
    1 \\
    1 \\
    1 \\
    1 \\
    1 \\
    1 \\
\end{bmatrix}$
Resolvamos esto con ayuda de mínimos cuadrados."""

# ╔═╡ 94e3dd2e-857f-43ed-a5c9-3432f55a62c8
A₃ = [x₃.^2 x₃.*y₃ y₃.^2 x₃ y₃] #definimos A

# ╔═╡ efe8b15d-3248-4cee-ba43-a73f9e36dd4e
b₃ = ones(10) #definimos b

# ╔═╡ 7438fd4d-5517-454c-b84c-461285df4eb3
solution = A₃\b₃

# ╔═╡ 1e6eafa1-6509-4e9c-bf1e-72b770820ad0
md"""Esto último son los coeficientes de la ecuación. Realicemos la gráfica."""

# ╔═╡ c5760b4d-c784-4a70-8990-608a3edbe36b
begin
	fig2 = Figure()
	aaxx = Axis(fig2[1, 1])
	scatter!(aaxx, x₃, y₃, markersize=10, color=:blue, label="datos")

	X = LinRange(minimum(x₃),maximum(x₃),100)
	Y = LinRange(minimum(y₃),maximum(y₃),100)
	F = Array{Float64}(undef,100,100)
	for i ∈ 1:100, j ∈ 1:100
    	F[i,j] = solution[1]*X[i]^2 + solution[2]*X[i]*Y[j] + solution[3]*Y[j]^2 + solution[4]*X[i] + solution[5]*Y[j]
	end
	contour!(X, Y, F, linewidth=3, levels=[1], color=:green, label="Ajuste")
	fig2
end

# ╔═╡ c227c241-ce0b-4fe2-adba-8825648917fd
md"""# La genialidad de Da Vinci

En el contexto de la iconografía medieval, las figuras sagradas eran comúnmente representadas con una aureola circular que se ubicaba detrás de sus cabezas. Sin embargo, con el advenimiento del Renacimiento y el avance de la ciencia, estas aureolas evolucionaron de simples círculos a formas más elípticas y detalladas.

Un ejemplo notable es la pintura "El Bautismo de Cristo" realizada por Leonardo en 1472, en la cual se destaca su papel como alumno de Andrea del Verrocchio. En esta obra, Leonardo demostró su habilidad al agregar un ángel adicional en la parte izquierda de la composición, complementando así la visión artística de su maestro. Este detalle revela tanto la destreza técnica de Leonardo como su comprensión profunda de la narrativa visual y religiosa que caracterizaba a la época.

El objetivo del problema es determinar si el pupilo supera al maestro, en otras palabras, ¿Cuál de las aureolas es más cercana a una elipse perfecta?"""

# ╔═╡ ed0ea5b5-5150-4b85-8db0-7a1317d68db2
begin
	url1 = "https://github.com/labmatecc/labmatecc.github.io/blob/main/Im%C3%A1genes/angeles.jpg?raw=true"	
	fname1 = download(url1)
	imag1 = load(fname1)
end

# ╔═╡ 1dd7a5b7-50ea-49cc-a8f9-4fe9022b1547
md"""$\texttt{Figura 2. El Bautismo de Cristo. Imagen tomada de Wikipedia.}$"""

# ╔═╡ be342e4a-0086-4dc6-b623-7e0760265356
md"""Vamos a seleccionar $n$ puntos que delineen cada elipse."""

# ╔═╡ ca3f7f44-fa66-44e5-b34c-7bfda72edb19
n=20 #Seleccione n puntos de cada elipse

# ╔═╡ 8abf8ea9-5d7e-43d6-9f81-4714dd30c9d4
begin
	img1 = rotl90(imag1, 3)

	figx, Ax = image(img1)

	display(figx)
	lx= []
	ly=[]
	on(events(figx).mousebutton, priority=0) do event
    	if event.button == Mouse.left
        	x, y = mouseposition(Ax.scene)
			push!(lx,x)
			push!(ly,y)
    	end
	end
end

# ╔═╡ ced48584-9f65-4a7d-9549-7970b4a6115d
begin
	a1x = [lx[i] for i in 1:length(lx) if i % 2 == 0][1:n]
	a1y = [ly[i] for i in 1:length(ly) if i % 2 == 0][1:n]
	a2x = [lx[i] for i in 1:length(lx) if i % 2 == 0][n+1:2*n]
	a2y = [ly[i] for i in 1:length(ly) if i % 2 == 0][n+1:2*n]
	fig4 = Figure()
	Aax = Axis(fig4[1, 1])

	scatter!(Aax, a1x, a1y, markersize=10, color=:blue, label="datos")
	scatter!(Aax, a2x, a2y, markersize=10, color=:blue, label="datos")
	fig4
end

# ╔═╡ e2037336-3de2-477d-a6b3-f8d47d5b0562
md"""Ahora, plantearemos el problema que ajuste los datos a una elipse como un problema de mínimos cuadrados y determinaremos los parámetros de la elipse.

Tanto los puntos obtenidos de la aureola 1 (izquierda) como los de la aureola 2 (derecha) se desean ajustar a una elipse de la forma 

$ax^2+bxy+cy^2+dx+ey+f=0,$
esto es equivalente a considerar

$-\dfrac{ax^2+bxy+cy^2+dx+ey}{f}=\dfrac{-a}{f}x^2-\dfrac{b}{f}xy-\dfrac{c}{f}y^2-\dfrac{d}{f}x-\dfrac{e}{f}y=1.$
Así, debemos ajustar los puntos a la siguiente ecuación que define una elipse

$Ax^2+Bxy+Cy^2+Dx+Ey=1$
al evaluar los puntos de cada una de las tablas se obtiene el siguiente sistema de ecuaciones: 

$\left \{
    \begin{aligned}
      Ax_1^2+Bx_1y_1+Cy_1^2+Dx_1+Ey_1&=1,\\
      Ax_2^2+Bx_2y_2+Cy_2^2+Dx_2+Ey_2&=1,\\
      \vdots \hspace{2cm} &= \hspace{0.2cm}\vdots\\
      Ax_{22}^2+Bx_{22}y_{22}+Cy_{22}^2+Dx_{22}+Ey_{22}&=1,\\
    \end{aligned}
  \right .$
Estos sistemas se pueden escribir matricialmente como $Ac=b$, donde $A$ es de tamaño $22\times 5$, $b$ es el vector de tamaño $22\times 1$ y $c$ tiene tamaño $5\times 1.$

$\begin{pmatrix}
x_1^2 & x_1y_1 & y_1^2 & x_1 & y_1\\
x_2^2 & x_2y_2 & y_2^2 & x_2 & y_2\\
\vdots & \vdots & \vdots & \vdots & \vdots\\
x_{22}^2 & x_{22}y_{22} & y_{22}^2 & x_{22} & y_{22}\\
\end{pmatrix}
\begin{pmatrix}
A\\
B\\
C\\
D\\
E\\
\end{pmatrix}=\begin{pmatrix}
1\\
1\\
\vdots\\
1
\end{pmatrix}.$
Para hallar la solución a este problema en el sentido de mínimos cuadrados se definen las matrices $A1$ y $A2$ para la aureola 1 y la aureola 2, respectivamente."""

# ╔═╡ 5607de4d-baec-4e86-96a0-90b8c038ed30
begin
	#aureola 1
	A1 = [a1x.^2 a1x.*a1y a1y.^2 a1x a1y]; #Definimos la matriz A1
	A2 = [a2x.^2 a2x.*a2y a2y.^2 a2x a2y]; #Definimos la matriz A2

	#aureola 2
	b1 = ones(n); #Definimos el vector b1
	b2 = ones(n); #Definimos el vector b2
end

# ╔═╡ a108f864-bb92-405c-9de0-6dadd76e3eff
md"""Resolvemos el sistema matricial $Ax=b$ en el sentido de los mínimos cuadrados de la siguiente forma"""

# ╔═╡ e5afb156-c8f6-4310-8026-932b09b95cc2
x1 = A1\b1

# ╔═╡ 1d1b4639-08a3-43c3-b155-bbc2e3a9f4f1
x2 = A2\b2

# ╔═╡ 7107c68b-4eeb-4067-89e5-570fe8ecf79e
md"""De esta forma los parámetros de la elipse 1 son:"""

# ╔═╡ ceb7a964-4577-4716-8c44-21c055c051a1
println("A=", x1[1], "\nB=", x1[2], "\nC=", x1[3], "\nD=", x1[4], "\nE=", x1[5])

# ╔═╡ a42235b5-4663-46b2-9d46-d439ca53dac8
md"""Y, los parámetros de la elipse 2 son:"""

# ╔═╡ c8d4b02e-0dd9-456a-be1e-9eb1af1ce001
println("A=", x2[1], "\nB=", x2[2], "\nC=", x2[3], "\nD=", x2[4], "\nE=", x2[5])

# ╔═╡ 8159c518-24e5-4db1-8c02-614e3b52a193
let
	fig2 = Figure()
	aaxx = Axis(fig2[1, 1])
	scatter!(aaxx, a1x, a1y, markersize=10, color=:blue, label="datos")
	scatter!(aaxx, a2x, a2y, markersize=10, color=:blue, label="datos")

	X1 = LinRange(minimum(a1x),maximum(a1x),100)
	Y1 = LinRange(minimum(a1y),maximum(a1y),100)
	F1 = Array{Float64}(undef,100,100)
	for i ∈ 1:100, j ∈ 1:100
    	F1[i,j] = x1[1]*X1[i]^2 + x1[2]*X1[i]*Y1[j] + x1[3]*Y1[j]^2 + x1[4]*X1[i] + x1[5]*Y1[j]
	end
	contour!(X1, Y1, F1, linewidth=3, levels=[1], color=:green, label="Ajuste")

	X2 = LinRange(minimum(a2x),maximum(a2x),100)
	Y2 = LinRange(minimum(a2y),maximum(a2y),100)
	F2 = Array{Float64}(undef,100,100)
	for i ∈ 1:100, j ∈ 1:100
    	F2[i,j] = x2[1]*X2[i]^2 + x2[2]*X2[i]*Y2[j] + x2[3]*Y2[j]^2 + x2[4]*X2[i] + x2[5]*Y2[j]
	end
	contour!(X2, Y2, F2, linewidth=3, levels=[1], color=:green, label="Ajuste")
	fig2
end

# ╔═╡ 79b04142-c6e7-4189-b4f8-3250934045ae
md"""Ahora, para ver si el alumno supera al maestro vamos a calcular el error de ambos modelos usando la norma euclidiana $||b-Ax||_2$"""

# ╔═╡ 7c22c28d-4e93-4ee8-a9bb-f26eeee1a472
n1 = norm(b1-A1*x1) #Norma del primer modelo ||b1 - A1*c1||_2

# ╔═╡ 5c7b50d8-af99-4742-9462-6560ad628bb3
n2 = norm(b2-A2*x2) #Norma del segundo modelo ||b2 - A2*c2||_2

# ╔═╡ 52150af2-1352-4016-a355-e42e38977d96
begin
	if n1>n2
		print("El alumno no supero al maestro")
	else
		print("El alumno supero al maestro")
	end
end

# ╔═╡ d8b99b55-410d-4af9-af8c-d2ba6f89243b
md"""# Referencias

[1] Interactive Linear Algebra." (s.f.). Least Squares. Georgia Institute of Technology. Recuperado de https://textbooks.math.gatech.edu/ila/least-squares.html

[2] Boyd, S., & Vandenberghe, L. (2018). Introduction to Applied Linear Algebra: Vectors, Matrices, and Least Squares. Cambridge University Press.

[3] Boyd, S., & Vandenberghe, L. (2004). Convex Optimization. Cambridge University Press.

[4] Kolman, B., & Hill, D. R. (2006). Álgebra Lineal (8a ed.). Pearson."""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ColorVectorSpace = "c3611d14-8923-5661-9e6a-0046d554d3a4"
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
GLMakie = "e9467ef8-e4e7-5192-8a1a-b1aee30e663a"
ImageIO = "82e4d734-157c-48bb-816b-45c225c6df19"
ImageShow = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
ColorVectorSpace = "~0.10.0"
Colors = "~0.12.10"
FileIO = "~1.16.3"
GLMakie = "~0.9.10"
ImageIO = "~0.6.7"
ImageShow = "~0.3.8"
PlutoUI = "~0.7.59"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "c32cc438667f766efe2f98f3faa1f641b5a9bfd1"

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

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "6a55b747d1812e699320963ffde36f1ebdda4099"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.0.4"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.Animations]]
deps = ["Colors"]
git-tree-sha1 = "e81c509d2c8e49592413bfb0bb3b08150056c79d"
uuid = "27a7e980-b3e6-11e9-2bcd-0b925532e340"
version = "0.4.1"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Automa]]
deps = ["PrecompileTools", "TranscodingStreams"]
git-tree-sha1 = "588e0d680ad1d7201d4c6a804dcb1cd9cba79fbb"
uuid = "67c07d97-cdcb-5c2c-af73-a7f9c32a568b"
version = "1.0.3"

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

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CRC32c]]
uuid = "8bf52ea8-c179-5cab-976a-9e18b702a9bc"

[[deps.CRlibm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e329286945d0cfc04456972ea732551869af1cfc"
uuid = "4e9b3aee-d8a1-5a3d-ad8b-7d824db253f0"
version = "1.0.1+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a2f1c8c668c8e3cb4cca4e57a8efdb09067bb3fd"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.0+2"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "71acdbf594aab5bbb2cec89b208c41b4c411e49f"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.24.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.ColorBrewer]]
deps = ["Colors", "JSON", "Test"]
git-tree-sha1 = "61c5334f33d91e570e1d0c3eb5465835242582c4"
uuid = "a2cac450-b92f-5266-8821-25eda20663c8"
version = "0.4.0"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "4b270d6465eb21ae89b732182c20dc165f8bf9f2"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.25.0"

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
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "362a287c3aa50601b0bc359053d5c2468f0e7ce0"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.11"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "b1c55339b7c6c350ee89f2c1604299660525b248"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.15.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "260fd2400ed2dab602a7c15cf10c1933c59930a2"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.5"
weakdeps = ["IntervalSets", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

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

[[deps.DelaunayTriangulation]]
deps = ["EnumX", "ExactPredicates", "Random"]
git-tree-sha1 = "1755070db557ec2c37df2664c75600298b0c1cfc"
uuid = "927a84f5-c5f4-47a5-9785-b46e178433df"
version = "1.0.3"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "9c405847cc7ecda2dc921ccf18b47ca150d7317e"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.109"

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

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e3290f2d49e661fbd94046d7e3726ffcb2d41053"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.4+0"

[[deps.EnumX]]
git-tree-sha1 = "bdb1942cd4c45e3c678fd11569d5cccd80976237"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.4"

[[deps.ExactPredicates]]
deps = ["IntervalArithmetic", "Random", "StaticArrays"]
git-tree-sha1 = "b3f2ff58735b5f024c392fde763f29b057e4b025"
uuid = "429591f6-91af-11e9-00e2-59fbe8cec110"
version = "2.2.8"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c6317308b9dc757616f0b5cb379db10494443a7"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.2+0"

[[deps.Extents]]
git-tree-sha1 = "94997910aca72897524d2237c41eb852153b0f65"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.3"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "ab3f7e1819dba9434a3a5126510c8fda3a4e7000"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "6.1.1+0"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "4820348781ae578893311153d69049a93d05f39d"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.8.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "82d8afa92ecf4b52d78d869f038ebfb881267322"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.3"

[[deps.FilePaths]]
deps = ["FilePathsBase", "MacroTools", "Reexport", "Requires"]
git-tree-sha1 = "919d9412dbf53a2e6fe74af62a73ceed0bce0629"
uuid = "8fc22ac5-c921-52a6-82fd-178b2807b824"
version = "0.8.3"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "9f00e42f8d99fdde64d40c8ea5d14269a2e2c1aa"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.21"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "0653c0a2396a6da5bc4766c43041ef5fd3efbe57"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.11.0"
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
git-tree-sha1 = "db16beca600632c95fc8aca29890d83788dd8b23"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.96+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType]]
deps = ["CEnum", "FreeType2_jll"]
git-tree-sha1 = "907369da0f8e80728ab49c1c7e09327bf0d6d999"
uuid = "b38be410-82b0-50bf-ab77-7b57e271db43"
version = "4.1.1"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "5c1d8ae0efc6c2e7b1fc502cbe25def8f661b7bc"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.2+0"

[[deps.FreeTypeAbstraction]]
deps = ["ColorVectorSpace", "Colors", "FreeType", "GeometryBasics"]
git-tree-sha1 = "2493cdfd0740015955a8e46de4ef28f49460d8bc"
uuid = "663a7486-cb36-511b-a19d-713bb74d65c9"
version = "0.10.3"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1ed150b39aebcc805c26b93a8d0122c940f64ce2"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.14+0"

[[deps.GLFW]]
deps = ["GLFW_jll"]
git-tree-sha1 = "35dbc482f0967d8dceaa7ce007d16f9064072166"
uuid = "f7f18e0c-5ee9-5ccd-a5bf-e8befd85ed98"
version = "3.4.1"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "ff38ba61beff76b8f4acad8ab0c97ef73bb670cb"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.9+0"

[[deps.GLMakie]]
deps = ["ColorTypes", "Colors", "FileIO", "FixedPointNumbers", "FreeTypeAbstraction", "GLFW", "GeometryBasics", "LinearAlgebra", "Makie", "Markdown", "MeshIO", "ModernGL", "Observables", "PrecompileTools", "Printf", "ShaderAbstractions", "StaticArrays"]
git-tree-sha1 = "3ef8015aefacb449d183201714a9c32d86019acc"
uuid = "e9467ef8-e4e7-5192-8a1a-b1aee30e663a"
version = "0.9.11"

[[deps.GeoInterface]]
deps = ["Extents"]
git-tree-sha1 = "801aef8228f7f04972e596b09d4dba481807c913"
uuid = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"
version = "1.3.4"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "Extents", "GeoInterface", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "b62f2b2d76cee0d61a2ef2b3118cd2a3215d3134"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.11"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "7c82e6a6cd34e9d935e9aa4051b66c6ff3af59ba"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.80.2+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.GridLayoutBase]]
deps = ["GeometryBasics", "InteractiveUtils", "Observables"]
git-tree-sha1 = "6f93a83ca11346771a93bbde2bdad2f65b61498f"
uuid = "3955a311-db13-416c-9275-1d80ed98e5e9"
version = "0.10.2"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "f218fe3736ddf977e0e772bc9a586b2383da2685"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.23"

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

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "2e4520d67b0cef90865b3ef727594d2a58e0e1f8"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.11"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "eb49b82c172811fd2c86759fa0553a2221feb909"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.7"

[[deps.ImageCore]]
deps = ["ColorVectorSpace", "Colors", "FixedPointNumbers", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "PrecompileTools", "Reexport"]
git-tree-sha1 = "b2a7eaa169c13f5bcae8131a83bc30eff8f71be0"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.10.2"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "437abb322a41d527c197fa800455f79d414f0a3c"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.8"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "355e2b974f2e3212a75dfb60519de21361ad3cb7"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.9"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "3b5344bcdbdc11ad58f3b1956709b5b9345355de"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.8"

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

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be50fe8df3acbffa0274a744f1a99d29c45a57f4"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2024.1.0+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "88a101217d7cb38a7b481ccd50d21876e1d1b0e0"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.15.1"

    [deps.Interpolations.extensions]
    InterpolationsUnitfulExt = "Unitful"

    [deps.Interpolations.weakdeps]
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.IntervalArithmetic]]
deps = ["CRlibm_jll", "MacroTools", "RoundingEmulator"]
git-tree-sha1 = "433b0bb201cd76cb087b017e49244f10394ebe9c"
uuid = "d1acc4aa-44c8-5952-acd4-ba5d80a2a253"
version = "0.22.14"

    [deps.IntervalArithmetic.extensions]
    IntervalArithmeticDiffRulesExt = "DiffRules"
    IntervalArithmeticForwardDiffExt = "ForwardDiff"
    IntervalArithmeticRecipesBaseExt = "RecipesBase"

    [deps.IntervalArithmetic.weakdeps]
    DiffRules = "b552c78f-8df3-52c6-915a-8e097449b14b"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

    [deps.IntervalSets.weakdeps]
    Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.Isoband]]
deps = ["isoband_jll"]
git-tree-sha1 = "f9b6d97355599074dc867318950adaa6f9946137"
uuid = "f1662d9f-8043-43de-a69a-05efc1cc6ff4"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

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
git-tree-sha1 = "c84a835e1a09b289ffcd2271bf2a337bbdda6637"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.3+0"

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

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d986ce2d884d49126836ea94ed5bfb0f12679713"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "70c5da094887fd2cae843b8db33920bac4b6f07d"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.2+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

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

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "9fd170c4bbfd8b935fdc5f8b7aa33532c991a673"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.11+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fbb1f2bef882392312feb1ede3615ddc1e9b99ed"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.49.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0c4f9c4f1a50d8f35048fa0532dabbadf702f81e"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.40.1+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "5ee6203157c120d79034c748a2acba45b82b8807"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.1+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "a2d09619db4e765091ee5c6ffe8872849de0feea"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.28"

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

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "oneTBB_jll"]
git-tree-sha1 = "80b2833b56d466b3858d565adcd16a4a05f2089b"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2024.1.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Makie]]
deps = ["Animations", "Base64", "CRC32c", "ColorBrewer", "ColorSchemes", "ColorTypes", "Colors", "Contour", "DelaunayTriangulation", "Distributions", "DocStringExtensions", "Downloads", "FFMPEG_jll", "FileIO", "FilePaths", "FixedPointNumbers", "Format", "FreeType", "FreeTypeAbstraction", "GeometryBasics", "GridLayoutBase", "ImageIO", "InteractiveUtils", "IntervalSets", "Isoband", "KernelDensity", "LaTeXStrings", "LinearAlgebra", "MacroTools", "MakieCore", "Markdown", "MathTeXEngine", "Observables", "OffsetArrays", "Packing", "PlotUtils", "PolygonOps", "PrecompileTools", "Printf", "REPL", "Random", "RelocatableFolders", "Scratch", "ShaderAbstractions", "Showoff", "SignedDistanceFields", "SparseArrays", "Statistics", "StatsBase", "StatsFuns", "StructArrays", "TriplotBase", "UnicodeFun"]
git-tree-sha1 = "4d49c9ee830eec99d3e8de2425ff433ece7cc1bc"
uuid = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
version = "0.20.10"

[[deps.MakieCore]]
deps = ["Observables", "REPL"]
git-tree-sha1 = "248b7a4be0f92b497f7a331aed02c1e9a878f46b"
uuid = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
version = "0.7.3"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MathTeXEngine]]
deps = ["AbstractTrees", "Automa", "DataStructures", "FreeTypeAbstraction", "GeometryBasics", "LaTeXStrings", "REPL", "RelocatableFolders", "UnicodeFun"]
git-tree-sha1 = "96ca8a313eb6437db5ffe946c457a401bbb8ce1d"
uuid = "0a4f8689-d25c-4efe-a92b-7142dfc1aa53"
version = "0.5.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.MeshIO]]
deps = ["ColorTypes", "FileIO", "GeometryBasics", "Printf"]
git-tree-sha1 = "8c26ab950860dfca6767f2bbd90fdf1e8ddc678b"
uuid = "7269a6da-0436-5bbc-96c2-40638cbb6118"
version = "0.4.11"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.ModernGL]]
deps = ["Libdl"]
git-tree-sha1 = "b76ea40b5c0f45790ae09492712dd326208c28b2"
uuid = "66fc600b-dfda-50eb-8b99-91cfa97b1301"
version = "1.1.7"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

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
git-tree-sha1 = "e64b4f5ea6b7389f6f046d13d4896a8f9c1ba71e"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.14.0"
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
version = "0.3.23+4"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "8292dd5c8a38257111ada2174000a33745b06d4e"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.2.4+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a028ee3cb5641cccc4c24e90c36b0a4f7707bdf5"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.14+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

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

[[deps.Packing]]
deps = ["GeometryBasics"]
git-tree-sha1 = "ec3edfe723df33528e085e632414499f26650501"
uuid = "19eb6ba3-879d-56ad-ad62-d5c202156566"
version = "0.5.0"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "35621f10a7531bc8fa58f74610b1bfb70a3cfc6b"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.43.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "7b1a9df27f072ac4c9c7cbe5efb198489258d1f5"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.1"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ab55ee1510ad2af0ff674dbcced5e94921f867a9"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"

[[deps.PolygonOps]]
git-tree-sha1 = "77b3d3605fc1cd0b42d95eba87dfcd2bf67d5ff6"
uuid = "647866c9-e3ac-4575-94e7-e3d426903924"
version = "0.1.2"

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

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "763a8ceb07833dd51bb9e3bbca372de32c0605ad"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.10.0"

[[deps.PtrArrays]]
git-tree-sha1 = "f011fbb92c4d401059b2212c05c0601b70f8b759"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.2.0"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9b23c31e76e333e6fb4c1595ae6afa74966a729e"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.9.4"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

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
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "f65dcb5fa46aee0cf9ed6274ccbd597adc49aa7b"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.1"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d483cd324ce5cf5d61b77930f0bbd6cb61927d21"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.4.2+0"

[[deps.RoundingEmulator]]
git-tree-sha1 = "40b9edad2e5287e05bd413a38f61a8ff55b9557b"
uuid = "5eaf0fd0-dfba-4ccb-bf02-d820a40db705"
version = "0.2.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "2803cab51702db743f3fda07dd1745aadfbf43bd"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.5.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.ShaderAbstractions]]
deps = ["ColorTypes", "FixedPointNumbers", "GeometryBasics", "LinearAlgebra", "Observables", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "79123bc60c5507f035e6d1d9e563bb2971954ec8"
uuid = "65257c39-d410-5151-9873-9b3e5be5013e"
version = "0.4.1"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SignedDistanceFields]]
deps = ["Random", "Statistics", "Test"]
git-tree-sha1 = "d263a08ec505853a5ff1c1ebde2070419e3f28e9"
uuid = "73760f76-fbc4-59ce-8f25-708e95d2df96"
version = "0.4.0"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "2da10356e31327c7096832eb9cd86307a50b1eb6"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2f5d4697f21388cbe1ff299430dd169ef97d7e14"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.4.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "6e00379a24597be4ae1ee6b2d882e15392040132"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.5"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "5cf7606d6cef84b543b483848d4ae08ad9832b21"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.3"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "cef0472124fab0695b58ca35a77c6fb942fdab8a"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.1"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StructArrays]]
deps = ["ConstructionBase", "DataAPI", "Tables"]
git-tree-sha1 = "f4dc295e983502292c4c3f951dbb4e985e35b3be"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.18"

    [deps.StructArrays.extensions]
    StructArraysAdaptExt = "Adapt"
    StructArraysGPUArraysCoreExt = "GPUArraysCore"
    StructArraysSparseArraysExt = "SparseArrays"
    StructArraysStaticArraysExt = "StaticArrays"

    [deps.StructArrays.weakdeps]
    Adapt = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "cb76cf677714c095e535e3501ac7954732aeea2d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.11.1"

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

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "bc7fd5c91041f44636b2c134041f7e5263ce58ae"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.10.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "a947ea21087caba0a798c5e494d0bb78e3a1a3a0"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.9"
weakdeps = ["Random", "Test"]

    [deps.TranscodingStreams.extensions]
    TestExt = ["Test", "Random"]

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.TriplotBase]]
git-tree-sha1 = "4d4ed7f294cda19382ff7de4c137d24d16adc89b"
uuid = "981d1d27-644d-49a2-9326-4793e63143c3"
version = "0.1.0"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c1a7aa6219628fcd757dede0ca95e245c5cd9511"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "1.0.0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "52ff2af32e591541550bd753c0da8b9bc92bb9d9"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.12.7+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "d2d1a5c49fae4ba39983f63de6afcbea47194e85"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "47e45cd78224c53109495b3e324df0c37bb61fbe"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+0"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.isoband_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51b5eeb3f98367157a7a12a1fb0aa5328946c03c"
uuid = "9a68df92-36a6-505f-a73e-abb412b6bfb4"
version = "0.2.3+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1827acba325fdcdf1d2647fc8d5301dd9ba43a9d"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.9.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d7015d2e18a5fd9a4f47de711837e980519781a4"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.43+1"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "d4f63314c8aa1e48cd22aa0c17ed76cd1ae48c3c"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

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
"""

# ╔═╡ Cell order:
# ╟─020a4153-bcfe-4be3-a72c-0a5a40f23416
# ╟─c9f06b65-74a2-4b8d-8b27-c580a02d25e6
# ╟─b81c330f-dcf7-4dfe-9b87-5cd802dde242
# ╟─cd328cd6-eee3-402a-b04d-1b72db08bb18
# ╟─d732b26f-f0ec-47ca-9383-9a4930c444ed
# ╠═b02f4a16-7a15-4520-a540-dde4f3876d1d
# ╟─0d636a16-354a-4580-aaff-2be57f10781b
# ╟─64e2e390-bbc0-11ee-02c2-6f5e15ce2274
# ╟─4eeb1395-45ba-405f-a53d-85897ecc2472
# ╟─2bf31546-c2b0-4768-b47c-e71700fb205c
# ╟─157e4703-1f0b-409d-a031-a6b40da58697
# ╠═fa95acb9-1d1f-4a09-b066-ba0612774745
# ╠═3f5d3f6f-042b-4e6a-b94a-18e47497b93b
# ╟─ec7ebb9a-4c47-4c63-a654-7cfccd8e3b39
# ╠═2723ef6c-8e52-4d35-a44e-efd50b74bd6f
# ╟─1234e1eb-f1e1-4ffb-bfa1-dabe0e4e9184
# ╠═3fb61103-6abb-4e32-9781-618e479117fb
# ╟─02c1a646-844a-4c0d-80fc-828506cee796
# ╠═10ca8a0f-e6e5-437c-a226-ce2659100d47
# ╟─52da8e95-c2bc-4d7d-921c-3b4a6c6f67b5
# ╟─87599952-8da8-409a-b94e-534425a82d08
# ╟─bd6ab1c5-42c6-4479-affb-da84da0575e6
# ╟─68fb33db-7f68-4ab5-bb03-c0dd919091de
# ╠═6e95ca33-6e68-422e-99a2-53dabb333f03
# ╟─dafca4b3-ff96-4eba-9143-f59e9c8d6ae7
# ╠═dec4e152-10c4-4364-8f19-f3f383c6678f
# ╠═dd7a5f4e-3763-4d5e-8c99-b5786acf79f2
# ╠═64cd5de6-9be8-4a98-aa92-dd732811a9e6
# ╟─61285f8b-b306-40b6-bdfb-ed7f4bc5f7d3
# ╟─5a72baac-2d77-407d-9322-a46b99a44c8c
# ╟─cc7369b7-d0bb-4e63-9402-bf8aa7b4dc93
# ╟─d8180bd6-8a0d-4647-a084-366705f2a4d7
# ╟─005e3d8f-b411-4088-936e-59473fb00f6d
# ╟─925a3293-94a3-4e25-b0af-4d57f87812f0
# ╟─222ce78d-40d2-4c6a-b692-322c680b90bc
# ╟─abc2a459-9dd8-4cfe-9c51-82d493574da2
# ╟─ea01b6cc-e60f-406a-bf7c-323df4c3d44e
# ╟─8c079ee9-dafc-4101-b6d2-8181fa9c0b76
# ╟─6bb2ec6f-0e17-45e7-b4dc-171c91426582
# ╠═94e3dd2e-857f-43ed-a5c9-3432f55a62c8
# ╠═efe8b15d-3248-4cee-ba43-a73f9e36dd4e
# ╠═7438fd4d-5517-454c-b84c-461285df4eb3
# ╟─1e6eafa1-6509-4e9c-bf1e-72b770820ad0
# ╟─c5760b4d-c784-4a70-8990-608a3edbe36b
# ╟─c227c241-ce0b-4fe2-adba-8825648917fd
# ╟─ed0ea5b5-5150-4b85-8db0-7a1317d68db2
# ╟─1dd7a5b7-50ea-49cc-a8f9-4fe9022b1547
# ╟─be342e4a-0086-4dc6-b623-7e0760265356
# ╠═ca3f7f44-fa66-44e5-b34c-7bfda72edb19
# ╠═8abf8ea9-5d7e-43d6-9f81-4714dd30c9d4
# ╟─ced48584-9f65-4a7d-9549-7970b4a6115d
# ╟─e2037336-3de2-477d-a6b3-f8d47d5b0562
# ╠═5607de4d-baec-4e86-96a0-90b8c038ed30
# ╟─a108f864-bb92-405c-9de0-6dadd76e3eff
# ╠═e5afb156-c8f6-4310-8026-932b09b95cc2
# ╠═1d1b4639-08a3-43c3-b155-bbc2e3a9f4f1
# ╟─7107c68b-4eeb-4067-89e5-570fe8ecf79e
# ╟─ceb7a964-4577-4716-8c44-21c055c051a1
# ╟─a42235b5-4663-46b2-9d46-d439ca53dac8
# ╟─c8d4b02e-0dd9-456a-be1e-9eb1af1ce001
# ╟─8159c518-24e5-4db1-8c02-614e3b52a193
# ╟─79b04142-c6e7-4189-b4f8-3250934045ae
# ╠═7c22c28d-4e93-4ee8-a9bb-f26eeee1a472
# ╠═5c7b50d8-af99-4742-9462-6560ad628bb3
# ╟─52150af2-1352-4016-a355-e42e38977d96
# ╟─d8b99b55-410d-4af9-af8c-d2ba6f89243b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
