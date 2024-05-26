### A Pluto.jl notebook ###
# v0.19.39

using Markdown
using InteractiveUtils

# ╔═╡ db207f03-6472-44fc-ba20-2d14499af15b
using PlutoUI

# ╔═╡ 537df122-4692-4a5a-847f-70777ed330ce
using LinearAlgebra

# ╔═╡ 1275e9e7-63d1-47dc-a761-bbabd33b6670
PlutoUI.TableOfContents(title="Independencia lineal II", aside=true)

# ╔═╡ 5b6c5c95-eaaa-41c6-b153-3a7bc9fe989b
md"""Este cuaderno esta en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias por favor escribir a jcgalvisa@unal.edu.co

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 687d4852-9b98-4342-8e07-701d055b57ac
md"""Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo."""

# ╔═╡ bd96fb46-9a41-42a5-86f1-51eb05d3d312
md"""Usaremos esta librería"""

# ╔═╡ ecff234d-eb13-4cd9-aaa5-7bbf88c14271
md"""# Introducción"""

# ╔═╡ 96817925-53b3-45e3-83c8-a1ab2c747ad8
md"""
Considermos el problema de ortogonaliar las columnas de una matriz dada $A$. Los métodos mas usados son
1. Gram-Schmidt clásico, CGS,  ([Gram](https://en.wikipedia.org/wiki/J%C3%B8rgen_Pedersen_Gram) 1883, Popularizado por [Schmidt](https://en.wikipedia.org/wiki/Erhard_Schmidt) 1907)
2. Gram-Schmidt modificado, MG (Desde 1820 por [Laplace](https://en.wikipedia.org/wiki/Pierre-Simon_Laplace))
3. Householder (H) (usando reflexiones). Desarrollado en 1958 por [Householder](https://en.wikipedia.org/wiki/Alston_Scott_Householder) en el [Oak Ridge National Laboratory](https://www.ornl.gov/)
4. Givens (G) (usando rotaciones). Desarrollado en 1950 por [Givens](https://en.wikipedia.org/wiki/Wallace_Givens) en el [Argone National Laboratory](Argone National Laboratory).
Además se usa 
5. Reortogonalización 

En aplicaciones practicas CGS es poco usado. MGS es mas estable que CGS. H es el mejor método en términos de estabilidad. G tiene mas calculos pero puede ser usado para matrices esparsas (ralas). En ocaciones debido a errores numéricos o perturbaciones es conveniente reortogonalizar, por ejemplo se puede combinar MGS con reortogonalización.


La ortogonalización de vectores tiene muchas aplicaciones. Por ejemplo en la solución estable de sistemas lineales. Se puede por ejemplo usar ortogonalización para calcular de forma estable la factorización $LU$. Existen métodos iterativos para calculo de vectores propios que son basados en ortogonalización. También es usado en el cálculo de la descomposición SVD. 
"""

# ╔═╡ 172c756c-c7f4-480d-9e4a-52fbc0564ed2
md"""
Sea $Q\in \mathbb{R}^{m\times p}$, decimos que $Q$ es ortogonal si $Q^TQ=I_{p\times p}$. Si $Q\in \mathbb{C}^{m\times p}$, decimos que $Q$ es unitaria si $Q^*Q=I$. 

Note que si $q_j$, $j=1,2,\dots,p$, denotan las columas de $Q$, entonces $q_j\in \mathbb{R}^m$ y $q_i^Tq_j=\delta_{ij}$. 
"""

# ╔═╡ a645cf2d-f176-4947-8122-bcdf41aa5c9d
md""" 
# Teorema de ortogonalización

Terminamos enunciado el siguiente resultado.

**Teorema:** Si las columnas de $A$ son linealmente independientes y $r_{ii}>0$ para $i=1,\dots,n$ entonces la factorización $A=Q_1R_1$ con $Q_1$ ortogonal y $R_1$ triangular superior es única. 

**Demostración:** Dado que $A=Q_1R_1$ implica $A^TA=(Q_1R_1)^T(Q_1R_1)= R_1^T ( Q_1^TQ_1)R_1=R_1^TR_1$, el resultado se sigue de la unicidad de la factorización de Cholesky para matrices positivas definidas, en este caso aplicada a $A^TA$. """

# ╔═╡ 5aa7ba63-870f-4b1b-a2da-02cc21295e87
md""" # Reflexiones de Householder

Dado $v\in\mathbb{R}^m$ defina la matrix de Housholder por $\displaystyle H_v=I - 2\frac{vv^T}{v^Tv}.$ Decimos que $v$ es el vector de Hoseholder.  Podemos verificar que 

1. La matriz $H$ es una isometría en la norma $\|\cdot\|_2$.
2. La matriz $H$ es simétrica 
3. La matriz $H$ es ortogonal

Dado $x\in \mathbb{R}^m$, la reflexión de $x$ con eje de reflexión el huperplano $v^\perp$ es dada por 
$y=H_vx = x- 2\frac{v^Tx}{v^Tv}v.
$
Note que para cacular $y$ no es necesario calcular todas la entradas de la matriz $H$, es suficiente calcular el producto interno $s=v^Tx$ y realizar la resta $x-\beta s v$ donde $\beta= 2\frac{1}{v^Tv}$. El valor de $\beta$ puede ser precalculado. 
"""

