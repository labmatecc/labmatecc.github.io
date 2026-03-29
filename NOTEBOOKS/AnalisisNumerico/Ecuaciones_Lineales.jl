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

# ╔═╡ b763cd10-d1e7-4613-b738-9fb1c1cfa1e5
using PlutoUI

# ╔═╡ e2feba71-69cb-4f39-92d1-d1f4daefb4ec
begin
	using LinearAlgebra, SpecialMatrices
	using MAT, HTTP, SparseArrays
end

# ╔═╡ a7d3298e-0138-4149-a189-0b5a92cfa0e7
PlutoUI.TableOfContents(title="Ecuaciones Lineales", aside=true)

# ╔═╡ 5d0d4c4e-b432-437e-9b8e-2f81c79f907e
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ c08f6550-5278-436d-96ec-408570476631
md"""**Este cuaderno está basado en actividades del curso Análisis numérico I de la Universidad Nacional de Colombia, sede Bogotá, dictado por el profesor Juan Galvis en 2022-2.**

Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo. 
"""

# ╔═╡ 7b84db99-9375-4dc5-8a3e-414bc176648a
md"""Usaremos las siguientes librerías:"""

# ╔═╡ b7655028-28be-49bb-87b2-ee35adeeb9a4
md"""# Introducción"""

# ╔═╡ 39622889-6658-4938-8127-f16105b331e2
md"""Consideremos un sistema de ecuaciones lineales en $n$ incógnitas $x_1, x_2, \ldots, x_n$. Se puede escribir de la siguiente forma:

$\begin{pmatrix}
a_{11} & a_{12} & a_{13} & \cdots & a_{1n} \\
a_{21} & a_{22} & a_{23} & \cdots & a_{2n} \\
a_{31} & a_{32} & a_{33} & \cdots & a_{3n} \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
a_{n1} & a_{n2} & a_{n3} & \cdots & a_{nn} \\
\end{pmatrix}
\begin{pmatrix}
x_1 \\
x_2 \\
x_3 \\
\vdots \\
x_n \\
\end{pmatrix}
=
\begin{pmatrix}
b_1 \\
b_2 \\
b_3 \\
\vdots \\
b_n \\
\end{pmatrix}.$

Las matrices en esta ecuación se denotan por $A$, $x$ y $b$. Así, nuestro sistema es simplemente $Ax = b$."""

# ╔═╡ 4c98459c-1bd6-423c-8539-a85b104b6221
md"""
En Julia se distingen las normas subordinadas como normas de operadores. 

Los comandos para calcular normas de vectores y de matrices son presentados a continuación. """

# ╔═╡ 8ed7fb31-3db4-4647-81db-15cfd0a48974
md"""Consideremos el siguiente vector:"""

# ╔═╡ 242b54ae-8c51-4d4c-b642-c02a57a9de34
x=[1, 2, 3, -4]

# ╔═╡ 2a3153f1-9553-441a-b30a-ae0936d6d676
md"""Algunas normas de este son:"""

# ╔═╡ d3a307af-ee47-42cd-a6e5-49105c9bed09
begin
	for i=1:5:15
    	nx=norm(x,i)
    	println("La norma ",i," de x es ",nx)
	end
	nx=norm(x,Inf)
	println("La norma ",Inf," de x es ",nx)
end

# ╔═╡ 202b70c9-c7cf-452c-83ab-8eea3885b093
md"""Ahora consideremos la siguiente matriz:"""

# ╔═╡ 4d07c792-9ae2-40cb-80b3-52728e9850a5
A1=[0 0 1; -1  2  0; 1 2  1]

# ╔═╡ 0ff22446-02cd-4c1a-868e-02b909ed6e80
md"""Algunos valores de las normas de esta matriz son:"""

