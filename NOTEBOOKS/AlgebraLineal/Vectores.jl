### A Pluto.jl notebook ###
# v0.19.39

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ c25927c0-9bb6-11ee-0858-3b487d9c079c
using PlutoUI

# ╔═╡ 26d4b07b-4427-4198-9d0e-e1ef0ca02372
using LinearAlgebra

# ╔═╡ 1b19c238-0208-422c-af30-1e50fc36632d
using Plots

# ╔═╡ 4f8e6c97-84a8-44e6-9bc0-43801b66c354
PlutoUI.TableOfContents(title="Vectores", aside=true)

# ╔═╡ 11190bac-6570-402e-b68f-17cb565b3b2f
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**.

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 35154b6f-eca3-4c71-a79a-460476370343
md"""Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo."""

# ╔═╡ 45d2c626-bb68-4c23-a9a9-5c2d825f4d00
md"""# Introducción a los vectores"""

# ╔═╡ c29f4362-6c2c-43af-a3f3-1aa5254eaf38
md"""Un vector se representa como un conjunto ordenado de números, conocidos como componentes, dispuestos en una cierta estructura (por ejemplo, una fila o una columna). De manera formal:

**Vector fila:** Un vector fila de $n$ componentes se define como un conjunto ordenado de $n$ números escritos de la siguiente manera:

$[x_1, x_2, \ldots, x_n].$ Donde $x_i$ con $i=1, 2, \ldots, n$ representa un elemento individual del vector.

**Vector columna:** Un vector columna de $n$ componentes implica la organización secuencial de $n$ números, presentados de la siguiente manera:

$\begin{bmatrix}
x_1 \\
x_2 \\
\vdots \\
x_n
\end{bmatrix}.$ Cada $x_i$, donde $i=1, 2, \ldots, n$, denota un elemento individual dentro del vector.

En las definiciones anteriores, $x_1$ se denomina la primera componente del vector, $x_2$ es la segunda componente, y así sucesivamente. En términos generales, $x_k$ se denomina la $k$-ésima componente del vector.

Para más detalles de esto ver $[3]$."""

# ╔═╡ a9c0fc03-973c-4b9c-ae51-1db9cecab9c4
md"""Ahora, cargamos la librería de álgebra lineal de Julia, que nos ayudará a visualizar algunos ejemplos y propiedades de los vectores."""

# ╔═╡ 6950bf0a-d3f3-41cc-beba-54accb8c496d
md"""En Julia, los vectores se representan mediante objetos de tipo Array unidimensional. Un vector se construye proporcionando la lista de elementos dentro de corchetes cuadrados, con los elementos separados por comas o punto y coma.  Para asignar un nombre al arreglo, se emplea el operador de asignación $=$."""

# ╔═╡ 00e4677e-765c-4f98-bd5f-8f959827b786
md"""Definamos un par de ejemplos."""

# ╔═╡ e2962a20-aed2-407d-bdd5-128a0ba72bf7
x₁ = [-3.4, 0.3, 3.5, -9.2, 84]

# ╔═╡ b78efeed-4e2c-492e-a75a-7dd466bf27a5
x₂ = [-3.4; 0.3; 3.5; -9.2; 84]

# ╔═╡ de6dae2a-43e7-4f2a-8f13-4116b131d2e4
md"""La función $\texttt{length}$ devuelve el tamaño (dimensión) del arreglo."""

# ╔═╡ efe10659-b1f9-428f-8f92-7c13c2266abb
length(x₁) #tamaño del vector x₁

# ╔═╡ 3c527dc7-b324-4de3-b5a9-2e2fb8cc316b
length(x₂) #tamaño del vector x₂

# ╔═╡ d73c06db-4389-4fc1-a843-0e5060eae6b0
md"""
Un vector puede considerarse como una matriz unidimensional y, por lo tanto, también puede representarse como una matriz $n\times 1$ (en caso de ser un vector columna), en el caso de Julia representan objetos distintos.

Algunas equivocaciones frecuentes incluyen omitir las comas o punto y coma entre las entradas y utilizar paréntesis en lugar de corchetes cuadrados. Estos errores pueden resultar en elementos que tienen sentido en Julia, pero no constituyen vectores. 

Observe los siguientes ejemplos:"""

# ╔═╡ f47021c0-b36b-4b4e-aee8-431f3fd8bd4f
a = [ 1 2 ]

# ╔═╡ eeec419b-3376-4fc4-97d0-34fe7463de1e
b = ( 1, 2 )

# ╔═╡ 736d7c9b-3344-4b96-8732-118832c8c936
c = [1, 2]

# ╔═╡ e1d49429-c8ca-4e48-87d9-9b379e8bd423
md"""La función $\texttt{typeof}$ devuelve el tipo de variable."""

# ╔═╡ 79618545-123b-435b-8b51-4ca1ef83aaf6
typeof(a)

# ╔═╡ 77460253-ef2b-4f8a-bbad-3c70697cd45e
typeof(b)

# ╔═╡ e345f402-3104-43f4-93a1-ca5387a01e90
typeof(c)

# ╔═╡ 69c1894e-312c-4715-9b82-fd04f389cad5
md"""Aquí, $a$ es una matriz de tamaño $1\times 2$, $b$ es una tupla o lista que consiste en dos escalares y $c$ es un vector."""

# ╔═╡ 65eef8e4-c669-4741-a55d-6a9b1ab5db96
md"""Por defecto, Julia genera vectores columna. Si se desea un vector fila, se puede crear inicialmente un vector columna y luego transponerlo. Este concepto será abordado de manera más detallada en secciones posteriores. Por ahora, presentaremos ejemplos de operaciones que pueden realizarse utilizando vectores columna."""

# ╔═╡ c5732cab-8147-41f4-a28c-5716357f8141
md"""Así, consideremos el siguiente vector de tamaño $5\times 1$ y veamos algunas cosas sobre él."""

# ╔═╡ 34d48642-ce86-4456-a400-a5b2bc9e464e
x = [7, 8, 9, 5, 10] #Construimos el vector

# ╔═╡ 8cae1796-ee6f-4f1c-bb99-968163feccd6
md"""El elemento $x_3$ del anterior vector es el siguiente

$\begin{bmatrix}
7 \\
8 \\
\textcolor{red}{9} \\
5 \\
10
\end{bmatrix}.$
Y lo podemos encontrar de la siguiente forma"""

# ╔═╡ 10ecfd04-e124-4bbf-bcac-1ca21aedf27a
x[3]

# ╔═╡ a2ed4fb0-8ef5-49e0-b769-61ee43e19dff
md"""El elemento $x_5$ 

$\begin{bmatrix}
7 \\
8 \\
9 \\
5 \\
\textcolor{red}{10}
\end{bmatrix}.$
Es el que se muestra a continuación"""

