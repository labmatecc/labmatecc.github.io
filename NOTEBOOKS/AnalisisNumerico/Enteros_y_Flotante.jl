### A Pluto.jl notebook ###
# v0.19.45

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

# ╔═╡ b763cd10-d1e7-4613-b738-9fb1c1cfa1e5
using PlutoUI

# ╔═╡ e2feba71-69cb-4f39-92d1-d1f4daefb4ec
using Symbolics, Plots, LinearAlgebra

# ╔═╡ a7d3298e-0138-4149-a189-0b5a92cfa0e7
PlutoUI.TableOfContents(title="Números enteros y punto flotante", aside=true)

# ╔═╡ 5d0d4c4e-b432-437e-9b8e-2f81c79f907e
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ c08f6550-5278-436d-96ec-408570476631
md"""**Este cuaderno está basado en actividades del curso Análisis numérico I de la Universidad Nacional de Colombia, sede Bogotá, dictado por el profesor Juan Galvis en 2022-2.**

Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo. 
"""

# ╔═╡ 7b84db99-9375-4dc5-8a3e-414bc176648a
md"""Usaremos las siguientes librerías:"""

# ╔═╡ fd74ea36-fa50-415c-b4a0-92f594178ab9
md"""# Enteros 
Presentamos ejemplos sencillos de la representación de los datos enteros en Julia.
En particular, un entero de $k$ bits es representado de la forma
$n=(b_{k-1}b_{k-2}\cdots b_2 b_1b_0)_2=b_0+b_1 2^1+b_22^2+\cdots+b_{k-2}2^{k-2}-b_{k-1}2^{k-1}$. 

Recuerde que $b_i\in\{0,1\}$.

Vea los siguientes ejemplos.
"""

# ╔═╡ 37e57a66-a785-45a1-90a0-3413e7f01898
@bind n Slider(-50:50, show_value=true,default=0)

# ╔═╡ d38e69a8-cbdb-4437-ad5b-64217f3e48d6
typeof(n)

# ╔═╡ 2cfc4a3a-91f3-416a-bcf5-89a2ecbb0a61
bitstring(n)

# ╔═╡ 5ffb3f8c-d31d-4ed1-8a34-dbe13be57c42
1+2+4+8+16+32+64-128

# ╔═╡ c53b615f-b8ca-4427-a52e-ac2e69b54545
@bind mint TextField(10, default="0")

# ╔═╡ 4bb033b7-02af-4f8d-be9c-62ee7c4fc554
n8=parse(Int8,mint); bitstring(n8)

# ╔═╡ 3681e1d1-4e78-4026-9295-a67950dfd260
un8=parse(UInt8,mint); bitstring(un8)

# ╔═╡ 1681a1f7-3edd-46e5-8214-a2ac3ab6966d
m16=parse(Int16,mint); bitstring(m16)

# ╔═╡ 4aeddca1-790a-41c6-a178-3a6369bd5fcc
md"""Este tipo de representaciones tiene varias consecuencias como son la existencia de infinitos valores enteros que se pueden representar y consecuencias para los resultados de operaciones aritméticas las cuales son realizadas directamente en hardware en binario. Considere el siguiente ejemplo."""

# ╔═╡ 36da1916-adb8-46de-ac90-f046974273f7
k=Int8(127); l=Int8(3)

# ╔═╡ 1b17b320-4d20-47d2-8da1-c34a7b35830b
kplus=k+l

# ╔═╡ f1bbb819-c83c-4b62-a376-a7a3ef82df04
md"""Observe también el siguiente ejemplo.
"""

# ╔═╡ 2d843847-ef7e-47d0-a255-c5ec3cc5ec57
nb=10^100

# ╔═╡ 65543d5f-4d55-4dc5-917b-8a241e09fe86
md"""En Julia podemos ver explícitamente los límites para cada una de las representaciones."""

# ╔═╡ 4ffbafed-ca8d-443e-92ff-ec6a6d76f05d
for T in [Int8,Int16,Int32,Int64,Int128,UInt8,UInt16,UInt32,UInt64,UInt128]
           println("$(lpad(T,7)): [$(typemin(T)),$(typemax(T))]")
end

# ╔═╡ 1afd2287-6a84-4f16-ab6c-141fce1782cd
md""" 
# Punto Flotante
Presentamos ilustraciones simples de cálculo con números de máquina y redondeo.
En particular, la representación usando un bit para el signo, $s_0\in \{0,1\}$, con 
$s=(-1)^{1-s_0}$, 
$k$ bits para el exponente

$m=(b_{k-1}b_{k-2}\dots b_1b_0)_{\mbox{expfp}(k)} = b_0+b_1 2^1+b_22^2+\cdots+b_{k-1}2^{k-1}-(2^{k-1}-1).$  
con $e_i\in\{0,1\}$, y $p$ bits de precisión para el significando 

$q=(1. a_1a_2\dots a_p)_2 = 1 + a_12^{-1}+a_22^{-2}+\dots+a_p2^{-p},$ 
está dada por 

$x=s\times q\times 2^m.$
"""

# ╔═╡ db2fc0fd-a234-490e-b3a0-936efd699b9c
md"""**Ejemplo:** 

Para $x=0.5$ tenemos en el formato Float32 tenemos bit par el signo 
$s_0=0$, tenemos 8 bits para el exponente $m=(01111110)_{{\mbox{expfp}(8)}}=-1$ y 23 bits para el significando $q=(1.00000000000000000000000)_2$. Tenemos lo siguiente.
"""

# ╔═╡ d794e5ad-d893-41c3-a257-2ed0af0390dd
bitstring(Float32(0.5))

# ╔═╡ 1bb97bb9-ef25-4a20-8d35-38b7caead7b9
begin
	bs=bitstring(Float32(0.5));
	println("signo=",bs[1],"\t exp=",bs[2:9],"\t significand=",bs[19:32])	     
end