# ╔═╡ 8acbac14-8724-4e01-b6e4-4000c6345233
md""" 
Dados $x,y\in \mathbb{R}^m$. ¿Existe $v$ tal que $H_vx=y$?. Si $\|x\|_2=\|y\|_2$ la respuesta es afirmativa  y 
$v=\alpha (x-y)$. 

Para usar Householder en ortogonalización procedemos como sigue. Suponga que queremos orgonaliar las columnas de $A=(a_1,a_2,\dots,a_n)\in \mathbb{R}^{m\times n}$. Considere inicialmente el caso de columnas linealmente independientes. Iniciamos la ortogonalización de Householder calculando $v$ que transforme $a_1$ en un multiplo del primer vector canónico $e_1=(1,0,\dots,0)$. Es decir $H_v a_1= \sigma e_1$ con $\sigma = \pm \|x\|_2$.



Suponga que $x\in\mathbb{R}^m$ y queremos calcular $v$ tal que $H_v x$ sea múltiplo de $e_1$, digamos $\sigma e_1$. Debe ser $\sigma= \pm\|x\|_2$. Observe que 

$x-\sigma e_1 = (x_1-\sigma,x_2,x_3,\dots,x_m).$

En la resta $x_1-\sigma$ puede ocurrir cancelacion catastrófica. Tenemos las siguientes opciones para evitar la cancelación catastrófica, 

*Opción 1:* Observe que si $x_1>0$ entonces $x$ esta mas cerca a  $\|x\|_2e_1$ que a $-\|x\|_2e_1$. Entonces podemos tomar $\sigma = -\mbox{sign}(x_1)$ y evitamos la cancelación catastrófica. 
Despues de calcular $v_1=x_1-\sigma$ podemos calcular 

$\beta =  \frac{2}{v^Tv}= \frac{2}{ v^Tv} = \frac{2}{ v_1^2+s}$

donde $s=x_2^2+\dots+x_m^2$.

*Opción 2:* Podemos seleccionar $\sigma=\|x\|_2$ pero tener cuidado al calcular $x_1-\sigma$. 
- Si $x_1<0$ entonces podemos calcular $v_1=x_1-\sigma$ (no hay resta).
- Si $x_1>0$ entonces calculamos 
    $x_1-\sigma = (x_1-\sigma) \frac{x_1+\sigma}{x_1+\sigma}= \frac{x_1^2-\|x\|_2^2}{x_1+\sigma}= 
    -\frac{x_2^2+\dots+x_m^2}{x_1+\sigma} = - \frac{s}{x_1+\sigma}$ donde $s=x_2^2+\dots+x_m^2$.
    
    Note tambien que se puede calcular $v^Tv$ como sigue (recuerde que $\sigma=\|x\|_2$)
    
$v^Tv= (x_1-\sigma)^2+x_2^2+\dots+x_m^2 = x_1^2-2\sigma x_1+\sigma^2+x_2^2+\dots+x_m^2= 
    2\sigma^2 - 2\sigma x_1= 2\sigma (\sigma -x)= -2\sigma v_1.$

En muchas implementaciones para ahorar en memoria se normaliza $v$ de tal forma que $\tilde{v}=v/v_1$ y se guardan las entradas $n-1$ últimas entradas de  $v_2/v_1,\dots,v_m/v_1$  en las entradas de $x_2,x_3, \dots,x_m$ (debajo de la diagonal de la matriz $R$ en aplicacion de ortonormalización).

Tenemos entonces el siguiente algorimos que dado un vector $x$, calcula de forma correcta el vector de Householder $v$. Algoritmo 5.1.1, página 210 del texto guía. """

# ╔═╡ 2586a5af-1604-4ccc-99e9-43e4cbc0b51f
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

# ╔═╡ 686f7301-e588-4819-a88e-460d175eaf38
md""" 
## Ejemplo 5
Considere el siguiente ejemplo."""

# ╔═╡ 0d3cddee-0a20-48c3-958e-1ca3ec890e3b
begin
x=[0.5;sqrt(3)/2;4];
v, β= house(x)
println(v)
println(β)
print(x)
end

# ╔═╡ 6b024c51-f449-473d-b07e-f0d54b046af1
H=UniformScaling(1)- 2(v*v')/(v'v)

# ╔═╡ dc01bbf0-8f62-4f2f-a64d-40ea2cdce63e
H*x

# ╔═╡ 49da426d-9b98-4e93-9ec3-d90385c28046
md""" 
Note que si estamos haciendo la factorización de una sola columna, $x$, entonces $H^T$ corresponde a la matriz $Q$ de la factorización $QR$, **pero esta vez la matriz $Q$ es cuadrada y genera todo $\mathbb{R}^m$**. Es decir, obtenemos la factorización completa. En esta caso las filas $2:m$ de la matriz $H$ son vectores ortogonales a $x$. Recuerde que si queremos obtener la factorizació completa con GS tendríamos que iniciar con $m$ columnas, es decir, tendriamos que encontrar $m-n$ columnas linealmente independientes a las que tenemos y despues aplicar GS. 
"""

# ╔═╡ 21935a4e-cd5c-4a43-821e-9ffb4399147b
md""" ## Uso de Householder en ortogonalización"""