# ╔═╡ 2f9f6439-8253-4f07-a1b0-020ae70e0bba
x[5]

# ╔═╡ dcf91b6d-7e0a-49e8-a15b-865ba3037d83
md"""Así, para recuperar un elemento específico se hace mediante la expresión $x[i]$, donde $i$ es el índice deseado."""

# ╔═╡ 7b69f698-db81-48d8-99ed-6027bc13f5d0
md"""También podemos crear un slide que permite al usuario seleccionar un valor en un rango determinado y vincula ese valor a un elemento específico del vector x que llamamos x_i. En este caso, el slide va desde 1 hasta el tamaño del vector."""

# ╔═╡ 43b20f85-994f-4dd4-9115-5b221853d8ae
@bind x_i Slider(1:length(x), show_value=true)

# ╔═╡ 3af8cad4-8dd4-4971-a67f-c14b32aa06b5
md"""Y así con ayuda del slide, podemos acceder a cada entrada del vector."""

# ╔═╡ d9d6af91-4294-45d9-99c8-18ed9fd07cda
x[x_i]

# ╔═╡ e0a47b7a-f497-4c91-b76c-c44085feec7d
md"""Mediante la función $\texttt{end}$, podemos acceder al último elemento del vector, ya que esta función se relaciona con el último índice del vector."""

# ╔═╡ d9e53517-82f6-4343-9c0e-c482999ff49f
md"""Así, para el vector anterior:"""

# ╔═╡ 6510f906-955a-4b23-9e40-8c66571b3f51
x[end]

# ╔═╡ db4fa1f6-410b-4d6a-8c89-35faf12421bd
md"""Si de desea mostrar varios elementos, por ejemplo mostrar

$\begin{bmatrix}
7 \\
\textcolor{red}{8} \\
\textcolor{red}{9} \\
\textcolor{red}{5} \\
10
\end{bmatrix}.$
Se puede hacer de la siguiente forma"""

# ╔═╡ 7ac66c82-33e8-40d2-bcf5-7cf5fd297da7
x[2:4]

# ╔═╡ e03fe848-9628-4b67-b3be-151f7ae74418
md"""También es posible mostrar desde un elemento $i$ hasta el final. Por ejemplo, si queremos ver desde el segundo elemento del vector $x$ hasta el final: 

$\begin{bmatrix}
7 \\
\textcolor{red}{8} \\
\textcolor{red}{9} \\
\textcolor{red}{5} \\
\textcolor{red}{10}
\end{bmatrix},$
lo podemos hacer de la siguiente manera:"""

# ╔═╡ 3940da59-4574-46d9-b05d-8fe1f126448e
x[2:end]

# ╔═╡ b22f2acc-813d-4cf7-9fb4-b525957f0413
md"""También, podemos mostrar los elementos del arreglo en orden inverso. Por ejemplo, lo que acabamos de presentar se puede visualizar "hacia atrás" de la siguiente manera:"""

# ╔═╡ 98f76fe0-9d56-4806-9461-6cc5cc049a4f
x[end:-1:2]

# ╔═╡ b9796d13-6f6a-4e48-b215-0875c1da6f29
md"""O mostrar los elementos x[2:4] en orden inverso:"""

# ╔═╡ 4547fcff-3ebc-4971-959e-3e4d880a13fe
x[4:-1:2]

# ╔═╡ 0d58bc35-3f03-48ee-b89a-f8cb6fd1c1e3
md"""La comparación de igualdad entre vectores se realiza mediante el operador relacional $==$. Cuando se aplica a dos vectores (arreglos), digamos $a$ y $b$, en Julia, la expresión $a == b$ dará como resultado $\texttt{true}$ si ambos vectores tienen la misma longitud y sus elementos son idénticos. En caso contrario, la expresión resultará en $\texttt{false}$.

Por ejemplo, consideremos los siguientes vectores:
"""

# ╔═╡ 7e7f3474-7e6f-4fcb-bc68-9d5a837ccaad
begin
	x₄ = [2, 5, 8, 4.5];
	x₅ = [2, 5, 8, 4.5];
	x₆ = [2, 5.2, 8, 4.5];
end

# ╔═╡ 9440f06b-8893-434f-bfde-9a4cf4fde48a
x₄==x₅

# ╔═╡ 99e1c7c6-bdd7-401a-8a28-37afae304e7f
x₄==x₆

# ╔═╡ e2ca30b7-029c-4fdd-ad7b-1bfc951358cc
md"""Usando el operador $==$, observamos que los vectores $x_4$ y $x_5$ son iguales, mientras que $x_4$ y $x_6$ son distintos. Luego por transitividad, se tiene que $x_5$ y $x_6$ son distintos."""

# ╔═╡ 393c961b-b468-42d5-b2a5-9e66a6276240
md"""También, podemos comparar elemento a elemento si son iguales, con el operador $.==$, de la siguiente forma"""

# ╔═╡ 920a2b62-1f67-4782-974c-8812d4f8dd3b
x₄.==x₆

# ╔═╡ fac95099-3259-4987-82d4-08afe2a1e57d
md"""Lo anterior nos muestra que todas las componentes son iguales, salvo la segunda."""

# ╔═╡ 973bf704-adfd-41e0-a8e4-65cc00a52ca4
md"""Al igual que Julia hace distinciones entre arreglos, también hace una distinción entre el vector de un elemento [2.7] y el número 2.7, observe:"""

# ╔═╡ de50d2da-862b-4e6e-959b-ce7e976eb3a6
y₁ = [2.7]

# ╔═╡ 92c3ef42-6916-469a-931e-f02b79b3a32c
y₂ = 2.7

# ╔═╡ fb368f6f-43b2-4866-9b2a-c1b9260c8649
y₁==y₂ #comparación

# ╔═╡ 87e68876-1e95-44e5-9995-fdf0809326d3
md"""Pero podemos verificar la igualdad del primer elemento de $y_1$ y la variable $y_2$."""

# ╔═╡ d60d75c1-d257-449f-bc6e-4ababbf1d122
y₁[1]==y₂

