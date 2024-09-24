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

# ╔═╡ db207f03-6472-44fc-ba20-2d14499af15b
using PlutoUI

# ╔═╡ 537df122-4692-4a5a-847f-70777ed330ce
using LinearAlgebra

# ╔═╡ 1275e9e7-63d1-47dc-a761-bbabd33b6670
PlutoUI.TableOfContents(title="Independencia lineal II", aside=true)

# ╔═╡ 5b6c5c95-eaaa-41c6-b153-3a7bc9fe989b
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 687d4852-9b98-4342-8e07-701d055b57ac
md"""Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo."""

# ╔═╡ bd96fb46-9a41-42a5-86f1-51eb05d3d312
md"""Usaremos esta librería"""

# ╔═╡ ecff234d-eb13-4cd9-aaa5-7bbf88c14271
md"""# Introducción

La factorización $QR$ es una herramienta fundamental. Esta técnica se emplea para descomponer una matriz $A$ en el producto de dos matrices: una matriz ortogonal $Q$ y una matriz triangular superior $R$, ver $[1,2,4]$. La notación usual para esta factorización es $A = QR$. Veamos:

Dada $A\in\mathbb{R}^{m\times n}$ con $A=[a_1,a_2,\dots,a_n]$, donde $a_i, i=1,2,\dots,n$ son las columnas de $A$, queremos escribir $A= QR$, con $Q\in\mathbb{R}^{m\times p}$ y $R\in\mathbb{R}^{p\times n}$, donde $Q$ es una matriz ortogonal.

Observamos que $Q^TQ=I$, pero si $p<n$, entonces $QQ^T\neq I$. Además, $\text{Span}(A)=\text{Span}\{ a_i\}_{i=1}^n=\text{Span}\{q_j\}_{j=1}^p=\text{Span}(Q)$.

Es común escribir la factorización **completa** $A=QR$ como:

$A= [ Q_1  \quad Q_2] \left[ \begin{matrix}R_1\\ 0\end{matrix} \right],$ 

de donde se deduce que $\text{Span}(A)=\text{Span}(Q_1)$ y $\text{Span}(A^T)^\perp=\text{Span}(Q_2)$.

Por último, si las columnas de $A$ son linealmente independientes, entonces $p=n$.
"""

# ╔═╡ bc320da0-1258-46f0-8f07-b8d36cdbcdc9
md"""En el cuaderno titulado **Independencia Lineal I** vimos el proceso de Gram-Schmidt Clásico y Gram-Schmidt Modificado, en este cuaderno mostraremos las reflexiones de Householder y las rotaciones de Givens para realizar la factorización $QR.$ Ver $[7]$."""


# ╔═╡ a5733492-14dc-4dc8-a596-80a82010a53c
md"""# Reflexiones de Householder"""

# ╔═╡ 2bbf4bdf-ae76-4189-80b8-71b51c70fe62
md"""Dado $v \in \mathbb{R}^m$, definimos la matriz de Householder como $H_v = I - 2 \frac{vv^T}{v^Tv}$, donde $v$ es el vector de Householder. Veamos algunas propiedades importantes de esta matriz:

1. La matriz $H_v$ es una isometría en la norma $\|\cdot\|_2$: Esto significa que $\|H_v x\|_2 = \|x\|_2$ para cualquier vector $x$. La matriz $H_v$ preserva las distancias bajo la norma $\|\cdot\|_2$.

2. La matriz $H_v$ es simétrica: La matriz $H_v$ es igual a su traspuesta, es decir, $H_v^T = H_v$. Esto se debe a la simetría de la operación de reflexión que realiza la matriz Householder.

3. La matriz $H_v$ es ortogonal: La matriz $H_v$ es ortogonal porque $H_v^T H_v = I$, lo que implica que la inversa de $H_v$ es igual a su traspuesta.

Para reflejar un vector $x$ respecto al hiperplano $v^\perp$, utilizamos la fórmula $y = H_v x = x - 2 \frac{v^Tx}{v^Tv}v$. Es importante destacar que para calcular $y$ no es necesario calcular todas las entradas de la matriz $H_v$; simplemente calculamos el producto interno $s = v^Tx$ y realizamos la resta $x - \beta s v$, donde $\beta = 2 \frac{1}{v^Tv}$. El valor de $\beta$ puede ser precalculado, lo que reduce la complejidad computacional del cálculo de la reflexión de Householder.
"""

# ╔═╡ 4592e579-0c6c-4599-98fc-f3f11507f4ab
md"""Dado $x,y \in \mathbb{R}^m$, nos preguntamos si ¿existe un vector $v$ tal que $H_v x = y$? Si $|x|_2 = |y|_2$, la respuesta es afirmativa y $v = \alpha (x - y)$.

Para utilizar Householder en la ortogonalización, procedemos de la siguiente manera. Supongamos que deseamos ortogonalizar las columnas de $A = (a_1, a_2, \dots, a_n) \in \mathbb{R}^{m \times n}$. Consideremos inicialmente el caso de columnas linealmente independientes. Comenzamos la ortogonalización de Householder calculando el vector $v$ que transforma $a_1$ en un múltiplo del primer vector canónico $e_1 = (1, 0, \dots, 0)$. Es decir, $H_v a_1 = \sigma e_1$ con $\sigma = \pm \|x\|_2$.
"""

