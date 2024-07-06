### A Pluto.jl notebook ###
# v0.19.39

using Markdown
using InteractiveUtils

# ╔═╡ e86ad4f0-b18b-11ee-32d1-69d2b22ccc54
using PlutoUI

# ╔═╡ 945f9feb-7722-491e-8c73-7ac27498b050
using LinearAlgebra

# ╔═╡ 69bdf92b-9615-46ec-99fa-d2eb55d71567
PlutoUI.TableOfContents(title="Diagonalización", aside=true)

# ╔═╡ 88991cf3-cb64-4196-884a-6eb736d81f6e
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 9e8ae634-6d8f-4b91-9b53-d33f3dae2486
md"""Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo."""

# ╔═╡ beac5bbc-9429-40da-9ec3-7dc001b2c5f6
md"""Usaremos la siguiente librería:"""

# ╔═╡ e95d693c-e540-4ad4-8eb1-c270ff5a14d6
md"""# Introducción

En este cuaderno, mostraremos qué son las matrices semejantes, junto con algunos ejemplos para facilitar su comprensión. De igual forma, se mostrará la diagonalización de matrices, incluyendo ejemplos de ello. Se deducirá la fórmula de Binet para los números de Fibonacci, esto de manera matricial, con ayuda de la diagonalización.

La fórmula de Binet es una herramienta versátil que va más allá de los números de Fibonacci, encontrando aplicaciones en diversos campos, desde la teoría de números hasta la computación gráfica y el modelado matemático de fenómenos naturales."""

# ╔═╡ b614f4ca-1bfa-41bd-89da-add848399550
md"""# Matrices semejantes"""

# ╔═╡ 22a4e785-1c8a-46cf-b355-4b4723d3a4b3
md"""Se dice que dos matrices $A,B \in \mathcal{M}_n(\mathbb{R})$ son **semejantes** si existe una matriz invertible $P\in \mathcal{M}_n(\mathbb{R})$ tal que $B=P^{-1}AP$.

**Nota:** La función definida por la igualdad anterior, que lleva la matriz $A$ en la matriz $B$, se denomina transformación de semejanza. Esta transformación lineal se puede escribir como 

$T(A)=P^{-1}AP.$

Note que se verifica fácilmente que esta es una transformación lineal:

i) Sean $A_1, A_2 \in \mathcal{M}_n(\mathbb{R})$, entonces

$T(A_1+A_2)=P^{-1}(A_1+A_2)P=P^{-1}A_1P+P^{-1}A_2P=T(A_1)+T(A_2)$

ii) Sea $\alpha\in\mathbb{R}$, entonces

$T(\alpha A_1)=P^{-1}(\alpha A_1) P=\alpha P^{-1}A_1 P=\alpha T(A_1)$"""

# ╔═╡ c6d98d5c-06ce-410c-97d5-2ba2e1a0aab1
md"""Otra definición alternativa de semejanza es la siguiente. Se dice que $A$ y $B$ son semejantes si y sólo si existe una matriz no singular $P$ tal que

$PB=AP.$"""

# ╔═╡ fc4f614c-870c-48c2-b7f2-15386566c769
md"""*Ejemplo:*

Consideremos $A = \begin{pmatrix} 2 & 1 \\ 0 & -1 \end{pmatrix}$, $B=\begin{pmatrix} 4 & -2 \\ 5 & -3 \end{pmatrix}$ y $P = \begin{pmatrix} 2 & -1 \\ -1 & 1 \end{pmatrix}$, verifiquemos que $A$ y $B$ son semejantes.

Definimos las matrices:"""

# ╔═╡ 2151f404-cced-4a72-b340-958a2b311976
begin
	A₁ = [2 1; 0 -1]
	B₁ = [4 -2; 5 -3]
	P₁ = [2 -1; -1 1]
end

# ╔═╡ d23ff556-8638-406b-97be-77ea1088084f
md"""Ahora veamos si $B = P^{-1}AP$"""

# ╔═╡ ac8aa991-397d-451f-8699-814ad9ab1f65
B₁ == inv(P₁)*A₁*P₁

# ╔═╡ 731f72e0-8cae-4c2c-9342-3fd5574efe51
md"""Por tanto, $A$ y $B$ son semejantes."""