# ╔═╡ 749f932e-8dcc-4728-878e-f16720b9ea04
md"""Un vector (columna) por bloques es un vector que está compuesto por bloques más pequeños en lugar de elementos individuales, es decir, un vector por bloques tiene subvectores (columna (bloques)) en lugar de elementos individuales.

Un vector por bloques generalmente se representa de la siguiente manera:

$v = \begin{bmatrix} v_{1}\\
v_2\\
\vdots\\
v_{n}\end{bmatrix}$

Donde cada $v_{j}$ es un vector (columna). 

De manera análoga se tiene la definición para un vector fila por bloques.

Veamos ahora un ejemplo de esto. Consideremos  

$z = \begin{bmatrix} z_{1}\\ z_{2} \\ z_{3} \end{bmatrix}$

Donde:

$z_{1} = \begin{bmatrix} 1\\ 1\\  2\end{bmatrix}, \quad
z_{2} = \begin{bmatrix} 2\\ 3 \end{bmatrix}, \quad
z_{3} = \begin{bmatrix} 5\\ 8\\ 13 \end{bmatrix}$

Implementemos esto, primero definimos los vectores $z_!, z_2$ y $z_3$
"""

# ╔═╡ 29bc7ad8-4281-4d23-8cdc-74a63ea58e8f
begin
	z₁ = [1,1,2]; 
	z₂ = [2,3];
	z₃ = [5,8,13];
end

# ╔═╡ 62e9b167-cb5a-47d1-866f-f2b1120adc0e
z = [z₁; z₂; z₃]

# ╔═╡ 478e5242-a18b-45df-b6c4-94cce14f0682
md"""Otra manera de ensamblar el vector es usando la función $\texttt{vcat}$. Esta función concatena los vectores de manera vertical."""

# ╔═╡ 71702ea2-553c-476a-a29e-987db155e522
vcat(z₁, z₂, z₃)

# ╔═╡ 5cc3ce6a-e755-4849-9be1-d647067e115d
md"""Una lista de n-vectores puede expresarse como $(\mathbf{v}_1, \mathbf{v}_2, \ldots, \mathbf{v}_n)$ o, como $[\mathbf{v}_1, \mathbf{v}_2, \ldots, \mathbf{v}_n]$. En Julia, existen diversas maneras de representar listas de vectores. Si proporcionamos los elementos de la lista, separándolos por comas y encerrándolos entre corchetes cuadrados, creamos un arreglo unidimensional de vectores. Por otro lado, al utilizar paréntesis como delimitadores, obtenemos una tupla o lista.
"""

# ╔═╡ 93078b0c-c68a-437a-8a61-1da0d0f54607
md"""Por ejemplo, consideremos los siguientes vectores"""

# ╔═╡ 5ccdcd5c-5b27-4302-bd74-5deb8dcfd0bb
begin
	x₇ = [1.0, 0]; 
	y₇ = [1.0,-1.0]; 
	z₇ = [0,1.0];
end

# ╔═╡ 7057ee8e-5b1d-46fc-8d9b-588f4aefc75b
list₁ = [x₇,y₇,z₇]

# ╔═╡ a66c8a36-fb17-412a-b75e-0031c0a428f7
list₂ = (x₇,y₇,z₇)

# ╔═╡ 214158b9-6e6e-477c-93f2-e92544fceb04
md"""Podemos acceder a los vectores de la misma forma que lo hicimos con los elementos de un vector, por ejemplo:"""

# ╔═╡ 01a73b87-21bf-4609-a649-5557b33e394b
list₁[2]

# ╔═╡ 63efff5c-17ce-465e-97fa-c6223677e65d
md"""O incluso acceder a un elemento de uno de los vectores del arreglo, de la siguiente forma"""

# ╔═╡ 7b1f26b5-c056-469a-96b9-aeeebed2fd36
list₁[2][1]

# ╔═╡ b9bf9c52-20b6-49c7-97ca-3054ec9934a8
md"""En Julia, la función $\texttt{rand(n)}$ genera un vector aleatorio de longitud $n$ con entradas entre 0 y 1. Cada vez que se llama o evalúa esta función, se obtiene un vector diferente."""

# ╔═╡ 10319b9c-488b-4c19-ad94-83d6aeeab81e
rand(8) #Vector aleatorio de tamaño 8

# ╔═╡ 4bb4bffc-cbf9-4f79-81d8-a2cde0f0cc8d
rand(3) #Vector aleatorio de tamaño 3

# ╔═╡ d233a853-04f2-4e43-8ab6-79e461079a8a
md"""# Tipos de vectores"""

# ╔═╡ 4f3ca58e-b404-4731-b04e-1c726bd949e5
md""" ### $\cdot$ Vector nulo
Un vector nulo es un vector cuyas componentes son todas iguales a cero. Un vector nulo de tamaño $n\times 1$ se representa como

$\mathbf{0} = \begin{bmatrix} 0\\
0\\
\vdots\\
0\end{bmatrix},$
donde hay $n$ elementos, y cada elemento es cero. Este es un vector columna nulo, para un vector fila la definición es la misma.

En Julia, un vector nulo de dimensión $n$ se crea utilizando $\texttt{zeros(n)}$.

Ejemplo: A continuación se genera un vector nulo de tamaño $3$.
"""

# ╔═╡ b60dd0bd-d397-4925-9917-8bbb79b0e29c
zeros(3) #Vector nulo

# ╔═╡ 0a60051c-a26f-4abb-aa7c-4972347ffdf1
md""" ### $\cdot$ Vectores canónicos

Para $1 \leq i \leq n$, el $i$-ésimo vector canónico $\mathbf{e}_i$ de tamaño $n\times 1$ es:

$\mathbf{e}_i = [0, 0, \ldots, 0, \underbrace{1}_{\text{i-ésima posición}}, 0, \ldots, 0]$

Estos vectores canónicos forman una base ortogonal estándar para $\mathbb{R}^n$ (esto se estudiará más adelante en el curso).


No hay una función incorporada en Julia para crear el $i$-ésimo vector canónico de longitud $n$. Pero con el siguiente código se puede crear el $i$-ésimo vector canónico, con $i = 2$ y $n = 4$."""

# ╔═╡ 38ad858d-6bf4-455d-886a-b257e962a3e6
begin
	i = 2; n = 4;
	ei = zeros(n); #Crea un vector de ceros
	ei[i] = 1; #Cambia la entrara i-ésima por 1
	ei
end

# ╔═╡ def16ddc-3710-41de-ad68-62b2642db717
md"""Aquí hay otra forma de crear vector mencionado."""

# ╔═╡ 72489742-7de3-4a0f-844b-ea4bac14d1e5
canonical(i,n) = [zeros(i-1); 1; zeros(n-i)] #Se establecen las entradas 1 a i-1 e i+1 a n como 0, y la entrada i-ésima como 1

# ╔═╡ 1801d0c8-77a6-4f08-a690-b784f84d2afe
canonical(2,4)

