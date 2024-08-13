### A Pluto.jl notebook ###
# v0.19.39

using Markdown
using InteractiveUtils

# ╔═╡ 514e2a75-352a-4b3b-94e1-8501f7feb714
using PlutoUI

# ╔═╡ d5d22c32-8628-49ec-8329-ec079b209662
using Plots

# ╔═╡ c9dba22d-acab-4290-aed0-d07e95cefeb7
using Roots

# ╔═╡ 9152f60d-875f-411e-8da5-69895768d114
using NLsolve

# ╔═╡ a230937a-04d0-4976-bd1f-cf7d873bcb5e
PlutoUI.TableOfContents(title="Ecuaciones no lineales", aside=true)

# ╔═╡ 3eaadcdf-e4b2-44f3-89c6-5d99722addc7
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 3dff2140-199b-4fdd-a683-74025fdda047
md"""**Este cuaderno está basado en actividades del curso Introducción a las ciencias de la computación y la programación de la Universidad Nacional de Colombia, sede Bogotá, dictado por el profesor Juan Galvis en 2021-2.**

Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo. 
"""

# ╔═╡ ad59ab9f-d880-4f7f-9b29-bbb560ae5512
md"""Usaremos las siguientes librerías:"""

# ╔═╡ f8ba8704-2cbf-4da1-a014-ed68d13868ac
md"""# Métodos para ecuaciones no lineales"""

# ╔═╡ 2e432045-2ba1-4c4b-a069-45ea1088320f
md"""## Método de bisección

Si $f$ es una función continua en el intervalo $[a, b]$ y se cumple que $f(a)f(b) < 0$, entonces debe existir al menos un punto donde $f$ se anule en el intervalo $(a, b)$. Esto es porque $f(a)f(b) < 0$ indica que la función cambia de signo dentro del intervalo $[a, b]$, garantizando al menos una raíz. Esto es consecuencia del teorema del valor intermedio para funciones continuas, que afirma que si $f$ es continua en $[a, b]$ y se cumple la desigualdad $f(a) < y < f(b)$, entonces existe algún $x \in (a, b)$ tal que $f(x) = y$.

El método de bisección se basa en este principio de la siguiente manera: si $f(a)f(b) < 0$, se calcula el punto medio $c = \frac{a+b}{2}$ y se verifica si $f(a)f(c) < 0$. Si es así, entonces la función $f$ tiene una raíz en $[a, c]$. Luego, se redefine $c$ como $b$ y se repite el proceso con el nuevo intervalo $[a, b]$, cuyo tamaño es la mitad del intervalo original.
"""

# ╔═╡ 6ead5b89-e850-478f-916a-3a76805d4232
md"""El algoritmo de bisección, ver [1], se puede escribir de la siguiente manera:"""

# ╔═╡ bad6775d-9759-4192-89a5-5804c683fbf9
md"""**ALGORITMO de Bisección**:

1. **input:** $a, b, M, \delta, \epsilon$
2.   $\hspace{0.5cm}u= f(a)$
3.   $\hspace{0.5cm}v= f(b)$
4.   $\hspace{0.5cm}e=b-a$
5.   $\hspace{0.5cm}$**if** $\text{sig}(u)\neq\text{sig}(v)$
6.   $\hspace{1cm}$**for** $k=1,2,\cdots, M$ **do**
7.   $\hspace{1.5cm}e=e/2$
8.   $\hspace{1.5cm}c=a+e$
9.   $\hspace{1.5cm}w=f(c)$
10.   $\hspace{1.5cm}$**if** $|e|<\delta$ o $|w|<\epsilon$
11.   $\hspace{2cm}$**stop**
12.   $\hspace{1.5cm}$**if** $\text{sig}(w)\neq\text{sig}(u)$ **then**
13.   $\hspace{2cm} b=c, v=w$
14.   $\hspace{1.5cm}$ **else**
15.   $\hspace{2cm} a=c, u=w$ 
16.   $\hspace{1.5cm}$ **end if**
17.   $\hspace{1cm}$ **end for**
17.   $\hspace{0.5cm}$ **end if**
18.   **output:** $a,b,c,e,w,k$
"""