# ╔═╡ 69daeb44-c973-4b48-a646-d83fd7faf00d
begin
	println("La norma  2 de la matrix extendida a vector  es = ", norm(A1))
	println("La norma de Frobenious es = ",norm(A1,2)) # Frobeniusln
	println("La norma subordinada 1 es = ",opnorm(A1,1))
	println("La norma subordinada Inf es = ", opnorm(A1,Inf))
end

# ╔═╡ a01ee843-e60d-469a-8eb4-0abbabda7df4
md"""# Factorizaciones"""

# ╔═╡ a22de485-1e4d-41a3-aaa0-8edfbc5041a7
md"""## Factorización $A=LU$

Supongamos que podemos escribir la factorización $A=LU$, es decir, que $A$ se puede factorizar como el producto de una matriz triangular inferior $L$ con una matriz triangular superior $U$."""

# ╔═╡ 40bc4e89-b846-4454-ba8c-b9bbb1733be9
md"""El algoritmo para la factorización $LU$ es el siguiente:

1. **Input:** $n, (a_{ij})$
2. **for** $k = 1, 2, \dots, n$ **do**
3.   $\hspace{0.2cm}$ Especificar un valor distinto de cero para $\ell_{kk}$ o $u_{kk}$  y calcular el otro a partir de
4.   $\hspace{0.2cm}$ $\ell_{kk} u_{kk} = a_{kk} - \displaystyle\sum_{s=1}^{k-1} \ell_{ks} u_{sk}$
5.   $\hspace{0.2cm}$ **for** $j = k+1, k+2, \dots, n$ **do**
6.   $\hspace{0.4cm}$ $u_{kj} = \frac{a_{kj} - \displaystyle\sum_{s=1}^{k-1} \ell_{ks} u_{sj}}{\ell_{kk}}$
7.   $\hspace{0.2cm}$ **end**
8.   $\hspace{0.2cm}$ **for** $i = k+1, k+2, \dots, n$ **do**
9.   $\hspace{0.4cm}$ $\ell_{ik} = \frac{a_{ik} - \displaystyle\sum_{s=1}^{k-1} \ell_{is} u_{sk}}{u_{kk}}$
10.   $\hspace{0.2cm}$ **end**
11.   **end**
12. **Output:** $(\ell_{ij}), (u_{ij})$
"""

# ╔═╡ aba814fc-44de-4dc8-ac57-ff6a26efe1b0
md"""La siguiente función realiza lo mencionado en el algoritmo."""

# ╔═╡ fa508713-bddd-4cf3-a6ea-cf384a77dd59
function lu_factorization(A)
    n = size(A, 1)
    L = Matrix{Float64}(I, n, n)
    U = zeros(Float64, n, n)

    for k in 1:n
        # Especificar un valor distinto de cero para L[k, k] o U[k, k] y calcular el otro
        U[k, k] = A[k, k] - sum(L[k, 1:k-1] .* U[1:k-1, k])
        L[k, k] = 1.0

        # Calcular los elementos u_{kj} para j > k
        for j in k+1:n
            U[k, j] = (A[k, j] - sum(L[k, 1:k-1] .* U[1:k-1, j])) / L[k, k]
        end

        # Calcular los elementos l_{ik} para i > k
        for i in k+1:n
            L[i, k] = (A[i, k] - sum(L[i, 1:k-1] .* U[1:k-1, k])) / U[k, k]
        end
    end

    return L, U
end

# ╔═╡ 702230ad-e362-48aa-9d8f-cb31fb3f81ec
md"""Veamos un ejemplo de esto. 

**Ejemplo:** Consideremos la siguiente matriz 

$A = \begin{pmatrix}
60 & 30 & 20 \\
30 & 20 & 15 \\
20 & 15 & 12
\end{pmatrix}.$"""

# ╔═╡ ddd6ff6f-3e60-49aa-9aec-001b3578f511
A=[60 30 20; 30 20 15; 20 15 12] #Definimos la matriz

