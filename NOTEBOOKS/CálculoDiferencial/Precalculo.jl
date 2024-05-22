### A Pluto.jl notebook ###
# v0.19.39

using Markdown
using InteractiveUtils

# ╔═╡ e2f450be-d3f3-11ee-087d-9fce200e533e
using PlutoUI

# ╔═╡ 162cf7ad-0ce4-41e9-9aa1-90f09fea256b
using IterTools, Primes, Polynomials, PolynomialFactors, Combinatorics

# ╔═╡ 09b6af2b-11d9-47bb-99be-e37c34a3ec42
PlutoUI.TableOfContents(title="Pre-cálculo", aside=true)

# ╔═╡ eca668ce-fcd2-4e71-a998-1e945255a9d9
md"""Este cuaderno esta en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias por favor escribir a jcgalvisa@unal.edu.co

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ c7645f20-d775-4a0d-a933-971df16b7c6f
md"""Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo."""

# ╔═╡ 3679a497-d772-450f-b75c-49bff1771b14
md"""Usaremos las siguientes librerías:"""

# ╔═╡ 3ea70fa8-3131-41c1-853d-2a314648f287
md"""# Introducción"""

# ╔═╡ 8144314d-b7e4-4d92-855a-41aa7b507d29
md"""En este cuaderno se presentan conceptos básicos para el curso de cálculo diferencial, tales como operaciones entre conjuntos, números primos, divisibilidad de enteros utilizando el teorema fundamental de la aritmética, solución de ecuaciones lineales y cuadráticas, solución de inecuaciones, operaciones con polinomios y el algoritmo de la división para polinomios."""

# ╔═╡ 3714a62d-d51d-4ed6-bcbe-e88313db6b80
md"""# Conjuntos"""

# ╔═╡ 2b97af85-d1d7-4114-9d4a-00097b454bff
md"""Un conjunto es una colección o agrupación de objetos. Cada objeto que está en un conjunto se denomina un elemento del conjunto y se dice que pertenece al conjunto. Esta relación de pertenencia, entre elementos y conjuntos, se nota con el signo $\in$; y si un objeto no está en un conjunto, se utiliza el signo $\notin$ y se dice que no pertenece.

Los conjuntos se denotan con letras mayúsculas. Recuerde que un conjunto se puede escribir por extensión o por compresión, para fines de este cuaderno, todos los conjuntos serán escritos por compresión."""

# ╔═╡ ae928c9a-13e0-4127-b827-d6d3cb51efc9
md"""*Ejemplo:* 

Consideremos el conjunto $A=\{2,4,6,8\}$, lo definimos de la siguiente forma:"""

# ╔═╡ d8bc9a0a-eaad-4348-ab8f-47a2f58a0c75
A₁ = Set([2,4,6,8])

# ╔═╡ 9db810bd-533a-4408-960b-5a2aec4daf2a
md"""*Ejemplo:*

El conjunto vacío $\varnothing$ o $\{\}$, se define de la siguiente forma:"""

# ╔═╡ 40f5876f-6975-40ae-ae90-9003d72baf15
A₂ = []

# ╔═╡ daacc61a-86c9-4768-9168-8bb3265a7ebe
md"""En Julia, podemos verificar si un elemento pertenece o no a un conjunto. Consideremos el siguiente conjunto:"""

# ╔═╡ 7d48e70a-0937-4112-ad10-4e84238537d5
C₁ = Set(["Hello", "Geeks", 10])

# ╔═╡ 913728c0-0e7e-4dce-aed7-14269c4e0418
md"""Es claro que 10 $\in$ Set₁ y $11 \notin$ Set₁, esto se verifica de la siguiente forma:"""

# ╔═╡ 77e4b744-21ba-48a2-8731-cb5830aaf29a
10 in C₁

# ╔═╡ c6c6adc6-3e0d-484d-83bb-8d6d01965753
11 in C₁

# ╔═╡ 47e78ce2-3da4-42c2-93ec-1bb57084aa36
md"""Un conjunto $A$ se dice que esta contenido en un conjunto $B$, $A\subseteq B$ si todo elemento de $A$ es también elemento de $B$. En este caso se dice que $A$ es un subconjunto de $B$."""

# ╔═╡ 0846c2a9-83a7-410e-9ea3-f54ed0f73be3
md"""*Ejemplo:*
Consideremos los siguientes conjuntos"""

# ╔═╡ 8edf7da5-b8d3-4e55-8686-b13df4e25adc
begin
	A₃ = Set([2])
	B₃ = Set([1,2,3,5, "Julia"])
end

# ╔═╡ 762662da-6093-405c-8e6b-7cf689f231ba
md"""Se tiene que"""

# ╔═╡ 744eab8e-68d5-45dc-aff1-01a1e07be6c0
A₃ ⊆ B₃

# ╔═╡ 626c3999-59f1-486e-8a39-bf6078d1f6f6
md"""Dado un  conjunto arbitrario $A$ podemos formar un nuevo conjunto cuyos elementos sean los subconjuntos de $A$. Este conjunto se demonina conjunto de partes de $A$, y se nota $℘(A)$."""

# ╔═╡ c4830c11-8e9f-4e8a-935b-01a37c9397f4
md"""*Ejemplo:*

Consideremos el conjunto $A=\{8,5,3\}$ y hallemos $℘(A)$."""