# ╔═╡ 8609c312-e09c-4ee6-bb60-c30b72e5b145
md"""Presentaremos una implementación del pseudocódigo de bisección en el texto guía. En particular resolvemos la ecuación $\exp(x)-\sin(x)=0$.

Primero definimos una función para $\exp(x)-\sin(x)$, de la siguiente manera:"""

# ╔═╡ b456907a-7de5-4d8a-91d1-beec1384c7d9
function mifun(x)
  	y=exp(x)-sin(x)
  	return y
end

# ╔═╡ 9a9b6ca4-8a52-4562-85f8-9479b58cbfa3
md"""Podemos hacer una gráfica para tener una idea de los parámetros del método de bisección. """

# ╔═╡ 72d14907-f6c3-4a4e-a731-ad8ac21d522c
let
	a,b=-20,2
	x = a:(b-a)/1000:b
	y= mifun.(x)
	plot(x, y*0,ls=:dash,label="y=0",lw=4)
	plot!(x, y, label="y=exp(x)-sin(x)",lw=5)
end

# ╔═╡ ec0277d5-51e5-4429-ae4c-33881362e104
md"""De lo anterior se observa que la función tiene varios ceros, centrémonos en el cero que se observa en el $[-4,-3]$."""

# ╔═╡ d4aa846e-cbfb-4c6d-a151-869b27109d3b
let
	a,b=-4,-3
	x = a:(b-a)/1000:b
	y= mifun.(x)
	plot(x, y*0,ls=:dash,label="y=0",lw=4)
	plot!(x, y, label="Funcion",lw=5)
end

# ╔═╡ a35963d4-aedc-42c1-91c8-41684ab218a3
md"""El siguiente código implementa el método de bisección para la función anterior usando como datos de entrada $[-4,-3]$, es decir, $a=-4, b=-3$, con una tolerancia a la longitud del intervalo y al valor absoluto del residuo de $10^{-8}$."""

# ╔═╡ af790662-5b4b-4623-a93b-eeeddb998534
begin
	a,b,M,delb,epsb=-4,-3,100,1E-10,1E-10
	println("a=",a,", b=",b,", M=",M,", deltab=",delb,", epsb=",epsb)
	u=mifun(a)
	v=mifun(b)
	e=b-a
	k=1;
	c=a+e
	w=mifun(c)
	if sign(u)!=sign(v)
    	while (k <= M && abs(e)>delb && abs(w)>epsb )
        	e=e/2
        	println("c=",c)
        	if sign(w)!=sign(u)
            	b=c
            	v=w
          	else
            	a=c
            	u=w
        	end
        	k=k+1;
        	c=a+e
        	w=mifun(c)
    	end 
	end
    println("k=",k,", w=f(c)=",w, ", e=",e)
end

# ╔═╡ 3a397d5c-4173-4798-9a16-32cdce31f2ae
md"""Observamos que en la iteración 33 el programa finaliza con la aproximación $-3.1830630120821297$, con una longitud del intervalo de $|e|\approx 2.3\times 10^{-10}$ y un residuo de $|w|\approx 8.7\times 10^{-11}$.
"""

# ╔═╡ b607e25f-28d6-483d-b6af-ca7ba35e07ba
md"""## Método de Newton

Nuevamente tenemos una función cuyos ceros deben determinarse numéricamente. Sea $r$ un cero de $f(x)$ y $x$ una aproximación a $r$. Si $f''(x)$ existe y es continua, el teorema de Taylor nos dice que:

$0 = f(r) = f(x + h) = f(x) + h f'(x) + O(h^2)$

donde $h = r - x$. Si $h$ es pequeño, es decir, si $x$ está cerca de $r$, es razonable ignorar el término $O(h^2)$ y resolver el resto de la ecuación para $h$. En consecuencia, se tiene que

$h = -\frac{f(x)}{f'(x)}$

Si $x$ está cerca de $r$, entonces $x - \frac{f(x)}{f'(x)}$ debería estar aún más cerca de $r$. El método de Newton comienza con una estimación $x_0$ de $r$ a partir de la cual se define una sucesión de aproximaciones:

$x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)} \quad (n \geq 0).$
"""

# ╔═╡ 34a7f5a0-c048-458f-a28d-f73beefbaec5
md"""El método de Newton, como se describe en [1], puede expresarse de la siguiente manera:"""