# ╔═╡ f8c05c62-f541-406c-ab89-1d6e5222d09d
md"""*Ejemplo:*

Sean $D = \begin{pmatrix} 1 & 0 & 0 \\ 0 & -1 & 0 \\ 0 & 0 & 2 \end{pmatrix}$, $A = \begin{pmatrix} -6 & -3 & -25 \\ 2 & 1 & 8 \\ 2 & 2 & 7 \end{pmatrix}$ y $P = \begin{pmatrix} 2 & 4 & 3 \\ 0 & 1 & -1 \\ 3 & 5 & 7 \end{pmatrix}$, veamos que $A$ es semejante a la matriz diagonal $D$.

Definimos las matrices:"""

# ╔═╡ d6285e38-3d7f-4d48-be47-fc6eeb0ea4e3
begin
	D₂ = [1 0 0; 0 -1 0; 0 0 2]
	A₂ = [-6 -3 -25; 2 1 8; 2 2 7]
	P₂ = [2 4 3; 0 1 -1; 3 5 7]
end

# ╔═╡ 3f1350e8-1f77-4b0a-a6d5-dd65d7ccf9fa
md"""La matriz $P$ es no singular, ya que $\text{det}(P)=3\neq 0$"""

# ╔═╡ ad101ebd-7d08-4deb-9818-cc428c623111
det(P₂)

# ╔═╡ 62ba106f-7a9b-4279-a027-e96a486e3240
md"""Ahora, calculemos $PA$ y $DP$"""

# ╔═╡ b5e086ea-11b6-46d4-ba92-08281255f561
P₂*A₂

# ╔═╡ 0b2fa3f6-e5a4-4dbf-b4c7-f75df134f974
D₂*P₂

# ╔═╡ be9fbca4-0c56-4736-88ea-f88817c9e877
md"""En efecto, se verifica que $PA=DP$"""

# ╔═╡ 476818e7-e13d-4ebf-8899-708ed39c3837
P₂*A₂ == D₂*P₂

# ╔═╡ eeae9b29-21d4-41a5-b5a4-98bbae99dab0
md"""**Teorema:**

Si $A,B\in \mathcal{M}_n(\mathbb{R})$ son matrices semejantes, entonces $A$ y $B$ tienen el mismo polinomio característico y, por consiguiente, tienen los mismos valores propios."""

# ╔═╡ e0b70b29-f478-416a-851a-fe4b6a8c879f
md"""*Ejemplo:*

Teniendo en cuenta el ejemplo anterior, hallemos los valores propios de la matriz $A$ y los de la matriz $D$."""

# ╔═╡ 482653a1-c40b-4433-ad73-ccfbf7d74cc6
eigvals(A₂)

# ╔═╡ 5d8fec49-321d-4dda-9410-c19f9c9136a5
eigvals(D₂)

# ╔═╡ 432ec4a1-f98c-4ba7-9536-9c9804eb6380
md"""En efecto, se verifica que son los mismos."""

# ╔═╡ 2aaf0e20-e9af-44c9-a992-d4297c47fb5f
md"""# Matriz diagonalizable"""

# ╔═╡ 150c5e47-3fad-47c8-aa2d-f82486c032e4
md"""Sea $A\in\mathcal{M}_n(\mathbb{R})$, se dice que $A$ es **diagonalizable** si existe una matriz diagonal $D$ tal que $A$ es semejante a $D$."""

# ╔═╡ b563e812-2d6f-40cb-8061-e68c4cb79d1e
md"""*Teorema:*

Una matriz $A\in \mathcal{M}_n(\mathbb{R})$ es diagonalizable si y sólo si posee $n$ vectores propios linealmente independientes. En este caso, la matriz diagonal $D$ semejante a $A$ se define como:

$D = \begin{pmatrix}
    \lambda_1 & 0 & \cdots & 0 \\
    0 & \lambda_2 & \cdots & 0 \\
    \vdots & \vdots & \ddots & \vdots \\
    0 & 0 & \cdots & \lambda_n
\end{pmatrix}=\text{diag} (\lambda_1, \lambda_2, \ldots, \lambda_n)$

donde $\lambda_1, \lambda_2, \ldots, \lambda_n$ son los valores propios de $A$. Si $P$ es una matriz cuyas columnas son vectores propios linealmente independientes de $A$, entonces

$D = P^{-1}AP$
"""