# ╔═╡ bf4dadde-a191-494a-bd1f-9b7a6c27608c
md"""Puede consultar cuántos bits usa cada uno de estos tipos de datos. 

**Ejemplo:**

Para $x=1.0$ se tiene lo siguiente"""

# ╔═╡ 2783c756-ae95-4112-b66c-927801c287e0
begin
	x16=Float16(1.0)
	println("x16=\t",bitstring(x16))
	x32=Float32(1.0)
	println("x32=\t",bitstring(x32))
	x64=Float64(1.0)
	println("x64=\t",bitstring(x64))
end

# ╔═╡ 6e2e5c03-adfe-427d-9880-cfd38c64321a
md"""Para $x=0.1$ se sigue que"""

# ╔═╡ 1f1253b4-f0d8-4a22-8eea-d0c57e3cff0c
begin
	z16=Float16(0.1)
	println("x16=\t",bitstring(z16))
	z32=Float32(0.1)
	println("x32=\t",bitstring(z32))
	z64=Float64(0.1)
	println("x64=\t",bitstring(z64))
end

# ╔═╡ 6a1957f2-e862-4bb0-a0f3-68b2d300534f
md"""Para $x=\pi$ se tiene lo siguiente"""

# ╔═╡ 649b75ff-e2a2-4b62-81a6-823d33ef330a
begin
	y16=Float16(π)
	println("x16=\t",y16)
	y32=Float32(π)
	println("x32=\t",y32)
	y64=Float64(π)
	println("x64=\t",y64)
	yBig=BigFloat(π)
	println("xBig=\t", yBig)     
end

# ╔═╡ da416d35-d074-4e37-bff6-cd2f04510d0e
md"""Podemos consultar por el 
 de la maquina y el rango representado. """

# ╔═╡ dcba3ba7-e801-4039-8a78-d1725aafa03e
for Ft in [Float16,Float32,Float64,BigFloat]
           println("$(lpad(Ft,7)): [$(floatmin(Ft)),$(floatmax(Ft))]")
end

# ╔═╡ 4d0544dc-cc03-442b-8d87-1677501a1356
md"""Los campos son el signo, el significando y el exponente. Por ejemplo. """

# ╔═╡ 48c7168a-56b5-41bf-b493-ddec30da8fee
begin
	xeps=bitstring(eps(Float32));
	println("signo=",xeps[1],"\t exp=",xeps[2:9],"\t significand=",xeps[19:32])
	xmin=bitstring(floatmin(Float32))
	println("signo=",xmin[1],"\t exp=",xmin[2:9],"\t significand=",xmin[19:32])
	xmax=bitstring(floatmax(Float32))
	println("signo=",xmax[1],"\t exp=",xmax[2:9],"\t significand=",xmax[19:32])
	     
end

# ╔═╡ df0d1912-104d-432f-bb80-baad219e5e8b
md"""Debemos tener cuidado al comparar dos variables de tipo float en condiciones para control condicional o control iterativo. Considere los siguientes ejemplos. """

# ╔═╡ 75e4ccf1-d51f-45c2-9bf1-46d731e579e3
(0.1+0.1)==0.2

# ╔═╡ 0f513283-82ad-47f3-84e2-b2d870a9a72d
(0.1+0.1+0.1)==0.3

# ╔═╡ 70c242d4-7de4-49a0-b3eb-93b757e1cb86
tol=1E-10; ((0.1+0.1+0.1)-0.3)< tol

# ╔═╡ eb6ab469-4830-4cea-a49a-9b901d5d9d2b
(0.1+0.1+0.1)≈0.3

# ╔═╡ 986889c7-2aa1-4ec2-ac1c-e9168eb1cd09
md"""**Ejemplo:**

Veamos que pasa si intentamos sumar x=1/10 varias veces, esto es, 
$\displaystyle\sum_{i=1}^N 0.1$. Veamos las siguientes implementaciones. """

# ╔═╡ 3e2df87d-960e-43a4-affd-3b020d9a7928
begin
	
	suma64=0.0
	N=10^6
	for i=1:N
	  suma64=suma64+(1/10) 
	end
	println("Despues de ",N, " sumas(Float64) de 1/10, \nel resultado es ",suma64)
	x=1/10
	p=N*x
	println("El producto es : ",p)
	     
end

# ╔═╡ d9016efd-cc95-4ac5-bdc0-32f5e9282eeb
begin
	suma32=Float32(0.0)
	for i=1:N
	  suma32=suma32+Float32(1/10) 
	end
	println("Despues de ",N, " sumas(Float32) de 1/10, el resultado es ",suma32)
	f32=Float32(1/10)
	p32=N*f32
	println("El producto es : ",p32)
end

# ╔═╡ f46a70a5-e090-42d1-922c-7aefd85d8700
md"""**Ejemplo:**

Veamos números de máquina positivos pequeños y algunas operaciones."""

# ╔═╡ 71d25ca2-7960-413a-8fad-e210fdd41a6b
begin
	xx=3E-324
	yy=2E-324
	print("x=",xx,"es un número de máquina. Pero y=2E-324 es aproximado  a  y=\t",yy, ".\n")
	print("Al dividir x=3E-324 por dos tenemos x/2=\t",xx/2,".\n")
	print("Note tambien que 1/x=\t",1/xx,".")
end

# ╔═╡ 8eb0cc2e-07e7-4c45-bde2-f53517004059
md""" Ahora veamos con números positivos grandes. """

# ╔═╡ f274879e-93ca-409c-94a5-28b59556949f
begin
	xp=1.7E+308
	#y=1.8E+308 # overflow in numeric constant 
	print("x=",xp," es un numéro de máquina pero 'y' genera desbordamiento.\n")
end

# ╔═╡ 97fc720c-cfb9-488f-92d4-96333dc35374
md"""**Ejemplo:**

Verificamos ahora la no-asociatividad de la suma en el siguiente ejemplo."""