# ╔═╡ 68443d0a-0ed3-4f6b-a2bf-d5d75ab60863
md"""**ALGORITMO de Newton**:

1. **input:** $x_0, M, \delta, \epsilon, f, f'$
2.   $\hspace{0.5cm}v= f(x_0)$
5.   $\hspace{0.5cm}$**if** $|v|<\epsilon$
4.   $\hspace{1cm}$**stop**
6.   $\hspace{0.5cm}$**for** $k=1,2,\cdots, M$ **do**
7.   $\hspace{1cm}w=f'(x_0)$
8.   $\hspace{1cm}x_1=x_0-\frac{v}{w}$
10.   $\hspace{1cm}$**if** $|x_1-x_2|<\delta$ o $|v|<\delta$
11.   $\hspace{1.5cm}$**stop**
12.   $\hspace{1cm} x_0=x_1$
16.   $\hspace{0.5cm}$ **end for**
18.   **output:** $x_0, v, k$
"""

# ╔═╡ b64ec4a4-8d70-4a4d-8b61-f943b0925ebe
md"""La siguiente función es la implementación del método de Newton."""

# ╔═╡ d1218051-a7fa-41dc-bcb2-8fec1f7e82df
function minewton(f,fp,x0,myeps,mydel,max_iter)
    #=f(x)=0 usando newton xn=xa-f(xa)/fp(xa)
    ----------
    f : funnción
    fp : Derivada
    x0 : Aproximación inicial
    epsilon : Tolerancia residuo.
    M : Número maximo de iteraciones
    ----------
    =#
    x = x0
    n=1
    while n<=max_iter
        fx = f(x)
        if abs(fx) < myeps
            print("residuo f(x(",n,"))=",fx)
            return x
        end
        fpx = fp(x)
        if fpx == 0
            print("Derivada nula. Error!")
            return None
        end
        x = x - fx/fpx
        println( "x(",n,")=",x)
        if abs(x-x0) < mydel
            print("incremento delta(",n,")=",fx)
            return x
        end
        x0=x
        n=n+1
    end
    if n==max_iter
        print("Número maximo de iteraciones")
    end 
    return x0
end

# ╔═╡ ea3eeabe-3a93-40cd-9c26-55a04b5997cc
md"""Nuevamente, resolvamos la ecuación $\exp(x)-\sin(x)=0$.

Primero definimos una función para $\exp(x)-\sin(x)$:"""

# ╔═╡ 415eb7f2-fbf7-41a7-bb13-c4bb01586a23
function f(x)
    return exp(x)-sin(x)
end

# ╔═╡ e560a1a2-29cd-4413-b10d-32b7c3c5db44
md"""A continuación se define una función para la primera derivada de $f(x).$"""

# ╔═╡ f8cd18f8-9b3b-4d47-ba6d-31c11ea4900f
function fp(x)
    return exp(x)-cos(x)
end

# ╔═╡ c350c549-4e6d-460d-97ab-40a477e5a32a
md"""Considerando $x_0=-3.5$ se obtiene que una raíz de $f(x)$ es:"""

# ╔═╡ 34ccffff-b05b-48e9-878e-394e8c9ec221
minewton(f,fp,-3.5,1e-10,1e-10,10)

# ╔═╡ 95dd3a55-0b4f-4182-b47e-f98b412066d0
md"""## Punto Fijo

El método del punto fijo es una técnica iterativa para encontrar un punto fijo de una función $F(x)$. Un punto $x^*$ es un punto fijo de $F(x)$ si cumple la condición $F(x^*) = x^*$.

Consideremos el método iterativo dado por

$x_{n+1} = F(x_n).$
Observe que si $F(x)$ es continua en el intervalo de interés, entonces el método convergerá al punto fijo $x^*$ bajo ciertas condiciones de convergencia, como la condición de contracción.

Por ejemplo, si usamos la función $F(x)$ definida como

$F(x) = x - \frac{f(x)}{f'(x)},$
la iteración de punto fijo asociada es

$x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)},$
que corresponde al método de Newton. En este caso, el método de Newton es un caso específico de iteración de punto fijo, donde la función $F(x)$ está diseñada para encontrar las raíces de la función $f(x)$ mediante la mejora sucesiva de la aproximación inicial $x_0$.
"""