# ╔═╡ 4ab002d2-159e-4a79-ae57-06a4fa2fa1f1
℘₁ = collect(powerset([8, 5, 3]))

# ╔═╡ bf947cc6-8636-4772-9d80-7102df99fe47
md"""En Julia, podemos agregar nuevos elementos a los conjuntos de la siguiente forma:"""

# ╔═╡ 5de3951b-0b5c-46e4-bc31-ca26a997ae3a
A₄ = Set([8, 5, 3])

# ╔═╡ 3f4253b9-4781-431b-af97-32f60295d110
push!(A₄, 12) #agrega nuevos elementos

# ╔═╡ e7809eca-0cf4-44cb-90d5-9fa0b5943f2b
md"""Así como podemos agregar elementos, también podemos quitarlos tal como se muestra"""

# ╔═╡ df5a0498-5976-4b2f-a3a1-9bfcf691f61e
delete!(A₄,8)

# ╔═╡ 79792dd7-3b13-4526-8ebc-f0f7ae3fb79e
md"""También podemos ver si dos conjuntos son iguales.

*Ejemplo:*

Consideremos"""

# ╔═╡ 1bb9203b-ef17-4e9e-b003-1391a4f01780
begin
	A₅ = Set([87, 15, 3, 9])
	A₆ = Set([3, 9, 87, 15])
end

# ╔═╡ 1a6e4461-3946-4f6f-8c58-e57f827c665b
md"""Se verifica la igualdad:"""

# ╔═╡ 523f9c25-0ff6-417e-8f13-b9a3ae32e711
issetequal(A₅, A₆)

# ╔═╡ ab17ea91-38e3-449b-a215-4348ea23988c
md"""## Operaciones entre conjuntos"""

# ╔═╡ f7dce22c-4893-4729-885f-f5a34766ae71
md"""### $\cdot$ Unión

Dados dos conjuntos $A$ y $B$ definimos la unión de $A$ y $B$, $A\cup B$, como el conjunto de los elementos que están en $A$ o están en $B$. Es decir, $A\cup B = \{x \hspace{0.1cm}|\hspace{0.1cm} x\in A \vee x\in B\}$."""

# ╔═╡ 514fa09a-61f0-4644-89f6-8863973fa735
md"""*Ejemplo:*

Consideremos los siguientes conjuntos:"""

# ╔═╡ c853600a-e6c7-40d3-8fa7-3fded60033db
begin
	D₃ = Set(["Hola", "Julia", 24])
	D₄ = Set([15, 24, [2]])
	D₅ = Set(["Pedro", "{"])
end

# ╔═╡ 9ff4330e-bec7-46ae-a209-14ad666d3ae3
md"""Así, se tiene que $D_3\cup D_4$ es el siguiente conjunto:"""

# ╔═╡ 12ba4e56-4a90-4705-b7f0-e237e269d6f9
union(D₃, D₄)

# ╔═╡ 5551fbc1-efa2-442d-acca-eb6a5399592a
md"""También se puede realizar la unión de más de dos conjuntos, note que $D_3\cup D_4 \cup D_5$ es el siguiente conjunto"""

# ╔═╡ 744e4dd5-9a00-4926-9ec9-e913db147b25
union(D₃, D₄, D₅)

# ╔═╡ 54c4df35-a435-40f5-82a8-445d370c5526
md"""### $\cdot$ Intersección

Dados dos conjuntos $A$ y $B$ se define la intersección de $A$ y $B$, $A\cap B$, como el conjunto de los elementos que están en $A$ y están en $B$. Es decir, $A\cap B=\{x\hspace{0.1cm}|\hspace{0.1cm} x\in A \wedge x\in B\}.$"""

# ╔═╡ 9d195154-0cbb-4e16-8b95-f082dc04e29c
md"""*Ejemplo:*

Consideremos los siguientes conjuntos"""

# ╔═╡ a6c1d9c7-aa25-4638-87cf-6afa76d8dc3a
begin
	D₆ = Set(["Juan", "Pluto", 20])
	D₇ = Set([20, 24, [15], "Juan"])
	D₈ = Set([[20]])
end

# ╔═╡ 6af73943-ad67-43e6-ac42-5a03d90729fe
md"""Se tiene que $D_6\cap D_7$ es:"""

# ╔═╡ 33cc940d-d7b2-4aa9-bbcc-7314047a741e
intersect(D₆, D₇)

# ╔═╡ 932d2f2b-6a72-4a25-a206-60bc4f3b0f22
md"""Recuerde que $\{20\}\neq 20$, es por eso que $D_7 \cap D_8$ es:"""

# ╔═╡ d5ea2e6d-bd1f-445e-aa95-42af7f72d6aa
intersect(D₇, D₈)

# ╔═╡ c640a0d8-e7be-4084-9239-189cbb8fb30f
md"""### $\cdot$ Diferencia

Dados dos conjuntos $A$ y $B$ se define la diferencia entre $A$ y $B$ como $A- B = \{x\hspace{0.1cm}|\hspace{0.1cm}x\in A \wedge x\notin B\}$."""

# ╔═╡ 1669ad62-90d5-471a-b0c7-d2e44f4b0157
md"""*Ejemplo:*

Consideremos los siguientes conjuntos"""