# ╔═╡ 47a1f5fb-52d5-4956-901c-d0cd4990facb
md""" 
Consideremos nuevamente la matrix $A=(a_1,a_2,\dots,a_n)$. Aplicando el procedimiento anterior construimos $H_1$ tal que 
$A_1=H_1A = (\sigma e_1, H_1a_2,\dots, H_1a_n)$
es una matriz con $A_1(2:m,1)=(0,\dots,0)$. 
Ahora debemos obtener entradas nulas también en la segunda columna debajo de la diagonal.
Para continuar con la triagularización de Householder construimos una reflexion de Householder en $\mathbb{R}^{m-1}$ que transforme el vector $A_1(2:m,{\color{red}{2}})$ en el vector $(1,0,\dots,0)\in \mathbb{R}^{m-1}$. Sea $\tilde{H}_2$ esta transformación. Defina 

$H_2= \begin{pmatrix}1 & 0\\ 0 &\tilde{H}_2\end{pmatrix}.$

Vemos que $H_2H_1a_2= (A_1(1,2), \sigma_2,0,\dots,0)\in \mathbb{R}^m$. 
Concluimos que $A_2= H_2H_1 A =  ( \sigma e_1, H_2H_1a_2, H_2H_1a_3,\dots, H_2H_1a_n)$
es una matriz con entradas nulas debajo de la diagonal en las dos primeras columnas. 

Podemos continuar este proceso hasta la ultima columna y obtenemos una matriz triangular superior. Es decir, obtenemos 
$H_nH_{n-1}\cdots  H_1  A = R
$
y por tanto $ A= H_1^TH_2^T\cdots H_n^T R =QR$ donde $Q=H_1H_2\cdots H_n$. 

Note que quedamos con la matriz $R$ pero para poder obtener la matriz $Q$ debemos, en prinicipio, multiplicar las matrices $H_i$, lo cual es computacionalmente costoso. Veamos primero como queda el algoritmos para obtener $R$ y después  mostraremos un algoritmo para construir $Q$. 


Considere el algorimos en la página 211 que usa el algoritmo anterior para obtener la matriz $R$ de la factorizacion $QR$. Recuerde que asumimos que las columnas de $A$ son linealmente independientes. 
"""