# ╔═╡ de6d8e70-bf3b-4ce9-8de2-4e2e381a30b9
md"""**Teorema:**
Sea $F:[a,b]\to [a,b]$ una aplicación contractiva, entonces $F$ tiene un único punto fijo y la sucesión definida por $x_{n+1} = F(x_n)$ converge al único punto fijo.

La demostración de este Teorema se encuentra en [1].
"""

# ╔═╡ 7d412955-6587-4db8-aa57-6c61343b8c27
md"""Nuevamente, resolvamos la ecuación $\exp(x)-\sin(x)=0$.

Primero definimos una función para $x + \exp(x)-\sin(x)$:"""

# ╔═╡ a1ca0d11-fc70-41b1-8ad5-f0b125130840
function miFpf(x)
  y=x+exp(x)-sin(x)
end

# ╔═╡ d146fba2-4913-4256-ac5e-0f53657ec3d6
md"""Ahora inciemos en el punto $(x_0, 0)=(-4,0)$, e iteremos 10 veces para hallar el cero de la función."""

# ╔═╡ 9298a38d-6c59-43ee-8389-bea3d617968c
begin
	x0=-4
	for n=1:10
  		x1=miFpf(x0)
  		x0=x1
  		println("x=",x1)
	end
end

# ╔═╡ 8dfd5714-44be-43a9-9431-7c8d9b65c22e
md"""# Librerías

En Julia, las librerías $\texttt{Roots}$ y $\texttt{NLsolve}$ son herramientas para resolver problemas numéricos relacionados con ecuaciones, como hallar ceros de ecuaciones lineales y no lineales.

La librería $\texttt{Roots}$ está diseñada para encontrar las raíces (o ceros) de funciones de una sola variable. Se utiliza para resolver ecuaciones de la forma $f(x)=0$. Esta librería ofrece varios métodos numéricos para la búsqueda de raíces, incluyendo el método de Bisección, el método de Newton, el método de la Secante y el método de Regula Falsi: Un método que combina aspectos de la bisección y la secante, ver [2]."""

# ╔═╡ c0fcc486-b314-42f3-9457-a399160a27db
md"""A continuación se presenta un ejemplo"""

# ╔═╡ 736b2175-d48f-458a-9114-d9259f91dfbb
f1(x)=exp(x)-sin(x) #Definimos la función

# ╔═╡ 42a2cc2e-641c-4bda-8e80-6d11cc6e94b6
x=fzero(f1,-4,-3) #Hallamos la raíz en el intervalo [-4,-3]

# ╔═╡ 7325c3a2-837f-4458-866c-a3f8b3e424fb
md"""La librería $\texttt{NLsolve}$ se utiliza para resolver sistemas de ecuaciones no lineales. Es útil para problemas en los que se busca encontrar un vector $x$ tal que el sistema de ecuaciones no lineales $F(x)=0$ sea satisfecho, donde $F$ es una función vectorial que devuelve un vector de valores. Los principales métodos que usa son el método de Newton-Raphson y el método de Levenberg-Marquardt, ver [3]."""

# ╔═╡ 69155e28-fd82-46bf-adbf-6fb07a546261
md"""A continuación se presenta un ejemplo"""

# ╔═╡ 2b1f103d-39ed-47a1-82ab-2809489a1908
function fv(F,x) #Definimos el sistema de ecuaciones no lineales
    F[1]=x[1]^2+x[2]^2-1
    F[2]=(x[1]-2)^2+x[2]^2-1
end

# ╔═╡ c3d1e933-608d-4a2c-9cff-0d8d6774034a
nlsolve(fv,[0.0;0.0]) #Hallamos la solución considerando como punto inicial el punto (0,0)

# ╔═╡ 6bc12d2f-c9de-42d7-9e97-fbbb70d9015c
md"""# Problemas"""

# ╔═╡ fe6bbb92-224f-4884-8da1-f8f1fedb1152
md"""**Problema (Kelley)** Considere el método de Shamanskii de orden $m$ definido de la siguiente manera. Dado $x_n$ calcule $x_{n+1}$ usando $m$ pasos del método de la cuerda, esto es, 

$z_1=x_n-f(x_n)/f'(x_n)$

$z_{j+1}=z_{j}-f(z_j)/f'(x_n), \hspace{0.5cm}1\leq j\leq m-1$

$x_{n+1}=z_{m}.$

Observe que se avanza m pasos sin actualiar la derivada en el punto. Implemente el método para un order $m$ definido por el usuario y verifique su código con una ecuación escalar. """