# ╔═╡ 55df5f2d-6a93-44ff-802d-d51c1721472c
begin
	A₉ = Set([14, "Julia", [5], 16])
	B₁₀ = Set(["Julia", 5])
end

# ╔═╡ bdc08bee-48ce-40ac-b800-88343e16be86
md"""Luego, $A_9-B_{10}$ es el siguiente conjunto"""

# ╔═╡ bcebebcd-e2c6-4f58-8f9d-4d134bc239c2
setdiff(A₉, B₁₀)

# ╔═╡ 1d26a3b4-3773-4028-9eda-682daa4f59c4
md"""Recuerde que la diferencia es no conmutativa."""

# ╔═╡ 679c4741-ddf9-4dcb-b418-012040c00fc3
issetequal(setdiff(A₉, B₁₀), setdiff(B₁₀, A₉))

# ╔═╡ c36826e6-22eb-4f68-b1e1-6ab592c7f884
md"""### $\cdot$ Diferencia simétrica

Dados dos conjuntos $A$ y $B$ se define la diferencia simétrica entre $A$ y $B$ como
$A\triangle B= (A-B)\cup (B-A)=\{x\hspace{0.1cm}|\hspace{0.1cm} x\in A \wedge x\notin B, \vee, x\in B \wedge x\notin A \}$."""

# ╔═╡ fe592b3a-13f6-4351-acf7-322648919165
md"""*Ejemplo:*

Consideremos los siguientes conjuntos"""

# ╔═╡ c84aead7-631d-4508-aaa1-9810480aa66b
begin
	A₁₁ = Set([1, 2, 4, 5, 6])
	B₁₂ = Set([1, 2, 3, 10])
end

# ╔═╡ 06a4968e-1c17-416a-84ef-8dbb36ac68be
md"""Así, $A\triangle B$ es el siguiente conjunto""" 

# ╔═╡ 18a78077-100b-4ee9-bb8a-41b0cded8a99
symdiff(A₁₁, B₁₂)

# ╔═╡ a1e96a82-6131-47ae-a5f3-adf77153c5d4
md"""O también podemos calcularla de la siguiente forma"""

# ╔═╡ 858a87d6-b08e-474e-b796-fa4beccf19d7
union(setdiff(A₁₁, B₁₂),setdiff(B₁₂, A₁₁))

# ╔═╡ 1f9fd815-02e2-4e2d-9a7c-1c452f2f9ea0
md"""**Nota:** Recuerde que la diferencia simétrica entre conjuntos es conmutativa."""

# ╔═╡ 91785e67-402a-425d-9e65-f419b24189ed
issetequal(symdiff(A₁₁, B₁₂), symdiff(B₁₂, A₁₁))

# ╔═╡ 61036e09-e855-4430-a308-1d890ecc8c7f
md"""### $\cdot$ Producto cartesiano

Dados dos conjuntos $A$ y $B$ definimos el producto cartesiano de $A$ y $B$, como $A\times B=\{(a,b)\hspace{0.1cm}|\hspace{0.1cm} a\in A \wedge b\in B\}.$
"""

# ╔═╡ 5bbcfbe6-ee8a-4529-96ad-6ab9bf15214e
md"""*Ejemplo:*

Consideremos los siguientes conjuntos y hallemos su producto cartesiano."""

# ╔═╡ c2db39d4-b448-474c-9d2f-80b00392da57
begin
	A₁₃ = Set([1, 2, 3])
	B₁₄ = Set(["a","b"])
end

# ╔═╡ 19ffa5e5-6abf-492f-a448-a3c1ba735d79
producto_cartesiano = Set([(a, b) for a in A₁₃, b in B₁₄])

# ╔═╡ 0b4c4adb-679d-4021-a7c9-f57c6b4bf9a8
md"""Esto también lo podemos hacer de la siguiente forma:"""

# ╔═╡ f9adc20c-f023-4537-b788-b6e5937c83dc
for p in product(A₁₃, B₁₄)
    @show p
end

# ╔═╡ acc3249c-5c30-4bd2-bc5d-cc62e347065c
md"""# Sistemas numéricos"""

# ╔═╡ 582c4328-559b-483f-8a85-b7bf514d3844
md"""## Números primos

Un número natural se llama primo si tiene exactamente dos divisores, él y 1. Por el teorema fundamental de la aritmética sabemos que todo número natural o es primo o se puede expresar de manera única como producto de primos o potencias de primos.

En Julia, podemos ver si un número es primo con la función $\texttt{isprime}$. Por ejemplo"""

# ╔═╡ 650fe7ef-f57a-49a0-9705-f8381143e9b4
isprime(78)

# ╔═╡ 24fffc9a-e19a-43ed-8aa1-0a774165ff7d
md"""Con la siguiente función podemos hallar los primeros $n$ números primos."""

# ╔═╡ 6b57b7f4-e481-4c5b-a713-a2117bf012c0
function primeros_n_primos(n)
    if n <= 0
        println("Por favor, introduce un número entero positivo.")
        return
    end
    
    numeros_primos = Int[]
    num = 2
    while length(numeros_primos) < n
        if isprime(num)
            push!(numeros_primos, num)
        end
        num += 1
    end
    
    println("Los primeros $n números primos son:")
    println(numeros_primos)
end