# ╔═╡ 6193030e-3807-471c-aaf9-d3c8a3ac895e
md"""Supongamos que $x \in \mathbb{R}^m$ y queremos calcular $v$ tal que $H_v x$ sea un múltiplo de $e_1$, digamos $\sigma e_1$ con $\sigma = \pm \|x\|_2$. En la resta $x_1 - \sigma$, puede ocurrir cancelación catastrófica. Para evitarla, consideramos las siguientes opciones:

*Opción 1:* Si $x_1 > 0$, entonces $x$ está más cerca de $\|x\|_2 e_1$ que de $-\|x\|_2 e_1$. Podemos tomar $\sigma = -\text{sign}(x_1)$ para evitar la cancelación catastrófica. Después de calcular $v_1 = x_1 - \sigma$, obtenemos

$\beta = \frac{2}{v^Tv} = \frac{2}{v_1^2 + s}$

donde $s = x_2^2 + \dots + x_m^2$.

Al elegir el signo de $\sigma$ de esta manera, evitamos la cancelación catastrófica en la resta $x_1 - \sigma$, asegurando la estabilidad numérica en el cálculo de $v_1$ y $\beta$.
"""

# ╔═╡ a5a2b67c-80ee-4f9b-a933-f3485a6cd892
md"""*Opción 2:* Podemos seleccionar $\sigma = \|x\|_2$ pero debemos tener cuidado al calcular $x_1 - \sigma$:
- Si $x_1 < 0$, entonces podemos calcular $v_1 = x_1 - \sigma$ (no hay resta).
- Si $x_1 > 0$, entonces calculamos 
  $x_1 - \sigma = (x_1 - \sigma) \frac{x_1 + \sigma}{x_1 + \sigma} = \frac{x_1^2 - \|x\|_2^2}{x_1 + \sigma} = -\frac{x_2^2 + \dots + x_m^2}{x_1 + \sigma} = - \frac{s}{x_1 + \sigma}$
  donde $s = x_2^2 + \dots + x_m^2$.

Note también que se puede calcular $v^Tv$ como sigue (recuerde que $\sigma = \|x\|_2$):

$\begin{align*}
v^Tv & = (x_1 - \sigma)^2 + x_2^2 + \dots + x_m^2\\
& = x_1^2 - 2\sigma x_1 + \sigma^2 + x_2^2 + \dots + x_m^2\\
& = 2\sigma^2 - 2\sigma x_1 \\
& = 2\sigma (\sigma - x) \\
& = -2\sigma v_1.
\end{align*}$

En muchas implementaciones para ahorrar en memoria se normaliza $v$ de tal forma que $\tilde{v} = v/v_1$ y se guardan las últimas $n-1$ entradas de $v_2/v_1, \dots, v_m/v_1$ en las entradas de $x_2, x_3, \dots, x_m$ (debajo de la diagonal de la matriz $R$ en la aplicación de ortonormalización).
"""

# ╔═╡ 26847907-9d04-4c9e-b2e7-64248258c0dd
md"""Dado $x \in \mathbb{R}^n$, esta función calcula $v \in \mathbb{R}^n$ con $v_1 = 1$ y $\beta \in \mathbb{R}$ tal que $P = I_n - \beta v v^T$ es ortogonal y $Px = \|x\|_2 e_1$, es decir, dado un vector $x$, calcula de forma correcta el vector de Householder $v$.

**ALGORITMO Vector de Householder**:

1. **función:** $[v, \beta]$ = house$(x)$
2.   $n$=length(x)
3.   $\sigma=x(2:n)^Tx(2:n)$
4.   $v=\left[ \begin{matrix}1\\ x(2:n)\end{matrix} \right]$
5. **if** $\sigma=0$
6.   $\beta=0$
7. **else**
8.   $\mu=\sqrt{x(1)^2+\sigma}$
9. **if** $x(1)\leq 0$
10.   $v(1)=x(1)-\mu$
11. **else**
12.   $v(1)=\frac{-\sigma}{x(1)+\mu}$
13. **end**
14.   $\beta=\frac{2(1)^2}{\sigma+v(1)^2}$
15.   $v = \frac{v}{v(1)}$
16. **end**"""

# ╔═╡ 2295fff5-1266-411a-9a77-b7483c488817
md"""Para más detalles de esto ver $[1,2].$"""

# ╔═╡ df902773-1bef-4bb4-a53c-c16b68c14fd0
md"""Programando el algoritmo, se obtiene la siguiente función"""

# ╔═╡ 9311ee53-94e6-49cc-8eaa-b5f2efcb9f16
function house(x)
    n = size(x,1) #(m,n)
    s = x[2:n]'x[2:n]
    v = [1; x[2:n]]
    
    if s == 0
        β = 0
        
    else
        mu = sqrt(x[1]^2 + s)
        if x[1] <= 0
            v[1] = x[1] - mu
        else
            v[1] = -s /(x[1]+mu)
        end
        β = 2((v[1])^2)/(s + (v[1])^2)
        v=v/v[1]
    end
    return v, β
end

# ╔═╡ 3573d257-bf10-46d2-9549-dfedcd95bc82
md""" Veamos el siguiente ejemplo.

*Ejemplo:*

Sea $x=\begin{bmatrix}
0.5 \\
\frac{\sqrt{3}}{2} \\
4
\end{bmatrix},$ se tiene que $v$ y $\beta$ son:"""

# ╔═╡ 93a5cf53-5796-4ca6-879b-5271eb49f2f6
begin
	x=[0.5;sqrt(3)/2;4];
	v, β= house(x)
	println("v = ", v)
	println("β = ", β)
end

# ╔═╡ bd4ae79d-a712-4a5e-9d85-2c6b24aefdf3
md"""Así, la matriz de Householder $H_v$ es la siguiente"""