# ╔═╡ 0afa9453-b5af-494b-afba-4ddbeae5da8b
begin
xr=1E+26-1E+26+1
yr=1E+26+1-1E+26
print("x= ",xr, " es diferente de y=",yr)
end

# ╔═╡ b654e0ec-fa6a-425c-b7b0-547e817da1a1
md"""**Ejemplo:**

En el siguiente ejercicio también podemos verificar la no-asociatividad."""

# ╔═╡ f35cd3c4-6433-4f3c-9422-23a9b6dbeade
begin
	a=1E+308
	b=1.1E+308
	c=-1.001E+308
	xs=a+(b+c)
	ys=(a+b)+c
	#y=a**2
	print("x=",xs," que es diferente a  y=",ys)
end

# ╔═╡ f9ddce28-e503-4203-b02b-831f85a347ec
md"""**Ejemplo:**

Otro ejemplo es el de calcular $\sqrt{a^2+b^2}$ con $a=$1E+200 y $b=1$.."""

# ╔═╡ e8846356-38b7-43a5-bb31-d5a7f4a8d63b
begin
	asq=1E+200
	bsq=1
	ysqr=sqrt( a^2+b^2)
	print(ysqr)
end

# ╔═╡ dd240d3d-2e96-4a63-b85c-650705c0e288
md"""Podemos evitar el desbordamiento por exceso, considerando que

$\sqrt{a^2+b^2} = a \sqrt{1+\frac{b^2}{a^2}},$
tal como se muestra a continuación"""

# ╔═╡ fc6ba034-1574-48ce-9780-31977607f8a6
z=asq*sqrt( 1+(bsq/asq)^2)

# ╔═╡ 714fa522-158c-436a-ac0e-86b4b9bf243d
md"""**Ejemplo:**

Se presentan algunas expresiones ideterminadas con las que se debe tener cuidado a la hora de calcular con punto flotante."""

# ╔═╡ 2545e2be-d3eb-4b79-8d80-d06b302e13d4
begin
	xt=1
	yt=0
	zt=1E+307*100
	wt=1E+308*100
	println("x= ",xt,", y=",yt,", z=",zt,", w=",wt, "\n")
	println("Inf/Inf=",wt/zt,"\n")
	println("Inf*Inf=",wt*zt,"\n")
	println("1/NaN=", 1/(wt/zt),"\n")
	println("NaN*1=",(wt/zt)*1,"\n")
	println("sqrt(NaN)=",sqrt((wt/zt)),"\n")
end

# ╔═╡ 281296be-ed1a-48f0-81fc-a2e5016da55d
md"""**Ejemplo:**

Un ejemplo de perdida de dígitos (o cancelación) es el siguiente. """

# ╔═╡ 8628081c-9db1-42ac-8ddd-a6283b59a0f8
begin
	xd=1E-15
	yd=((1+xd)-1)/xd
	print("y=",yd)
	print("Con error relativo de ", 100*(yd-1),"%.")
end

# ╔═╡ 1880359e-f665-4628-98a7-ca7a35a78206
md"""**Ejemplo:**

Un otro ejemplo común de cancelación es cuando se evaluan polinomios usando la expresión de potencias. Por ejemplo, evaluemos 

$P(x)=(x-1)^7=x^7-7x^6+21x^5-35x^4+35x^3-21x^2+7x-1,$
usando estás dos expresiones. """

# ╔═╡ c3c091c7-637b-4335-89ac-aa8f16dd8c09
md"""Es un buen ejercicio hallar el esquema de Horner para calcular este polinomio y comparar. Observe que dicho esquema de Horner es el siguiente 

$(x-1)^7=\left( \left( \left( \left( \left( \left( x - 7 \right) x + 21  \right) x - 35 \right) x + 35 \right) x - 21 \right) x + 7 \right) x - 1.$

Ahora, grafiquemos estás 3 expresiones."""

# ╔═╡ 23f33d5d-f32e-4328-b7e4-651f7cdcf345
begin
	aleft=1-12E-3
	aright=1+12E-3
	xv = aleft:4E-3/50:aright;
	uno=ones(size(xv))
	p1= (xv.-uno).^7;
	p2=xv.^7-7*xv.^6+21*xv.^5-35*xv.^4+35*xv.^3-21*xv.^2+7*xv.-uno;
	p3= ((((((xv-7*uno).*xv+21*uno).*xv-35*uno).*xv+35*uno).*xv-21*uno).*xv+7*uno).*xv-uno
	plot(xv, p1,title = "Expansion vs Fatorizado", label = ["Factorizado"], lw = 1)
	plot!( xv, p2, label=["Expandido"],lw=1)
	plot!( xv, p3, label=["Horner"],lw=1)
end

# ╔═╡ 0510e6d0-2628-4ef8-a9ef-ae3f562b9d2d
md""" 
Por último notamos que, aunque el error de redondeo es pequeño al principio, en cálculos complejos puede acumular para ocasionar efectos catastróficos.

**EJEMPLO 1:** Explosión del [misil Ariane](https://www.bugsnag.com/blog/bug-day-ariane-5-disaster) en Junio de 1996 por un desbordamiento por exceso en el computador del mismo. 

**EJEMPLO 2:** La falla de una misión de un [misil American Patriot](https://www.iro.umontreal.ca/~mignotte/IFT2425/Disasters.html) durante la guerra del Golfo en 1991 debido a errores de redondeo en el cálculo de la trayectoria a seguir. 
"""

# ╔═╡ a670f208-e006-47f5-89a7-9bebab429f44
md"""
# Cálculo simbólico

Para terminar mencionaremos la librería  	`Symbolics` que permite realizar cálculo simbólico en lugar de cálculo numérico. Recuerden que en el cálculo numérico las variables en todo momento tiene valores particulares asignados los cuales corresponden a números de máquina que dependen del formato que se esté usando: precisión simple, precisión doble, e.t.c. En los cálculos simbólicos las variables no tienen que tomar valores particulares y se pueden manipular solo restringiendo su comportamiento a reglas que aplican a conjuntos numéricos como por ejemplo: enteros, reales, complejos, matrices, e.t.c. 

A continuación presentamos algunos comandos de cálculo simbólico. 

"""