# ╔═╡ 45961919-74c1-4954-8658-ee20b8cbab2b
md"""Por ejemplo, los primeros 6 números primos son:"""

# ╔═╡ 35a43f00-7851-422d-aa37-79763b001c9c
primeros_n_primos(5)

# ╔═╡ bb149b4d-a414-4318-a610-cf6155f67ffe
md"""También podemos hallar la descomposición en factores primos. Por ejemplo:"""

# ╔═╡ 990bc1d0-35fc-4ab3-b381-542d6cb5c327
factor(78)

# ╔═╡ b6edf3cc-a663-4c2e-9907-c4cfeea0bb0f
md"""Esto quiere decir que $78=2^1\cdot 3^1\cdot 13^1$."""

# ╔═╡ ee40d96f-fd18-4665-95d0-621041af048f
md"""## Orden

Dados dos números $m$ y $n$ decimos que $m$ es menor que $n$ si existe $k\neq 0$ tal que $m+k=n$. Se nota $m<n$."""

# ╔═╡ 64f0f1c2-6caa-47a9-a215-93948e17d960
md"""Algunos ejemplos se muestran a continuación."""

# ╔═╡ d0af68c4-c009-4ecd-8058-c4a96986f9a3
0 < 1.1

# ╔═╡ bd850af7-ffef-4893-942f-247bf07079e2
87 < 122*sqrt(3)

# ╔═╡ ebf913b3-064d-49e2-8c3d-da2c0b40d07b
87 < 12

# ╔═╡ 35a84365-d5ca-48bd-a54b-dfca28a5d4d0
md"""Al comparar dos números es posible que se obtenga la igualdad entre ellos, es por eso que decimos que $m$ es menor o igual a $n$, lo que se nota $m\leq n$. O que $t$ es mayor o igual a $s$, $t\geq s$.

Observe los siguientes ejemplos."""

# ╔═╡ 9059caef-9ced-4c83-a88a-cb12871e5b00
12 <= 14

# ╔═╡ ec8ba53d-de66-46ae-a206-98e369da0db6
15 >= 18-3

# ╔═╡ 9383609e-294c-4858-b833-f5a0b8b090fa
md"""## Divisibilidad de los números enteros

Consideremos los siguientes números naturales."""

# ╔═╡ 273062dc-9728-4413-a8a9-2fff16c38b24
begin
	m = 120
	n = 256
end

# ╔═╡ 5a6dff0e-6678-402e-bbeb-95c4e42796a1
md"""El cociente de $n$ entre $m$ se puede calcular de la siguiente forma:"""

# ╔═╡ d8e80c48-cfde-4fb3-9b69-1268c6d9f173
div(n,m)

# ╔═╡ a97cfcdf-65b0-4644-ab48-9e4a4ca80f1b
md"""El residuo de dividir $n$ entre $m$ se halla de la siguiente manera:"""

# ╔═╡ 62145064-866d-4c96-b8d8-21c36c151231
rem(n,m)

# ╔═╡ 4a51bc6e-a7bc-4b13-bcec-02e952cc1337
md"""Con la función $\texttt{divrem}$ podemos hallar tanto el cociente como el residuo."""

# ╔═╡ 52891b9d-03c2-4cf7-9cc3-d93d35bbf7a4
divrem(n,m)

# ╔═╡ fa6495f4-42a6-4062-a29b-f598e182c2b8
md"""En efecto se verifica que"""

# ╔═╡ 53cef02a-ced6-49f6-bdfd-c750d6acd65e
n == m*div(n,m) + rem(n,m)

# ╔═╡ c92bdaa0-a727-4ee9-b17b-242a41b4c20e
md"""Dados dos números naturales $a$ y $b$ se define el máximo común divisor de $a$ y $b$ como el mayor de los naturales que sea divisor tanto de $a$ como de $b$. Se nota m.c.d.($a,b$) o g.c.d.($a,b$).

*Ejemplo:* El máximo común divisor de 120 y 256 es:"""

# ╔═╡ 2313908a-37ac-49b6-b240-ff0ef29fb06a
gcd(n,m)

# ╔═╡ 16e93f6b-3bff-4eba-92de-d279699acd9e
md"""**Nota:** Si m.c.d.($a,b$)=1 se dice que $a$ y $b$ son primos relativos. Por ejmplo 16 y 59 son primos relativos."""

# ╔═╡ 9f572065-4ac2-404b-8717-31af21bae19a
gcd(16, 59)

# ╔═╡ d3e18827-e82c-4b0c-8b3b-45c5f58fc1e9
md"""Dados dos números naturales $a$ y $b$ se define el mínimo común múltiplo de $a$ y $b$, que notams m.c.m.($a,b$) o l.c.m.($a,b$) como el menor entero positivo que es divisible por $a$ y por $b$.

*Ejemplo:* El mínimo común múltiplo de 120 y 256 es:"""

# ╔═╡ adb150c0-de23-436d-a664-63d605a9989c
lcm(n,m)