# ╔═╡ 85ab59bd-f543-476b-b7e7-ba8cef870512
md"""**Corolario:**

Si la matriz $A\in \mathcal{M}_n(\mathbb{R})$ tiene $n$ valores propios diferentes, entonces $A$ es diagonalizable."""

# ╔═╡ 8fba5533-c1a4-40ff-a41e-186841e65657
md"""*Ejemplo:*

Consideremos la matriz $A = \begin{pmatrix} 4 & 2 \\ 3 & 3 \end{pmatrix}$ y veamos si esta es diagonalizable. Definimos la matriz:"""

# ╔═╡ f897ea21-8076-4356-8301-578dafd66b96
A₃ = [4 2; 3 3]

# ╔═╡ 6209a805-bd0f-4ba7-bba8-6e7ae1a5dd32
md"""Hallemos sus valores propios:"""

# ╔═╡ a1924f4b-2bc1-44ef-9987-d0be0bf28ee8
eigvals(A₃)

# ╔═╡ 2055da67-9c0b-480c-be64-040afcd1f2a8
md"""Como la matriz es de tamaño $2\times 2$ y tiene 2 valores propios diferentes, entonces es diagonalizable. Hallemos la matriz diagonal semejante a $A$, primero hallamos $P$"""

# ╔═╡ 3bc90bca-65c8-48d6-ba76-7770f47f25a2
P₃ = eigvecs(A₃)

# ╔═╡ 7243071c-1a7a-40c6-a511-b3f72ba64df4
md"""Ahora calculamos $D=P^{-1}AP$"""

# ╔═╡ be556534-427e-4b56-b3be-0a3dbdb436d5
D₃=inv(P₃)*A₃*P₃

# ╔═╡ df225bb4-838b-40d1-b32a-12dfc4cc94f3
md"""Se tiene que $D$ es la matriz cuyas componentes en la diagonal son los valores característicos de A. Verifiquemos esto con la norma matricial:"""

# ╔═╡ d9ed3214-e6f4-4454-a14a-46e9e168ee74
norm(D₃ - diagm(eigvals(A₃)))

# ╔═╡ 2621b8fd-2f05-4854-9c97-d266b0d40ed5
md"""*Ejemplo:*

Sea $A = \begin{pmatrix} 1 & -1 & 4 \\ 3 & 2 & -1 \\ 2 & 1 & -1 \end{pmatrix}$, hallemos $D=P^{-1}AP$. Primero definimos la matriz $A$:"""

# ╔═╡ fe1275c6-355c-4a1e-a770-390d9e487891
A₄ = [1 -1 4; 3 2 -1; 2 1 -1]

# ╔═╡ 18e3f156-34a7-40eb-8250-d676a80ead7a
md"""Ahora hallamos $P$"""

# ╔═╡ d4f06784-c516-4e95-a70f-040714603d75
P₄ = eigvecs(A₄)

# ╔═╡ 2605bf07-d1ec-4ee5-85d0-6047f4fe47b1
md"""Por último calculamos $P^{-1}AP$"""

# ╔═╡ 72afc3f9-ba1b-4e0b-847a-23a9da445796
D₄ = inv(P₄)*A₄*P₄

# ╔═╡ d0941528-fd3b-42e0-af41-21c12f4866fc
md"""Y con ayuda de la norma matricial verificamos la igualdad"""

# ╔═╡ becc9632-45d7-4606-9367-33e3adbfe338
norm(inv(P₄)*A₄*P₄ - diagm(eigvals(A₄)))

# ╔═╡ 9c6f91bb-2a1b-4939-be73-818146587540
md"""**Nota:**

Sea $A$ una matriz diagonalizable, es decir, $D=P^{-1}AP$, esto es $A=PDP^{-1}$. Entonces la potencia $k$-ésima de $A$ es

$A^k = (PDP^{-1})^k = PDP^{-1} \cdot PDP^{-1} \cdot \ldots \cdot PDP^{-1} = PD^kP^{-1}$"""

# ╔═╡ 15516294-d366-400e-9441-0a32e93312c5
md"""# La sucesión de Fibonacci"""