# ╔═╡ 50a76a56-c2c1-434a-99f2-35ecc46128ee
md"""**Problema (Kelley, Iterative methodos for linear and non linear equations)** Resuelva las siguientes ecuaiones $f(x)=0$ usando el Método de newton, el método de la secante (para este inicie la iteración en $x_{-1}$ con $x_{-1}=0.99x_0$) y el método de Shamanskii con $m=2,3,4$. Comente los resultados. Puede hacer tablas o plots con las iteraciones.


1.   $f(x)=\cos(x)-x$,  $\quad x_0=.5$.
2.   $f(x)=\arctan(x)$,  $\quad x_0=1$.
3.   $f(x)=\sin(x)$, $\quad  x_0=3$.
4.   $f(x)=x^2$,  $\quad  x_0=.5$.
5.   $f(x)=x^2+1$,  $\quad  x_0=10$.

"""

# ╔═╡ 888e95ee-d50b-45f6-b1d0-8c1841225e7c
md"""**Problema (Quarteroni, Saleri, Gervasio)** Considere un plano cuya pendiente varía con tasa constante $\omega$ y un punto de masa quieto en el tiempo $t=0$. En el tiempo $t>0$ su posición es dada por
$s(t,\omega)= \frac{g}{2\omega^2}\Big[ \sinh(\omega t)-\sin(\omega t) \Big]$
donde $g=9.8 \frac{m}{s^2}$. Suponga que el objeto se ha movido 1 metro en un segundo, calcule el valor correspondiente de $\omega$ con 12 decimales exactos. """

# ╔═╡ 5ebc2201-f4b0-4e37-9c8c-25e93e5bc80e
md"""**Problema (Quarteroni, Saleri, Gervasio)** La longitud maxima de una varilla que se puede arrastrar de un extremo a otro deslizandola por un pasillo como el de la fiugra es 

$L=\frac{l_2}{\sin(\pi-\gamma-\alpha)}+\frac{l_1}{\sin(\alpha)}$
donde $\alpha$ es la solución de la ecuación

$l_2 \frac{\cos(\pi-\gamma-\alpha)}{\sin^2(\pi-\gamma-\alpha)}-l_1\frac{\cos(\alpha)}{\sin^2(\alpha)}=0.$
Calcule $\alpha$ cuando $l_2=10$, $l_1=8$ y $\gamma=\frac{3\pi}{5}$. ¿Cuántos decimales puede garantizar para $\alpha$ y $L$?"""

# ╔═╡ dc557a21-09ef-4b89-b203-474a0f030a17
md"""**Problema** Seleccione alguno de los métodos implementados en julia para resolver ecuaciones o sistemas de ecuaciones. Describa el método implementado con el mayor detalle posible. 

Si usa Python selecciones dos de los métodos en https://docs.scipy.org/doc/scipy-0.13.0/reference/optimize.html en la sección Root finding, diga cual es el método numerico implementado (e.g, similar a newton, usa derivadas, no usa derivadas, combina varios métodos, llama alguna otra subrutina conocida encontrada en netlib, cuales son las toleracias por defecto, etc)  y para cada uno de los métodos seleccionados implementar un ejemplo numérico con una ecuación escalar o una ecuación vectorial según sea el caso. Imprima la solución calculada asi como alguna informacion adicional (residuo, cantidad de iteraciones, etc). 

Si usa MatLab seleccione dos de entre los métodos como fsolve, froot, fzero, roots, o similares (https://la.mathworks.com/help/optim/systems-of-nonlinear-equations.html). Análogamente para octave (https://octave.org/doc/v4.2.0/Solvers.html), julia, etc."""

# ╔═╡ 855e0a0b-e6ef-4c99-a23c-8f4a1a1a7932
md"""# Referencias 
[1] Kincaid, D., & Cheney, W. (2002). Numerical analysis: Mathematics of scientific computing. American Mathematical Society.

[2] JuliaMath. (n.d.). Roots.jl (Version 0.10.0) [Software]. GitHub. https://github.com/JuliaMath/Roots.jl

[3] JuliaNLSolvers. (n.d.). NLsolve.jl [Software]. GitHub. https://github.com/JuliaNLSolvers/NLsolve.jl"""