# ╔═╡ 1afe0e36-0a10-4642-a0b8-71208197e6c6
md"""# Ecuaciones y polinomios

Una variable es el término usado para designar una cantidad desconocida. Podemos asignar cualquier letra para identificar una variable, generalmente se usa $t, x, y$ y $z$.

Una ecuación es una igualdad entre dos expresiones algebraicas que involucra variables. En la ecuaciones generalmente se busca su solución, una solución de una ecuación en una variable es un número que al reemplazar la variable hace cierta la igualdad. Dichas soluciones son conocidas como raíces.

Un polinomio en una variable $x$ es una expresión de la forma 

$p(x):= a_nx^n+a_{n-1}x^{n-1}+\cdots +a_1x+a_0,$
donde $a_n, a_{n-1},\cdots, a_1, a_0$ son números reales, $x$ representa la variable. Si $n$ es la mayor potencia a la que se encuentra elevada la variable $x$ se dice que el polinomio es de grado $n$."""

# ╔═╡ 5053658c-7c1c-435d-bad6-085147ee5619
md"""## Operaciones elementales

Para sumar, restar y multiplicar polinomios hay que tener en cuenta el grado de $x$ y su coeficiente. 

*Ejemplo:* Consideremos los siguientes polinomios:"""

# ╔═╡ 3aaeee88-9c87-4fdf-93a1-92328f155476
p₁ = Polynomial([0,1])

# ╔═╡ b100253c-8d03-400a-aeae-15470b2d1ca4
p₂ = Polynomial([-1,1])

# ╔═╡ 51db8c54-cc5d-4ab9-96c9-9206d9cd8c19
p₃ = Polynomial([6,-2,3])

# ╔═╡ 386d7cfe-5bcb-4863-b801-3607d05396bd
md"""Al sumar los 3 polinomios se obtiene lo siguiente"""

# ╔═╡ d9421505-39d8-4162-8af8-611d0af2c46f
p₁ + p₂ + p₃

# ╔═╡ c413a7a8-ad32-401e-a450-5db537f05d9a
md"""El producto del $p_1$ y $p_2$ se realiza de la siguiente forma"""

# ╔═╡ 947397ad-db9a-4049-9eb5-40bc0150866b
p₁ * p₂

# ╔═╡ 35520831-b8f5-4760-aa01-7dbb601c71c6
md"""Podemos también realizar el producto de un escalar con el polinomio:"""

# ╔═╡ 3ba5af7f-65ef-4203-8c8e-3f36c7bb6f0f
(1/2) * p₃

# ╔═╡ 2a768900-e533-4d66-a049-ed1cba147e52
md"""Con la función $\texttt{divrem}$ podemos hallar el cociente y el residuo de dos polinomios, por ejemplo:"""

# ╔═╡ 614eb3a6-fbd1-4faf-a921-905fc6afed02
cociente₂, residuo₂ = divrem(p₃, p₂)

# ╔═╡ 7b94be59-9bc2-407a-a770-cd598609fbe1
md"""En efecto, se verifica la igualdad"""

# ╔═╡ 217c8cfb-dce4-4332-81a0-fd54c764586e
p₂*cociente₂ + residuo₂ == p₃

# ╔═╡ bac3ac46-a714-4796-9f9c-07967bc01e08
md"""## Factorización

La factorización de polinomios consiste en expresar un polinomio como el producto de otros polinomios lineales o irreducibles.

*Ejemplo:* Hallemos la factorización de $-4x^2+1$."""

# ╔═╡ 8e8298af-1541-49c3-a997-faa8ce557339
pol₁ = Polynomial([1, 0, -4])  #definimos el polinomio

# ╔═╡ d674f983-9b42-4a5f-863d-00058990004b
poly_factor(pol₁) #hallamos su factorización

# ╔═╡ dc886f28-0319-47ab-8cba-6364d304e324
md"""De esto se tiene que $x^2-4=(-1)(2x+1)(2x-1).$"""

# ╔═╡ ded4cb5e-b2f0-420e-9138-6a47903e9491
md"""*Ejemplo:* Hallemos la factorización del polinomio $x^2-5x+6$"""

# ╔═╡ 1e4fee7c-b91b-4978-bf8b-595bcfab02e2
poly_factor(Polynomial([6, -5, 1]))

# ╔═╡ 2da1eec5-095b-4eb3-9a2e-584c52e431cf
md"""De aquí que $x^2-5x+6=(x-2)(x-3)$"""

# ╔═╡ 9ca21ac7-ca08-4994-9aae-63de5a795181
md"""*Ejemplo:* Factoricemos el polinomio $x^2+9x+6$"""

# ╔═╡ 46cc68d9-c5ec-4f0b-81d0-af4e9a02d0ef
poly_factor(Polynomial([6, 9, 1]))

# ╔═╡ 4153f179-7b4a-49fc-b3d3-a4c9cd8b6859
md"""De esto se concluye que el polinomio anterior es irreducible en $\mathbb{Z}[x].$"""

# ╔═╡ 2dfe701c-2a55-4b34-9d60-28b54dab667c
md"""## Raíces"""

# ╔═╡ cbee0e7c-c828-4ada-a4e4-f8eebc86f68b
md"""Consideremos la ecuación $2x+3=0$, si deseamos hallar $x$ primero definimos el polinomio $2x+3$:"""

# ╔═╡ 418e41c1-b47a-4416-83df-35750090a35e
polinomio = Polynomial([3, 2])  # 3 + 2x

# ╔═╡ 3cd2c6f5-da98-454b-a753-e060f9a51015
md"""Y luego se iguala esto a 0 y se despeja $x$, esto se puede calcular directamente con la función $\texttt{roots}$, tal como se muestra"""