# ╔═╡ d1d58b7f-eb59-472a-b928-ef22a6f175e1
md"""La sucesión de Fibonacci se define de manera recursiva como: $F_0=0, F_1=1$, y para $n\geq 2$, $F_n = F_{n-1}+F_{n-2}$. Así, los primeros 10 numeros de Fibonacci son

$0, \hspace{0.3cm} 1, \hspace{0.3cm}  1, \hspace{0.3cm} 2, \hspace{0.3cm} 3, \hspace{0.3cm} 5, \hspace{0.3cm} 8, \hspace{0.3cm} 13, \hspace{0.3cm} 21, \hspace{0.3cm} 34, \hspace{0.3cm} 55$"""

# ╔═╡ 8de8d8e6-cf14-4014-93b9-69a170c6ef6e
md"""Con la siguiente función definida de manera recursiva podemos hallar el $n$-ésimo número de Fibonacci"""

# ╔═╡ c417caf7-e8f2-430b-af01-7958cc3dd40b
function fibonacci(n)
	if n==0
		return 0
	elseif 0 < n <= 2
    return 1
  end
  return fibonacci(n - 1) + fibonacci(n - 2)
end

# ╔═╡ 5eb23a85-f6ee-4bb2-b67d-1258f631430b
md"""A continuación se muestran los primeros 10 números de la sucesión"""

# ╔═╡ 56527357-6b8f-4fd7-b224-177874baf193
[fibonacci(i) for i= 0:10]

# ╔═╡ 0dc08c77-d62e-4373-9e90-a41bf2868c9c
md"""La sucesión de Fibonacci aparece en una amplia gama de aplicaciones, como en la distribución de hojas en ciertos árboles, en el orden de las semillas de los girasoles, en las técnicas de búsqueda en análisis numérico, en la generación de números aleatorios en estadística, y en otros temas."""

# ╔═╡ d09aca0b-4bb0-48e6-be09-aef8622e0862
md"""Para calcular $F_n$ mediante la relación recursiva debemos calcular primero $F_0, F_1, \cdots, F_{n-1}$. Esto resultaría tedioso para $n$ grande. Desarrollaremos una fórmula que nos permita calcular $F_n$ directamente.

Se tiene que el sistema de ecuaciones

$\begin{align*}
F_n &= F_{n-1} + F_{n-2}\\
F_{n-1} &= F_{n-1}
\end{align*}$

puede escribirse de forma matricial como

$\begin{pmatrix}
    F_n \\
    F_{n-1}
\end{pmatrix} = \begin{pmatrix}
    1 & 1 \\
    1 & 0
\end{pmatrix} \begin{pmatrix}
    F_{n-1} \\
    F_{n-2}
\end{pmatrix}.$

Definamos así

$x_k = \begin{pmatrix}
    F_{k+1} \\
    F_{k}
\end{pmatrix} \hspace{0.2cm}\text{ y }\hspace{0.2cm}A = \begin{pmatrix}
    1 & 1 \\
    1 & 0
\end{pmatrix}\hspace{0.2cm}\text{ para }\hspace{0.2cm}0 \leq k \leq n-1,$

así

$\begin{align*}
x_0 &= \begin{pmatrix}
    F_1 \\
    F_{0}
\end{pmatrix} = \begin{pmatrix}
    1 \\
    0
\end{pmatrix},\\
x_1 &= \begin{pmatrix}
    F_2 \\
    F_1
\end{pmatrix} = \begin{pmatrix}
    1 \\
    1
\end{pmatrix},\\
&\vdots\\
x_{n-2} &= \begin{pmatrix}
    F_{n-1} \\
    F_{n-2}
\end{pmatrix},\\
x_{n-1} &= \begin{pmatrix}
    F_{n} \\
    F_{n-1}
\end{pmatrix}
\end{align*}$
"""

# ╔═╡ 36fb92d9-b7f5-43b5-b18a-8804c957977d
md"""Así, el anterior problema matricial se puede escribir como

$x_{n-1}=Ax_{n-2}.$

Así, observe que

$\begin{align*}
x_1&=Ax_0\\
x_2&=Ax_1=A(Ax_0)=A^2x_0\\
x_3&=Ax_2=A(A^2x_0)=A^3x_0\\
&\vdots\\
x_{n-1}&=A^{n-1}x_0
\end{align*}$"""