# ╔═╡ dabc76fa-0b1c-413e-8eac-720bd607bf83
md""" ### $\cdot$ Vector de unos
Es un vector cuyas componentes son todas iguales a 1, es decir, un vector de unos de tamaño $n\times 1$ se representa como

$\mathbf{1} = \begin{bmatrix} 1\\
1\\
\vdots\\
1\end{bmatrix},$
donde hay $n$ elementos, este vector se crea utilizando la función $\texttt{ones(n)}$.

Ejemplo: A continuación se genera un vector de unos de tamaño $6$.
"""

# ╔═╡ b7a7c23f-e4ca-4b8d-9da4-817fe6631575
ones(6)

# ╔═╡ 8cab06c5-8de0-4b65-8c80-f1e306e9df5a
md"""Para más detalle de los tipos de vectores, por favor consultar $[1, 3]$."""

# ╔═╡ 42411343-8eeb-4cab-adf3-cc4fa2f73e56
md"""# Gráficas de vectores 
Un paquete para crear gráficas en Julia es Plots.jl, lo importamos de la siguiente forma
"""

# ╔═╡ e86441e6-e225-4f05-bb7d-b3b92dced60b
md"""Consideremos el siguiente vector que tiene 48 elementos:"""

# ╔═╡ e76a140d-c5a8-4a96-977d-13bab9b7c443
t = [71, 71, 68, 69, 68, 69,68, 74, 77, 82, 85, 86, 88, 86, 85, 86, 84, 79, 77, 75, 73, 71, 70, 70, 69, 69, 69, 69, 67, 68, 68, 73, 76, 77, 82, 84, 84, 81, 80, 78, 79, 78, 73, 72, 70, 70, 68, 67];

# ╔═╡ 146f9bf8-cad2-4c38-adb8-3a4b13572c99
md"""Podemos graficar el vector de la siguiente manera:"""

# ╔═╡ 4df5b1d8-2d02-436b-86b6-585894b833ad
plot(t, seriestype=:scatter, legend = false, grid = true)

# ╔═╡ 3779aae5-dee3-4840-b3f9-9cf6009a38bd
md"""Consideremos ahora un vector de tamaño $m\times 1$, donde $m$ varia desde 1 hasta 50, generado de manera aleatoria."""

# ╔═╡ cd45633e-20a9-4df6-bcac-fd0da75d2a27
@bind m Slider(1:50, show_value=true)

# ╔═╡ 6829875c-c295-4495-bad8-09d83faebd58
s = rand(m)

# ╔═╡ 181cad7f-b5d5-4b99-b1c6-234dc8c0c071
md"""Realicemos la gráfica, para visualizar los datos."""

# ╔═╡ d43eb64b-da8b-434c-b72f-3d73d3c99736
plot(s, marker = :star, legend = false, grid = true)

# ╔═╡ 3c7ee2ab-3b8a-4678-962b-f3dfc7b6211f
md"""# Operaciones con vectores"""

# ╔═╡ 32e21a6a-a5a7-453a-b126-56df920d3827
md"""El material aquí presente fue tomado y adaptado de $[1, 2, 3]$."""

# ╔═╡ 3250c7cd-4091-40c8-9cae-5db185ff1d6c
md""" ### $\cdot$ Suma de vectores

La suma de dos vectores $u$ y $v$ de tamaño $n\times 1$ se realiza componente a componente y da como resultado otro vector de tamaño $n\times 1$. De la siguiente forma

$\begin{align}u+v &= \begin{bmatrix} u_{1}\\ u_{2}\\ \vdots \\ u_{n} \end{bmatrix}+\begin{bmatrix} v_{1}\\ v_{2}\\ \vdots \\ v_{n} \end{bmatrix}\\

&=\begin{bmatrix}  u_{1}+v_{1}\\  u_{2}+v_{2}\\ \vdots \\  u_{n}+v_{n} \end{bmatrix}\end{align}$

De manera análoga se tiene la suma de dos vectores de tamaño $1\times n$.
"""

# ╔═╡ cc5ae8e8-536b-4b45-91d2-3f65ed87c684
md"""Ejemplo: Consideremos dos vectores de tamaño $3\times 1$ y realicemos su suma:"""

# ╔═╡ 01b4070b-cc0e-4bcd-8346-c484036c3609
begin
	u₁ = [0, 7, 3];
	v₁ = [1, 2, 0];
end

# ╔═╡ 42033b73-6f49-41a5-9960-52262a5960b0
u₁+v₁ #Suma de vectores

# ╔═╡ 6a81b773-e4bf-4efe-a86a-1582066347de
md"""Mostremos otro ejemplo, generemos dos vectores aleatorios de tamaño $5\times 1$ y realicemos su resta."""

# ╔═╡ afac972f-5e88-4e3a-ab14-3273adbb3c76
begin
	u₂,v₂=rand(5),rand(5)
end

# ╔═╡ 8ee98e63-78b8-443c-9721-fe336440a65f
u₂-v₂ #Resta de vectores

# ╔═╡ 81b00b86-ca0a-4045-8a06-3e2c2a36896f
md""" ### $\cdot$ Multiplicación por un escalar"""

# ╔═╡ 0998d8ac-94b5-4c4b-ad19-1798c742ccab
md"""Dado un vector $u$ de tamaño $n \times 1$ y un escalar $k$, la multiplicación por escalar $v = k \cdot u$ es otro vector de tamaño $n \times 1$ donde cada elemento $v_{i}$ se obtiene multiplicando $u_{i}$ por $k$: $v_{i} = k \cdot u_{i}$. Tal como se muestra a continuación:

$\begin{align}v&=k\cdot u \\

&= k\cdot \begin{bmatrix} u_{1}\\ u_{2}\\ \vdots \\ u_{n} \end{bmatrix}\\

&= \begin{bmatrix} k\cdot u_{1}\\ k\cdot u_{2}\\ \vdots \\ k\cdot u_{n}  \end{bmatrix}\end{align}$
De manera análoga se tiene para un vector de tamaño $1\times n$."""

# ╔═╡ 364c8c6a-1d00-42f7-86e2-85afe82cf4c6
md"""Ejemplo: Consideremos un vector de tamaño $3\times 1$"""

# ╔═╡ 70f7422f-3d0e-4aa7-8336-e02862c97f50
u₃ = [0, 2, -1]

# ╔═╡ 062e21dc-a3e1-4a1d-98b3-2299efcf2ceb
md"""Multipliquemos el vector con algunos escalares"""

# ╔═╡ 1897d792-feda-4f76-b6a4-8ebbff071f2c
2.2*u₃ #Multiplicación con k=2.2

# ╔═╡ 280d2a5a-ad13-42f6-a04d-61d1820090a6
u₃/3 #División con k=3

# ╔═╡ 8071d9a8-5093-4cb5-83a1-f0651a2ec885
3\u₃ #División con k=3