# ╔═╡ f16922f2-3e6b-405d-b7a6-e3a6cd73e4f2
md"""Con ayuda de la función creada hallamos su factorización LU."""

# ╔═╡ 97a502f8-7c75-4883-ad68-e762354e95b2
L, U = lu_factorization(A)

# ╔═╡ 2fb041cb-dcbf-4ec8-92d6-5ac1a645ba2f
md"""Para verificar su eficiencia usamos la norma:"""

# ╔═╡ 16a6fe86-0916-48bd-a2a0-867a3af61144
norm(L*U-A)

# ╔═╡ 0e8ae2e3-933b-4cb9-87d2-49de76407e29
md""" ## Factorización $PA=LU$
Al realizar eliminación gaussiana con pivoteo se obtendra una factorización $PA=LU$ en donde $P$ es la matriz de permutaciones."""

# ╔═╡ 221fa728-392e-4f61-b113-e2e88a9f6d99
md"""Presentamos algunos comandos relacionados a esta factorización.

**Ejemplo 1:**

Consideremos la siguiente matriz

$A=\begin{pmatrix}
2 & 5 & 8 & 7 \\
5 & 2 & 2 & 8 \\
7 & 5 & 6 & 6 \\
5 & 4 & 4 & 8
\end{pmatrix}.$"""

# ╔═╡ 7123f4ea-87d7-4549-9b4f-56547eb38bc5
A₁ =[2  5  8  7 ; 5  2  2  8 ; 7  5  6  6; 5 4 4 8] #Definimos la matriz

# ╔═╡ 68a41cbc-6c64-4c96-95ce-f529680fbe36
md"""La función $\texttt{lu()}$ en Julia, realiza una factorización $PA=LU$ de una matriz $A$, donde tal como ya sabemos $L$ es una matriz triangular inferior, $U$ es una matriz triangular superior y $P$ es una matriz de permutación que reordena las filas de $A$."""

# ╔═╡ 6aef40cd-26e2-47f6-94c8-c6702709056f
luA= lu(A₁)

# ╔═╡ e2373181-d738-4b5c-9974-d85849e44a77
md"""Las matrices $L$, $U$ y $P$ pueden ser desplegadas como sigue:  """

# ╔═╡ b9a2366f-afb1-40ab-a9d0-96886782c43f
begin
	display(luA.L)
	display(luA.U)
	display(luA.P)
end

# ╔═╡ e837f218-1099-4bc4-b8a9-cd9a2ef3d014
md""" Podemos calcular la norma del residuo de la factorización: $|| PA-LU||$."""

# ╔═╡ f4d510f5-0995-48c9-8940-1ab8e1eca805
opnorm(luA.P*A₁-luA.L*luA.U)

# ╔═╡ 74b36cc9-c28e-420c-bfe2-9e2b353d3cd5
md"""**Ejemplo 2:**

Con el paquete SpecialMatrices podemos generar la matriz de Hilbert. Por ejemplo la matriz de Hilbert de tamaño $5\times 5$ es la que se muestra a continuación."""

# ╔═╡ f5cb28ec-1504-46fe-977a-5b11bd3ac0ea
H₁=Hilbert{Rational{Int64}}(5,5) #En su forma racional

# ╔═╡ da020f53-0110-43b8-8ecc-1413a9de776b
H₂=Hilbert{Float64}(5,5) #Con entradas tipo float

# ╔═╡ 4af21bbb-87a7-4b7d-b21d-e26782fc04fe
md"""Ahora calculemos la factorización para la matriz de Hilbert de tamaño $50 \times 50$ y el respectivo residuo. """

# ╔═╡ ecd9abc9-f2da-4655-80e4-3bca05424f6f
begin
	H₃=Hilbert{Float64}(50,50) #Definimos la matriz
	luH= lu(H₃)
	res=luH.P*H₃-luH.L*luH.U
	
	println("La norma Inf del residuo es ",opnorm(res,Inf))
	println("La norma 2 del residuo es ", opnorm(res,2))