# ╔═╡ 8b6e75a5-cc8d-49fd-9847-12f2b8fb3fb8
md"""Por lo tanto, para determinar $F_n$, basta calcular $A^{n−1}$, lo cual sigue siendo tedioso para $n$ grande. Para facilitar esto, determinemos una matriz diagonal $B$ semejante a $A$. Definimos la matriz $A$:"""

# ╔═╡ dcc71170-3bae-4270-8c5f-f68936f3a21e
A = [1 1; 1 0]

# ╔═╡ f0eb9e76-d638-4a1f-85c0-0e6c8f03be16
md"""Con los valores propios de $A$ creamos la matriz $D$"""

# ╔═╡ 02e50656-10ed-46df-85cc-205efe0d81e3
D = diagm(eigvals(A))

# ╔═╡ 0e91727d-cf8e-487c-a9fb-c335327cd6d2
md"""Y ahora con los vectores propios correspondientes creamos la matriz $P$"""

# ╔═╡ 25ef6979-8b17-4ba3-8a38-e655bbdbd0cc
P = eigvecs(A)

# ╔═╡ 4622d313-70d8-4da8-a7fc-f2eca56cf8b4
md"""Así $A=PDP^{-1}$"""

# ╔═╡ 2808c05d-97b0-4723-a84c-5331c7981f59
P*D*inv(P)

# ╔═╡ 3433e168-b165-4f45-b354-68c31e46a154
md"""Luego, para cualquier $n\in\mathbb{N}^+$ se tiene que $A^{n-1}=PD^{n-1}P^{-1}$. Como $D$ es diagonal, $D^n$ se calcula fácilmente; sus entradas son las entradas de la diagonal de $D$, elevadas a la $n$-ésima potencia. Así, se tiene

$\begin{align*}
x_{n-1} &= A^{n-1}x_0\\
       &= PD^{n-1}P^{-1}x_0,
\end{align*}$

de donde se sigue que

$\begin{pmatrix}
    F_n \\
    F_{n-1}
\end{pmatrix} = PD^{n-1}P^{-1} \begin{pmatrix}
    1 \\
    0
\end{pmatrix}.$

Por lo tanto, $F_n$ es igual a la primera componente del vector $PD^{n-1}P^{-1} \begin{pmatrix}
    1 \\
    0
\end{pmatrix}$. Creemos así una función que nos ayude a calcular esto.
"""