# ╔═╡ 1737d90d-2d20-4f2b-b256-aca34ff19b53
@variables s t

# ╔═╡ 521da315-bd00-4fa0-958f-ca9ed9d7b81f
r=s^2+t

# ╔═╡ 2c83c7d6-befa-4aae-813d-698eda707646
expand(r^4)

# ╔═╡ 57ddf55f-5ca0-443b-abb2-42fe7615cb42
A = [s^2 + t s 2s
     0       t 2t
     t^2 + s s 0]

# ╔═╡ db5e8c5f-3122-4b43-97a8-09b94f35b2ad
det(A)

# ╔═╡ fc8a0527-5ac0-43a1-a866-394f9265db5d
D = Differential(t)

# ╔═╡ ddfa13d6-b42e-4a21-89e2-6bceea08b0e8
D(r)

# ╔═╡ 5b5ed004-a54f-4feb-b9ce-3e4a0ccbffee
expand_derivatives(D(r))

# ╔═╡ 495df1e1-c814-4dd9-97cf-c0d9b852834f
B = simplify.([t + t^2 + t + t^2  2t + 4t
               s + s+2t     s^2 - 3s^2 + s^2])

# ╔═╡ 09119c27-56ee-4201-98b2-2dd0d5adfa64
simplify.(substitute.(B, (Dict(s => (t-1)^2),)))

# ╔═╡ a4d427b5-ab98-43f8-8641-d743e578d456
md"""# Problemas"""

# ╔═╡ 3b0181ce-5038-4c34-9629-40adb5c585c2
md"""
**PROBLEMA 1** ¿Cuánta memoria requiere guardar 100.000 números de punto flotante de precisión doble?¿Cuánta memoria requiere guardar una matriz de números de punto flotante dimensión 100.000 x 100.000?

**PROBLEMA 2** Describe el tipo BigFloat the Julia. 


**PROBLEMA (Sullivan) 3** Con $x_0=1/10$, considere la sucesión,  

$x_{n+1}=\left\{\begin{array}{ll}
2x_n & \mbox{ si } x_n\in \left[0,\frac{1}{2}\right] \\
2x_n-1 &  \mbox{ si } x_n\in \left(\frac{1}{2},1\right].
\end{array}\right.$
para $n=1,2,\dots$. Calcule $x_1,x_2,x_3,\dots,x_{50}$ de forma análitica y despues usandoun código en python. Compare y explique.

Repetir pero ahora iniciando con $x_0=1/8$. Compare y explique. 

**PROBLEMA 4** Explique la falla del Ariane y del American Patriot. Muestre cálculos numéricos para soportar su explicación. 


**PROBLEMA 5** Escriba rutina que implemente la función 
$SF_{i}(x)=\frac{\exp\left(x_{i}\right)}{\sum_{j=1}^{n}\exp\left(x_{j}\right)}.$
La rutina debe estar estabilizada para evitar desbordamiento por exceso. 

**PROBLEMA (Stoer) 6** Ensaye calcular las funciones $$f(x)=\sqrt{x^2+1}-1 \quad g(x)=\frac{x^2}{\sqrt{x^2+1}+1}$$
Use valores pequeños como $x=8^{-1},8^{-2},8^{-3},\dots$. Explique los resultados. Note que, análiticamete,  $f(x)=g(x)$.

"""

# ╔═╡ 818df822-2688-49c1-8ace-8494c7562800
md"""

**PROBLEMA (Quarteroni,Saleri,Gervasio) 7** El lector puede implementar el calculo de la siguiente recurrencia que approxima $\pi$ (formula de Franc,ois Viète) y estudiar su estabilidad/instabilidad numérica, 
$z_1=2, \,\,z_{n+1}=2^{n-1/2}\sqrt{1-\sqrt{1-4^{1-n}z_n^2}},\,\,n=2,3,\dots.$


**PROBLEMA (Stewart) 8** Repita el experimento arriba con la recurrencia $x_1=\frac{1}{3}, x_2=\frac{1}{12}$,  $x_{k+1}=2.25x_k-0.5x_{k-1}$.

**PROBLEMA 9** Presente un ejemplo, adicional  a los presentados en clase, de algortimos inestables o problemas mal condicionados. 

**PROBLEMA 10** Repita el experimento arriba con $P(x)=(x-1)^7$. Agrege a la figura el siguiente método 

$P(x)= ((((((x-7)x+21)x-35)x+35)x-21)x+7)x-1.$
Verifique esta formula. Implemente y comente los resultados. Esta forma de calcular polinimios es conocida como el esquema de Horner.

"""

