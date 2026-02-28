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
md"""Algunos valores de las normas de $A$ son:"""

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
\end{pmatrix}$"""

# ╔═╡ ddd6ff6f-3e60-49aa-9aec-001b3578f511
A=[60 30 20; 30 20 15; 20 15 12] #Definimos la matriz

# ╔═╡ 69daeb44-c973-4b48-a646-d83fd7faf00d
begin
	println("La norma  2 de la matrix extendida a vector  es = ", norm(A))
	println("La norma de Frobenious es = ",norm(A,2)) # Frobeniusln
	println("La norma subordinada 1 es = ",opnorm(A,1))
	println("La norma subordinada Inf es = ", opnorm(A,Inf))
end

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
md""" Podemos calcular la norma del residuo de la factorización: $|| PA-LU||$,"""

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

Calculemos la permutación de la factorización $PA=LU$ para una matriz diagonal dominante. """

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

El algoritmo para la factorización de Cholesky es un caso especial del algoritmo general para la factorización LU. Si $A$ es real, simétrica y definida positiva, entonces, por el teorema 2 de [1], tiene una factorización única de la forma $A = LL^T$, en donde $L$ es triangular inferior y tiene una diagonal positiva.

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
md"""Note que por defecto Julia define $U=L^T.$"""

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
md"""Recuerden que debemos mirar el número de de cóndición de la matriz, el comando *cond(H,p)* aproxima la condición de la matriz con $p=1,2,\infty$ """

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
md"""A continuación cargamos dicha matriz, de la siguiente forma"""

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

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
MAT = "23992714-dd62-5051-b70f-ba57cb901cac"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
SpecialMatrices = "928aab9d-ef52-54ac-8ca1-acd7ca42c160"

[compat]
HTTP = "~1.10.8"
MAT = "~0.10.7"
PlutoUI = "~0.7.58"
SpecialMatrices = "~3.0.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "d5e179bc362d64b0c796b48450f9a6a5193fb1bf"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

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

[[deps.BufferedStreams]]
git-tree-sha1 = "6863c5b7fc997eadcabdbaf6c5f201dc30032643"
uuid = "e1450e63-4bb3-523b-b2a4-4ffa8c0fd77d"
version = "1.2.2"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

    [deps.ColorTypes.weakdeps]
    StyledStrings = "f489334b-da3d-4c2e-b8f0-e476e12c162b"

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

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "21d088c496ea22914fe80906eb5bce65755e5ec8"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.HDF5]]
deps = ["Compat", "HDF5_jll", "Libdl", "MPIPreferences", "Mmap", "Preferences", "Printf", "Random", "Requires", "UUIDs"]
git-tree-sha1 = "e856eef26cf5bf2b0f95f8f4fc37553c72c8641c"
uuid = "f67ccb44-e63f-5c2f-98bd-6dc0ccc4ba2f"
version = "0.17.2"

    [deps.HDF5.extensions]
    MPIExt = "MPI"

    [deps.HDF5.weakdeps]
    MPI = "da04e1cc-30fd-572f-bb4f-1f8673147195"