# ╔═╡ 88fc3b26-cf7f-4b2e-a5ec-372dfa527495
raices = roots(polinomio)

# ╔═╡ 520b8a92-6da8-4d16-82c2-f8741b82dcd4
md"""De esto se concluye que $x=-1.5$.

Otro ejemplo es el siguiente, consideremos la ecuación $x^2-5x+1=-5$. Para hallar el valor de $x$ primero definimos el polinomio $x^2-5x+1$"""

# ╔═╡ d9ce86aa-786c-433d-8444-1012974f3950
polinomio₂ = Polynomial([1,-5,1])

# ╔═╡ 1c83d36c-af6e-40dc-93db-d23f41c3431d
md"""Y hallamos las raices del polinomio mencionado + 5, ya que pasamos a sumar el lado derecho de la igualdad, así las raíces de la ecuación orginal son"""

# ╔═╡ 8d2d4264-3f88-4018-9170-7036bad47f90
roots(polinomio₂ + 5)

# ╔═╡ 2fc4cb56-fd6e-4d19-afdb-eb173b1c2a18
md"""Podemos crear un polinomio conociendo sus raíces, esto con la función $\texttt{fromroots}$. Por ejemplo:"""

# ╔═╡ 3cdc410b-fda3-4452-9e6f-890b50534d08
fromroots([1,2,3]) # (x-1)*(x-2)*(x-3)

# ╔═╡ 9ea9c354-9f48-4425-9325-846eabcfac6f
md"""# Referencias"""

# ╔═╡ 5c365b71-8c90-4ebb-a5c8-db3eb68376fa
md"""[1] Opsina, M. (2017). Curso Matemáticas Básicas. Universidad Nacional de Colombia."""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Combinatorics = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
IterTools = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
PolynomialFactors = "ec145902-31c2-532e-934a-7c64254c4b82"
Polynomials = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
Primes = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"

[compat]
Combinatorics = "~1.0.2"
IterTools = "~1.10.0"
PlutoUI = "~0.7.58"
PolynomialFactors = "~0.3.2"
Polynomials = "~4.0.6"
Primes = "~0.5.6"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.3"
manifest_format = "2.0"
project_hash = "0ec39cebd9f013e7558d670b3ce497fed3116033"

[[deps.AbstractAlgebra]]
deps = ["GroupsCore", "InteractiveUtils", "LinearAlgebra", "Markdown", "Random", "RandomExtensions", "SparseArrays", "Test"]
git-tree-sha1 = "b859af958bc9440b44e6d3013fe5a34b18d8a7fc"
uuid = "c3fe647b-3220-5bb0-a1ea-a7954cac585d"
version = "0.23.0"

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

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "c53fc348ca4d40d7b371e71fd52251839080cbc9"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.4"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

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

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GroupsCore]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "6df9cd6ee79fc59feab33f63a1b3c9e95e2461d5"
uuid = "d5909c97-4eac-4ecc-a3dc-fdd0858a4120"
version = "0.4.2"

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
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.IntegerMathUtils]]
git-tree-sha1 = "b8ffb903da9f7b8cf695a8bead8e01814aa24b30"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

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

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

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
git-tree-sha1 = "71a22244e352aa8c5f0f2adde4150f62368a3f2e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.58"