# ╔═╡ Cell order:
# ╟─514e2a75-352a-4b3b-94e1-8501f7feb714
# ╟─a230937a-04d0-4976-bd1f-cf7d873bcb5e
# ╟─3eaadcdf-e4b2-44f3-89c6-5d99722addc7
# ╟─3dff2140-199b-4fdd-a683-74025fdda047
# ╟─ad59ab9f-d880-4f7f-9b29-bbb560ae5512
# ╠═d5d22c32-8628-49ec-8329-ec079b209662
# ╟─f8ba8704-2cbf-4da1-a014-ed68d13868ac
# ╟─2e432045-2ba1-4c4b-a069-45ea1088320f
# ╟─6ead5b89-e850-478f-916a-3a76805d4232
# ╟─bad6775d-9759-4192-89a5-5804c683fbf9
# ╟─8609c312-e09c-4ee6-bb60-c30b72e5b145
# ╠═b456907a-7de5-4d8a-91d1-beec1384c7d9
# ╟─9a9b6ca4-8a52-4562-85f8-9479b58cbfa3
# ╟─72d14907-f6c3-4a4e-a731-ad8ac21d522c
# ╟─ec0277d5-51e5-4429-ae4c-33881362e104
# ╟─d4aa846e-cbfb-4c6d-a151-869b27109d3b
# ╟─a35963d4-aedc-42c1-91c8-41684ab218a3
# ╠═af790662-5b4b-4623-a93b-eeeddb998534
# ╟─3a397d5c-4173-4798-9a16-32cdce31f2ae
# ╟─b607e25f-28d6-483d-b6af-ca7ba35e07ba
# ╟─34a7f5a0-c048-458f-a28d-f73beefbaec5
# ╟─68443d0a-0ed3-4f6b-a2bf-d5d75ab60863
# ╟─b64ec4a4-8d70-4a4d-8b61-f943b0925ebe
# ╠═d1218051-a7fa-41dc-bcb2-8fec1f7e82df
# ╟─ea3eeabe-3a93-40cd-9c26-55a04b5997cc
# ╠═415eb7f2-fbf7-41a7-bb13-c4bb01586a23
# ╟─e560a1a2-29cd-4413-b10d-32b7c3c5db44
# ╠═f8cd18f8-9b3b-4d47-ba6d-31c11ea4900f
# ╟─c350c549-4e6d-460d-97ab-40a477e5a32a
# ╠═34ccffff-b05b-48e9-878e-394e8c9ec221
# ╟─95dd3a55-0b4f-4182-b47e-f98b412066d0
# ╟─de6d8e70-bf3b-4ce9-8de2-4e2e381a30b9
# ╟─7d412955-6587-4db8-aa57-6c61343b8c27
# ╠═a1ca0d11-fc70-41b1-8ad5-f0b125130840
# ╟─d146fba2-4913-4256-ac5e-0f53657ec3d6
# ╠═9298a38d-6c59-43ee-8389-bea3d617968c
# ╟─8dfd5714-44be-43a9-9431-7c8d9b65c22e
# ╠═c9dba22d-acab-4290-aed0-d07e95cefeb7
# ╟─c0fcc486-b314-42f3-9457-a399160a27db
# ╠═736b2175-d48f-458a-9114-d9259f91dfbb
# ╠═42a2cc2e-641c-4bda-8e80-6d11cc6e94b6
# ╟─7325c3a2-837f-4458-866c-a3f8b3e424fb
# ╠═9152f60d-875f-411e-8da5-69895768d114
# ╟─69155e28-fd82-46bf-adbf-6fb07a546261
# ╠═2b1f103d-39ed-47a1-82ab-2809489a1908
# ╠═c3d1e933-608d-4a2c-9cff-0d8d6774034a
# ╟─6bc12d2f-c9de-42d7-9e97-fbbb70d9015c
# ╟─fe6bbb92-224f-4884-8da1-f8f1fedb1152
# ╟─50a76a56-c2c1-434a-99f2-35ecc46128ee
# ╟─888e95ee-d50b-45f6-b1d0-8c1841225e7c
# ╟─5ebc2201-f4b0-4e37-9c8c-25e93e5bc80e
# ╟─dc557a21-09ef-4b89-b203-474a0f030a17
# ╟─855e0a0b-e6ef-4c99-a23c-8f4a1a1a7932