# ╔═╡ f77d7f17-9f96-4172-b2a5-e04772768095
md"""De esto último observe que se puede realizar la división por escalar con / o con $\textbackslash$."""

# ╔═╡ 9842f3bb-c4fd-4198-975b-c8b28af059a2
md""" ##### $\cdot$ Combinación lineal"""

# ╔═╡ 4e5b4e78-740a-4537-a8b2-db50db836669
md""" La combinación lineal de dos vectores $u$ y $v$ de tamaño $n\times 1$ con coeficientes $\alpha$ y $\beta$ respectivamente, se define como

$\begin{align}\alpha\cdot u+\beta \cdot v &= \alpha\cdot\begin{bmatrix} u_{1}\\ u_{2}\\ \vdots \\ u_{n} \end{bmatrix}+\beta\cdot\begin{bmatrix} v_{1}\\ v_{2}\\ \vdots \\ v_{n} \end{bmatrix}\\

&=\begin{bmatrix} \alpha\cdot u_{1}+\beta\cdot v_{1}\\  \alpha\cdot u_{2}+\beta\cdot v_{2}\\ \vdots \\ \alpha\cdot u_{n}+\beta\cdot v_{n} \end{bmatrix}\end{align}$

Cada componente de la combinación lineal es obtenido multiplicando el correspondiente coeficiente por el componente correspondiente del vector y sumando los resultados.

De manera análoga se tiene la combinación lineal de dos vectores de tamaño $1\times n$.
"""

# ╔═╡ 16c12333-de25-4bea-bfef-4f30baa8a998
md"""Ejemplo: Consideremos 2 vectores aleatorios de tamaño $3\times 1$ y $\alpha=0.5$ y $\beta=0.2$ y realicemos la combinación lineal."""

# ╔═╡ f73ac118-540c-4a3a-91c0-0477733cfa56
begin
	u₄ = rand(3); v₄ = rand(3)
	alpha = -0.5; beta = 1.5;
	w₄ = alpha*u₄ + beta*v₄
end

# ╔═╡ d5c5dca2-4882-4046-8458-7ed229d442b8
md"""Para ilustrar algunas sintaxis adicionales de Julia, hemos creado una función que toma como argumentos una lista de coeficientes y una lista de vectores. Esta función retorna la combinación lineal de dichos vectores, y las listas pueden ser representadas tanto por tuplas como por arreglos."""

# ╔═╡ 62e1da9f-d9d5-433e-a11c-44d6e70cbda0
function lincomb(coeff,vectors)
    n = length(vectors[1]) # Length of vectors
    a = zeros(n)
    for i = 1:length(vectors)
        a = a + coeff[i] * vectors[i];
    end
    return a
end

# ╔═╡ 57615fa4-bcc9-4a8a-b41b-3802699182b6
lincomb((-0.5,1.5), ([1,2], [3,4]))

# ╔═╡ 28394b5f-1919-44ad-b9ab-71e83e6d6169
md"""Otra forma de ver la anterior función, de una manera más reducida es la siguiente:"""

# ╔═╡ fecfdafa-263d-4515-a352-14747de569ba
function lincomb1(coeff,vectors)
    return sum(coeff[i] * vectors[i] for i = 1:length(vectors))
end

# ╔═╡ 40e04b3e-3a83-470a-b3dd-3e7803767045
lincomb1((-0.5,1.5), ([1,2], [3,4]))

# ╔═╡ 355220ea-0ed6-4189-8b0c-9acb4b52a43e
md""" ### $\cdot$ Transposición de un vector

Dado un vector $u$ de tamaño $n \times 1$, el transpuesto $u^T$ es otro vector $1 \times n$ donde cada elemento $(u^T)_{1i}$ es igual al elemento $u_{i1}$: $(u^T)_{1i} = u_{i1}$. Es decir, si

$u=\begin{bmatrix} u_{1}\\ u_{2}\\ \vdots \\ u_{n} \end{bmatrix}$
entonces 

$u^T=\begin{bmatrix}  u_{1} & u_{2} & \cdots & u_{n}  \end{bmatrix}$

De manera análoga se tiene para un vector de tamaño $1\times n$.

**Nota:** Observe que si se tiene un vector columna y se toma su transpuesta, se obtendrá un vector fila, y si se tiene un vector fila y se realiza su transposición, se obtendrá un vector columna.

Ejemplo: Considere la siguiente vector de tamaño $3\times 1$."""

# ╔═╡ 07b6df54-47fe-4a3f-8059-15f44205863f
u₅=[2, 3, 4]

# ╔═╡ ba134bc3-f63c-4d37-af2f-66589fd1cf06
u₅' #vector transpuesto

# ╔═╡ c800912d-2061-454d-860c-9fa19be49437
md""" ### $\cdot$ Producto interno"""

# ╔═╡ 4a2bd078-b788-438f-92e7-6ab488d8519b
md"""El producto interno de dos vectores $u$ y $v$ de tamaño $n \times 1$ se denota como $\langle u, v \rangle$. 

Así, si

$u = \begin{bmatrix} u_1 \\ u_2 \\ \vdots \\ u_n \end{bmatrix}, \quad v = \begin{bmatrix} v_1 \\ v_2 \\ \vdots \\ v_n \end{bmatrix}$

entonces, el producto interno entre $u$ y $v$ se define como:

$\langle u, v \rangle = u \cdot v = u_1 \cdot v_1 + u_2 \cdot v_2 + \ldots + u_n \cdot v_n = \sum_{i=1}^{n} u_i \cdot v_i = u^Tv.$

De manera análoga se tiene para el producto interno de dos vectores de tamaño $1\times n$."""

# ╔═╡ 5770caa7-9059-431e-a8c9-44d7ff056d13
md"""Ejemplo: Consideremos dos vectores de tamaño $4\times 1$ y realicemos su producto interno:"""

# ╔═╡ e713415e-830a-4af9-82d3-23b92ba72031
begin
	u₆ = [-1, 2, 2, 0];
	v₆ = [1, 0, -3, -1];
end

# ╔═╡ 2e1bc705-8ad1-481a-8ee6-7c32b100728c
u₆'*v₆

# ╔═╡ afcb776e-4fa2-4ad2-8da8-be7da606a418
v₆'*u₆

# ╔═╡ 655a8b4b-f01a-419c-98b3-93b70e0f8dc1
md"""**Nota:** El producto interno es conmutativo."""