[[deps.PolynomialFactors]]
deps = ["AbstractAlgebra", "Combinatorics", "LinearAlgebra", "Primes", "Test"]
git-tree-sha1 = "3d6d7432a5fba335d09e704ae387be3c15146bc6"
uuid = "ec145902-31c2-532e-934a-7c64254c4b82"
version = "0.3.2"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "RecipesBase", "Setfield", "SparseArrays"]
git-tree-sha1 = "a9c7a523d5ed375be3983db190f6a5874ae9286d"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "4.0.6"

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
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "cb420f77dc474d23ee47ca8d14c90810cafe69e7"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.6"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RandomExtensions]]
deps = ["Random", "SparseArrays"]
git-tree-sha1 = "b8a399e95663485820000f26b6a43c794e166a49"
uuid = "fb686558-2515-59ef-acaa-46db3789a887"
version = "0.4.4"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.StaticArraysCore]]
git-tree-sha1 = "36b3d696ce6366023a0ea192b4cd442268995a0d"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.2"

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
# ╟─e2f450be-d3f3-11ee-087d-9fce200e533e
# ╟─09b6af2b-11d9-47bb-99be-e37c34a3ec42
# ╟─eca668ce-fcd2-4e71-a998-1e945255a9d9
# ╟─c7645f20-d775-4a0d-a933-971df16b7c6f
# ╟─3679a497-d772-450f-b75c-49bff1771b14
# ╠═162cf7ad-0ce4-41e9-9aa1-90f09fea256b
# ╟─3ea70fa8-3131-41c1-853d-2a314648f287
# ╟─8144314d-b7e4-4d92-855a-41aa7b507d29
# ╟─3714a62d-d51d-4ed6-bcbe-e88313db6b80
# ╟─2b97af85-d1d7-4114-9d4a-00097b454bff
# ╟─ae928c9a-13e0-4127-b827-d6d3cb51efc9
# ╠═d8bc9a0a-eaad-4348-ab8f-47a2f58a0c75
# ╟─9db810bd-533a-4408-960b-5a2aec4daf2a
# ╠═40f5876f-6975-40ae-ae90-9003d72baf15
# ╟─daacc61a-86c9-4768-9168-8bb3265a7ebe
# ╠═7d48e70a-0937-4112-ad10-4e84238537d5
# ╟─913728c0-0e7e-4dce-aed7-14269c4e0418
# ╠═77e4b744-21ba-48a2-8731-cb5830aaf29a
# ╠═c6c6adc6-3e0d-484d-83bb-8d6d01965753
# ╟─47e78ce2-3da4-42c2-93ec-1bb57084aa36
# ╟─0846c2a9-83a7-410e-9ea3-f54ed0f73be3
# ╠═8edf7da5-b8d3-4e55-8686-b13df4e25adc
# ╟─762662da-6093-405c-8e6b-7cf689f231ba
# ╠═744eab8e-68d5-45dc-aff1-01a1e07be6c0
# ╟─626c3999-59f1-486e-8a39-bf6078d1f6f6
# ╟─c4830c11-8e9f-4e8a-935b-01a37c9397f4
# ╠═4ab002d2-159e-4a79-ae57-06a4fa2fa1f1
# ╟─bf947cc6-8636-4772-9d80-7102df99fe47
# ╠═5de3951b-0b5c-46e4-bc31-ca26a997ae3a
# ╠═3f4253b9-4781-431b-af97-32f60295d110
# ╟─e7809eca-0cf4-44cb-90d5-9fa0b5943f2b
# ╠═df5a0498-5976-4b2f-a3a1-9bfcf691f61e
# ╟─79792dd7-3b13-4526-8ebc-f0f7ae3fb79e
# ╠═1bb9203b-ef17-4e9e-b003-1391a4f01780
# ╟─1a6e4461-3946-4f6f-8c58-e57f827c665b
# ╠═523f9c25-0ff6-417e-8f13-b9a3ae32e711
# ╟─ab17ea91-38e3-449b-a215-4348ea23988c
# ╟─f7dce22c-4893-4729-885f-f5a34766ae71
# ╟─514fa09a-61f0-4644-89f6-8863973fa735
# ╠═c853600a-e6c7-40d3-8fa7-3fded60033db
# ╟─9ff4330e-bec7-46ae-a209-14ad666d3ae3
# ╠═12ba4e56-4a90-4705-b7f0-e237e269d6f9
# ╟─5551fbc1-efa2-442d-acca-eb6a5399592a
# ╠═744e4dd5-9a00-4926-9ec9-e913db147b25
# ╟─54c4df35-a435-40f5-82a8-445d370c5526
# ╟─9d195154-0cbb-4e16-8b95-f082dc04e29c
# ╠═a6c1d9c7-aa25-4638-87cf-6afa76d8dc3a
# ╟─6af73943-ad67-43e6-ac42-5a03d90729fe
# ╠═33cc940d-d7b2-4aa9-bbcc-7314047a741e
# ╟─932d2f2b-6a72-4a25-a206-60bc4f3b0f22
# ╠═d5ea2e6d-bd1f-445e-aa95-42af7f72d6aa
# ╟─c640a0d8-e7be-4084-9239-189cbb8fb30f
# ╟─1669ad62-90d5-471a-b0c7-d2e44f4b0157
# ╠═55df5f2d-6a93-44ff-802d-d51c1721472c
# ╟─bdc08bee-48ce-40ac-b800-88343e16be86
# ╠═bcebebcd-e2c6-4f58-8f9d-4d134bc239c2
# ╟─1d26a3b4-3773-4028-9eda-682daa4f59c4
# ╠═679c4741-ddf9-4dcb-b418-012040c00fc3
# ╟─c36826e6-22eb-4f68-b1e1-6ab592c7f884
# ╟─fe592b3a-13f6-4351-acf7-322648919165
# ╠═c84aead7-631d-4508-aaa1-9810480aa66b
# ╟─06a4968e-1c17-416a-84ef-8dbb36ac68be
# ╠═18a78077-100b-4ee9-bb8a-41b0cded8a99
# ╟─a1e96a82-6131-47ae-a5f3-adf77153c5d4
# ╠═858a87d6-b08e-474e-b796-fa4beccf19d7
# ╟─1f9fd815-02e2-4e2d-9a7c-1c452f2f9ea0
# ╠═91785e67-402a-425d-9e65-f419b24189ed
# ╟─61036e09-e855-4430-a308-1d890ecc8c7f
# ╟─5bbcfbe6-ee8a-4529-96ad-6ab9bf15214e
# ╠═c2db39d4-b448-474c-9d2f-80b00392da57
# ╠═19ffa5e5-6abf-492f-a448-a3c1ba735d79
# ╟─0b4c4adb-679d-4021-a7c9-f57c6b4bf9a8
# ╠═f9adc20c-f023-4537-b788-b6e5937c83dc
# ╟─acc3249c-5c30-4bd2-bc5d-cc62e347065c
# ╟─582c4328-559b-483f-8a85-b7bf514d3844
# ╠═650fe7ef-f57a-49a0-9705-f8381143e9b4
# ╟─24fffc9a-e19a-43ed-8aa1-0a774165ff7d
# ╠═6b57b7f4-e481-4c5b-a713-a2117bf012c0
# ╟─45961919-74c1-4954-8658-ee20b8cbab2b
# ╠═35a43f00-7851-422d-aa37-79763b001c9c
# ╟─bb149b4d-a414-4318-a610-cf6155f67ffe
# ╠═990bc1d0-35fc-4ab3-b381-542d6cb5c327
# ╟─b6edf3cc-a663-4c2e-9907-c4cfeea0bb0f
# ╟─ee40d96f-fd18-4665-95d0-621041af048f
# ╟─64f0f1c2-6caa-47a9-a215-93948e17d960
# ╠═d0af68c4-c009-4ecd-8058-c4a96986f9a3
# ╠═bd850af7-ffef-4893-942f-247bf07079e2
# ╠═ebf913b3-064d-49e2-8c3d-da2c0b40d07b
# ╟─35a84365-d5ca-48bd-a54b-dfca28a5d4d0
# ╠═9059caef-9ced-4c83-a88a-cb12871e5b00
# ╠═ec8ba53d-de66-46ae-a206-98e369da0db6
# ╟─9383609e-294c-4858-b833-f5a0b8b090fa
# ╠═273062dc-9728-4413-a8a9-2fff16c38b24
# ╟─5a6dff0e-6678-402e-bbeb-95c4e42796a1
# ╠═d8e80c48-cfde-4fb3-9b69-1268c6d9f173
# ╟─a97cfcdf-65b0-4644-ab48-9e4a4ca80f1b
# ╠═62145064-866d-4c96-b8d8-21c36c151231
# ╟─4a51bc6e-a7bc-4b13-bcec-02e952cc1337
# ╠═52891b9d-03c2-4cf7-9cc3-d93d35bbf7a4
# ╟─fa6495f4-42a6-4062-a29b-f598e182c2b8
# ╠═53cef02a-ced6-49f6-bdfd-c750d6acd65e
# ╟─c92bdaa0-a727-4ee9-b17b-242a41b4c20e
# ╠═2313908a-37ac-49b6-b240-ff0ef29fb06a
# ╟─16e93f6b-3bff-4eba-92de-d279699acd9e
# ╠═9f572065-4ac2-404b-8717-31af21bae19a
# ╟─d3e18827-e82c-4b0c-8b3b-45c5f58fc1e9
# ╠═adb150c0-de23-436d-a664-63d605a9989c
# ╟─1afe0e36-0a10-4642-a0b8-71208197e6c6
# ╟─5053658c-7c1c-435d-bad6-085147ee5619
# ╠═3aaeee88-9c87-4fdf-93a1-92328f155476
# ╠═b100253c-8d03-400a-aeae-15470b2d1ca4
# ╠═51db8c54-cc5d-4ab9-96c9-9206d9cd8c19
# ╟─386d7cfe-5bcb-4863-b801-3607d05396bd
# ╠═d9421505-39d8-4162-8af8-611d0af2c46f
# ╟─c413a7a8-ad32-401e-a450-5db537f05d9a
# ╠═947397ad-db9a-4049-9eb5-40bc0150866b
# ╟─35520831-b8f5-4760-aa01-7dbb601c71c6
# ╠═3ba5af7f-65ef-4203-8c8e-3f36c7bb6f0f
# ╟─2a768900-e533-4d66-a049-ed1cba147e52
# ╠═614eb3a6-fbd1-4faf-a921-905fc6afed02
# ╟─7b94be59-9bc2-407a-a770-cd598609fbe1
# ╠═217c8cfb-dce4-4332-81a0-fd54c764586e
# ╟─bac3ac46-a714-4796-9f9c-07967bc01e08
# ╠═8e8298af-1541-49c3-a997-faa8ce557339
# ╠═d674f983-9b42-4a5f-863d-00058990004b
# ╟─dc886f28-0319-47ab-8cba-6364d304e324
# ╟─ded4cb5e-b2f0-420e-9138-6a47903e9491
# ╠═1e4fee7c-b91b-4978-bf8b-595bcfab02e2
# ╟─2da1eec5-095b-4eb3-9a2e-584c52e431cf
# ╟─9ca21ac7-ca08-4994-9aae-63de5a795181
# ╠═46cc68d9-c5ec-4f0b-81d0-af4e9a02d0ef
# ╟─4153f179-7b4a-49fc-b3d3-a4c9cd8b6859
# ╟─2dfe701c-2a55-4b34-9d60-28b54dab667c
# ╟─cbee0e7c-c828-4ada-a4e4-f8eebc86f68b
# ╠═418e41c1-b47a-4416-83df-35750090a35e
# ╟─3cd2c6f5-da98-454b-a753-e060f9a51015
# ╠═88fc3b26-cf7f-4b2e-a5ec-372dfa527495
# ╟─520b8a92-6da8-4d16-82c2-f8741b82dcd4
# ╠═d9ce86aa-786c-433d-8444-1012974f3950
# ╟─1c83d36c-af6e-40dc-93db-d23f41c3431d
# ╠═8d2d4264-3f88-4018-9170-7036bad47f90
# ╟─2fc4cb56-fd6e-4d19-afdb-eb173b1c2a18
# ╠═3cdc410b-fda3-4452-9e6f-890b50534d08
# ╟─9ea9c354-9f48-4425-9325-846eabcfac6f
# ╟─5c365b71-8c90-4ebb-a5c8-db3eb68376fa
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