end

# ╔═╡ 50fdd35a-de2a-4a75-acbc-5c337626d772
md"""**Ejemplo 3:**

Calculemos la permutación de la factorización $PA=LU$ para la siguiente matriz diagonal dominante. """

# ╔═╡ abd66ffe-97bf-44b9-8713-16a4041463b4
A₂ =[5 -1 2 -1; -1 5 0 1; 0 -1 4 2; 1 1 1 5] #Definimos la matriz A

# ╔═╡ 81b52dea-5f0e-426d-959f-aa3182820042
md"""Realizamos la factorización de la matriz:"""

# ╔═╡ 38605809-7063-48fe-9749-f70dbb141d2e
luA₂=lu(A₂)

# ╔═╡ 701f8996-b16f-4283-bc0c-5a77704050c0
md"""A continuación se muestra la matriz $P$."""

# ╔═╡ 6264dbf0-0450-426b-9c99-2a9f5349eba9
luA₂.P

# ╔═╡ 8e0575a3-966b-4de5-b83e-bea79430cbfa
md"""Observe que en este caso la matriz de permutación es la matriz identidad.  """

# ╔═╡ 36dc58de-640a-4328-8ed8-08c5485ea749
md"""## Factorización de Cholesky

El algoritmo para la factorización de Cholesky es un caso especial del algoritmo general para la factorización LU. Si $A$ es real, simétrica y definida positiva, entonces, por el teorema $2$ de $[1]$, tiene una factorización única de la forma $A = LL^T$, en donde $L$ es triangular inferior y tiene una diagonal positiva.

El algoritmo para la factorización de Cholesky es el siguiente.
"""

# ╔═╡ bd112bd0-4258-4a39-9533-187226984b8a
md"""
1. **Input:** $n, (a_{ij})$
2. **for** $k = 1, 2, \dots, n$ **do**
3.   $\hspace{0.2cm}$ $\ell_{kk} = \left(a_{kk} - \displaystyle\sum_{s=1}^{k-1} \ell^2_{ks}\right)^{1/2}$
4.   $\hspace{0.2cm}$ **for** $i = k+1, k+2, \dots, n$ **do**
5.   $\hspace{0.4cm}$ $\ell_{ik} = \frac{a_{ik} - \displaystyle\sum_{s=1}^{k-1} \ell_{is} \ell_{ks}}{\ell_{kk}}$
6.   $\hspace{0.2cm}$ **end**
7.   **end**
8. **Output:** $(\ell_{ij})$"""

# ╔═╡ 69fbd8ba-4408-4528-93f6-6bdd0052ffa1
md"""En Julia esta factorización se puede realizar con la función $\texttt{cholesky()}$."""

# ╔═╡ d1107046-daa6-4b03-8020-670ac69d0194
md"""**Ejemplo:**

Calculemos la factorización de Cholesky de una matriz de la forma $A^TA$ con $A$ aleatoria. """

# ╔═╡ b89e46e6-63f7-4f84-b7b9-958c3781a3e3
begin
	B=1.0.+randn(4,4);
	A₃=B'B
end

# ╔═╡ 843536b1-a471-4c07-b3ba-c1960a2d83fd
md"""Realizamos su factorización:"""

# ╔═╡ 1716e39f-874a-4a41-bda1-fe63f8cafcb2
cholA=cholesky(A₃)

# ╔═╡ 4930800b-401a-4d29-ac45-39bd80b3e0a7
md"""Así se tiene que $L$ es la siguiente matriz:"""

# ╔═╡ 6ac7297a-28bf-47d4-92bd-39085471ab8d
begin
	display(cholA.L)
	display(cholA.U)
end

# ╔═╡ 61afa6a1-f109-4cc0-a102-c681f029e613
md"""Note que por defecto Julia define $U=L^T$."""