# ╔═╡ 6abf9914-4337-420f-bfd9-0d30d55c14ad
md""" ### $\cdot$ Norma
La norma de un vector $u = \begin{bmatrix} u_1 \\ u_2 \\ \vdots \\ u_n \end{bmatrix}$ de tamaño $n \times 1$ se define como:

$\|\mathbf{u}\| = \sqrt{u_1^2 + u_2^2 + \ldots + u_n^2} = \sqrt{\sum_{i=1}^{n} u_i^2} = \sqrt{u^Tu}$

Esta definición representa la longitud o magnitud del vector $u$. En otras palabras, es la raíz cuadrada de la suma de los cuadrados de las componentes individuales del vector.

Para calcular la norma $\|u\|$ se puede usar la función $\texttt{norm(u)}$.

De manera análoga se tiene para un vector de tamaño $1\times n$.

Ejemplo: Consideremos el siguiente vector de tamaño $4\times 1$
"""

# ╔═╡ 3cddc10f-c3b3-4ddf-842a-f7d8ac9b9824
u₇ = [2, -1, 2.4, 0];

# ╔═╡ fa11ad1d-02fe-4f3c-a386-fb1d448823a4
md"""Calculemos la norma del vector de dos formas, usando la función $\texttt{norm}$ y usando la definición anterior $\|u\|=\sqrt{u^Tu}$."""

# ╔═╡ aad4dd39-1bcb-4bce-b7a7-7c7bf877bc89
norm(u₇) #usando la función norm