# ╔═╡ f31d90d8-5168-449c-894a-b38e90e8f671
function Rhouse(A)
    m,n = size(A)
    for j = 1:n
        v, β = house(A[j:m,j])
        A[j:m,j:n] = ( UniformScaling(1) - β*v*v')A[j:m,j:n]
#        A[j+1:m,j]=v[2:end]
    end
    return A
end

# ╔═╡ 7f1b9df8-b615-4e56-a29a-30ee91f414d4
begin
n₁₀ = 3 ;
m₁₀ = 5 ;
A₁₀ = rand(m₁₀,n₁₀)
B₁₀ = A₁₀
end

# ╔═╡ fc6bbc21-17a4-4fe3-9f87-9d4f690bee5a
R₁₀h=Rhouse(B₁₀)

# ╔═╡ 42a9d7cf-dc39-4fad-ac3a-c68353c37473
md""" 
##  Matriz $Q$ acumulación progresiva
"""

# ╔═╡ f83064a3-a069-49ca-8fd3-21acf7644a81
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

# ╔═╡ 927c7a39-c246-479f-bb80-98bf1695c666
begin
Q₁₀,R₁₀=QFA(copy(A₁₀))
#Q11'*Q11
A₁₀-Q₁₀*R₁₀
end

# ╔═╡ cc29c002-414b-4c9d-a32d-60e0f5d2dd47
Q₁₀[:,1:n₁₀]

# ╔═╡ aecf4109-da0b-4697-a1d1-a48ccbfb3613
Q₁₀[:,n₁₀+1:m₁₀]

# ╔═╡ 85d9218c-5e9f-4a63-bb68-cdfb3f1bc333
begin
	n₁₁ = 30 ;
	m₁₁ = 50 ;
	A₁₁ = rand(m₁₁,n₁₁);
	B₁₁ = A₁₁;
	Q₁₁,R₁₁=QFA(A₁₁);
end

# ╔═╡ f979d7b3-aa78-4d4c-a610-41f971e39d3d
opnorm(UniformScaling(1)-Q₁₁'Q₁₁)

# ╔═╡ 90183fec-5530-4502-9974-b1fad810224c
opnorm(A₁₁-Q₁₁*R₁₁)

# ╔═╡ a917a34e-9922-4281-bc99-8c73d503093a
md""" 
##  Matriz $Q$: acumulación progresiva
"""

# ╔═╡ f5565ecd-cd50-405f-b0ca-900b02f2bc87
md""" 

Mencionamos antes que realizar la multiplicación de las matrices de Householder puede ser costoso. En su lugar, cuando se requiere la $R$ podemos usar al siguiente resulado. 

"""

# ╔═╡ 450a7a6d-efb5-4b8d-aa40-dfb3826c1c0d
md""" 
**Teorema (Representación por bloques de Householder)** Si definimos 
$Q_1=H_1, \quad Q_2=H_1H_2, \dots, Q_i=H_1H_{2}\cdots H_{i-1}H_i= Q_{i-1}H_i$
entonces $Q_i=I +W_i Y_i^T$, $i=1,2,\dots,n$, $W_i, Y_i \in \mathbb{R}^{m\times i}$.

**Demostración:** Tensmos que $Q_1=H_1=I -\beta_1 v_1 v_1^T==I +W_1 Y_1^T$ donde $W_1=-\beta_1v_1$ y $Y_1=v_1$. Continuando por inducción suponga que 
$Q_j=I +W_j Y_j^T$, con $W_j,Y_j\in \mathbb{R}^{m\times j}$. Tenemos que 

$\begin{align}
Q_{j+1}=Q_jH_{j+1}&= (I +W_j Y_j^T)(I -\beta_{j+1}v_{j+1}  v_{j+1}^T)\\
&= I +W_j Y_j^T -\beta_{j+1}Q_jv_{j+1}  v_{j+1}^T\\
&= I +W_j Y_j^T +z_{j+1} v_{j+1}^T \quad \mbox{ con } \quad z_{j+1}=-\beta_{j+1}Q_jv_{j+1},\\
&=  I +[W_j\quad  z_{j+1}][Y_j \quad v_{j+1}]^T\\
&= I +W_{j+1} Y_{j+1}^T.
\end{align}$
"""

# ╔═╡ e4bd815e-0f8f-4aa1-b659-3293f245ac1b
function VβHouse(A)
    m,n = size(A)
    β   = zeros(n,1)
    Y   = zeros(m,n)

    Am  = copy(A)
    
    # Primera actualización
    v1,β[1] = house(Am[:,1])
    Y[:,1]  = v1
    W       = -β[1]*v1
    Am      = ( UniformScaling(1) - β[1]*v1*v1')Am
    
    #De ahi para adelante
    for j = 2:n
        v1,β[j] = house(Am[j:m,j])
        Y[:,j]  = [ zeros(j-1,1) ; v1 ] 
        z       = -β[j]*(UniformScaling(1)+W*Y[:,1:j-1]')*Y[:,j]
        W       = [ W z ]
        Am[j:m,j:n] = ( UniformScaling(1) - β[j]*v1*v1')Am[j:m,j:n]
    end
    
    
    return Y,W,Am
end

# ╔═╡ 6e4a35d6-c365-4cb2-b6c6-c010151c3f18
Y,W,R = VβHouse(A₁₀)

# ╔═╡ f959900f-1785-4b6e-92e1-4ca2cfb6d6ab
display(Y)

# ╔═╡ 6c7ed78c-7084-462f-830a-5c007cb83620
display(W)

# ╔═╡ 3e2df74d-3b00-4294-9662-5ec36b5e1b04
Q₁₀r = UniformScaling(1) + W*Y'

# ╔═╡ c9172d77-f6ce-42e5-b866-679d4412d1b2
A₁₀-Q₁₀r*R

# ╔═╡ 7b7eeac0-1b60-4145-86f3-c14be909121d
md""" ## Observaciones

El costo de este algoritmo es del orden de $2n^2m-2n^3/3$.

Una ventaja empirica de Householder es que opera con transformaciones ortogonales, así que preserva normas, mientras que MGS no tiene transformaciones ortogonales. 

Otra ventaja es que cuando los vectores son casi linealmente independientes, en las cuentas del algoritmos de Householder se hace el cálculo numerico con cuidado, esto no se hace en MGS.
"""

# ╔═╡ a669b08d-e608-4fd6-8104-b60ea5cf8419
md"""# Rotaciones de Givens """

# ╔═╡ 71b65271-f6ad-4d19-af2a-e09d0644e6a9
md""" También conocido como rotaciones de planos. Se aplica en el caso de matrices dispersas (sparse matrices) ya que tiene un efecto "local". """

# ╔═╡ b98a9ad3-4774-4397-8040-a39c85633e71
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

# ╔═╡ aac81505-9de9-4faf-979b-8c206e4424d6
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

# ╔═╡ d4d04c4c-0354-420c-9014-9e70b1acf140
md"""Si

$x_i=||x||\cos(\phi), \quad x_k=||x||\sin(\phi)$
entonces

$y_i=||x||\Big( \cos(\theta)\cos(\phi)-\sin(\theta)\sin(\phi) \Big) =||x||
\cos(\theta+\phi)$
y

$y_i=||x||\sin(\theta+\phi).$
Si queremos $y_k=0$ tenemos así dos alternativas, $\theta=-\phi$ o $\theta=\pi-\phi$.
Escogemos $\theta=-\phi$. De donde

$c=\cos(\theta)=\frac{x_i}{\sqrt{x_i^2+x_k^2}}, \quad
s=\sin(\theta)=-\frac{x_k}{\sqrt{x_i^2+x_k^2}}$
"""

# ╔═╡ 4903bc32-709c-4bb6-9d38-02ce341f0f73
md"""Tenemos el siguiente algoritmo (que evita división por la menor componente y también evita división por norma pequeña."""

# ╔═╡ a448ba92-6e0e-4fc9-8593-dd4b959d9064
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

# ╔═╡ a4cedd9f-a634-4896-994f-5d3a95455947
md"""Observe que $|\tau|\leq 1$ e que para calsuclar $s$ y $c$ necesitamos de 5 operaciones y una raíz cuadrada.  """

# ╔═╡ 60c24631-edff-40d1-a206-0ba660f2a9cd
md""" ## Ejemplo 6"""

# ╔═╡ 26039653-4ddc-4f0c-8cd3-6b573e4eb2b8
begin
	v₁₁=[8; 6]
	c,s = Givens(v₁₁[1],v₁₁[2])
	G=[c -s; s c]
end

# ╔═╡ 396cba4d-e917-40d0-a0f3-cbcaedaf2426
G*v₁₁

# ╔═╡ 8a2f9a09-59f4-4439-b588-df50ad700434
md"""Tenemos la siguiente función que  aplica una 
rotación de Gives dadas dos filas de una matriz $A$."""

# ╔═╡ 5aa40728-98a9-4889-8c4a-db1e847c5af1
function Giv(A, i, k, c, s)
    for j=1:size(A)[2]
        τ1 = A[i,j]
        τ2 = A[k,j]
    
        A[i,j] = c*τ1 - s*τ2
        A[k,j] = s*τ1 + c*τ2
    end
    return A
end

# ╔═╡ b4848641-6639-4ee1-834e-aaa0a297afd9
md""" ## Ejemplo 7"""

# ╔═╡ b6b1d326-854c-4e02-836c-bbbd3de081dd
begin
	A₁₂ = floor.(10*rand( 3, 3))
	B₁₂=copy(A₁₂)
end

# ╔═╡ 0226c6c0-ef0a-4123-8f33-63f96ac7ce1a
begin
	if( A₁₂[3,1] !=0.0)
	c₁, s₁ = Givens(A₁₂[2,1], A₁₂[3,1])
	A₁₃= Giv(B₁₂ , 2,3 ,c₁,s₁)
	end
	A₁₃
end

# ╔═╡ af14f7a0-6765-4454-a985-0265934f9d4f
begin
	c₂, s₂ = Givens(A₁₃[1,1], A₁₃[2,1])
	D = Giv(A₁₃, 1,2,c₂,s₂)
end

# ╔═╡ 8f396bc5-1fe0-4723-b41f-dc8818dd9ffb
md""" 
## Givens rápido
"""

# ╔═╡ a69a2fce-ddbf-486a-81cd-1f0cf2f155fb
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

# ╔═╡ ab8c204c-91a2-4db0-97a6-ffd9ba6c50ab
md"""Tenemos así que, por ejemplo  

$G^T(i_1,k_1,\theta_1)A=S_p(i_1,k_1,c)T_p(i_1,k_1,\tau_1)=S_p(i_1,k_1,c_1)\widetilde{A}$

donde $A(1,k)=0$. Para el siguiente paso, tendriamos, 

$G^T(i_2,k_2,\theta_2)G^T(i_1,k_1,\theta_1)A= S_q(i_2,k_2,c_2)T_q(i_2,k_2,\tau_2)S_p(i_1,k_1,c_1)\widetilde{A}$
"""

# ╔═╡ 092d92b5-a499-4c30-92c2-8536ba6cafdc
md"""
Queremos proceder de tal manera que la multiplicación $C_p(i_1,k_1,c_1)\widetilde{A}$ no se haga y solo acumule hasta el final. Queremos escribir 

$T_q(i_2,k_2,\tau_2)S_p(i_1,k_1,c_1)= \text{ Digonal}\times \text{Matrix similar to S}$
"""

# ╔═╡ 7e8aeab0-e46b-485d-9c1c-49f7f349f59b
md""" 
Para esto consideramos dos casos dependiendo si la rotación de Givens es tipo 1 o tipo 2. Para simplificar consideremos solo las entradas implicadas en nuestra notación. Por ejemplo en el caso tipo 1, tenemos, 
"""

# ╔═╡ e593f931-957a-4054-b2b4-2fd5301bfa50
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

# ╔═╡ f4db36eb-0669-416d-927d-b20ee197a15a
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

# ╔═╡ db108ef8-3c3e-4ea5-916c-9bfbf72ed9d3
md"""
Obtenemos así matrices $\tilde{G}_\ell=S_3(i,k)$ tales que

$D\tilde{G}_N\tilde{G}_{N-1}\cdots \tilde{G}_1 A= M (\text{ que es triangular superior})$
"""

# ╔═╡ 89e4bca0-e984-4fed-bf8b-8a493020b1f8
md"""Para obtener las matrices $\tilde{G}_\ell$ basta calcular $\tau$. Para calcular las entradas de la diagonal de la matriz D, tenemos elementos de la forma 

$d^2=\prod_{\ell=1}^N\left(\frac{1}{1+\tau_\ell^2}\right)$
"""

# ╔═╡ bb59d3ed-e13b-4140-ac84-e8ec1a726368
md"""
Se implementa la función FastGivens que define los valores de 
 $\alpha$ y $\beta$ 
 de la matriz que elimina la segunda entrada del vector $x$, La función modifica $d$.
"""

# ╔═╡ e173aeea-050a-4df3-aa65-8660a27236f7
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

# ╔═╡ 1e079e91-0f65-4261-a9b9-e6ddd6e6bcd9
A₁₄ = floor.(10*rand(4, 4))

# ╔═╡ 75cd6109-1982-433f-b36c-e0d44e138d2d
md"""A continuación verificamos que se elimina la primera fila de la matriz $A_{14$}."""

# ╔═╡ 837534d5-2079-4e8b-ac64-1e2b07b98819
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

# ╔═╡ 6696c1b0-3fef-4668-9df5-1c158abbd1cc
md"""
Ahora se implementa FastGivensQR, la cual toma una matriz $A$ y sobreescribe en ella una matriz triangular superior $T$ y devuelve las matrices $M, D$ que satisfacen:

$\begin{gather} M^{T}M = D\\
M^{T}A=T\\
A=\left(MD^{-\frac{1}{2}}\right)\left(D^{-\frac{1}{2}}T\right)
\end{gather}$

"""

# ╔═╡ 9a1f938f-fdc1-4cd7-a2ad-a1a78cbf5697
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

# ╔═╡ dac13369-d651-4382-a47b-874663365096
md""" ## Ejemplo 8
Ejecutamos el algoritmo sobre una matriz $A$, verificamos que $A=QR$ y la ortogonalidad de $Q$,
"""

# ╔═╡ ea739032-5a45-42cb-8e95-8776bd37e6a1
A₁₅  = floor.(20*rand(5,4))

# ╔═╡ 946e765b-6273-4332-a945-32707ebec723
begin
	B₁₅=copy(A₁₅)
	M₁₅, D₁₅ = FastGivensQR(B₁₅)
	
	
	Q₁₅ = M₁₅*Diagonal(1 ./ sqrt.(D₁₅))
	R₁₅ = Diagonal(1 ./ sqrt.(D₁₅))*B₁₅
end

# ╔═╡ 0192486e-319c-4b44-add6-2c8e669fc34f
begin
	println("La norma de M'M-D es ", opnorm(M₁₅'*M₁₅-Diagonal(D₁₅)))
	println("la norma de Q'Q-I es ", opnorm(Q₁₅'*Q₁₅ - UniformScaling(1)))
	println("La norma de Q*R-A es ", opnorm(Q₁₅*R₁₅-A₁₅))
end

# ╔═╡ 4901f309-bf67-40ad-9b1c-a216cc0db42b
md""" 
# Householder con dependencia lineal
"""

# ╔═╡ c1b3e1ed-d76f-4514-b85b-a2fcead6c658
md"""
Cosidere ahora $A\in\mathbb{R}^{m\times n}$ con $A=[a_1,a_2,\dots,a_n]$ donde $a_i, i=1,2,\dots,n$ denotan las columnas de $A$ que no son necesariamente linealmente independientes. 

Podemos aplicar, por ejemplo, Householder con permutación de columnas y si en ese caso llegamos hasta el paso $r$, entonces, $\mbox{rank}(A)\geq r$ y además, 

$
H_rH_{r-1}\cdots H_1 A \pi_1\pi_2\cdots\pi_r =
\begin{pmatrix}
R_{11}&R_{12}\\ 0&R_{22}\end{pmatrix}$
donde $R_{11}$ es de tamaño $r\times r$, $R_{1,2}$ es de tamaño $(r,n-r)$, 
$R_{2,2}$ es de tamaño $(m-r)\times (m-r)$ y $0$ representa la matriz $0$ de tamaño 
$(m-r)\times r$.
"""

# ╔═╡ c12ed9df-e9aa-42e2-be20-0f20e9881f9f
md"""
Supongamos que $\mbox{rank}(A)=r$, debe ser $R_{2,2}\equiv 0$. Queremos ahora obtener "0" en el lugar de $R_{2,1}$, para esto observe que podemos aplicar Hoseholder a 

$
\begin{pmatrix}
R_{12}^T\\ R_{12}^T\end{pmatrix}$
para obtener

$
Z_r\dots Z_1\begin{pmatrix}
R_{12}^T\\ R_{12}^T\end{pmatrix}=
\begin{pmatrix}
T_{11}^T\\ 0\end{pmatrix} \mbox{ y por tanto } \begin{pmatrix}
R_{11} & R_{12}\end{pmatrix}\widetilde{Q}= \begin{pmatrix}
T_{11} & 0\end{pmatrix}$
con $T_{11}$ de tamaño $r\times r$ triangular inferior y 
$\widetilde{Q}^T=Z_r\dots Z_1$. Note que en esta última aplicación de Householder no es necesario aplicar permutaciones pues las filas de
$\begin{pmatrix}
R_{11} & R_{12}\end{pmatrix}$ son linealmente independientes.

"""

# ╔═╡ ee54552d-1e56-408b-921c-c7b10358a12a
md""" 
Concluimos que

$Q^TA\pi \widetilde{Q}\begin{pmatrix}R_{11}& R_{12}\\ 0& R_{22}\end{pmatrix}\widetilde{Q}
=\begin{pmatrix} T_{11} &0\\ 0 &0\end{pmatrix}$
donde $T_{1,1}$ es una matriz triangular inferior de tamaño $r \times r$. Finalmente, para obtener una matriz triangular superior en el lugar de $T_{11}$, permutamos la filas y columnas de $T_{11}$, para esto usamos las siguientes tranformaciones
"""

# ╔═╡ 5c13b0f8-8385-4cdb-8561-6f89dfcb7c32
md""" 
$\widetilde{\pi}_1 =
\begin{pmatrix}
J & 0\\ 0 & I_{n-r}\end{pmatrix} \quad \mbox{ con } \quad 
J_{r\times r}=\begin{pmatrix}
0& 0& \cdots & 0 & 0 &1\\  
0& 0& \cdots & 0 & 1 &0\\
0& 0& \cdots & 1 & 0 &0\\
\vdots & \vdots& \cdots & \vdots & \vdots &\vdots\\
0& 1& \cdots & 0 & 0 &0\\
1& 0& \cdots & 0 & 0 &0\\
\end{pmatrix}$\
y donde $I_{n-r}$ denota la matriz identidad $(n-r)\times(n-r)$. Analogamente

$\widetilde{\pi}_2 =
\begin{pmatrix}
J & 0\\ 0 & I_{m-r}\end{pmatrix}$
"""

# ╔═╡ 4e5d2083-29e6-4527-8fe5-5d2eb67be7b4
md"""Obtenemos

$\overline{Q}^TAW=\widetilde{\pi}_2Q^TA\pi \widetilde{Q}\widetilde{\pi}_1=
\begin{pmatrix} T_{11}^T &0\\ 0 &0\end{pmatrix}$
donde $\overline{Q}^T=\widetilde{\pi}_2Q^T$y $W=\pi \widetilde{Q}\widetilde{\pi}_1$. Esta descomposición es concocida como la descomposición ortogonal completa (y no es la descomposición de Schur que es dela forma $Q^TAQ=R$ donde $R$ es triangular superior). 
"""

# ╔═╡ c645d6c5-b926-4f5d-b193-c039c67523b0
md"""En lugar de pedir $T_{11}$ triangular superior se puede requerir que sea bidiagonal superior, lo que se conoce como bidiagonalización. Podemos usar Householder de la siguiente manera. Resumimos el procedimiento aplicado a una matriz $B$

1. Aplicackos HH a la primera columa de $B$ para obtener $H_1B$ con zeros debajo de la primera entrada
2. Aplicamos HH a la primera fila sin la primera entrada para obtener zero en la primera fila despues de la segunda entrada, obtenermos $H_1B\widetilde{H}_2$
3. Continuamos con este procedimiento obtenemos 

$
H_n\dots H_1 B \widetilde{H}_2 \dots \widetilde{H}_m$
qie debe ser una matriz  bidiagonal. 

La bidiagonalización es usadad en el calculo de valore propios, primero se bidiagonliza y despues se aplica el método de Jacobi. 

Como aspecto negativo de este algoritmo, tenemos su forato "alternado", por lo que se pierde la facultad de usar operaciones de nivel 3 como en Householder normal.  Por esta razon se realiza $R-bidiagonliaación$ que consiste en aplicar Householder para obtner

$
Q^TA=\begin{pmatrix}R_{1} \\ 0\end{pmatrix}$
y depués aplicar Bidiagonlización a la matrix $R_{1}$ que generalmente es menor que $A$. Se obtine entonces 

$
Q_B^TR_{1}U_B=\mbox{ bigiagonal}$
y luego usamos 

$
\overline{U}_B=Q\begin{pmatrix}Q_B &0\\ 0& I\end{pmatrix}$ 
para terminar con 

$
\overline{U}_B^TAU_B=\begin{pmatrix}Q_B^T &0\\ 0& I\end{pmatrix}Q^TAU_B=
\begin{pmatrix}Q_B^T &0\\ 0& I\end{pmatrix}
\begin{pmatrix}R_1\\ 0\end{pmatrix}U_B=
\begin{pmatrix}Q_B^TR_1U_B\\ 0\end{pmatrix}=\begin{pmatrix}\mbox{didiagonal}\\ 0\end{pmatrix}.$
"""

# ╔═╡ 06b07e27-0781-434f-9e8c-04edcaba4f31
md"""# Referencias"""

# ╔═╡ 567004f4-77a1-4693-ba6e-017c4e84572e
md"""[1] Strang, G. (2016). Introduction to Linear Algebra (5ta ed.). Wellesley-Cambridge Press.

[2] Saad, Y. (2003). Iterative methods for sparse linear systems (2nd ed.). Society for Industrial and Applied Mathematics.

[4] Martínez R., H. J., & Sanabria R., A. M. (2014). Álgebra Lineal. Programa Editorial Universidad del Valle.

[5] Boyd, S., & Vandenberghe, L. (2021). Introduction to Applied Linear Algebra: Vectors, Matrices, and Least Squares - Julia Language Companion. Cambridge University Press.

[6] Grossman, S. I., & Flores Godoy, J. J. (2012). Álgebra Lineal (7a ed.). McGraw-Hill."""

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

julia_version = "1.10.3"
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
# ╟─db207f03-6472-44fc-ba20-2d14499af15b
# ╟─1275e9e7-63d1-47dc-a761-bbabd33b6670
# ╟─5b6c5c95-eaaa-41c6-b153-3a7bc9fe989b
# ╟─687d4852-9b98-4342-8e07-701d055b57ac
# ╟─bd96fb46-9a41-42a5-86f1-51eb05d3d312
# ╠═537df122-4692-4a5a-847f-70777ed330ce
# ╟─ecff234d-eb13-4cd9-aaa5-7bbf88c14271
# ╟─96817925-53b3-45e3-83c8-a1ab2c747ad8
# ╠═172c756c-c7f4-480d-9e4a-52fbc0564ed2
# ╟─a645cf2d-f176-4947-8122-bcdf41aa5c9d
# ╟─5aa7ba63-870f-4b1b-a2da-02cc21295e87
# ╟─8acbac14-8724-4e01-b6e4-4000c6345233
# ╠═2586a5af-1604-4ccc-99e9-43e4cbc0b51f
# ╟─686f7301-e588-4819-a88e-460d175eaf38
# ╠═0d3cddee-0a20-48c3-958e-1ca3ec890e3b
# ╠═6b024c51-f449-473d-b07e-f0d54b046af1
# ╠═dc01bbf0-8f62-4f2f-a64d-40ea2cdce63e
# ╟─49da426d-9b98-4e93-9ec3-d90385c28046
# ╟─21935a4e-cd5c-4a43-821e-9ffb4399147b
# ╟─47a1f5fb-52d5-4956-901c-d0cd4990facb
# ╠═f31d90d8-5168-449c-894a-b38e90e8f671
# ╠═7f1b9df8-b615-4e56-a29a-30ee91f414d4
# ╠═fc6bbc21-17a4-4fe3-9f87-9d4f690bee5a
# ╟─42a9d7cf-dc39-4fad-ac3a-c68353c37473
# ╠═f83064a3-a069-49ca-8fd3-21acf7644a81
# ╠═927c7a39-c246-479f-bb80-98bf1695c666
# ╠═cc29c002-414b-4c9d-a32d-60e0f5d2dd47
# ╠═aecf4109-da0b-4697-a1d1-a48ccbfb3613
# ╠═85d9218c-5e9f-4a63-bb68-cdfb3f1bc333
# ╠═f979d7b3-aa78-4d4c-a610-41f971e39d3d
# ╠═90183fec-5530-4502-9974-b1fad810224c
# ╟─a917a34e-9922-4281-bc99-8c73d503093a
# ╟─f5565ecd-cd50-405f-b0ca-900b02f2bc87
# ╟─450a7a6d-efb5-4b8d-aa40-dfb3826c1c0d
# ╠═e4bd815e-0f8f-4aa1-b659-3293f245ac1b
# ╠═6e4a35d6-c365-4cb2-b6c6-c010151c3f18
# ╠═f959900f-1785-4b6e-92e1-4ca2cfb6d6ab
# ╠═6c7ed78c-7084-462f-830a-5c007cb83620
# ╠═3e2df74d-3b00-4294-9662-5ec36b5e1b04
# ╠═c9172d77-f6ce-42e5-b866-679d4412d1b2
# ╟─7b7eeac0-1b60-4145-86f3-c14be909121d
# ╟─a669b08d-e608-4fd6-8104-b60ea5cf8419
# ╟─71b65271-f6ad-4d19-af2a-e09d0644e6a9
# ╟─b98a9ad3-4774-4397-8040-a39c85633e71
# ╟─aac81505-9de9-4faf-979b-8c206e4424d6
# ╟─d4d04c4c-0354-420c-9014-9e70b1acf140
# ╟─4903bc32-709c-4bb6-9d38-02ce341f0f73
# ╠═a448ba92-6e0e-4fc9-8593-dd4b959d9064
# ╟─a4cedd9f-a634-4896-994f-5d3a95455947
# ╟─60c24631-edff-40d1-a206-0ba660f2a9cd
# ╠═26039653-4ddc-4f0c-8cd3-6b573e4eb2b8
# ╠═396cba4d-e917-40d0-a0f3-cbcaedaf2426
# ╟─8a2f9a09-59f4-4439-b588-df50ad700434
# ╠═5aa40728-98a9-4889-8c4a-db1e847c5af1
# ╟─b4848641-6639-4ee1-834e-aaa0a297afd9
# ╠═b6b1d326-854c-4e02-836c-bbbd3de081dd
# ╠═0226c6c0-ef0a-4123-8f33-63f96ac7ce1a
# ╠═af14f7a0-6765-4454-a985-0265934f9d4f
# ╟─8f396bc5-1fe0-4723-b41f-dc8818dd9ffb
# ╟─a69a2fce-ddbf-486a-81cd-1f0cf2f155fb
# ╟─ab8c204c-91a2-4db0-97a6-ffd9ba6c50ab
# ╟─092d92b5-a499-4c30-92c2-8536ba6cafdc
# ╟─7e8aeab0-e46b-485d-9c1c-49f7f349f59b
# ╟─e593f931-957a-4054-b2b4-2fd5301bfa50
# ╟─f4db36eb-0669-416d-927d-b20ee197a15a
# ╟─db108ef8-3c3e-4ea5-916c-9bfbf72ed9d3
# ╟─89e4bca0-e984-4fed-bf8b-8a493020b1f8
# ╟─bb59d3ed-e13b-4140-ac84-e8ec1a726368
# ╠═e173aeea-050a-4df3-aa65-8660a27236f7
# ╠═1e079e91-0f65-4261-a9b9-e6ddd6e6bcd9
# ╟─75cd6109-1982-433f-b36c-e0d44e138d2d
# ╠═837534d5-2079-4e8b-ac64-1e2b07b98819
# ╟─6696c1b0-3fef-4668-9df5-1c158abbd1cc
# ╠═9a1f938f-fdc1-4cd7-a2ad-a1a78cbf5697
# ╟─dac13369-d651-4382-a47b-874663365096
# ╠═ea739032-5a45-42cb-8e95-8776bd37e6a1
# ╠═946e765b-6273-4332-a945-32707ebec723
# ╠═0192486e-319c-4b44-add6-2c8e669fc34f
# ╟─4901f309-bf67-40ad-9b1c-a216cc0db42b
# ╟─c1b3e1ed-d76f-4514-b85b-a2fcead6c658
# ╟─c12ed9df-e9aa-42e2-be20-0f20e9881f9f
# ╟─ee54552d-1e56-408b-921c-c7b10358a12a
# ╟─5c13b0f8-8385-4cdb-8561-6f89dfcb7c32
# ╟─4e5d2083-29e6-4527-8fe5-5d2eb67be7b4
# ╟─c645d6c5-b926-4f5d-b193-c039c67523b0
# ╟─06b07e27-0781-434f-9e8c-04edcaba4f31
# ╟─567004f4-77a1-4693-ba6e-017c4e84572e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