# ╔═╡ dc6968ae-939a-4821-9072-853d0b5ff737
md""" # Referencias

[1] Driscoll, T. A., & Braun, R. J. (n.d.). *Fundamentals of Numerical Computation*. Adapted for Julia. Retrieved from https://tobydriscoll.net/fnc-julia/frontmatter.html

[2] Sullivan, E. (2020). *Numerical Methods: An Inquiry-Based Approach With Python*.

[3] Bulirsch, R., Stoer, J., & Stoer, J. (2002). *Introduction to Numerical Analysis* (Vol. 3). Springer.

[4] Stewart, G. W. (1996). *Afternotes on Numerical Analysis*. Society for Industrial and Applied Mathematics.

[5] Quarteroni, A., Saleri, F., & Gervasio, P. (2006). *Scientific Computing with MATLAB and Octave* (Vol. 3). Springer.

[6] IEEE Standards Association. (n.d.). *IEEE Standard*.

[7] Sinews. (n.d.). *Low Precision Floating-Point Formats: The Wild West of Computer Arithmetic*. Retrieved from https://sinews.siam.org/Details-Page/low-precision-floating-point-formats-the-wild-west-of-computer-arithmetic

[8] Goldberg, D. (1991). *What Every Computer Scientist Should Know About Floating-Point Arithmetic*. *Computing Surveys, 23*(1), 5-48. 

[9] Brent, R. P., & Zimmermann, P. (n.d.). *Modern Computer Arithmetic*. Retrieved from https://docs.oracle.com/cd/E19957-01/806-3568/ncgTOC.html

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Symbolics = "0c5d862f-8b57-4792-8d23-62f2024744c7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[[deps.AbstractAlgebra]]
deps = ["GroupsCore", "InteractiveUtils", "LinearAlgebra", "MacroTools", "Preferences", "Random", "RandomExtensions", "SparseArrays", "Test"]
git-tree-sha1 = "d7832de8cf7af26abac741f10372080ac6cb73df"
uuid = "c3fe647b-3220-5bb0-a1ea-a7954cac585d"
version = "0.34.7"

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
git-tree-sha1 = "cde29ddf7e5726c9fb511f340244ea3481267608"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.7.2"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra", "Requires", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "16267cf279190ca7c1b30d020758ced95db89cd0"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.5.1"

[[deps.ArrayInterfaceCore]]
deps = ["LinearAlgebra", "SnoopPrecompile", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "e5f08b5689b1aad068e01751889f2f615c7db36d"
uuid = "30b0a656-2188-435a-8636-2ec0e6a096e2"
version = "0.1.29"

[[deps.ArrayInterfaceStaticArraysCore]]
deps = ["ArrayInterfaceCore", "LinearAlgebra", "StaticArraysCore"]
git-tree-sha1 = "01a9f8e6cfc2bfdd01d333f70b8014a04893103c"
uuid = "dd5226c6-a4d4-4bc7-8575-46859f9c95b9"
version = "0.1.4"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bijections]]
git-tree-sha1 = "95f5c7e2d177b7ba1a240b0518038b975d72a8c0"
uuid = "e2ed5e7c-b2de-5872-ae92-c73ca462fb04"
version = "0.1.7"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a2f1c8c668c8e3cb4cca4e57a8efdb09067bb3fd"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.0+2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "71acdbf594aab5bbb2cec89b208c41b4c411e49f"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.24.0"

[[deps.ChangesOfVariables]]
deps = ["InverseFunctions", "LinearAlgebra", "Test"]
git-tree-sha1 = "799b25ca3a8a24936ae7b5c52ad194685fc3e6ef"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.9"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "bce6804e5e6044c6daab27bb533d1295e4a2e759"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.6"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b5278586822443594ff615963b0c09755771b3e0"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.26.0"

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

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "362a287c3aa50601b0bc359053d5c2468f0e7ce0"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.11"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.CompositeTypes]]
git-tree-sha1 = "bce26c3dab336582805503bed209faab1c279768"
uuid = "b152e2b5-7a66-4b01-a709-34e65c35f657"
version = "0.1.4"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "ea32b83ca4fefa1768dc84e504cc0a94fb1ab8d1"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.2"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "a33b7ced222c6165f624a3f2b55945fac5a598d9"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.7"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

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

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fc173b380865f70627d7dd1190dc2fce6cc105af"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.14.10+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["AliasTables", "ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "0e0a1264b0942f1f3abb2b30891f2a590cc652ac"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.110"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.DomainSets]]
deps = ["CompositeTypes", "IntervalSets", "LinearAlgebra", "Random", "StaticArrays", "Statistics"]
git-tree-sha1 = "51b4b84d33ec5e0955b55ff4b748b99ce2c3faa9"
uuid = "5b8099bc-c8ec-5219-889f-1d9e522a28bf"
version = "0.6.7"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.DynamicPolynomials]]
deps = ["Future", "LinearAlgebra", "MultivariatePolynomials", "MutableArithmetics", "Pkg", "Reexport", "Test"]
git-tree-sha1 = "30a1848c4f4fc35d1d4bbbd125650f6a11b5bc6c"
uuid = "7c1d4256-1411-5781-91ec-d7bc3513ac07"
version = "0.5.7"

[[deps.EnumX]]
git-tree-sha1 = "bdb1942cd4c45e3c678fd11569d5cccd80976237"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.4"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c6317308b9dc757616f0b5cb379db10494443a7"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.2+0"

[[deps.ExprTools]]
git-tree-sha1 = "27415f162e6028e81c72b82ef756bf321213b6ec"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.10"

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

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "7072f1e3e5a8be51d525d64f63d3ec1287ff2790"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.11"

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

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions", "StaticArrays"]
git-tree-sha1 = "cf0fe81336da9fb90944683b8c41984b08793dad"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.36"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "5c1d8ae0efc6c2e7b1fc502cbe25def8f661b7bc"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.2+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1ed150b39aebcc805c26b93a8d0122c940f64ce2"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.14+0"

[[deps.FunctionWrappers]]
git-tree-sha1 = "d62485945ce5ae9c0c48f124a84998d755bae00e"
uuid = "069b7b12-0de2-55c6-9aab-29f3d0a68a2e"
version = "1.1.3"

[[deps.FunctionWrappersWrappers]]
deps = ["FunctionWrappers"]
git-tree-sha1 = "b104d487b34566608f8b4e1c39fb0b10aa279ff8"
uuid = "77dc65aa-8811-40c2-897b-53d922fa7daf"
version = "0.1.3"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "532f9126ad901533af1d4f5c198867227a7bb077"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+1"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "2d6ca471a6c7b536127afccfa7564b5b39227fe0"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.1.5"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "629693584cef594c3f6f99e76e7a7ad17e60e8d5"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.7"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a8863b69c2a0859f2c2c87ebdc4c6712e88bdf0d"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.7+0"

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

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.Groebner]]
deps = ["AbstractAlgebra", "Combinatorics", "ExprTools", "Logging", "MultivariatePolynomials", "PrecompileTools", "PrettyTables", "Primes", "Printf", "Random", "SIMD", "TimerOutputs"]
git-tree-sha1 = "6b505ef15e55bdc5bb3ddbcfebdff1c9e67081e8"
uuid = "0b43b601-686d-58a3-8a1c-6623616c7cd4"
version = "0.5.1"

[[deps.GroupsCore]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "6df9cd6ee79fc59feab33f63a1b3c9e95e2461d5"
uuid = "d5909c97-4eac-4ecc-a3dc-fdd0858a4120"
version = "0.4.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "d1d712be3164d61d1fb98e7ce9bcbc6cc06b45ed"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.8"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "7c4195be1649ae622304031ed46a2f4df989f1eb"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.24"

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

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

[[deps.IntegerMathUtils]]
git-tree-sha1 = "b8ffb903da9f7b8cf695a8bead8e01814aa24b30"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IntervalSets]]
deps = ["Random", "RecipesBase", "Statistics"]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"

[[deps.InverseFunctions]]
deps = ["Dates", "Test"]
git-tree-sha1 = "2787db24f4e03daf859c6509ff87764e4182f7d1"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.16"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "39d64b09147620f5ffbf6b2d3255be3c901bec63"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.8"

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
git-tree-sha1 = "c84a835e1a09b289ffcd2271bf2a337bbdda6637"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.3+0"

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
git-tree-sha1 = "e16271d212accd09d52ee0ae98956b8a05c4b626"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "17.0.6+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "70c5da094887fd2cae843b8db33920bac4b6f07d"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.2+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.LabelledArrays]]
deps = ["ArrayInterface", "ChainRulesCore", "ForwardDiff", "LinearAlgebra", "MacroTools", "PreallocationTools", "RecursiveArrayTools", "StaticArrays"]
git-tree-sha1 = "d1f981fba6eb3ec393eede4821bca3f2b7592cd4"
uuid = "2ee39098-c373-598a-b85f-a56591580800"
version = "1.15.1"

[[deps.LambertW]]
git-tree-sha1 = "c5ffc834de5d61d00d2b0e18c96267cffc21f648"
uuid = "984bce1d-4616-540c-a9ee-88d1112d94c9"
version = "0.4.6"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "ce5f5621cac23a86011836badfedf664a612cee4"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.5"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

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

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "5ee6203157c120d79034c748a2acba45b82b8807"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.1+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "a2d09619db4e765091ee5c6ffe8872849de0feea"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.28"

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
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

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

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.MultivariatePolynomials]]
deps = ["ChainRulesCore", "DataStructures", "LinearAlgebra", "MutableArithmetics"]
git-tree-sha1 = "5c1d1d9361e1417e5a065e1f84dc3686cbdaea21"
uuid = "102ac46a-7ee4-5c85-9060-abc95bfdeaa3"
version = "0.5.6"

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "d0a6b1096b584a2b88efb70a92f8cb8c881eb38a"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "1.4.6"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "38cb508d080d21dc1128f7fb04f20387ed4c0af4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.3"

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

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "949347156c25054de2db3b166c52ac4728cbad65"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.31"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cb5a2ab6763464ae0f19c86c56c63d4a2b0f5bda"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.52.2+0"

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
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "6e55c6841ce3411ccb3457ee52fc48cb698d6fb0"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.2.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "7b1a9df27f072ac4c9c7cbe5efb198489258d1f5"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.1"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "082f0c4b70c202c37784ce4bfbc33c9f437685bf"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.5"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ab55ee1510ad2af0ff674dbcced5e94921f867a9"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"

[[deps.PreallocationTools]]
deps = ["Adapt", "ArrayInterface", "ForwardDiff", "Requires"]
git-tree-sha1 = "f739b1b3cc7b9949af3b35089931f2b58c289163"
uuid = "d236fae5-4411-538c-8e31-a6e3d9e00b46"
version = "0.4.12"

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

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "66b20dd35966a748321d3b2537c4584cf40387c7"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.3.2"

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "cb420f77dc474d23ee47ca8d14c90810cafe69e7"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.6"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.PtrArrays]]
git-tree-sha1 = "f011fbb92c4d401059b2212c05c0601b70f8b759"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.2.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "492601870742dcd38f233b23c3ec629628c1d724"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.7.1+1"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll"]
git-tree-sha1 = "e5dd466bf2569fe08c91a2cc29c1003f4797ac3b"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.7.1+2"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "1a180aeced866700d4bebc3120ea1451201f16bc"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.7.1+1"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "729927532d48cf79f49070341e1d918a65aba6b0"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.7.1+1"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "e237232771fdafbae3db5c31275303e056afaa9f"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.10.1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
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

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.RecursiveArrayTools]]
deps = ["Adapt", "ArrayInterfaceCore", "ArrayInterfaceStaticArraysCore", "ChainRulesCore", "DocStringExtensions", "FillArrays", "GPUArraysCore", "IteratorInterfaceExtensions", "LinearAlgebra", "RecipesBase", "StaticArraysCore", "Statistics", "Tables", "ZygoteRules"]
git-tree-sha1 = "a5ce741acddc02f0d4fc6505463ca89697d7fb23"
uuid = "731186ca-8d62-57ce-b412-fbd966d074cd"
version = "2.32.3"

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
git-tree-sha1 = "e60724fd3beea548353984dc61c943ecddb0e29a"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.4.3+0"

[[deps.RuntimeGeneratedFunctions]]
deps = ["ExprTools", "SHA", "Serialization"]
git-tree-sha1 = "6aacc5eefe8415f47b3e34214c1d79d2674a0ba2"
uuid = "7e49a35a-f44a-4d26-94aa-eba1b4ca6b47"
version = "0.5.12"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "2803cab51702db743f3fda07dd1745aadfbf43bd"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.5.0"

[[deps.SciMLBase]]
deps = ["ArrayInterfaceCore", "CommonSolve", "ConstructionBase", "Distributed", "DocStringExtensions", "EnumX", "FunctionWrappersWrappers", "IteratorInterfaceExtensions", "LinearAlgebra", "Logging", "Markdown", "Preferences", "RecipesBase", "RecursiveArrayTools", "RuntimeGeneratedFunctions", "StaticArraysCore", "Statistics", "Tables"]
git-tree-sha1 = "fe89a8113ea445bcff9ee570077830674babb534"
uuid = "0bca4576-84f4-4d90-8ffe-ffa030f20462"
version = "1.81.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2f5d4697f21388cbe1ff299430dd169ef97d7e14"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.4.0"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "eeafab08ae20c62c44c8399ccb9354a04b80db50"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.7"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

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
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "cef0472124fab0695b58ca35a77c6fb942fdab8a"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.1"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a04cabe79c5f01f4d723cc6704070ada0b9d46d5"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.4"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SymbolicIndexingInterface]]
git-tree-sha1 = "65f4ed0f9e3125e0836df12c231cea3dd98bb165"
uuid = "2efcf032-c050-4f8e-a9bb-153293bab1f5"
version = "0.3.0"

[[deps.SymbolicUtils]]
deps = ["AbstractTrees", "Bijections", "ChainRulesCore", "Combinatorics", "ConstructionBase", "DataStructures", "DocStringExtensions", "DynamicPolynomials", "IfElse", "LabelledArrays", "LinearAlgebra", "MultivariatePolynomials", "NaNMath", "Setfield", "SparseArrays", "SpecialFunctions", "StaticArrays", "SymbolicIndexingInterface", "TimerOutputs", "Unityper"]
git-tree-sha1 = "c84ea9bcc9d527ba86ce08191cf561f35b48f9a0"
uuid = "d1185830-fcd6-423d-90d6-eec64667417b"
version = "1.7.1"

[[deps.Symbolics]]
deps = ["ArrayInterface", "Bijections", "ConstructionBase", "DataStructures", "DiffRules", "Distributions", "DocStringExtensions", "DomainSets", "DynamicPolynomials", "Groebner", "IfElse", "LaTeXStrings", "LambertW", "Latexify", "Libdl", "LinearAlgebra", "LogExpFunctions", "MacroTools", "Markdown", "NaNMath", "PrecompileTools", "RecipesBase", "Reexport", "Requires", "RuntimeGeneratedFunctions", "SciMLBase", "Setfield", "SparseArrays", "SpecialFunctions", "StaticArrays", "SymbolicIndexingInterface", "SymbolicUtils"]
git-tree-sha1 = "8d28ebc206dec9e250e21b9502a2662265897650"
uuid = "0c5d862f-8b57-4792-8d23-62f2024744c7"
version = "5.14.1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

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

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TimerOutputs]]
deps = ["ExprTools", "Printf"]
git-tree-sha1 = "5a13ae8a41237cff5ecf34f73eb1b8f42fff6531"
uuid = "a759f4b9-e2f1-59dc-863e-4aeb61b1ea8f"
version = "0.5.24"

[[deps.TranscodingStreams]]
git-tree-sha1 = "e84b3a11b9bece70d14cce63406bbc79ed3464d2"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.2"

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

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["ConstructionBase", "Dates", "InverseFunctions", "LinearAlgebra", "Random"]
git-tree-sha1 = "d95fe458f26209c66a187b1114df96fd70839efd"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.21.0"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "975c354fcd5f7e1ddcc1f1a23e6e091d99e99bc8"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.4"

[[deps.Unityper]]
deps = ["ConstructionBase"]
git-tree-sha1 = "25008b734a03736c41e2a7dc314ecb95bd6bbdb0"
uuid = "a7c27f48-0311-42f6-a7f8-2c11e75eb415"
version = "0.1.6"

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
git-tree-sha1 = "93f43ab61b16ddfb2fd3bb13b3ce241cafb0e6c9"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.31.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "1165b0443d0eca63ac1e32b8c0eb69ed2f4f8127"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "a54ee957f4c86b526460a720dbc882fa5edcbefc"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.41+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ac88fb95ae6447c8dda6a5503f3bafd496ae8632"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.4.6+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "326b4fea307b0b39892b3e85fa451692eda8d46c"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.1+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "3796722887072218eabafb494a13c963209754ce"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.4+0"

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
git-tree-sha1 = "bcd466676fef0878338c61e655629fa7bbc69d8e"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.0+0"

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

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e678132f07ddb5bfa46857f0d7620fb9be675d3b"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.6+0"

[[deps.ZygoteRules]]
deps = ["ChainRulesCore", "MacroTools"]
git-tree-sha1 = "27798139afc0a2afa7b1824c206d5e87ea587a00"
uuid = "700de1a5-db45-46bc-99cf-38207098b444"
version = "0.2.5"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "936081b536ae4aa65415d869287d43ef3cb576b2"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.53.0+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3516a5630f741c9eecb3720b1ec9d8edc3ecc033"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+0"

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
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

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
git-tree-sha1 = "d7015d2e18a5fd9a4f47de711837e980519781a4"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.43+1"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "490376214c4721cdaca654041f635213c6165cb3"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+2"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

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
# ╟─b763cd10-d1e7-4613-b738-9fb1c1cfa1e5
# ╟─a7d3298e-0138-4149-a189-0b5a92cfa0e7
# ╟─5d0d4c4e-b432-437e-9b8e-2f81c79f907e
# ╟─c08f6550-5278-436d-96ec-408570476631
# ╟─7b84db99-9375-4dc5-8a3e-414bc176648a
# ╠═e2feba71-69cb-4f39-92d1-d1f4daefb4ec
# ╟─fd74ea36-fa50-415c-b4a0-92f594178ab9
# ╠═37e57a66-a785-45a1-90a0-3413e7f01898
# ╠═d38e69a8-cbdb-4437-ad5b-64217f3e48d6
# ╠═2cfc4a3a-91f3-416a-bcf5-89a2ecbb0a61
# ╠═5ffb3f8c-d31d-4ed1-8a34-dbe13be57c42
# ╠═c53b615f-b8ca-4427-a52e-ac2e69b54545
# ╠═4bb033b7-02af-4f8d-be9c-62ee7c4fc554
# ╠═3681e1d1-4e78-4026-9295-a67950dfd260
# ╠═1681a1f7-3edd-46e5-8214-a2ac3ab6966d
# ╟─4aeddca1-790a-41c6-a178-3a6369bd5fcc
# ╠═36da1916-adb8-46de-ac90-f046974273f7
# ╠═1b17b320-4d20-47d2-8da1-c34a7b35830b
# ╟─f1bbb819-c83c-4b62-a376-a7a3ef82df04
# ╠═2d843847-ef7e-47d0-a255-c5ec3cc5ec57
# ╟─65543d5f-4d55-4dc5-917b-8a241e09fe86
# ╟─4ffbafed-ca8d-443e-92ff-ec6a6d76f05d
# ╟─1afd2287-6a84-4f16-ab6c-141fce1782cd
# ╟─db2fc0fd-a234-490e-b3a0-936efd699b9c
# ╠═d794e5ad-d893-41c3-a257-2ed0af0390dd
# ╟─1bb97bb9-ef25-4a20-8d35-38b7caead7b9
# ╟─bf4dadde-a191-494a-bd1f-9b7a6c27608c
# ╟─2783c756-ae95-4112-b66c-927801c287e0
# ╟─6e2e5c03-adfe-427d-9880-cfd38c64321a
# ╟─1f1253b4-f0d8-4a22-8eea-d0c57e3cff0c
# ╟─6a1957f2-e862-4bb0-a0f3-68b2d300534f
# ╟─649b75ff-e2a2-4b62-81a6-823d33ef330a
# ╟─da416d35-d074-4e37-bff6-cd2f04510d0e
# ╟─dcba3ba7-e801-4039-8a78-d1725aafa03e
# ╟─4d0544dc-cc03-442b-8d87-1677501a1356
# ╟─48c7168a-56b5-41bf-b493-ddec30da8fee
# ╟─df0d1912-104d-432f-bb80-baad219e5e8b
# ╠═75e4ccf1-d51f-45c2-9bf1-46d731e579e3
# ╠═0f513283-82ad-47f3-84e2-b2d870a9a72d
# ╠═70c242d4-7de4-49a0-b3eb-93b757e1cb86
# ╠═eb6ab469-4830-4cea-a49a-9b901d5d9d2b
# ╟─986889c7-2aa1-4ec2-ac1c-e9168eb1cd09
# ╟─3e2df87d-960e-43a4-affd-3b020d9a7928
# ╟─d9016efd-cc95-4ac5-bdc0-32f5e9282eeb
# ╟─f46a70a5-e090-42d1-922c-7aefd85d8700
# ╟─71d25ca2-7960-413a-8fad-e210fdd41a6b
# ╟─8eb0cc2e-07e7-4c45-bde2-f53517004059
# ╟─f274879e-93ca-409c-94a5-28b59556949f
# ╟─97fc720c-cfb9-488f-92d4-96333dc35374
# ╠═0afa9453-b5af-494b-afba-4ddbeae5da8b
# ╟─b654e0ec-fa6a-425c-b7b0-547e817da1a1
# ╠═f35cd3c4-6433-4f3c-9422-23a9b6dbeade
# ╟─f9ddce28-e503-4203-b02b-831f85a347ec
# ╠═e8846356-38b7-43a5-bb31-d5a7f4a8d63b
# ╟─dd240d3d-2e96-4a63-b85c-650705c0e288
# ╠═fc6ba034-1574-48ce-9780-31977607f8a6
# ╟─714fa522-158c-436a-ac0e-86b4b9bf243d
# ╠═2545e2be-d3eb-4b79-8d80-d06b302e13d4
# ╟─281296be-ed1a-48f0-81fc-a2e5016da55d
# ╠═8628081c-9db1-42ac-8ddd-a6283b59a0f8
# ╟─1880359e-f665-4628-98a7-ca7a35a78206
# ╟─c3c091c7-637b-4335-89ac-aa8f16dd8c09
# ╟─23f33d5d-f32e-4328-b7e4-651f7cdcf345
# ╟─0510e6d0-2628-4ef8-a9ef-ae3f562b9d2d
# ╟─a670f208-e006-47f5-89a7-9bebab429f44
# ╠═1737d90d-2d20-4f2b-b256-aca34ff19b53
# ╠═521da315-bd00-4fa0-958f-ca9ed9d7b81f
# ╠═2c83c7d6-befa-4aae-813d-698eda707646
# ╠═57ddf55f-5ca0-443b-abb2-42fe7615cb42
# ╠═db5e8c5f-3122-4b43-97a8-09b94f35b2ad
# ╠═fc8a0527-5ac0-43a1-a866-394f9265db5d
# ╠═ddfa13d6-b42e-4a21-89e2-6bceea08b0e8
# ╠═5b5ed004-a54f-4feb-b9ce-3e4a0ccbffee
# ╠═495df1e1-c814-4dd9-97cf-c0d9b852834f
# ╠═09119c27-56ee-4201-98b2-2dd0d5adfa64
# ╟─a4d427b5-ab98-43f8-8641-d743e578d456
# ╟─3b0181ce-5038-4c34-9629-40adb5c585c2
# ╟─818df822-2688-49c1-8ace-8494c7562800
# ╟─dc6968ae-939a-4821-9072-853d0b5ff737
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