# ╔═╡ 4438144e-b113-4612-9297-231283196534
sqrt(u₇'*u₇) #usando la definición de norma

# ╔═╡ 88576eab-1677-428f-b2aa-1597905c8ba1
md""" ##### $\cdot$ Vectores unitarios"""

# ╔═╡ 45ad46c2-571d-45f8-ac2c-ff17dc6be3e7
md"""Un vector unitario es un vector cuya norma es igual a 1.

Para un vector no nulo $v$ de tamaño $n \times 1$, el vector unitario correspondiente, denotado como $u$, se define como:

$u = \frac{v}{\|v\|},$

donde $\|v\|$ representa la norma del vector $v$.

La expresión $\frac{v}{\|v\|}$ normaliza cada componente de $v$ dividiéndola por la norma total, asegurando así que el vector resultante $u$ tenga una norma igual a 1.

De manera análoga se tiene para un vector de tamaño $1\times n$.
"""

# ╔═╡ e8b2abff-a91e-45ce-ae89-a6a759842e17
md"""Ejemplo: Consideremos el siguiente vector de tamaño $7\times 1$ y normalicémoslo."""

# ╔═╡ 90a680f4-fac8-47a9-be85-5826364361be
v₈=[4, 5, 6, 0, 7, 11, 3]

# ╔═╡ ed084339-8e42-4bfa-9f89-a90a63c4c909
md"""Note que su norma es diferente de 1."""

# ╔═╡ 4d5ec3f7-0656-4c7f-88fc-84928dfcfe6f
norm(v₈)

# ╔═╡ b445ffd4-41f4-4ab2-b89f-5ef93100835d
md"""Al dividirlo por su norma, ya nos queda un vector unitario."""

# ╔═╡ e9c2eab5-81d5-4a3b-87c8-0303049f7e51
u₈=v₈/norm(v₈)

# ╔═╡ b9ce6976-6121-402a-8820-eb16133881a4
md"""En efecto, observe que su norma ya es 1."""

# ╔═╡ d6e34a70-ed5d-4114-9864-1075de7e508b
norm(u₈)

# ╔═╡ fd789023-99c7-4ab1-8fcb-7bd6564d3f1b
md"""# Referencias"""

# ╔═╡ c9d1ea74-4b2c-4a66-b4e2-bd0dc4a21c7a
md"""[1] Martínez R., H. J., & Sanabria R., A. M. (2014). Álgebra Lineal. Programa Editorial Universidad del Valle.

[2] Boyd, S., & Vandenberghe, L. (2021). Introduction to Applied Linear Algebra: Vectors, Matrices, and Least Squares - Julia Language Companion. Cambridge University Press.

[3] Grossman, S. I., & Flores Godoy, J. J. (2012). Álgebra Lineal (7a ed.). McGraw-Hill."""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Plots = "~1.39.0"
PlutoUI = "~0.7.54"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "5111ea6a7e9342bcbea251f23f4c1d4ed4ede4f6"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "793501dcd3fa7ce8d375a2c878dca2296232686e"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "2dc09997850d68179b69dafb58ae806167a32b1b"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.8"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "cd67fc487743b2f0fd4380d4cbd3a24660d0eec8"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.3"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "67c1f244b991cad9b0aa4b7540fb758c2488b129"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.24.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

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
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "886826d76ea9e72b35fcd000e535588f7b60f21d"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.10.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "8cfa272e8bdedfa88b6aefbbca7c19f1befac519"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.3.0"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3dbd312d370723b6bb43ba9d02fc36abade4518d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.15"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

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
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "e90caa41f5a86296e014e148ee061bd6c3edec96"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.9"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "466d45dc38e15794ec7d5d63ec03d776a9aff36e"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.4+1"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

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

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "e94c92c7bf4819685eb80186d51c43e71d4afa17"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.76.5+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "abbbb9ec3afd783a7cbd82ef01dcd088ea051398"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.1"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

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

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "a53ebe394b71470c7f97c2e7e170d51df21b17af"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.7"

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

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "60b1194df0a3298f460063de985eae7b01bc011a"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.1+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f689897ccbe049adb19a065c495e75f372ecd42b"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.4+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "f428ae552340899a935973270b8d98e5a31c49fe"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.1"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "7d6dd4e9212aebaeed356de34ccf262a3cd415aa"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.26"

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

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "9ee1618cbf5240e6d4e0371d6f24065083f60c48"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.11"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cc6e1927ac521b659af340e0ca45828a3ffc748f"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.12+0"

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

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a935806434c9d4c506ba941871b327b96d41f2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.0"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "f92e1315dadf8c46561fb9396e525f7200cdc227"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.5"

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

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "37b7bb7aabf9a085e0044307e1717436117f2b3b"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.5.3+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

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
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "5165dfb9fd131cf0c6957a3a7605dede376e7b63"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.0"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

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
git-tree-sha1 = "1d77abd07f617c4868c33d4f5b9e1dbb2643c9cf"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.2"

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

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
git-tree-sha1 = "1fbeaaca45801b4ba17c251dd8603ef24801dd84"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.2"
weakdeps = ["Random", "Test"]

    [deps.TranscodingStreams.extensions]
    TestExt = ["Test", "Random"]

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

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "3c793be6df9dd77a0cf49d80984ef9ff996948fa"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.19.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

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
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "801cbe47eae69adc50f36c3caec4758d2650741b"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.12.2+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "522b8414d40c4cbbab8dee346ac3a09f9768f25d"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.4.5+0"

[[deps.Xorg_libICE_jll]]
deps = ["Libdl", "Pkg"]
git-tree-sha1 = "e5becd4411063bdcac16be8b66fc2f9f6f1e8fe5"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.0.10+1"

[[deps.Xorg_libSM_jll]]
deps = ["Libdl", "Pkg", "Xorg_libICE_jll"]
git-tree-sha1 = "4a9d9e4c180e1e8119b5ffc224a7b59d3a7f7e18"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.3+0"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

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

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "04341cb870f29dcd5e39055f895c39d016e18ccd"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.4+0"

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
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a68c9655fbe6dfcab3d972808f1aafec151ce3f8"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.43.0+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3516a5630f741c9eecb3720b1ec9d8edc3ecc033"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "141fe65dc3efabb0b1d5ba74e91f6ad26f84cc22"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "ad50e5b90f222cfe78aa3d5183a20a12de1322ce"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.18.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "93284c28274d9e75218a416c65ec49d0e0fcdf3d"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.40+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

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
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╟─c25927c0-9bb6-11ee-0858-3b487d9c079c
# ╟─4f8e6c97-84a8-44e6-9bc0-43801b66c354
# ╟─11190bac-6570-402e-b68f-17cb565b3b2f
# ╟─35154b6f-eca3-4c71-a79a-460476370343
# ╟─45d2c626-bb68-4c23-a9a9-5c2d825f4d00
# ╟─c29f4362-6c2c-43af-a3f3-1aa5254eaf38
# ╟─a9c0fc03-973c-4b9c-ae51-1db9cecab9c4
# ╠═26d4b07b-4427-4198-9d0e-e1ef0ca02372
# ╟─6950bf0a-d3f3-41cc-beba-54accb8c496d
# ╟─00e4677e-765c-4f98-bd5f-8f959827b786
# ╠═e2962a20-aed2-407d-bdd5-128a0ba72bf7
# ╠═b78efeed-4e2c-492e-a75a-7dd466bf27a5
# ╟─de6dae2a-43e7-4f2a-8f13-4116b131d2e4
# ╠═efe10659-b1f9-428f-8f92-7c13c2266abb
# ╠═3c527dc7-b324-4de3-b5a9-2e2fb8cc316b
# ╟─d73c06db-4389-4fc1-a843-0e5060eae6b0
# ╠═f47021c0-b36b-4b4e-aee8-431f3fd8bd4f
# ╠═eeec419b-3376-4fc4-97d0-34fe7463de1e
# ╠═736d7c9b-3344-4b96-8732-118832c8c936
# ╟─e1d49429-c8ca-4e48-87d9-9b379e8bd423
# ╠═79618545-123b-435b-8b51-4ca1ef83aaf6
# ╠═77460253-ef2b-4f8a-bbad-3c70697cd45e
# ╠═e345f402-3104-43f4-93a1-ca5387a01e90
# ╟─69c1894e-312c-4715-9b82-fd04f389cad5
# ╟─65eef8e4-c669-4741-a55d-6a9b1ab5db96
# ╟─c5732cab-8147-41f4-a28c-5716357f8141
# ╠═34d48642-ce86-4456-a400-a5b2bc9e464e
# ╟─8cae1796-ee6f-4f1c-bb99-968163feccd6
# ╠═10ecfd04-e124-4bbf-bcac-1ca21aedf27a
# ╟─a2ed4fb0-8ef5-49e0-b769-61ee43e19dff
# ╠═2f9f6439-8253-4f07-a1b0-020ae70e0bba
# ╟─dcf91b6d-7e0a-49e8-a15b-865ba3037d83
# ╟─7b69f698-db81-48d8-99ed-6027bc13f5d0
# ╠═43b20f85-994f-4dd4-9115-5b221853d8ae
# ╟─3af8cad4-8dd4-4971-a67f-c14b32aa06b5
# ╠═d9d6af91-4294-45d9-99c8-18ed9fd07cda
# ╟─e0a47b7a-f497-4c91-b76c-c44085feec7d
# ╟─d9e53517-82f6-4343-9c0e-c482999ff49f
# ╠═6510f906-955a-4b23-9e40-8c66571b3f51
# ╟─db4fa1f6-410b-4d6a-8c89-35faf12421bd
# ╠═7ac66c82-33e8-40d2-bcf5-7cf5fd297da7
# ╟─e03fe848-9628-4b67-b3be-151f7ae74418
# ╠═3940da59-4574-46d9-b05d-8fe1f126448e
# ╟─b22f2acc-813d-4cf7-9fb4-b525957f0413
# ╠═98f76fe0-9d56-4806-9461-6cc5cc049a4f
# ╟─b9796d13-6f6a-4e48-b215-0875c1da6f29
# ╠═4547fcff-3ebc-4971-959e-3e4d880a13fe
# ╟─0d58bc35-3f03-48ee-b89a-f8cb6fd1c1e3
# ╠═7e7f3474-7e6f-4fcb-bc68-9d5a837ccaad
# ╠═9440f06b-8893-434f-bfde-9a4cf4fde48a
# ╠═99e1c7c6-bdd7-401a-8a28-37afae304e7f
# ╟─e2ca30b7-029c-4fdd-ad7b-1bfc951358cc
# ╟─393c961b-b468-42d5-b2a5-9e66a6276240
# ╠═920a2b62-1f67-4782-974c-8812d4f8dd3b
# ╟─fac95099-3259-4987-82d4-08afe2a1e57d
# ╟─973bf704-adfd-41e0-a8e4-65cc00a52ca4
# ╠═de50d2da-862b-4e6e-959b-ce7e976eb3a6
# ╠═92c3ef42-6916-469a-931e-f02b79b3a32c
# ╠═fb368f6f-43b2-4866-9b2a-c1b9260c8649
# ╟─87e68876-1e95-44e5-9995-fdf0809326d3
# ╠═d60d75c1-d257-449f-bc6e-4ababbf1d122
# ╟─749f932e-8dcc-4728-878e-f16720b9ea04
# ╠═29bc7ad8-4281-4d23-8cdc-74a63ea58e8f
# ╠═62e9b167-cb5a-47d1-866f-f2b1120adc0e
# ╟─478e5242-a18b-45df-b6c4-94cce14f0682
# ╠═71702ea2-553c-476a-a29e-987db155e522
# ╟─5cc3ce6a-e755-4849-9be1-d647067e115d
# ╟─93078b0c-c68a-437a-8a61-1da0d0f54607
# ╠═5ccdcd5c-5b27-4302-bd74-5deb8dcfd0bb
# ╠═7057ee8e-5b1d-46fc-8d9b-588f4aefc75b
# ╠═a66c8a36-fb17-412a-b75e-0031c0a428f7
# ╟─214158b9-6e6e-477c-93f2-e92544fceb04
# ╠═01a73b87-21bf-4609-a649-5557b33e394b
# ╟─63efff5c-17ce-465e-97fa-c6223677e65d
# ╠═7b1f26b5-c056-469a-96b9-aeeebed2fd36
# ╟─b9bf9c52-20b6-49c7-97ca-3054ec9934a8
# ╠═10319b9c-488b-4c19-ad94-83d6aeeab81e
# ╠═4bb4bffc-cbf9-4f79-81d8-a2cde0f0cc8d
# ╟─d233a853-04f2-4e43-8ab6-79e461079a8a
# ╟─4f3ca58e-b404-4731-b04e-1c726bd949e5
# ╠═b60dd0bd-d397-4925-9917-8bbb79b0e29c
# ╟─0a60051c-a26f-4abb-aa7c-4972347ffdf1
# ╠═38ad858d-6bf4-455d-886a-b257e962a3e6
# ╟─def16ddc-3710-41de-ad68-62b2642db717
# ╠═72489742-7de3-4a0f-844b-ea4bac14d1e5
# ╠═1801d0c8-77a6-4f08-a690-b784f84d2afe
# ╟─dabc76fa-0b1c-413e-8eac-720bd607bf83
# ╠═b7a7c23f-e4ca-4b8d-9da4-817fe6631575
# ╟─8cab06c5-8de0-4b65-8c80-f1e306e9df5a
# ╟─42411343-8eeb-4cab-adf3-cc4fa2f73e56
# ╠═1b19c238-0208-422c-af30-1e50fc36632d
# ╟─e86441e6-e225-4f05-bb7d-b3b92dced60b
# ╠═e76a140d-c5a8-4a96-977d-13bab9b7c443
# ╟─146f9bf8-cad2-4c38-adb8-3a4b13572c99
# ╟─4df5b1d8-2d02-436b-86b6-585894b833ad
# ╟─3779aae5-dee3-4840-b3f9-9cf6009a38bd
# ╠═cd45633e-20a9-4df6-bcac-fd0da75d2a27
# ╠═6829875c-c295-4495-bad8-09d83faebd58
# ╟─181cad7f-b5d5-4b99-b1c6-234dc8c0c071
# ╟─d43eb64b-da8b-434c-b72f-3d73d3c99736
# ╟─3c7ee2ab-3b8a-4678-962b-f3dfc7b6211f
# ╟─32e21a6a-a5a7-453a-b126-56df920d3827
# ╟─3250c7cd-4091-40c8-9cae-5db185ff1d6c
# ╟─cc5ae8e8-536b-4b45-91d2-3f65ed87c684
# ╠═01b4070b-cc0e-4bcd-8346-c484036c3609
# ╠═42033b73-6f49-41a5-9960-52262a5960b0
# ╟─6a81b773-e4bf-4efe-a86a-1582066347de
# ╠═afac972f-5e88-4e3a-ab14-3273adbb3c76
# ╠═8ee98e63-78b8-443c-9721-fe336440a65f
# ╟─81b00b86-ca0a-4045-8a06-3e2c2a36896f
# ╟─0998d8ac-94b5-4c4b-ad19-1798c742ccab
# ╟─364c8c6a-1d00-42f7-86e2-85afe82cf4c6
# ╠═70f7422f-3d0e-4aa7-8336-e02862c97f50
# ╟─062e21dc-a3e1-4a1d-98b3-2299efcf2ceb
# ╠═1897d792-feda-4f76-b6a4-8ebbff071f2c
# ╠═280d2a5a-ad13-42f6-a04d-61d1820090a6
# ╠═8071d9a8-5093-4cb5-83a1-f0651a2ec885
# ╟─f77d7f17-9f96-4172-b2a5-e04772768095
# ╟─9842f3bb-c4fd-4198-975b-c8b28af059a2
# ╟─4e5b4e78-740a-4537-a8b2-db50db836669
# ╟─16c12333-de25-4bea-bfef-4f30baa8a998
# ╠═f73ac118-540c-4a3a-91c0-0477733cfa56
# ╟─d5c5dca2-4882-4046-8458-7ed229d442b8
# ╠═62e1da9f-d9d5-433e-a11c-44d6e70cbda0
# ╠═57615fa4-bcc9-4a8a-b41b-3802699182b6
# ╟─28394b5f-1919-44ad-b9ab-71e83e6d6169
# ╠═fecfdafa-263d-4515-a352-14747de569ba
# ╠═40e04b3e-3a83-470a-b3dd-3e7803767045
# ╟─355220ea-0ed6-4189-8b0c-9acb4b52a43e
# ╠═07b6df54-47fe-4a3f-8059-15f44205863f
# ╠═ba134bc3-f63c-4d37-af2f-66589fd1cf06
# ╟─c800912d-2061-454d-860c-9fa19be49437
# ╟─4a2bd078-b788-438f-92e7-6ab488d8519b
# ╟─5770caa7-9059-431e-a8c9-44d7ff056d13
# ╠═e713415e-830a-4af9-82d3-23b92ba72031
# ╠═2e1bc705-8ad1-481a-8ee6-7c32b100728c
# ╠═afcb776e-4fa2-4ad2-8da8-be7da606a418
# ╟─655a8b4b-f01a-419c-98b3-93b70e0f8dc1
# ╟─6abf9914-4337-420f-bfd9-0d30d55c14ad
# ╠═3cddc10f-c3b3-4ddf-842a-f7d8ac9b9824
# ╟─fa11ad1d-02fe-4f3c-a386-fb1d448823a4
# ╠═aad4dd39-1bcb-4bce-b7a7-7c7bf877bc89
# ╠═4438144e-b113-4612-9297-231283196534
# ╟─88576eab-1677-428f-b2aa-1597905c8ba1
# ╟─45ad46c2-571d-45f8-ac2c-ff17dc6be3e7
# ╟─e8b2abff-a91e-45ce-ae89-a6a759842e17
# ╠═90a680f4-fac8-47a9-be85-5826364361be
# ╟─ed084339-8e42-4bfa-9f89-a90a63c4c909
# ╠═4d5ec3f7-0656-4c7f-88fc-84928dfcfe6f
# ╟─b445ffd4-41f4-4ab2-b89f-5ef93100835d
# ╠═e9c2eab5-81d5-4a3b-87c8-0303049f7e51
# ╟─b9ce6976-6121-402a-8820-eb16133881a4
# ╠═d6e34a70-ed5d-4114-9864-1075de7e508b
# ╟─fd789023-99c7-4ab1-8fcb-7bd6564d3f1b
# ╟─c9d1ea74-4b2c-4a66-b4e2-bd0dc4a21c7a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