# ╔═╡ a5cc8644-a521-407e-af28-9983da292b63
H=UniformScaling(1)- 2(v*v')/(v'v)

# ╔═╡ aa63c29e-c5c7-4ee6-91fb-f4dfaf01b5e7
md"""Así"""

# ╔═╡ 36d99657-dcfb-4516-9265-0cc8d61ae35e
H*x

# ╔═╡ db3855fb-f8d2-484b-a95c-e467ba8dfc93
md"""Note que $\|H_v x\|_2 = \|x\|_2$:"""

# ╔═╡ 160a23f8-0950-40c3-8aa2-d25ca8b22913
norm(x)==norm(H*x)

# ╔═╡ eb6b82d9-2047-44e7-b104-a3ea8a977d3a
md""" ## Uso de Householder en ortogonalización"""

# ╔═╡ 029f4ce6-87da-44be-afd4-776230245937
md"""Consideremos nuevamente la matriz $A=(a_1,a_2,\dots,a_n)$. Aplicando el procedimiento anterior, construimos $H_1$ tal que 
$A_1=H_1A = (\sigma e_1, H_1a_2,\dots, H_1a_n)$
es una matriz con $A_1(2:m,1)=(0,\dots,0)$. 

Ahora debemos obtener entradas nulas también en la segunda columna debajo de la diagonal. Para continuar con la triangularización de Householder, construimos una reflexión de Householder en $\mathbb{R}^{m-1}$ que transforme el vector $A_1(2:m,2)$ en el vector $(1,0,\dots,0)\in \mathbb{R}^{m-1}$. Sea $\tilde{H}_2$ esta transformación. Definamos 

$H_2= \begin{pmatrix}1 & 0\\ 0 &\tilde{H}_2\end{pmatrix}.$

Vemos que $H_2H_1a_2= (A_1(1,2), \sigma_2,0,\dots,0)\in \mathbb{R}^m$. Concluimos que 
$A_2= H_2H_1 A =  ( \sigma e_1, H_2H_1a_2, H_2H_1a_3,\dots, H_2H_1a_n)$
es una matriz con entradas nulas debajo de la diagonal en las dos primeras columnas. 

Podemos continuar este proceso hasta la última columna y obtenemos una matriz triangular superior. Es decir, obtenemos 
$H_nH_{n-1}\cdots  H_1  A = R
$
y por tanto $ A= H_1^TH_2^T\cdots H_n^T R = QR$ donde $Q=H_1H_2\cdots H_n$. 

Note que quedamos con la matriz $R$, pero para poder obtener la matriz $Q$ debemos, en principio, multiplicar las matrices $H_i$, lo cual es computacionalmente costoso. Veamos primero cómo queda el algoritmo para obtener $R$ y después mostraremos un algoritmo para construir $Q$.
"""

# ╔═╡ 5a8f5d62-3f4e-48ab-aef7-8a9446e33f14
md"""Consideremos el siguiente algoritmo 

1.   $[v, \beta]$ = house$(A(j:m,j))$
2.   $A(j:m,j;n)=(I_{m-j+1}-\beta v v^T)A(j:m, j:n)$
3.   $A(j+1:m,j)=v(2:m-j+1)$

Este algoritmo usa el algoritmo anterior para obtener la matriz $R$ de la factorización $QR$. Recuerde que asumimos que las columnas de $A$ son linealmente independientes."""

# ╔═╡ a715a5f4-6754-4551-92b9-b91586c56616
md"""Para más detalles de esto ver $[1,2].$ A continuación se crea una función para el algoritmo mostrado."""