# ╔═╡ e05d69e9-1a38-4ec4-af7e-a01aa4613b7a
function fib(n)
	return (P * (D^(n-1)) * inv(P) * [1 0]')[1]
end

# ╔═╡ 74dff67a-50ef-422b-bf05-ad28e1711676
md"""Observe que obtenemos lo mismo que usando la formula recursiva"""

# ╔═╡ 31161ff5-913f-4846-9728-820e0d1d8e86
[fib(i) for i= 0:10] #Primeros 10 valores de la sucesión de Fibonacci

# ╔═╡ ee55d839-5e6c-4d36-bacb-0929efb5fff9
md"""Veamos más en detalle esto. Si realizamos cuidadosamente los cálculos se obtiene que los valores propios de $A$ son $\lambda_1=\frac{1+\sqrt{5}}{2}$ y $\lambda_2=\frac{1-\sqrt{5}}{2}$, así

$D=\begin{pmatrix}
    \frac{1+\sqrt{5}}{2} & 0\\
    0 & \frac{1-\sqrt{5}}{2}
\end{pmatrix},$

de aquí que los vectores propios correspondientes son 

$\begin{pmatrix}
    \frac{1+\sqrt{5}}{2}\\
    1
\end{pmatrix}\hspace{0.2cm}\text{ y }\hspace{0.2cm}\begin{pmatrix}
    \frac{1-\sqrt{5}}{2}\\
    1
\end{pmatrix},$

así

$P=\begin{pmatrix}
    \frac{1+\sqrt{5}}{2} & \frac{1-\sqrt{5}}{2}\\
    1 & 1
\end{pmatrix},$

y 

$P^{-1}=\begin{pmatrix}
    \frac{1}{\sqrt{5}} & -\frac{1-\sqrt{5}}{2\sqrt{5}}\\
    -\frac{1}{\sqrt{5}} & \frac{1+\sqrt{5}}{2\sqrt{5}}
\end{pmatrix}=\frac{1}{\sqrt{5}} \begin{pmatrix}
    1 & -\frac{1 - \sqrt{5}}{2} \\
    -1 & \frac{1 + \sqrt{5}}{2}
\end{pmatrix}.$

Así se tiene que $A^{n-1}=PD^{n-1}P^{-1}$. Luego
"""

# ╔═╡ c3f4d4af-1de4-4c1c-8ef3-823ae1b44094
md"""$\begin{align*}
x_{n-1}=\begin{pmatrix}
    F_n \\
    F_{n-1}
\end{pmatrix}&=PD^{n-1}P^{-1}
\begin{pmatrix}
    1 \\
    0
\end{pmatrix}\\
&=\begin{pmatrix}
    \frac{1+\sqrt{5}}{2} & \frac{1-\sqrt{5}}{2}\\
    1 & 1
\end{pmatrix} \begin{pmatrix}
    \frac{1+\sqrt{5}}{2} & 0\\
    0 & \frac{1-\sqrt{5}}{2}
\end{pmatrix}^{n-1} \frac{1}{\sqrt{5}} \begin{pmatrix}
    1 & -\frac{1 - \sqrt{5}}{2} \\
    -1 & \frac{1 + \sqrt{5}}{2}\end{pmatrix} \begin{pmatrix}
    1 \\
    0
\end{pmatrix}\\
&= \frac{1}{\sqrt{5}}\begin{pmatrix}
    \frac{1+\sqrt{5}}{2} & \frac{1-\sqrt{5}}{2}\\
    1 & 1
\end{pmatrix} \begin{pmatrix}
    \left(\frac{1+\sqrt{5}}{2}\right)^{n-1} & 0\\
    0 & \left(\frac{1-\sqrt{5}}{2}\right)^{n-1}
\end{pmatrix} \begin{pmatrix}
    1 & -\frac{1 - \sqrt{5}}{2} \\
    -1 & \frac{1 + \sqrt{5}}{2}\end{pmatrix} \begin{pmatrix}
    1 \\
    0
\end{pmatrix}\\
&=\frac{1}{\sqrt{5}}\begin{pmatrix}
    \frac{1+\sqrt{5}}{2} & \frac{1-\sqrt{5}}{2}\\
    1 & 1
\end{pmatrix} \begin{pmatrix}
    \left(\frac{1+\sqrt{5}}{2}\right)^{n-1} & 0\\
    0 & \left(\frac{1-\sqrt{5}}{2}\right)^{n-1}
\end{pmatrix}  \begin{pmatrix}
    1 \\
    -1
\end{pmatrix}\\
&=\frac{1}{\sqrt{5}}\begin{pmatrix}
    \frac{1+\sqrt{5}}{2} & \frac{1-\sqrt{5}}{2}\\
    1 & 1
\end{pmatrix} \begin{pmatrix}
    \left(\frac{1+\sqrt{5}}{2}\right)^{n-1}\\
    -\left(\frac{1-\sqrt{5}}{2}\right)^{n-1}
\end{pmatrix}\\
&=\frac{1}{\sqrt{5}} \begin{pmatrix}
    \left(\frac{1+\sqrt{5}}{2}\right)^{n}-\left(\frac{1-\sqrt{5}}{2}\right)^{n}\\
\left(\frac{1+\sqrt{5}}{2}\right)^{n-1}-\left(\frac{1-\sqrt{5}}{2}\right)^{n-1}
\end{pmatrix}\\
&= \begin{pmatrix}
    \frac{1}{\sqrt{5}}\left(\left(\frac{1+\sqrt{5}}{2}\right)^{n}-\left(\frac{1-\sqrt{5}}{2}\right)^{n}\right)\\
\frac{1}{\sqrt{5}}\left(\left(\frac{1+\sqrt{5}}{2}\right)^{n-1}-\left(\frac{1-\sqrt{5}}{2}\right)^{n-1}\right)
\end{pmatrix}\\
\end{align*}$"""

# ╔═╡ c91d815a-1cb4-4668-821c-ac0950742e3d
md"""Igualando las componentes de los vectores se tiene que $F_n=\frac{1}{\sqrt{5}}\left(\left(\frac{1+\sqrt{5}}{2})^{n} -(\frac{1-\sqrt{5}}{2}\right)^{n}\right)$. Así podemos crear otra función para $F_n$."""

# ╔═╡ 332e2d8e-7c8b-4a0a-a8df-2e50bc75ab68
function fibo(n)
	return (1/sqrt(5))*(((1+sqrt(5))/2)^n - ((1-sqrt(5))/2)^n)
end

# ╔═╡ 6f299c1e-0a51-4650-9694-860cfff03af1
[fibo(i) for i= 0:10] #Primeros 10 valores de la sucesión de Fibonacci

# ╔═╡ 06fa96c3-13a5-4f8d-b12f-88bef8b45a27
md"""Esta es conocida como la fórmula de Binet, esta es una expresión analítica que nos da el $n$-ésimo número de Fibonacci en términos del número áureo $\left(\frac{1+\sqrt{5}}{2}\right)$ y su conjugado $\left(\frac{1-\sqrt{5}}{2}\right)$.
"""

# ╔═╡ 7bffd265-4900-454e-b4dd-dfaac111a14b
md"""# Referencias"""

# ╔═╡ 604d7637-a793-48d3-8b12-30ccf5c01628
md"""[1] Kolman, B., & Hill, D. R. (2006). Álgebra Lineal (8a ed.). Pearson.

[2] Horn, R. A., & Johnson, C. R. (2013). Matrix Analysis (2nd ed.). Cambridge University Press.

[3] Grossman, S. I., & Flores Godoy, J. J. (2012). Álgebra Lineal (7a ed.). McGraw-Hill."""

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

julia_version = "1.10.4"
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
# ╟─e86ad4f0-b18b-11ee-32d1-69d2b22ccc54
# ╟─69bdf92b-9615-46ec-99fa-d2eb55d71567
# ╟─88991cf3-cb64-4196-884a-6eb736d81f6e
# ╟─9e8ae634-6d8f-4b91-9b53-d33f3dae2486
# ╟─beac5bbc-9429-40da-9ec3-7dc001b2c5f6
# ╠═945f9feb-7722-491e-8c73-7ac27498b050
# ╟─e95d693c-e540-4ad4-8eb1-c270ff5a14d6
# ╟─b614f4ca-1bfa-41bd-89da-add848399550
# ╟─22a4e785-1c8a-46cf-b355-4b4723d3a4b3
# ╟─c6d98d5c-06ce-410c-97d5-2ba2e1a0aab1
# ╟─fc4f614c-870c-48c2-b7f2-15386566c769
# ╠═2151f404-cced-4a72-b340-958a2b311976
# ╟─d23ff556-8638-406b-97be-77ea1088084f
# ╠═ac8aa991-397d-451f-8699-814ad9ab1f65
# ╟─731f72e0-8cae-4c2c-9342-3fd5574efe51
# ╟─f8c05c62-f541-406c-ab89-1d6e5222d09d
# ╠═d6285e38-3d7f-4d48-be47-fc6eeb0ea4e3
# ╟─3f1350e8-1f77-4b0a-a6d5-dd65d7ccf9fa
# ╠═ad101ebd-7d08-4deb-9818-cc428c623111
# ╟─62ba106f-7a9b-4279-a027-e96a486e3240
# ╠═b5e086ea-11b6-46d4-ba92-08281255f561
# ╠═0b2fa3f6-e5a4-4dbf-b4c7-f75df134f974
# ╟─be9fbca4-0c56-4736-88ea-f88817c9e877
# ╠═476818e7-e13d-4ebf-8899-708ed39c3837
# ╟─eeae9b29-21d4-41a5-b5a4-98bbae99dab0
# ╟─e0b70b29-f478-416a-851a-fe4b6a8c879f
# ╠═482653a1-c40b-4433-ad73-ccfbf7d74cc6
# ╠═5d8fec49-321d-4dda-9410-c19f9c9136a5
# ╟─432ec4a1-f98c-4ba7-9536-9c9804eb6380
# ╟─2aaf0e20-e9af-44c9-a992-d4297c47fb5f
# ╟─150c5e47-3fad-47c8-aa2d-f82486c032e4
# ╟─b563e812-2d6f-40cb-8061-e68c4cb79d1e
# ╟─85ab59bd-f543-476b-b7e7-ba8cef870512
# ╟─8fba5533-c1a4-40ff-a41e-186841e65657
# ╠═f897ea21-8076-4356-8301-578dafd66b96
# ╟─6209a805-bd0f-4ba7-bba8-6e7ae1a5dd32
# ╠═a1924f4b-2bc1-44ef-9987-d0be0bf28ee8
# ╟─2055da67-9c0b-480c-be64-040afcd1f2a8
# ╠═3bc90bca-65c8-48d6-ba76-7770f47f25a2
# ╟─7243071c-1a7a-40c6-a511-b3f72ba64df4
# ╠═be556534-427e-4b56-b3be-0a3dbdb436d5
# ╟─df225bb4-838b-40d1-b32a-12dfc4cc94f3
# ╠═d9ed3214-e6f4-4454-a14a-46e9e168ee74
# ╟─2621b8fd-2f05-4854-9c97-d266b0d40ed5
# ╠═fe1275c6-355c-4a1e-a770-390d9e487891
# ╟─18e3f156-34a7-40eb-8250-d676a80ead7a
# ╠═d4f06784-c516-4e95-a70f-040714603d75
# ╟─2605bf07-d1ec-4ee5-85d0-6047f4fe47b1
# ╠═72afc3f9-ba1b-4e0b-847a-23a9da445796
# ╟─d0941528-fd3b-42e0-af41-21c12f4866fc
# ╠═becc9632-45d7-4606-9367-33e3adbfe338
# ╟─9c6f91bb-2a1b-4939-be73-818146587540
# ╟─15516294-d366-400e-9441-0a32e93312c5
# ╟─d1d58b7f-eb59-472a-b928-ef22a6f175e1
# ╟─8de8d8e6-cf14-4014-93b9-69a170c6ef6e
# ╠═c417caf7-e8f2-430b-af01-7958cc3dd40b
# ╟─5eb23a85-f6ee-4bb2-b67d-1258f631430b
# ╠═56527357-6b8f-4fd7-b224-177874baf193
# ╟─0dc08c77-d62e-4373-9e90-a41bf2868c9c
# ╟─d09aca0b-4bb0-48e6-be09-aef8622e0862
# ╟─36fb92d9-b7f5-43b5-b18a-8804c957977d
# ╟─8b6e75a5-cc8d-49fd-9847-12f2b8fb3fb8
# ╠═dcc71170-3bae-4270-8c5f-f68936f3a21e
# ╟─f0eb9e76-d638-4a1f-85c0-0e6c8f03be16
# ╠═02e50656-10ed-46df-85cc-205efe0d81e3
# ╟─0e91727d-cf8e-487c-a9fb-c335327cd6d2
# ╠═25ef6979-8b17-4ba3-8a38-e655bbdbd0cc
# ╟─4622d313-70d8-4da8-a7fc-f2eca56cf8b4
# ╠═2808c05d-97b0-4723-a84c-5331c7981f59
# ╟─3433e168-b165-4f45-b354-68c31e46a154
# ╠═e05d69e9-1a38-4ec4-af7e-a01aa4613b7a
# ╟─74dff67a-50ef-422b-bf05-ad28e1711676
# ╠═31161ff5-913f-4846-9728-820e0d1d8e86
# ╟─ee55d839-5e6c-4d36-bacb-0929efb5fff9
# ╟─c3f4d4af-1de4-4c1c-8ef3-823ae1b44094
# ╟─c91d815a-1cb4-4668-821c-ac0950742e3d
# ╠═332e2d8e-7c8b-4a0a-a8df-2e50bc75ab68
# ╠═6f299c1e-0a51-4650-9694-860cfff03af1
# ╟─06fa96c3-13a5-4f8d-b12f-88bef8b45a27
# ╟─7bffd265-4900-454e-b4dd-dfaac111a14b
# ╟─604d7637-a793-48d3-8b12-30ccf5c01628
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