[[deps.HDF5_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LazyArtifacts", "LibCURL_jll", "Libdl", "MPICH_jll", "MPIPreferences", "MPItrampoline_jll", "MicrosoftMPI_jll", "OpenMPI_jll", "OpenSSL_jll", "TOML", "Zlib_jll", "libaec_jll"]
git-tree-sha1 = "e94f84da9af7ce9c6be049e9067e511e17ff89ec"
uuid = "0234f1f7-429e-5d53-9886-15a909be8d59"
version = "1.14.6+0"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "5e6fe50ae7f23d171f44e311c2960294aaa0beb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.19"

[[deps.Hwloc_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XML2_jll", "Xorg_libpciaccess_jll"]
git-tree-sha1 = "157e2e5838984449e44af851a52fe374d56b9ada"
uuid = "e33a78d0-f292-5ffc-b300-72abe9b543c8"
version = "2.13.0+0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "d1a86724f81bcd184a38fd284ce183ec067d71a0"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "1.0.0"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"
version = "1.11.0"

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

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f00544d95982ea270145636c181ceda21c4e2575"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.2.0"

[[deps.MAT]]
deps = ["BufferedStreams", "CodecZlib", "HDF5", "SparseArrays"]
git-tree-sha1 = "1d2dd9b186742b0f317f2530ddcbf00eebb18e96"
uuid = "23992714-dd62-5051-b70f-ba57cb901cac"
version = "0.10.7"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MPICH_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Hwloc_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "MPIPreferences", "TOML"]
git-tree-sha1 = "9341048b9f723f2ae2a72a5269ac2f15f80534dc"
uuid = "7cb0a576-ebde-5e09-9194-50597f1243b4"
version = "4.3.2+0"

[[deps.MPIPreferences]]
deps = ["Libdl", "Preferences"]
git-tree-sha1 = "c105fe467859e7f6e9a852cb15cb4301126fac07"
uuid = "3da0fdf6-3ccc-4f1b-acd9-58baa6c99267"
version = "0.1.11"

[[deps.MPItrampoline_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "MPIPreferences", "TOML"]
git-tree-sha1 = "36c2d142e7d45fb98b5f83925213feb3292ca348"
uuid = "f1f71cc9-e9ae-5b93-9b94-4fe0e1ad3748"
version = "5.5.5+0"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "8785729fa736197687541f7053f6d8ab7fc44f92"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.10"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.MicrosoftMPI_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bc95bf4149bf535c09602e3acdf950d9b4376227"
uuid = "9237b28f-5490-5468-be7b-bb81f5f5e6cf"
version = "10.1.4+3"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenMPI_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Hwloc_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "MPIPreferences", "TOML", "Zlib_jll"]
git-tree-sha1 = "2f3d05e419b6125ffe06e55784102e99325bdbe2"
uuid = "fe0851c0-eecd-5654-98d4-656369965a5c"
version = "5.0.10+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "NetworkOptions", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "1d1aaa7d449b58415f97d2839c318b70ffb525a0"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.6.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c9cbeda6aceffc52d8a0017e71db27c7a7c0beaf"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.5+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "3ac7038a98ef6977d44adeadc73cc6f596c08109"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.79"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "RecipesBase"]
git-tree-sha1 = "3aa2bb4982e575acd7583f01531f241af077b163"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "3.2.13"

    [deps.Polynomials.extensions]
    PolynomialsChainRulesCoreExt = "ChainRulesCore"
    PolynomialsMakieCoreExt = "MakieCore"
    PolynomialsMutableArithmeticsExt = "MutableArithmetics"

    [deps.Polynomials.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    MakieCore = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
    MutableArithmetics = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "8b770b60760d4451834fe79dd483e318eee709c4"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
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

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.SpecialMatrices]]
deps = ["LinearAlgebra", "Polynomials"]
git-tree-sha1 = "8fd75ee3d16a83468a96fd29a1913fb170d2d2fd"
uuid = "928aab9d-ef52-54ac-8ca1-acd7ca42c160"
version = "3.0.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

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

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

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

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "80d3930c6347cfce7ccf96bd3bafdf079d9c0390"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.9+0"

[[deps.Xorg_libpciaccess_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "4909eb8f1cbf6bd4b1c30dd18b2ead9019ef2fad"
uuid = "a65dc6b1-eb27-53a1-bb3e-dea574b5389e"
version = "0.18.1+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libaec_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "13b760f97c6e753b47df30cb438d4dc3b50df282"
uuid = "477f73a3-ac25-53e9-8cc3-50b2fa2566f0"
version = "1.1.5+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

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
# ╟─08f8ada2-073f-4ad7-9e51-c4dd2c1d9513
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
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