# ╔═╡ 11ce39a8-7b98-4ea5-bfe9-81c7bbfd9e8e
function Rhouse(A)
    m,n = size(A)
    for j = 1:n
        v, β = house(A[j:m,j])
        A[j:m,j:n] = ( UniformScaling(1) - β*v*v')A[j:m,j:n]
    end
    return A
end

# ╔═╡ 575ae122-a70d-4c28-8c93-4213b72f5a6a
md"""*Ejemplo:*

Consideremos la siguiente matriz"""

# ╔═╡ 7bcc8c19-176b-4bec-9788-14bed749f920
begin
	n₁ = 3 ;
	m₁ = 5 ;
	A₁ = rand(m₁,n₁)
	B₁ = A₁
end

# ╔═╡ d57bf3b8-8758-4734-a23c-5b256943b946
md"""Así la matriz $R$ de la factorización $QR$ es la siguiente:"""

# ╔═╡ d88bb07b-84b2-42e7-8732-dc94fee01cfd
R₁h=Rhouse(B₁)

# ╔═╡ adc0d7dd-665c-49ce-b5f9-442fe2d5c000
md""" Ahora debemos hallar a la matriz $Q$, esto lo podemos hacer realizando acumulación progresiva. Con el siguiente algoritmo
"""

# ╔═╡ 6e610a1f-fb78-491a-8719-fb26e48f694b
function QFA(A)
    Q = UniformScaling(1)
    m,n = size(A)
    for j = 1:n
        v,β = house(A[j:m,j])
        v1 = zeros(j-1,1)
        v = [v1;v]
        Qj = UniformScaling(1)-β*v*v'
        Q = Q*Qj
        A=Qj*A;
    end
    return Q, A
end

# ╔═╡ ef43ca1d-a653-4a5d-97a4-4009fdfad54c
md"""*Ejemplo:*

Consideremos nuevamente la matriz del ejemplo anterior"""

# ╔═╡ 26bd3a24-5c5b-4d1a-82b0-3c00b3b8443d
A₁

# ╔═╡ 8aa0a10e-48d2-4f1d-865a-64786821c8f6
md"""Usando el algoritmo anterior se tiene que su factorización $QR$ es la siguiente"""

# ╔═╡ 1fff49b0-de66-4d7a-be0a-54da00d29d60
begin
	Q₁,R₁ =QFA(A₁)
end

# ╔═╡ 3acf0e47-42cb-4d43-aa81-4823c95a3dda
md"""Para analizar el error, podemos hacerlo de la siguientes formas"""

# ╔═╡ a3a992d9-6757-4a3e-9bd9-cd568fd60dca
opnorm(UniformScaling(1)-Q₁'Q₁) #I ∼ Q^T*Q

# ╔═╡ 9bd370df-7194-4dcc-acdf-9c66c53fc142
opnorm(A₁-Q₁*R₁) #A ∼ Q*R

# ╔═╡ fa729ae6-54c9-467a-8bd7-03abdb295a3b
md"""# Rotaciones de Givens """

# ╔═╡ f3e51af1-5dcc-4bbf-b190-cfcbd741b231
md""" También conocido como rotaciones de planos. Se aplica en el caso de matrices dispersas (sparse matrices) ya que tiene un efecto "local". """

# ╔═╡ 99f54ca8-46a5-4c06-8164-38b648f27629
md""" Dados $i,k\in \{1,\dots,m\}, \theta\in\mathbb{R}$, defina:
$c=\cos(\theta), s=\sin(\theta)$,

$G(i,k,\theta)=\begin{pmatrix} 
\vdots & \vdots  & \vdots & \vdots & \vdots \\ 
\dots & c  & \dots & s & \dots \\ 
\vdots & \vdots  & \vdots & \vdots & \vdots \\ 
\dots & -s  & \dots & c& \dots \\
\vdots & \vdots  & \vdots & \vdots & \vdots \\ 
\end{pmatrix}$

Aplicar $G^T(i,k,\theta)$ a una matriz $A=(a_1,\dots,a_n)$ equivale a "rotar" los ejes $i$ y $k$.
"""

# ╔═╡ 1b72085e-a0fd-4c17-aca4-56622a4a5bb3
md""" 
Si $y=G^T(i,k,\theta)x$ con $x\in \mathbb{R}^n$ tenemos que 

$y_i=cx_i -sx_k, \quad y_k=sx_i+cx_k$

y además $y_j=x_j$ para $j\not=i$,$j\not=k$. Luego

$G^T(i,k,\theta)A=G^T(i,k,\theta)
\begin{pmatrix} 
r_1 \\ 
\vdots\\
r_i \\ 
\vdots \\
r_k\\
\vdots\\
r_m
\end{pmatrix}=
\begin{pmatrix} 
r_1 \\ 
\vdots\\
cr_i-sr_k \\ 
\vdots \\
sr_i+cr_k \\ 
\vdots \\
r_m
\end{pmatrix}$
"""

# ╔═╡ 29959f97-471f-4e2f-a124-eedea72fbab3
md"""Si

$x_i=||x||\cos(\phi), \quad x_k=||x||\sin(\phi),$
entonces

$y_i=||x||\Big( \cos(\theta)\cos(\phi)-\sin(\theta)\sin(\phi) \Big) =||x||
\cos(\theta+\phi),$
y

$y_i=||x||\sin(\theta+\phi).$
Si queremos $y_k=0$ tenemos así dos alternativas, $\theta=-\phi$ o $\theta=\pi-\phi$.
Escogemos $\theta=-\phi$. De donde

$c=\cos(\theta)=\frac{x_i}{\sqrt{x_i^2+x_k^2}}, \quad
s=\sin(\theta)=-\frac{x_k}{\sqrt{x_i^2+x_k^2}}.$
"""

# ╔═╡ b1eabc55-366c-4994-9ede-c73747180268
md"""Esto fue tomado de $[1,2].$"""

# ╔═╡ ddf93e9b-5d73-410c-b3a0-ac39e1075746
md"""Tenemos el siguiente algoritmo (que evita división por la menor componente y también evita división por norma pequeña."""

# ╔═╡ 06efe5f4-8f9a-411b-a63a-28280f579212
function Givens(a,b)
    if b!=0
        if abs(b)>abs(a)
			# tipo 1
            τ=-a/b
            s=-1/sqrt(1+τ^2)
            c=s*τ
        else
            # tipo 2
			τ=-b/a
            c=1/sqrt(1+τ^2)
            s=c*τ
        end
    end
    return c,s
end

# ╔═╡ ca11ea3a-e4e7-4ad7-8a88-915e274539af
md"""Observe que $|\tau|\leq 1$ e que para calsuclar $s$ y $c$ necesitamos de 5 operaciones y una raíz cuadrada.  """

# ╔═╡ 13cb5cc9-c818-4f5d-ba96-ec35c75b3c39
md"""*Ejemplo:*

Consideremos el siguiente vector"""

# ╔═╡ e61cc769-d17d-47d3-9844-d122019d520d
v₁₁=[8; 6]

# ╔═╡ 0153bd7b-2e4f-4da5-964a-5e86f9d7c517
md"""La matríz de rotaciones de Givens es la siguiente:"""

# ╔═╡ d82dd29f-ee96-443b-9067-a8d1b3cc675e
begin
	c,s = Givens(v₁₁[1],v₁₁[2])
	G=[c -s; s c]
end

# ╔═╡ f99c3371-35a9-4bd0-95ae-1f8e5be6e6cf
md"""Así $G\cdot v$ es el siguiente vector"""

# ╔═╡ 67593be2-7185-4695-8d88-9682042ff043
G*v₁₁

# ╔═╡ ee4c46a7-aeaf-4029-900b-56522d6a1963
md"""Tenemos la siguiente función que  aplica una 
rotación de Gives dadas dos filas de una matriz $A$."""

# ╔═╡ e7691b15-f8ab-4f8f-95a7-d918c6d44057
function Giv(A, i, k, c, s)
    for j=1:size(A)[2]
        τ1 = A[i,j]
        τ2 = A[k,j]
    
        A[i,j] = c*τ1 - s*τ2
        A[k,j] = s*τ1 + c*τ2
    end
    return A
end

# ╔═╡ 7a3c3bf8-44d5-4d38-b73a-3d829f9bd2f6
md""" *Ejemplo:*

Consideremos la siguiente matriz aleatoria de tamaño $4\times 4.$"""

# ╔═╡ 2e34f7cb-56b2-4651-a47c-aae2d547d4dc
n= @bind N Slider(2:1:6, show_value=true, default=4)

# ╔═╡ 03219844-9eb9-433f-acfd-525455fcf83a
A₁₂ = floor.(10*rand(N, N))

# ╔═╡ 6c45f477-7356-4c0e-82df-bf1d64518411
md"""Realizamos la primera rotación de Givens (en las filas $2$ y $3$), se verifica si $a_{31}$ es distinto de $0$, si es así, se calcula la rotación de Givens volver dicha componente $0$."""

# ╔═╡ 9464edf3-1096-4e77-b64b-ad15fd256b76
begin
	if A₁₂[3,1] !=0.0
		c₁, s₁ = Givens(A₁₂[2,1], A₁₂[3,1])
		A₁₃= Giv(A₁₂ , 2,3 ,c₁,s₁)
	else
        A₁₃ = A₁₂
    end
	A₁₃
end

# ╔═╡ ae0d923f-40ba-413d-aef6-ba47d080eb5c
md"""Ahora bien, realizamos la segunda rotación de Givens (en las filas $1$ y $2$) para volver $0$ la componente $a_{12}.$ Obteniendo la siguiente matriz."""

# ╔═╡ 53cfcfd5-a41f-4518-8a2b-6b36d34efb54
begin
	c₂, s₂ = Givens(A₁₃[1,1], A₁₃[2,1])
	D = Giv(A₁₃, 1,2,c₂,s₂)
end

# ╔═╡ a4930f05-7401-4a3c-80b5-5ee906d19fda
md""" 
## Givens rápido
"""

# ╔═╡ 7bb9ca37-7339-4e47-8831-caa6895f7dfc
md""" 
Una matriz $G(i,k,\theta)$ puede escribirse (según sea tipo 1 o 2) como: 


$G(i,k,\theta)^T=
\mbox{diag}(1,\dots,1,-s,1,\dots,1,s,1,\dots)
\begin{pmatrix} 
\vdots & \vdots  & \vdots & \vdots & \vdots \\ 
\dots & -\tau  & \dots & 1 & \dots \\ 
\vdots & \vdots  & \vdots & \vdots & \vdots \\ 
\dots & 1  & \dots & \tau& \dots \\
\vdots & \vdots  & \vdots & \vdots & \vdots \\ 
\end{pmatrix}=S_1(i,k,s)T_1(i,k,\tau)$
o

$G(i,k,\theta)^T=
\mbox{diag}(1,\dots,1,c,1,\dots,1,c,1,\dots)
\begin{pmatrix} 
\vdots & \vdots  & \vdots & \vdots & \vdots \\ 
\dots & 1  & \dots & -\tau & \dots \\ 
\vdots & \vdots  & \vdots & \vdots & \vdots \\ 
\dots & \tau  & \dots & 1& \dots \\
\vdots & \vdots  & \vdots & \vdots & \vdots \\ 
\end{pmatrix}=S_2(i,k,c)T_2(i,k,\tau).$
"""

# ╔═╡ 4e512555-bed0-40d6-aa59-b351a6a25c77
md"""Tenemos así que, por ejemplo  

$G^T(i_1,k_1,\theta_1)A=S_p(i_1,k_1,c)T_p(i_1,k_1,\tau_1)=S_p(i_1,k_1,c_1)\widetilde{A}$

donde $A(1,k)=0$. Para el siguiente paso, tendriamos, 

$G^T(i_2,k_2,\theta_2)G^T(i_1,k_1,\theta_1)A= S_q(i_2,k_2,c_2)T_q(i_2,k_2,\tau_2)S_p(i_1,k_1,c_1)\widetilde{A}$
"""

# ╔═╡ 296f0f5a-f430-4acd-bef8-2eaf4694c1e9
md"""
Queremos proceder de tal manera que la multiplicación $C_p(i_1,k_1,c_1)\widetilde{A}$ no se haga y solo acumule hasta el final. Queremos escribir 

$T_q(i_2,k_2,\tau_2)S_p(i_1,k_1,c_1)= \text{ Digonal}\times \text{Matrix similar to S}$
"""

# ╔═╡ 12f4f64c-9746-4180-9e9c-c90be81b9de4
md""" 
Para esto consideramos dos casos dependiendo si la rotación de Givens es tipo 1 o tipo 2. Para simplificar consideremos solo las entradas implicadas en nuestra notación. Por ejemplo en el caso tipo 1, tenemos, 
"""

# ╔═╡ b13610de-ea16-4ee8-92f6-33fcd1b0653b
md""" 
$
G(a,b,\theta)^T
= \begin{pmatrix}
c&-s\\ s&c\end{pmatrix}=
\begin{pmatrix}
-s&0\\ 0&s\end{pmatrix}\begin{pmatrix}
-\tau&1\\ 1&\tau
\end{pmatrix}$

con $\tau=c/s$.
"""

# ╔═╡ 2e9b5a7f-f491-42ef-9516-5f1cf915bfa8
md"""
Para realizar la multiplicación por una nueva matriz diagonal por la derecha podemos usar que 

$\begin{pmatrix}
-\tau&1\\ 1&\tau\end{pmatrix}\begin{pmatrix}
d_1&0\\ 0&d_2\end{pmatrix}
=\begin{pmatrix}
d_1&0\\ 0&d_2\end{pmatrix}
\begin{pmatrix}
\left(\frac{d_1}{d_2}\right)^2 \frac{a_1}{b_1}&1\\ 1& -\frac{a_1}{b_1}\end{pmatrix}=
D(d_1,d_2) S_3$
y podemos realizar  la multiplicación $S_2\tilde{A}$ y acumular la multipliación de matrices diagonales $S_p\times D$. 
"""

# ╔═╡ 21018e14-b76e-48e4-8dbc-52990dbc34c0
md"""
Obtenemos así matrices $\tilde{G}_\ell=S_3(i,k)$ tales que

$D\tilde{G}_N\tilde{G}_{N-1}\cdots \tilde{G}_1 A= M (\text{ que es triangular superior})$
"""

# ╔═╡ de0dadd6-3b56-4604-bc10-297900a65092
md"""Para obtener las matrices $\tilde{G}_\ell$ basta calcular $\tau$. Para calcular las entradas de la diagonal de la matriz D, tenemos elementos de la forma 

$d^2=\prod_{\ell=1}^N\left(\frac{1}{1+\tau_\ell^2}\right)$
"""

# ╔═╡ 9a7ed401-4344-4039-aebc-9d3e6d4c8263
md"""
Se implementa la función FastGivens que define los valores de 
 $\alpha$ y $\beta$ 
 de la matriz que elimina la segunda entrada del vector $x$, La función modifica $d$. Para más detalles, ver $[1,2].$
"""

# ╔═╡ 083f1674-085f-4207-812c-6ce36b260a7e
#Input: x vector 2x1, d vecor 2x1 que representa las diagonales de una matriz 2x2
#Output: α, β y el tipo de la matriz.
function FastGivens(x, d)
    if x[2] !=0 
        α = -x[1]/x[2]
        β = -α*d[2]/d[1]
        γ = -α*β
        if γ ≤ 1
            tipo = 1
            τ = d[1]
            d[1] = (1+γ)*d[2]
            d[2] = (1+γ)*τ
        else
            tipo = 2
            α = 1/α
            β = 1/β
            γ = 1/γ
            d[1] = (1+γ)*d[1]
            d[2] = (1+γ)*d[2]
        end
    else
        tipo = 2
        α = 0
        β = 0
    end
    return α, β, tipo
end

# ╔═╡ c70369a5-8fac-4eae-8a2a-754e2621f8c6
A₁₄ = floor.(10*rand(4, 4))

# ╔═╡ 0bf40e80-8a00-4c82-88a7-ec95982eb1a0
md"""A continuación verificamos que se elimina la primera fila de la matriz $A_{14}$."""

# ╔═╡ 3a305d4c-3def-4a83-ac66-a281fa4f74a3
begin
	D₁₄ = ones(4)
	#Se copia A1 para no modificar la matriz inicial
	Aaux= copy(A₁₄)
	
	for k = 4:-1:2
	    d          = D₁₄[k-1:k]
	    α, β, tipo = FastGivens(Aaux[[k-1,k],1],d)
	    D₁₄[k-1:k]   = d
	
	    #Construimos la matriz G1
	    G1 = 1.0*Matrix(I, 4, 4)
	
	
	    if tipo == 1
	        G1[k-1:k,k-1:k] = [β 1; 1 α]
	    elseif tipo == 2
	        G1[k-1:k,k-1:k] = [1 α; β 1]
	    end
	    
	    #Actualizamos A1
	    Aaux = G1'*Aaux
	end
	
	sqrt.(D₁₄).*Aaux
end

# ╔═╡ 6527c6dc-d1d7-41fe-af22-d549647ccd0a
md"""
Ahora se implementa FastGivensQR, la cual toma una matriz $A$ y sobreescribe en ella una matriz triangular superior $T$ y devuelve las matrices $M, D$ que satisfacen:

$\begin{gather} M^{T}M = D\\
M^{T}A=T\\
A=\left(MD^{-\frac{1}{2}}\right)\left(D^{-\frac{1}{2}}T\right)
\end{gather}$

"""

# ╔═╡ 83988e50-454c-43ab-96dd-8c4f94c7d7fc
function FastGivensQR(P)
    m, n = size(P)
    D = ones(m)
    
    #Para guardar la matriz M
    M = 1.0*Matrix(I, m, m)
    
    for j = 1:n
        for i = m:-1:j+1
            
            d          = D[i-1:i]
            α, β, tipo = FastGivens(P[i-1:i,j],d)
            D[i-1:i]   = d
            
            if tipo == 1
                G = [β 1; 1 α]
                P[i-1:i,j:n] = G'*P[i-1:i,j:n]
                M[:,i-1:i] = M[:,i-1:i]*G
            else
                G = [1 α; β 1]
                P[i-1:i,j:n] = G'*P[i-1:i,j:n]
                M[:,i-1:i] = M[:,i-1:i]*G
            end
            
        end
    end
    return M, D
end

# ╔═╡ 131a04f5-67eb-4457-9239-9a0eb698d5db
md""" *Ejemplo:*

Ejecutamos el algoritmo sobre una matriz $A$, verificamos que $A=QR$ y la ortogonalidad de $Q$,
"""

# ╔═╡ 667ddc44-d8a9-4ef4-9e36-c0e36ebce40e
A₁₅  = floor.(20*rand(5,4))

# ╔═╡ 557c517c-897d-4e56-abf3-b0b0e3b0acae
md"""Así, usando givens rápido sobre $A$ se tiene lo siguiente"""

# ╔═╡ c4f50bbb-28dd-4ed5-a93f-50ede0bcb3cb
begin
	B₁₅=copy(A₁₅)
	M₁₅, D₁₅ = FastGivensQR(B₁₅)
end

# ╔═╡ 77c2194f-772e-49f3-a6dc-69bf8f50cf69
md"""De lo anterior se tiene que $Q$ y $R$ son, respectivamente,"""

# ╔═╡ e15d1205-1780-4d0d-a2d4-01edba895742
Q₁₅ = M₁₅*Diagonal(1 ./ sqrt.(D₁₅))

# ╔═╡ 65e2781c-8851-4628-87b9-1aab7bb26b22
R₁₅ = Diagonal(1 ./ sqrt.(D₁₅))*B₁₅

# ╔═╡ 313d2c07-be5f-4579-a8f1-904b068a87b5
md"""Verificamos que el error sea pequeño con ayuda de la norma."""

# ╔═╡ ef68b4f9-4bd3-4311-b8aa-0e1a5edaa049
begin
	println("La norma de M'M-D es ", opnorm(M₁₅'*M₁₅-Diagonal(D₁₅)))
	println("la norma de Q'Q-I es ", opnorm(Q₁₅'*Q₁₅ - UniformScaling(1)))
	println("La norma de Q*R-A es ", opnorm(Q₁₅*R₁₅-A₁₅))
end

# ╔═╡ 06b07e27-0781-434f-9e8c-04edcaba4f31
md"""# Referencias"""

# ╔═╡ 567004f4-77a1-4693-ba6e-017c4e84572e
md"""[1] Golub, G. H. (1996). Matrix computation and the theory of moments. Numerical analysis (Louvain-la-Neuve, 1995). Bull. Belg. Math. Soc. Simon Stevin, 1996(suppl.), 1–9.

[2] Saad, Y. (2003). Iterative methods for sparse linear systems (2nd ed.). Society for Industrial and Applied Mathematics.

[3] Martínez R., H. J., & Sanabria R., A. M. (2014). Álgebra Lineal. Programa Editorial Universidad del Valle.

[4] Strang, G. (2016). Introduction to Linear Algebra (5ta ed.). Wellesley-Cambridge Press.

[5] Boyd, S., & Vandenberghe, L. (2021). Introduction to Applied Linear Algebra: Vectors, Matrices, and Least Squares - Julia Language Companion. Cambridge University Press.

[6] Grossman, S. I., & Flores Godoy, J. J. (2012). Álgebra Lineal (7a ed.). McGraw-Hill.

[7] Labmatecc. Independencia lineal. Labmatecc. [https://labmatecc.github.io/Notebooks/AlgebraLineal/Independencialineal/](https://labmatecc.github.io/Notebooks/AlgebraLineal/Independencialineal/)"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.59"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "e41793cbd1124ea5d05573eb874098b20a960e1d"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

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
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

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
git-tree-sha1 = "ab55ee1510ad2af0ff674dbcced5e94921f867a9"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"

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
version = "5.11.0+0"

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
# ╟─db207f03-6472-44fc-ba20-2d14499af15b
# ╟─1275e9e7-63d1-47dc-a761-bbabd33b6670
# ╟─5b6c5c95-eaaa-41c6-b153-3a7bc9fe989b
# ╟─687d4852-9b98-4342-8e07-701d055b57ac
# ╟─bd96fb46-9a41-42a5-86f1-51eb05d3d312
# ╠═537df122-4692-4a5a-847f-70777ed330ce
# ╟─ecff234d-eb13-4cd9-aaa5-7bbf88c14271
# ╟─bc320da0-1258-46f0-8f07-b8d36cdbcdc9
# ╟─a5733492-14dc-4dc8-a596-80a82010a53c
# ╟─2bbf4bdf-ae76-4189-80b8-71b51c70fe62
# ╟─4592e579-0c6c-4599-98fc-f3f11507f4ab
# ╟─6193030e-3807-471c-aaf9-d3c8a3ac895e
# ╟─a5a2b67c-80ee-4f9b-a933-f3485a6cd892
# ╟─26847907-9d04-4c9e-b2e7-64248258c0dd
# ╟─2295fff5-1266-411a-9a77-b7483c488817
# ╟─df902773-1bef-4bb4-a53c-c16b68c14fd0
# ╠═9311ee53-94e6-49cc-8eaa-b5f2efcb9f16
# ╟─3573d257-bf10-46d2-9549-dfedcd95bc82
# ╠═93a5cf53-5796-4ca6-879b-5271eb49f2f6
# ╟─bd4ae79d-a712-4a5e-9d85-2c6b24aefdf3
# ╠═a5cc8644-a521-407e-af28-9983da292b63
# ╟─aa63c29e-c5c7-4ee6-91fb-f4dfaf01b5e7
# ╠═36d99657-dcfb-4516-9265-0cc8d61ae35e
# ╟─db3855fb-f8d2-484b-a95c-e467ba8dfc93
# ╠═160a23f8-0950-40c3-8aa2-d25ca8b22913
# ╟─eb6b82d9-2047-44e7-b104-a3ea8a977d3a
# ╟─029f4ce6-87da-44be-afd4-776230245937
# ╟─5a8f5d62-3f4e-48ab-aef7-8a9446e33f14
# ╟─a715a5f4-6754-4551-92b9-b91586c56616
# ╠═11ce39a8-7b98-4ea5-bfe9-81c7bbfd9e8e
# ╟─575ae122-a70d-4c28-8c93-4213b72f5a6a
# ╠═7bcc8c19-176b-4bec-9788-14bed749f920
# ╟─d57bf3b8-8758-4734-a23c-5b256943b946
# ╠═d88bb07b-84b2-42e7-8732-dc94fee01cfd
# ╟─adc0d7dd-665c-49ce-b5f9-442fe2d5c000
# ╠═6e610a1f-fb78-491a-8719-fb26e48f694b
# ╟─ef43ca1d-a653-4a5d-97a4-4009fdfad54c
# ╠═26bd3a24-5c5b-4d1a-82b0-3c00b3b8443d
# ╟─8aa0a10e-48d2-4f1d-865a-64786821c8f6
# ╠═1fff49b0-de66-4d7a-be0a-54da00d29d60
# ╟─3acf0e47-42cb-4d43-aa81-4823c95a3dda
# ╠═a3a992d9-6757-4a3e-9bd9-cd568fd60dca
# ╠═9bd370df-7194-4dcc-acdf-9c66c53fc142
# ╟─fa729ae6-54c9-467a-8bd7-03abdb295a3b
# ╟─f3e51af1-5dcc-4bbf-b190-cfcbd741b231
# ╟─99f54ca8-46a5-4c06-8164-38b648f27629
# ╟─1b72085e-a0fd-4c17-aca4-56622a4a5bb3
# ╟─29959f97-471f-4e2f-a124-eedea72fbab3
# ╟─b1eabc55-366c-4994-9ede-c73747180268
# ╟─ddf93e9b-5d73-410c-b3a0-ac39e1075746
# ╠═06efe5f4-8f9a-411b-a63a-28280f579212
# ╟─ca11ea3a-e4e7-4ad7-8a88-915e274539af
# ╟─13cb5cc9-c818-4f5d-ba96-ec35c75b3c39
# ╠═e61cc769-d17d-47d3-9844-d122019d520d
# ╟─0153bd7b-2e4f-4da5-964a-5e86f9d7c517
# ╠═d82dd29f-ee96-443b-9067-a8d1b3cc675e
# ╟─f99c3371-35a9-4bd0-95ae-1f8e5be6e6cf
# ╠═67593be2-7185-4695-8d88-9682042ff043
# ╟─ee4c46a7-aeaf-4029-900b-56522d6a1963
# ╠═e7691b15-f8ab-4f8f-95a7-d918c6d44057
# ╟─7a3c3bf8-44d5-4d38-b73a-3d829f9bd2f6
# ╟─2e34f7cb-56b2-4651-a47c-aae2d547d4dc
# ╠═03219844-9eb9-433f-acfd-525455fcf83a
# ╟─6c45f477-7356-4c0e-82df-bf1d64518411
# ╠═9464edf3-1096-4e77-b64b-ad15fd256b76
# ╟─ae0d923f-40ba-413d-aef6-ba47d080eb5c
# ╠═53cfcfd5-a41f-4518-8a2b-6b36d34efb54
# ╟─a4930f05-7401-4a3c-80b5-5ee906d19fda
# ╟─7bb9ca37-7339-4e47-8831-caa6895f7dfc
# ╟─4e512555-bed0-40d6-aa59-b351a6a25c77
# ╟─296f0f5a-f430-4acd-bef8-2eaf4694c1e9
# ╟─12f4f64c-9746-4180-9e9c-c90be81b9de4
# ╟─b13610de-ea16-4ee8-92f6-33fcd1b0653b
# ╟─2e9b5a7f-f491-42ef-9516-5f1cf915bfa8
# ╟─21018e14-b76e-48e4-8dbc-52990dbc34c0
# ╟─de0dadd6-3b56-4604-bc10-297900a65092
# ╟─9a7ed401-4344-4039-aebc-9d3e6d4c8263
# ╠═083f1674-085f-4207-812c-6ce36b260a7e
# ╠═c70369a5-8fac-4eae-8a2a-754e2621f8c6
# ╟─0bf40e80-8a00-4c82-88a7-ec95982eb1a0
# ╠═3a305d4c-3def-4a83-ac66-a281fa4f74a3
# ╟─6527c6dc-d1d7-41fe-af22-d549647ccd0a
# ╠═83988e50-454c-43ab-96dd-8c4f94c7d7fc
# ╟─131a04f5-67eb-4457-9239-9a0eb698d5db
# ╠═667ddc44-d8a9-4ef4-9e36-c0e36ebce40e
# ╟─557c517c-897d-4e56-abf3-b0b0e3b0acae
# ╠═c4f50bbb-28dd-4ed5-a93f-50ede0bcb3cb
# ╟─77c2194f-772e-49f3-a6dc-69bf8f50cf69
# ╠═e15d1205-1780-4d0d-a2d4-01edba895742
# ╠═65e2781c-8851-4628-87b9-1aab7bb26b22
# ╟─313d2c07-be5f-4579-a8f1-904b068a87b5
# ╟─ef68b4f9-4bd3-4311-b8aa-0e1a5edaa049
# ╟─06b07e27-0781-434f-9e8c-04edcaba4f31
# ╟─567004f4-77a1-4693-ba6e-017c4e84572e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