# ╔═╡ 340d2511-6df3-4ef7-a3d0-6d98d675dc92
typeof(cholA.L) #Tipo de dato que es L

# ╔═╡ da1ccf05-3e51-4750-8adf-2ca2be616115
md""" # Sistemas lineales"""

# ╔═╡ 0f0c2889-6e79-4496-aceb-d1f0b156f9a1
md""" En Julia, podemos resolver un sistema lineal general usando el operador "backslash", tal como se muestra en el siguiente ejemplo."""

# ╔═╡ de3437d4-94c1-4807-b417-451ffabfb5c9
md"""**Ejemplo:**

Resolvamos $Ax=b$, donde $A = \begin{pmatrix}
3 & 2 & 0 \\
1 & -1 & 0 \\
0 & 5 & 1
\end{pmatrix}$ y $b = \begin{pmatrix}
2 \\
4 \\
-1
\end{pmatrix}$.
"""

# ╔═╡ dcb2dc6e-9e4e-4493-945a-b797a0e346b8
begin
	A₄ =[3  2  0 ; 1 -1 0; 0 5 1]; #Definimos A
	b₄ = [2; 4; -1]; #Definimos b
end

# ╔═╡ 2a054ce0-e940-4168-95eb-e96cfc1f4f05
md"""Ahora, resolvemos el sistema."""

# ╔═╡ 5b4d678a-589f-4772-84ad-0a8c0dcb1014
x₄=A₄\b₄

# ╔═╡ 27021196-5b97-41b6-b215-27889073aa23
md""" Podemos calcular el vector residuo y su norma de la siguiente manera,"""

# ╔═╡ 0a81b3ea-8457-4d4e-809e-6c182557abef
begin
	res₄=b₄-A₄*x₄
	println("res=",norm(res₄))
end

# ╔═╡ 19745c50-19c5-4af9-b70c-7f4c72b92148
md"""**Ejemplo:**

Intentemos ahora con la matriz de Hilbert de tamaño $n$."""

# ╔═╡ c618b8bb-9d04-4335-a393-ae78da54aa39
@bind n Slider(1:30, show_value=true, default= 25)

# ╔═╡ 08f8ada2-073f-4ad7-9e51-c4dd2c1d9513
md"""A continuación definimos la matriz de Hilbert y el vector $b$, de tal forma que deseamos resolver el siguiente sistema $Hx=b$."""

# ╔═╡ b0b69872-d210-43e8-b599-5c4f6072d258
begin
	H₅=Hilbert{Float64}(n,n);
	b₅=fill(1,n,1);
end

# ╔═╡ d25276c9-6413-4825-ba74-fd25bd0aee48
md"""Hallamos la solución,"""

# ╔═╡ da768200-cd84-4ee5-9399-4b96c08d7952
x₅=H₅\b₅

# ╔═╡ ebed93c4-090a-4431-8ecd-4b5ff2ae2552
md"""Medimos el error con la norma del residuo."""

# ╔═╡ 79edfba2-fc76-40b0-8e6c-537a1951a9ec
begin
	res₅=b₅-H₅*x₅
	println("La norma del residuo es ",norm(res₅))
end

# ╔═╡ babd81de-8495-4bcf-9d14-a875ad2fdaf6
md"""Recuerden que debemos mirar el número de de cóndición de la matriz, el comando *cond(H,p)* aproxima la condición de la matriz con $p=1,2,\infty.$ """

# ╔═╡ 9043e1a4-3833-4244-a282-77ac7cdb5e1c
cond(H₅,Inf)

# ╔═╡ 8294b725-58cc-447e-8496-a41f48462cba
md"""#  Matrices dispersas
Una matriz dispersa (sparce matrix) es una matriz en que la mayoría de los elementos son nulos."""

# ╔═╡ 12a543ce-27ce-45de-804d-010f0e501a94
md""" Consideremos un ejemplo de una matriz dispersa en [2]. En particular la matriz correspondiente a: *HB/494_bus S ADMITTANCE MATRIX 494 BUS POWER SYSTEM, D.J.TYLAVSKY, JULY 1985.*

Esta matriz tiene un total de 494 filas y 494 columnas. Contiene 1666 entradas no nulas. La matriz es simétrica y fue publicada en 1985. El autor del problema es D. Tylavsky, con edición realizada por I. Duff, R. Grimes y J. Lewis.
"""

# ╔═╡ 23cb1bd5-2883-468c-943e-239916a1e164
md"""A continuación cargamos dicha matriz, de la siguiente forma:"""

# ╔═╡ ceab82c1-1adc-4be5-a4c7-52d0587c5515
url = "https://suitesparse-collection-website.herokuapp.com/mat/HB/494_bus.mat" #url de la matriz

# ╔═╡ 9a105022-3995-42ca-abee-e05665eff936
r = HTTP.request("GET", url)

# ╔═╡ 0c1e6291-aa8a-401b-a92f-44019a22ba32
Body=String(r.body)

# ╔═╡ f52ccc9e-7ba6-4bf5-90da-786cb761f9da
md""" Ahora escribimos en un archivo, """

# ╔═╡ 0fc5eafe-e674-463b-851d-32204d79319c
begin
	io = open("out.mat", "w")
	write(io,Body)
	close(io);
end

# ╔═╡ ea549e65-148e-4ee9-aa7d-089269e6040f
md""" Y usamos el paquete MAT para leer el archivo .mat"""

# ╔═╡ 74f6b1ba-bb93-4bbb-997a-4dbd50b7f302
vars = matread("out.mat")

# ╔═╡ 33670717-ea48-44e5-bc58-5e27106b97bd
md"""Note que la variable del archivo .mat es un dicctionario. Para recuperar la matriz usamos las claves apropiadas del diccionario vars. Así, la matriz es la siguiente:"""

# ╔═╡ d29f63bf-6733-40d0-89c4-3d00b0320b3a
sparsA=vars["Problem"]["A"]

# ╔═╡ 4ad284bd-5544-4e76-b3e3-425dab6aea7a
md""" Observamos que es un SparseArray con 1666 entradas y nos muestra el patron de dispersion de la matriz. """

# ╔═╡ b702876a-59e5-4b39-b39e-407230d008f2
md"""Notamos que las matrices dispersas (o ralas) necesitan tratamiento especial. Por ejemplo si calculamos la factorización $LU$ de una matriz rala como si fuera una matriz densa, entonces se produce el fenomeno de fill-in, es decir, los factores $L$ y $U$ son densos."""

# ╔═╡ eca903ca-6eee-472a-b01f-ceec54dadfc9
md"""Hallemos la factorización $LU$ de la matriz *HB/494_bus*."""

# ╔═╡ 0b40430f-3239-4d4f-ad06-a7d7f8e90348
luA1=lu(Array{Float64}(sparsA));

# ╔═╡ cd996e35-5742-4f26-b007-b07a5062814a
md"""Vemos la forma de $L$ y de $U$, respectivamente."""

# ╔═╡ 36578a91-fb9f-4de5-8499-12d5ce909538
sparse(luA1.L)

# ╔═╡ db0f6371-b77a-4a1d-a8fb-29eb5f4dbcb8
sparse(luA1.U)

# ╔═╡ 84658bb2-be90-417f-b1d3-581f05181f1e
md"""# Referencias 
[1] Kincaid, D., & Cheney, W. (2009). Numerical analysis: Mathematics of scientific computing (3rd ed.). American Mathematical Society.

[2] SuiteSparse Collection. (n.d.). SuiteSparse matrix collection. Recuperado de https://suitesparse-collection-website.herokuapp.com/"""

# ╔═╡ Cell order:
# ╟─b763cd10-d1e7-4613-b738-9fb1c1cfa1e5
# ╟─a7d3298e-0138-4149-a189-0b5a92cfa0e7
# ╟─5d0d4c4e-b432-437e-9b8e-2f81c79f907e
# ╟─c08f6550-5278-436d-96ec-408570476631
# ╟─7b84db99-9375-4dc5-8a3e-414bc176648a
# ╠═e2feba71-69cb-4f39-92d1-d1f4daefb4ec
# ╟─b7655028-28be-49bb-87b2-ee35adeeb9a4
# ╟─39622889-6658-4938-8127-f16105b331e2
# ╟─4c98459c-1bd6-423c-8539-a85b104b6221
# ╟─8ed7fb31-3db4-4647-81db-15cfd0a48974
# ╠═242b54ae-8c51-4d4c-b642-c02a57a9de34
# ╟─2a3153f1-9553-441a-b30a-ae0936d6d676
# ╟─d3a307af-ee47-42cd-a6e5-49105c9bed09
# ╟─202b70c9-c7cf-452c-83ab-8eea3885b093
# ╠═4d07c792-9ae2-40cb-80b3-52728e9850a5
# ╟─0ff22446-02cd-4c1a-868e-02b909ed6e80
# ╟─69daeb44-c973-4b48-a646-d83fd7faf00d
# ╟─a01ee843-e60d-469a-8eb4-0abbabda7df4
# ╟─a22de485-1e4d-41a3-aaa0-8edfbc5041a7
# ╟─40bc4e89-b846-4454-ba8c-b9bbb1733be9
# ╟─aba814fc-44de-4dc8-ac57-ff6a26efe1b0
# ╠═fa508713-bddd-4cf3-a6ea-cf384a77dd59
# ╟─702230ad-e362-48aa-9d8f-cb31fb3f81ec
# ╠═ddd6ff6f-3e60-49aa-9aec-001b3578f511
# ╟─f16922f2-3e6b-405d-b7a6-e3a6cd73e4f2
# ╠═97a502f8-7c75-4883-ad68-e762354e95b2
# ╟─2fb041cb-dcbf-4ec8-92d6-5ac1a645ba2f
# ╠═16a6fe86-0916-48bd-a2a0-867a3af61144
# ╟─0e8ae2e3-933b-4cb9-87d2-49de76407e29
# ╟─221fa728-392e-4f61-b113-e2e88a9f6d99
# ╠═7123f4ea-87d7-4549-9b4f-56547eb38bc5
# ╟─68a41cbc-6c64-4c96-95ce-f529680fbe36
# ╠═6aef40cd-26e2-47f6-94c8-c6702709056f
# ╟─e2373181-d738-4b5c-9974-d85849e44a77
# ╠═b9a2366f-afb1-40ab-a9d0-96886782c43f
# ╟─e837f218-1099-4bc4-b8a9-cd9a2ef3d014
# ╠═f4d510f5-0995-48c9-8940-1ab8e1eca805
# ╟─74b36cc9-c28e-420c-bfe2-9e2b353d3cd5
# ╠═f5cb28ec-1504-46fe-977a-5b11bd3ac0ea
# ╠═da020f53-0110-43b8-8ecc-1413a9de776b
# ╟─4af21bbb-87a7-4b7d-b21d-e26782fc04fe
# ╠═ecd9abc9-f2da-4655-80e4-3bca05424f6f
# ╟─50fdd35a-de2a-4a75-acbc-5c337626d772
# ╠═abd66ffe-97bf-44b9-8713-16a4041463b4
# ╟─81b52dea-5f0e-426d-959f-aa3182820042
# ╠═38605809-7063-48fe-9749-f70dbb141d2e
# ╟─701f8996-b16f-4283-bc0c-5a77704050c0
# ╠═6264dbf0-0450-426b-9c99-2a9f5349eba9
# ╟─8e0575a3-966b-4de5-b83e-bea79430cbfa
# ╟─36dc58de-640a-4328-8ed8-08c5485ea749
# ╟─bd112bd0-4258-4a39-9533-187226984b8a
# ╟─69fbd8ba-4408-4528-93f6-6bdd0052ffa1
# ╟─d1107046-daa6-4b03-8020-670ac69d0194
# ╠═b89e46e6-63f7-4f84-b7b9-958c3781a3e3
# ╟─843536b1-a471-4c07-b3ba-c1960a2d83fd
# ╠═1716e39f-874a-4a41-bda1-fe63f8cafcb2
# ╟─4930800b-401a-4d29-ac45-39bd80b3e0a7
# ╠═6ac7297a-28bf-47d4-92bd-39085471ab8d
# ╟─61afa6a1-f109-4cc0-a102-c681f029e613
# ╠═340d2511-6df3-4ef7-a3d0-6d98d675dc92
# ╟─da1ccf05-3e51-4750-8adf-2ca2be616115
# ╟─0f0c2889-6e79-4496-aceb-d1f0b156f9a1
# ╟─de3437d4-94c1-4807-b417-451ffabfb5c9
# ╠═dcb2dc6e-9e4e-4493-945a-b797a0e346b8
# ╟─2a054ce0-e940-4168-95eb-e96cfc1f4f05
# ╠═5b4d678a-589f-4772-84ad-0a8c0dcb1014
# ╟─27021196-5b97-41b6-b215-27889073aa23
# ╠═0a81b3ea-8457-4d4e-809e-6c182557abef
# ╟─19745c50-19c5-4af9-b70c-7f4c72b92148
# ╠═c618b8bb-9d04-4335-a393-ae78da54aa39
# ╠═08f8ada2-073f-4ad7-9e51-c4dd2c1d9513
# ╠═b0b69872-d210-43e8-b599-5c4f6072d258
# ╟─d25276c9-6413-4825-ba74-fd25bd0aee48
# ╠═da768200-cd84-4ee5-9399-4b96c08d7952
# ╟─ebed93c4-090a-4431-8ecd-4b5ff2ae2552
# ╠═79edfba2-fc76-40b0-8e6c-537a1951a9ec
# ╟─babd81de-8495-4bcf-9d14-a875ad2fdaf6
# ╠═9043e1a4-3833-4244-a282-77ac7cdb5e1c
# ╟─8294b725-58cc-447e-8496-a41f48462cba
# ╟─12a543ce-27ce-45de-804d-010f0e501a94
# ╟─23cb1bd5-2883-468c-943e-239916a1e164
# ╠═ceab82c1-1adc-4be5-a4c7-52d0587c5515
# ╠═9a105022-3995-42ca-abee-e05665eff936
# ╠═0c1e6291-aa8a-401b-a92f-44019a22ba32
# ╟─f52ccc9e-7ba6-4bf5-90da-786cb761f9da
# ╠═0fc5eafe-e674-463b-851d-32204d79319c
# ╟─ea549e65-148e-4ee9-aa7d-089269e6040f
# ╠═74f6b1ba-bb93-4bbb-997a-4dbd50b7f302
# ╟─33670717-ea48-44e5-bc58-5e27106b97bd
# ╠═d29f63bf-6733-40d0-89c4-3d00b0320b3a
# ╟─4ad284bd-5544-4e76-b3e3-425dab6aea7a
# ╟─b702876a-59e5-4b39-b39e-407230d008f2
# ╟─eca903ca-6eee-472a-b01f-ceec54dadfc9
# ╠═0b40430f-3239-4d4f-ad06-a7d7f8e90348
# ╟─cd996e35-5742-4f26-b007-b07a5062814a
# ╠═36578a91-fb9f-4de5-8499-12d5ce909538
# ╠═db0f6371-b77a-4a1d-a8fb-29eb5f4dbcb8
# ╟─84658bb2-be90-417f-b1d3-581f05181f1e
