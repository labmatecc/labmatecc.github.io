### A Pluto.jl notebook ###
# v0.20.24

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 1f07472c-99b1-448a-9fff-6d21c3a3653c
begin
	using Plots, LinearAlgebra, Optim, DifferentialEquations
	using PlutoUI
	using HypertextLiteral
end

# ╔═╡ 4c42c02f-206d-4ac9-b17a-9547bb9da4cd
PlutoUI.TableOfContents(title="Ajuste de parámetros", aside=true)

# ╔═╡ f83c7795-f18b-4b95-8944-ff934b291df9
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ d37822d7-480c-4f7f-ab83-806655326573
md"""**Este cuaderno está basado en actividades del curso Introducción a las ciencias de la computación y la programación de la Universidad Nacional de Colombia, sede Bogotá, dictado por el profesor Juan Galvis en 2021-2.**

Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo. 
"""

# ╔═╡ 228e6502-1dad-447b-8684-2bf4115bb6cf
md"""Usaremos las siguientes librerías:"""

# ╔═╡ c66ecc8a-9dd4-4244-ada6-48e9ad85c305
md"""
# Introducción

El ajuste de curvas o ajuste de datos consiste en buscar una relación entre ellos. Es decir, si tenemos datos correspondientes a dos variables, la idea es encontrar una relación que describa de manera precisa el comportamiento de dichos datos.

Para optimizar los valores de los parámetros del modelo, creamos una función que calcule el tamaño del desajuste entre los datos observados y los generados por los posibles modelos. Esta función recibe los datos y los valores válidos de los parámetros del modelo, y devuelve la norma del residuo. Podemos utilizar, por ejemplo, la medida de desajuste de mínimos cuadrados (norma euclidiana). Posteriormente, empleamos una biblioteca de optimización para calcular el valor del parámetro óptimo aproximado.
"""

# ╔═╡ d00d6273-7b7c-4fc3-b591-ebde3831f383
md"""# Ajuste mediante mínimos cuadrados

Consideremos el siguiente ejemplo, donde tenemos datos sobre el crecimiento de un tumor en ratones. 

Estos datos y más información se encuentran en el trabajo "Modeling Cancer Growth with Differential Equations" de Jue Wang, del Departamento de Matemáticas de Union College, Schenectady NY 12308, USA. Ver [9]. Se recomienda también consultar [10]."""

# ╔═╡ 5fbc47f1-3d0b-4db7-87a6-cafc71b1df91
begin
	# Datos tomados del documento,  
	#Modeling Cancer Growth with Differential Equations
	# de Jue Wang, Department of Mathematics
	#Union College, Schenectady NY 12308 USA
	#wangj@union.edu
	
	Datos=[
	3.46	0.0158
	4.58	0.0264
	5.67	0.0326
	6.64	0.0445
	7.63	0.0646
	8.41	0.0933
	9.32	0.1454
	10.27	0.2183
	11.19	0.2842
	12.39	0.4977
	13.42	0.6033
	15.19	0.8441
	16.24	1.2163
	17.23	1.447
	18.18	2.3298
	19.29	2.5342
	21.23	3.0064
	21.99	3.4044
	24.33	3.2046
	25.58	4.5241
	26.43	4.3459
	27.44	5.1374
	28.43	5.5376
	30.49	4.8946
	31.34	5.066
	32.34	6.1494
	33.00	6.8548
	35.20	5.9668
	36.34	6.6945
	37.29	6.6395
	38.50	6.8971
	39.67	7.2966
	41.37	7.2268
	42.58	6.8815
	45.39	8.0993
	46.38	7.2112
	48.29	7.0694
	49.24	7.4971
	50.19	6.9974
	51.14	6.7219
	52.10	7.0523
	54.00	7.1095
	56.33	7.0694
	57.33	8.0562
	59.38	7.2268];
	
	tiempo=Datos[:,1];
	volumen=Datos[:,2];
	Datos
end

# ╔═╡ 7b68aba2-181e-4f79-956d-81cb968539a1
md"""Visualicemos dichos datos."""

# ╔═╡ 29fee2c7-1ebd-497c-8be2-e7883ac62011
scatter(tiempo,volumen,ls=:dash,label="Volumen",lw=4, xlabel = "Tiempo",yaxis="Volumen", title="Datos del crecimiento de un tumor en ratones")

# ╔═╡ d1c225a8-1d13-4e99-a657-167f37524065
md"""Para ilustrar el procedimiento, ajustaremos los datos a los siguientes modelos:
1. Un modelo polinomial de grado uno.
2. Un modelo polinomial cúbico.
3. Un modelo de redes neuronales artificiales.
4. Un modelo de ecuaciones diferenciales (Modelo de von Bertalanffy)."""

# ╔═╡ f455f893-2ca2-49ff-a581-0e1fd04ef8cc
md"""
## Modelo lineal
Asumamos que el modelo lineal tiene la siguiente forma:

$V(t) \approx a+bt,$

y queremos estimar los parámetros $a$ y $b$.

Para lograr esto, creamos una función que mida la norma del residuo, es decir, el tamaño del desajuste entre el modelo polinomial cúbico y los datos. Utilizaremos, por ejemplo, la metodología de mínimos cuadrados, que corresponde a la norma euclidiana de la diferencia o residuo.
"""

# ╔═╡ 7487e176-6d28-4ed2-bd57-d7a10e5c0af4
function residuoPL(par,V,tiempo)
  a,b=par
  oneaux=fill(1,size(tiempo))
  Vmodelo=a*oneaux+b*tiempo
  res=V-Vmodelo
  nres=norm(res)
return nres
end

# ╔═╡ 69902876-e96f-46ab-bf25-7dc1e08bf4de
md"""La función de residuo arriba mide el desajuste (o tamaño del residuo) de la simulación del modelo lineal con respecto a los datos usando mínimos cuadrados, es decir, la norma euclidiana de la diferencia o residuo. Asumimos que nuestro modelo de observación mide directamente el tamaño del tumor. Es decir, el desajuste se mide directamente con la diferencia del modelo contra los datos."""

# ╔═╡ 37325f60-6e42-401c-bd5a-14fe3346008d
md"""
Por ejemplo, el desajuste de usar $a=1$ y $b=2$, es decir, aproximar $V(t)≈1+2t$ es $\approx 424.31$ que es calculado a continuación.
"""

# ╔═╡ 30572dcb-d068-4289-95b5-0ae7f226cd45
residuoPL([1,2],volumen,tiempo)

# ╔═╡ beb14444-3720-449c-b9b6-3a49d3f5efe5
begin
	aLins= @bind aLinv Slider(-2:.1:2, show_value=true, default=-0.7)
	bLins= @bind bLinv Slider(-2:.1:2, show_value=true, default=0.16)
end;

# ╔═╡ 2c627e7f-b60c-49ec-ac83-1cc9bf8f93c3
md""" Otro ejemplo, se presenta a continuación:"""

# ╔═╡ 79e6eb38-8a95-4261-8bcf-cb8bc94b6966
reslinaux=residuoPL([aLinv,bLinv],volumen,tiempo);

# ╔═╡ 2fe9a793-b39f-42f7-8309-6eb08adf609b
md""" a = $aLins,  	b = $bLins\

Residuo= $reslinaux
"""

# ╔═╡ 89974b10-40a8-418c-9f5f-6c000e4070d3
md"""
Ahora usamos una librería de optimización para calcular el valor del parámetro óptimo aproximado.
"""

# ╔═╡ d7942a99-8730-4911-afb3-5fcd9bf9504d
md"""
Definimos una función que dependa únicamente de la varible de desición de la optimización.
"""

# ╔═╡ 97f3b97b-bee3-4314-9076-bca4e6d5e401
rPL(par) = residuoPL(par, volumen, tiempo)

# ╔═╡ d62512e5-9594-4a2e-9bb1-96a590d002d1
md"""
Procedemos a realizar la optimización, para esto usamos el comando optimize.
"""

# ╔═╡ 253ef95f-1734-4e51-8592-85aa421b9f68
oL =Optim.optimize(rPL, [3.0, 5.0], LBFGS())

# ╔═╡ 60398575-8e55-4a36-966c-46822b43a5c0
md"""Podemos obtener información sobre los valores óptimos numéricos encontrados y los puntos óptimos de la siguiente manera."""

# ╔═╡ 58b75390-8bbe-419e-a9e5-6b477deb4e56
oL.minimizer

# ╔═╡ 127d3343-1fdc-46e1-a831-0a9e2ddd30f7
oL.minimum

# ╔═╡ 7641feae-e88e-46d8-948f-9321d8c05f64
md"""De esto se tiene que la ecuación lineal óptima es $V(t)= -0.701959 + 0.16774t$.

Después de determinar el valor del parámetro óptimo, podemos presentar el ajuste final de nuestro modelo. Podemos visualizar el ajuste comparándolo con los datos. Para ello, tenemos:"""

# ╔═╡ 431b33e2-a912-4f06-8c18-8022f041960a
begin
	ts=0:0.1:60
	oneaux=fill(1,size(ts))
	
	VolumenPL=oL.minimizer[1]*oneaux+oL.minimizer[2]*ts
	plot(ts,VolumenPL,lw=5,label="Modelo lineal óptimo")
	scatter!(tiempo,volumen,ls=:dash,label="Volumen",lw=4, xlabel = "Tiempo",yaxis="Volumen",legend=:bottomright, title="Modelo lineal óptimo")
end

# ╔═╡ 035e0c2b-da27-4ec6-8f7c-10d07197357f
begin
#	ts=0:0.1:60
#	oneaux=fill(1,size(ts))
	
	VolumenPLaux=aLinv*oneaux+bLinv*ts
	plot(ts,VolumenPLaux,lw=5,label="Modelo lineal óptimo")
	scatter!(tiempo,volumen,ls=:dash,label="Volumen",lw=4, xlabel = "Tiempo",yaxis="Volumen",legend=:bottomright)

end

# ╔═╡ 743bf7f7-cb1f-4b5b-a3a2-033b61fc0d18
md"""
## Modelo polinomio cúbico 

Asumamos que el modelo cúbico tiene la siguiente forma:

$V(t) \approx a+bt+ct^2+dt^3,$

y queremos estimar los parámetros $a,b,c$ y $d$.

Vamos a crear una función que calcule la norma del residuo, es decir, el tamaño del desajuste del modelo polinomial cúbico con respecto a los datos. Utilizaremos, por ejemplo, la metodología de mínimos cuadrados, que corresponde a la norma euclidiana de la diferencia o residuo.
"""

# ╔═╡ adc26b63-b7d9-466e-b293-57d1c6c6d655
function residuoPC(par,V,t)
  a,b,c,d=par
  oneaux=fill(1,size(t))
  Vmodelo=a*oneaux+b*t+c*t.^2+d*t.^3
  res=V-Vmodelo
  nres=norm(res)
return nres
end

# ╔═╡ 3a0d542b-a24f-419a-937d-670498a0d588
md"""Al igual que en el modelo lineal, la función anterior mide el desajuste de la simulación con respecto a los datos usando mínimos cuadrados.

A continuación, definimos una función que dependa únicamente de la varible de desición de la optimización."""

# ╔═╡ dd5ec77b-d541-4e6c-a1d3-5b75889079ba
rPC(par) = residuoPC(par, volumen, tiempo)

# ╔═╡ b1a0066a-7d45-4397-a6cf-d5657ee12a9d
md"""Ya con esto podemos realizar la optimización de los parámetros"""

# ╔═╡ 3acbb4d7-a48d-44f5-bddd-4420db2a6230
oC=Optim.optimize(rPC, [.1,.01,.01,0.001],NelderMead() )

# ╔═╡ 1c215b55-d48c-44f3-9bdb-bd4f86c76d11
oC.minimizer

# ╔═╡ 18120e10-5bb6-4c6c-974f-97dca370e49e
md"""De esto se tiee que la ecuación cúbica que se ajusta a los datos dados es 

$V(t)=-0.814806 + 0.0540683 t + 0.00836915 t^2 -0.000121103 t^3$"""

# ╔═╡ 94abec7a-211e-4bfc-9df6-e51cb6cf5e30
md"""La visualización del ajuste y los datos es la que se muestra a continuación"""

# ╔═╡ 70690406-24ec-43ef-b7d4-5685304fcecb
begin
	oCm=oC.minimizer
	VolumenPC=oCm[1]*oneaux+oCm[2]*ts+oCm[3]*ts.^2+oCm[4]*ts.^3
	plot(ts,VolumenPC,lw=5,label="Cúbico optimo")
	scatter!(tiempo,volumen,ls=:dash,label="Volumen",lw=4, xlabel = "Tiempo",yaxis="Volumen",legend=:bottomright, title="Modelo cúbico optimo")
end

# ╔═╡ 322db9b0-f40a-401f-9860-d3556b59b0de
md"""
## Modelo de redes neuronales artificiales

En este modelo asumimos que 

$V(t) \approx a\frac{1}{1+e^{bt+ c}}+d\frac{1}{1+e^{ft+g}},$

y queremos estimar $a,b,c,d,f$ y $g$.

Creamos una función que calcula la magnitud del residuo, es decir, el grado de desajuste del modelo polinomial cúbico en relación con los datos. Para esto, utilizamos mínimos cuadrados, calculando la norma euclidiana de la diferencia o residuo."""

# ╔═╡ 552bf189-aa47-46c2-b397-3a15b666e2a1
function residuoNN(par,V,t)
  a,b,c,d,f,g=par
  one=fill(1,size(tiempo))
  Vmodelo=a*( one./ (one+exp.(b*t+c*one)  ))+d*( one./ (one+exp.(f*t+g*one)  ))
  res=V-Vmodelo
  nres=norm(res)
return nres
end

# ╔═╡ 18f377b7-13a4-4d05-866b-5aa7673bbf91
md"""Similar a los modelos anteriores, la función previa mide el desajuste de la simulación en comparación con los datos utilizando mínimos cuadrados.

A continuación, definimos una función que depende exclusivamente de la variable de decisión de la optimización."""

# ╔═╡ 0dec7897-abe4-4915-820f-4a641cddc9af
rNN(par) = residuoNN(par, volumen, tiempo)

# ╔═╡ a6ef954b-de4a-49d0-bf8a-aa0a3a27cd91
md"""Así, optimizando los parámetros se tiene lo siguiente:"""

# ╔═╡ 1977c545-5213-4a53-9eeb-c5affdaa0b44
oN=Optim.optimize(rNN, [.01,.01,.01,0.001,0.001,0], BFGS())

# ╔═╡ d628e804-ae91-40e0-8707-7e928b02ab5d
oN.minimizer

# ╔═╡ 44560655-61cc-402a-aef7-7800c0fe27f1
md"""
Esto quiere decir, que el mejor modelo encontrado de redes neuronales artificales es

$V(t) \approx 2.872\frac{1}{1+e^{0.519t+ 25.399}}+7.279\frac{1}{1+e^{-0.195t+ 4.680}}.$
Como antes, podemos visualizar el ajuste comparandolo con los datos. Para esto tenemos, 
"""

# ╔═╡ 4488222b-3332-45f2-87e1-ee5562a622d3
begin
	uno=fill(1,size(ts))
	oNm=oN.minimizer
	VolumenNN=oNm[1]*( uno./ (uno+exp.(oNm[2]*ts+oNm[3]*uno)  ))+oNm[4]*( uno./ (uno+exp.(oNm[5]*ts+oNm[6]*uno)  ))
	plot(ts,VolumenNN,lw=5,label="NN optimo")
	scatter!(tiempo,volumen,ls=:dash,label="Volumen",lw=4, xlabel = "Tiempo",yaxis="Volumen",legend=:bottomright, title="Modelo de redes neuronales artificiales óptimo")
end

# ╔═╡ a1832207-f5b1-4617-9ff1-9d9b0ac1a5ec
md"""
## Modelo de ecuaciones diferenciales"""

# ╔═╡ c64814cb-96a6-4677-8bec-4ef9a45492c8
md"""
### Modelo de von Bertalanffy
Para ilustrar el procedimiento, ajustaremos los datos a un modelo de ecuaciones diferenciales, el Modelo de von Bertalanffy. Este modelo se utiliza para mostrar el crecimiento de tumores en el cuerpo, donde el crecimiento del tumor se desacelera a medida que se hace más grande.

El modelo es el siguiente:

$V'=aV^{\frac{2}{3}}-bV,$

donde $V$ es el tamaño del tumor en el tiempo $t$, $a$ es la velocidad máxima de crecimiento, y $b$ es la tasa de muerte celular o retroceso del tumor.

Consideremos este modelo con la condición inicial $V_0=V(0)=0.0158$. Recordemos que buscamos hallar los valores óptimos de $a$ y $b$.

Creamos una función para el modelo de Bertalanffy:
"""

# ╔═╡ b70471d6-b236-4a45-847c-3f70eaf32547
modeloBF(V,par,t)=par[1]*V.^(2/3)-par[2]*V

# ╔═╡ ab67a9df-c3a9-422c-b872-3c9146f9ce62
md"""
Si queremos resolver la EDO para determinados valores de los parámetros, usamos, 
"""

# ╔═╡ 69f0b870-6854-4cf1-b4d1-eaff9c2b54de
begin
	aBerts= @bind aBertv Slider(0:.1:2, show_value=true, default=1.0)
	bBerts= @bind bBertv Slider(0:.1:2, show_value=true, default=1.0)
end;

# ╔═╡ df8ba077-c1f8-45f9-b35d-695da050ef60
md""" a = $aBerts,  	b = $bBerts
"""

# ╔═╡ 7a64aa81-cf01-4d0b-8829-713f3bb41b85
begin
	tspan=(3.26,80)
	V0=0.0158
	par=[aBertv,bBertv]
	EDO=ODEProblem(modeloBF,V0,tspan,par)
	V=solve(EDO)
	plot(V, linewidth=4)
#	VI=[V(t) for t in tiempo] # Evaluación de la solución en los tiempos dados (datos)
#	scatter!(tiempo,VI)
end

# ╔═╡ 3c4a0c66-6e87-46ee-a4d9-a8a8adb172ce
md"""
Ahora podemos escribir la función residuo del modelo de EDO. Es decir, cacular la norma entre el pronostico de una EDO con parametros dados y los datos. 
"""

# ╔═╡ 4f407f00-5c0b-4549-b325-cfb1b9c6b794
function residuoBF(par,V,t)
	tspan=(3.26,80)
	V₀=0.0158
	EDO=ODEProblem(modeloBF,V₀,tspan,par)
	VSOL=solve(EDO)
	VI=[VSOL(t) for t in tiempo]
	res=V-VI
	nres=norm(res)
	return nres
end

# ╔═╡ b4722136-23d0-462a-bc4a-7cc437dfa2e0
md"""La función de residuo arriba mide el desajuste (o tamaño del residuo) de la simulación de la EDO con respecto a los datos usando mínimos cuadrados, es decir, la norma euclidiana de la diferencia o residuo. 
**Asumimos que nuestro modelo de observación mide directamente el tamaño del tumor. Es decir, el desajuste se mide directamente con la diferencia del modelo contra los datos.**

Por ejemplo, el desajuste al usar $a=1$ y $b=1$ en el modelo es:"""

# ╔═╡ ba28e078-7473-4b80-a327-06075f0fd896
residuoBF([1 1],volumen,tiempo)

# ╔═╡ 866c5782-fbab-4bfc-bad9-e87c6ff25d1a
md"""
Como antes, escribimos una función solo del parámetro, 
"""

# ╔═╡ 07be42af-7328-4ed0-a6d0-3399403f1495
rBF(par) = residuoBF(par, volumen, tiempo)

# ╔═╡ 891ab2d0-4e78-46c4-83b2-c39487a28111
md"""
Y podemos optimizar el valor de los parámetros.
"""

# ╔═╡ 1327ecc4-d5fa-4f87-b6f8-f5c77101f8e4
oBF=Optim.optimize(rBF, [.01,.01], NelderMead())

# ╔═╡ 7d0f1d07-e85a-4ede-86a1-a147d08e660a
oBF.minimizer

# ╔═╡ d2f8bd46-b802-41c0-af8d-b09d92e47fac
md"""
De esto se obtiene que la EDO optima es

$V'=  0.396V^\frac{2}{3}- 0.194V.$

Después de calcular el valor del parámetro óptimo, podemos mostrar el ajuste final de nuestro modelo. Como antes, podemos visualizar el ajuste comparándolo con los datos. Para esto tenemos:
"""

# ╔═╡ 801492a6-0c56-41c3-bd28-82d9dd59d79c
begin
#	tspan=(3.26,80)
#	V0=0.0158
	oBFm=oBF.minimizer
	EDOoptima=ODEProblem(modeloBF,V0,tspan,oBFm)
	VEDOoptima=solve(EDOoptima)
	plot(VEDOoptima,lw=5,label="EDO optima")
	scatter!(tiempo,volumen,ls=:dash,label="Volumen",lw=4, xlabel = "Tiempo",yaxis="Volumen",legend=:bottomright, title="Ecuación diferencial ordinaria óptima")
end

# ╔═╡ e4e8d624-ca1b-49b3-bd90-0ef3d2cfde3a
md"""### Modelo Logistic Growth
 
Teniendo en cuenta los datos sobre el crecimiento de un tumor en ratones, ajustemos dichos datos siguiendo el modelo de crecimiento logístico.
El modelo es el siguiente:

$$V' = aV\left(1 - \frac{V}{b}\right).$$

Este modelo describe el crecimiento de poblaciones bajo ciertas condiciones. $V$ representa la población en el instante $t$, donde $V'$ representa la tasa de cambio de la población con respecto al tiempo. $a$ es la tasa de crecimiento intrínseca de la población y $b$ es la capacidad de carga del entorno, es decir, el máximo tamaño de la población que el entorno puede soportar de manera sostenible. Así, la ecuación describe cómo la tasa de crecimiento de una población cambia a medida que la población se acerca a su capacidad máxima de carga en un entorno dado.

Consideremos este modelo con la condición inicial $V_0 = V(0) = 0.0158$. Recordemos que buscamos hallar los valores óptimos de $a$ y $b$."""

# ╔═╡ 212d057a-302f-4e7e-a923-d907d322552f
modeloLG(V,par,t)=par[1]*V*(1-V/par[2])

# ╔═╡ 7a0cd968-b14e-4a05-9c6f-3052509bd468
md"""Si deseamos encontrar la solución de la ecuación diferencial ordinaria para ciertos valores específicos de los parámetros, empleamos:
"""

# ╔═╡ 292d6659-8db3-4477-aa46-e60881d7c923
begin
	aLogistic= @bind aLogisticv Slider(0:.1:2, show_value=true, default=1.0)
	bLogistic= @bind bLogisticv Slider(0:.1:2, show_value=true, default=1.0)
end;

# ╔═╡ 11c6fe6a-7d01-464c-b31a-bf99b05ba9d2
md""" a = $aLogistic,  	b = $bLogistic
"""

# ╔═╡ 0e6e35b5-9cc5-40d4-84d1-370205c97df1
begin
	tspan₂=(3.26,80)
	V0₂=0.0158
	par₂=[aLogisticv,bLogisticv]
	EDO₂=ODEProblem(modeloLG,V0₂,tspan₂,par₂)
	V₂=solve(EDO₂)
	plot(V₂, linewidth=4)
end

# ╔═╡ fd1fd424-6f28-4c8a-88a6-89e8bae8db8d
md"""La función de residuo mide el desajuste (o tamaño del residuo) de la simulación de la ecuación diferencial ordinaria con respecto a los datos usando mínimos cuadrados, es decir, la norma euclidiana de la diferencia o residuo."""

# ╔═╡ a1035046-1058-4e97-bc92-59f3282b7904
function residuoLG(par₂,V₂,t₂)
   	tspan₂=(3.26,80)
  	V0₂=0.0158
 	EDO₂=ODEProblem(modeloLG,V0₂,tspan₂,par₂)
  	VSOL₂=solve(EDO₂)
  	VI₂=[VSOL₂(t) for t in tiempo]
  	res₂=V₂-VI₂
  	nres₂=norm(res₂)
	return nres₂
end

# ╔═╡ f99b063a-f443-40c8-816a-18049277ec84
md"""Por ejemplo, el desajuste de usar $a=1$ y $b=1$ en el modelo es de:"""

# ╔═╡ ebe8f2d6-40f3-4c06-a169-60923cdfda14
residuoLG([1 1],volumen,tiempo)

# ╔═╡ c3cc2a03-ed78-479f-b51c-200e132671a5
md"""Ahora, usemos optimización para calcular el valor del parámetro óptimo aproximado. Para esto creamos una función solo del parámetro,"""

# ╔═╡ bebec37c-dcb3-4023-9790-3ec5dd0ecc95
rLG(par₂) = residuoLG(par₂, volumen, tiempo)

# ╔═╡ e1663738-c3e7-405b-bcf1-9178cae3aec1
md"""y, optimizamos su valor:"""

# ╔═╡ a60eb433-067e-497d-891b-26f2216fef21
oLG=Optim.optimize(rLG, [.01,.01], NelderMead())

# ╔═╡ 6367f839-5eab-408c-83a9-bb5065a53391
oLG.minimizer

# ╔═╡ 87a380f0-4c04-457d-b30f-bbf964a2a1c9
md"""Obteniendo así que los valores optimos para $a$ y $b$ son $0.297$ y $7.012$, respectivamente. 

Luego, la EDO optima esta dada como:

$V'= 0.3V\left(1-\frac{V}{7.01}\right).$

Después de calcular el valor del parámetro óptimo podemos mostrar el ajuste final de nuestro modelo. """

# ╔═╡ 7e6767f2-a6d4-4138-9d06-21587586b402
begin
	oLGm=oLG.minimizer
	EDOoptima₂=ODEProblem(modeloLG,V0₂,tspan,oLGm)
	VEDOoptima₂=solve(EDOoptima₂)
	plot(VEDOoptima₂,lw=5,label="EDO optima")
	scatter!(tiempo,volumen,ls=:dash,label="Volumen",lw=4, xlabel = "Tiempo",yaxis="Volumen",legend=:bottomright, title="Ecuación diferencial ordinaria óptima")
end

# ╔═╡ 081cb3c2-6527-4676-a238-99f7ff51c1c3
md"""
# Problemas
**1.** Considere el modelo polinomial de grado 1 y 3. Proponga un modelo polinomial de grado 4. Escriba las rutinas necesarias para optimizar los valores de los parámetros de este modelo de grado 4. Muestre el ajuste obtenido. Intente con diferentes valores iniciales de los parámetros y seleccione los valores calculados que arrojen un menor valor del residuo. Puede usar listas e índices para la identificación de los parámetros. 
 
**2.** Considere ahora el modelo de redes neuronales artificiales presentado arriba. Esta red neuronal artificial tiene una capa y dos neuronas. Agregue una tercera neurona.  Escriba las rutinas necesarias para optimizar los valores de los parámetros de este modelo con tres neuronas. Muestre el ajuste obtenido. Intente con diferentes valores iniciales de los parámetros y seleccione los valores calculados que arrojen un menor valor del residuo. Puede usar listas e índices para la identificación de los parámetros. 

**3. OPCIONAL** Considerar el modelo de ecuaciones diferenciales (Logistic Growth)

$V'= aV\left(1-\frac{V}{b}\right).$


**4** Construya, para un conjunto de datos seleccionados, un modelo que considere adecuado y ajuste los valores de los parámetros. Es decir, repita el ejercicio arriba para otro conjunto de datos. 
Puede usar librerías de aprendizaje de máquina, de interpolación o de ajustes diferentes a las mostradas en clase. Por ejemplo, puede usar los datos de la tabla anexa (https://saludata.saludcapital.gov.co/osb/index.php/datos-de-salud/enfermedades-trasmisibles/ocupacion-ucis/). 


|Fecha |Camas UCI Covid-19|
|---|---|
|1/01/2022| 222|
|2/01/2022| 209|
|3/01/2022|217|
|4/01/2022| 245|
|5/01/2022| 252|
|6/01/2022| 278|
|7/01/2022| 291|
|8/01/2022| 299|
|9/01/2022| 302|
|10/01/2022| 292|
|11/01/2022| 311|
|12/01/2022| 306|
|13/01/2022| 326|
|14/01/2022| 332|
|15/01/2022| 368|
|16/01/2022| 356|
|17/01/2022| 373|
|18/01/2022| 397|
|19/01/2022| 410|
|20/01/2022| 431|

Puede usar los modelos vistos en clase y algunos adicionales como:


$y=A\frac{1}{x}+B,$
$y=\frac{D}{x+C},$
$y=\frac{x}{Ax+B},$
$y=Ce^{Ax},$
$y=Cx^A,$
$y=(Ax+b)^{-2},$
$y=Cxe^{-Dx},$
$y=\frac{L}{1+Ce^{Ax}},$

entre otros. O intetente modelos de ecuaciones diferenciaqles
"""

# ╔═╡ 4e370389-c16f-4496-9f7d-9a98f18df78f
md"""
# Referencias
[1] Driscoll, T. A., & Braun, R. J. (n.d.). Revisión del libro de texto *Fundamentals of Numerical Computation*. Adaptado a Julia. Recuperado de https://epubs.siam.org/doi/10.1137/1.9781611977011

[2] Sullivan, E. (2020). *Numerical Methods: An Inquiry-Based Approach With Python*.

[3] Bulirsch, R., Stoer, J., & Stoer, J. (2002). *Introduction to numerical analysis* (Vol. 3). Heidelberg: Springer.

[4] Stewart, G. W. (1996). *Afternotes on numerical analysis*. Society for Industrial and Applied Mathematics.

[5] Quarteroni, A., Saleri, F., & Gervasio, P. (2006). *Scientific computing with MATLAB and Octave* (Vol. 3). Berlín: Springer.

[6] Hertzmann, A. (n.d.). *Machine Learning and Data Mining Lecture Notes*. Recuperado de http://www.dgp.toronto.edu/~hertzman/411notes.pdf

[7] Goodfellow, I., Bengio, Y., & Courville, A. (n.d.). *Deep Learning*. Recuperado de https://www.deeplearningbook.org/lecture_slides.html

[8] Wang, J. (s.f.). Modeling Cancer Growth with Differential Equations. Department of Mathematics, Union College, Schenectady, NY, USA.

[9] SIMIODE. (n.d.). SIMIODE: Systemic Initiative for Modeling Investigations and Opportunities with Differential Equations. QUBES. Recuperado de [https://qubeshub.org/community/groups/simiode](https://qubeshub.org/community/groups/simiode)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DifferentialEquations = "0c46a032-eb83-5123-abaf-570d42b7fbaa"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Optim = "429524aa-4258-5aef-a3af-852621145aeb"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
DifferentialEquations = "~8.1.1"
HypertextLiteral = "~1.0.0"
Optim = "~2.3.2"
Plots = "~1.41.7"
PlutoUI = "~0.7.83"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.6"
manifest_format = "2.0"
project_hash = "63f1a18c44a32dbee3c43f42dae0c055a19121af"

[[deps.ADTypes]]
deps = ["PrecompileTools"]
git-tree-sha1 = "629de23e1c16911b439dabd2303c08af9575b226"
uuid = "47edcb42-4c32-4615-8424-f2b9edc5f35b"
version = "1.24.0"

    [deps.ADTypes.extensions]
    ADTypesChainRulesCoreExt = "ChainRulesCore"
    ADTypesConstructionBaseExt = "ConstructionBase"
    ADTypesEnzymeCoreExt = "EnzymeCore"

    [deps.ADTypes.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"

[[deps.AMD]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse_jll"]
git-tree-sha1 = "344f3d221a6bee75925b5c97a30cfd870f12a138"
uuid = "14f7f29c-3bd6-536c-9a0b-7339e30b5a3e"
version = "0.5.4"

[[deps.AbstractPlutoDingetjes]]
git-tree-sha1 = "e71ee7b4aa06b045259a7d6101e1cb45ad140bce"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.4.1"

[[deps.Accessors]]
deps = ["CompositionsBase", "ConstructionBase", "Dates", "InverseFunctions", "MacroTools"]
git-tree-sha1 = "7063ad1083578215c7c4bf410368150abe8d5524"
uuid = "7d9f7c33-5ae7-4f3b-8dc6-eff91059b697"
version = "0.1.45"

    [deps.Accessors.extensions]
    AxisKeysExt = "AxisKeys"
    IntervalSetsExt = "IntervalSets"
    LinearAlgebraExt = "LinearAlgebra"
    StaticArraysExt = "StaticArrays"
    StructArraysExt = "StructArrays"
    TestExt = "Test"
    UnitfulExt = "Unitful"

    [deps.Accessors.weakdeps]
    AxisKeys = "94b1ba4f-4ee9-5380-92f1-94cde586c3c5"
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "dee8388a9bec89c8713ad176f96960ae2f98598a"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.7.4"

    [deps.Adapt.extensions]
    AdaptSparseArraysExt = "SparseArrays"
    AdaptStaticArraysExt = "StaticArrays"

    [deps.Adapt.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra"]
git-tree-sha1 = "1aec1ff0dcaa83a484e7f72097562fa3102c6722"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.30.2"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceAMDGPUExt = "AMDGPU"
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = ["CUDSS", "CUDA"]
    ArrayInterfaceChainRulesCoreExt = "ChainRulesCore"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceFillArraysExt = "FillArrays"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceGPUArraysCoreTrackerExt = ["GPUArraysCore", "Tracker"]
    ArrayInterfaceMetalExt = "Metal"
    ArrayInterfaceReverseDiffExt = "ReverseDiff"
    ArrayInterfaceSparseArraysExt = "SparseArrays"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    AMDGPU = "21141c5a-9bdb-4563-92ae-f87d6854732e"
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CUDSS = "45b445bb-4962-46a0-9369-b4df9d0f772e"
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    FillArrays = "1a297f60-69ca-5386-bcde-b61e274b549b"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    Metal = "dde4c033-4e86-420c-a63e-0dd931031962"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BinaryHeaps]]
deps = ["PrecompileTools"]
git-tree-sha1 = "0adb6d8d0a4bae93a07d79c8d59eaf617f4c59da"
uuid = "b2a6c25c-c996-4615-94ab-6e519ffb8690"
version = "1.1.0"

[[deps.BracketingNonlinearSolve]]
deps = ["CommonSolve", "ConcreteStructs", "NonlinearSolveBase", "PrecompileTools", "Reexport", "SciMLBase", "SciMLLogging"]
git-tree-sha1 = "b1b04c236ff7ed92e69d64b620448b3da00933d4"
uuid = "70df07ce-3d50-431d-a3e7-ca6ddb60ac1e"
version = "1.12.8"

    [deps.BracketingNonlinearSolve.extensions]
    BracketingNonlinearSolveChainRulesCoreExt = ["ChainRulesCore", "ForwardDiff"]
    BracketingNonlinearSolveForwardDiffExt = "ForwardDiff"

    [deps.BracketingNonlinearSolve.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "0cfb779e24fdced77a05df1dbe99200821a9f563"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.8+1"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b0fd3f56fa442f81e0a47815c92245acfaaa4e34"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.31.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "61761f58648aa7217445f24f841839b78c712232"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.3"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Reexport"]
git-tree-sha1 = "a633156e74096f90b3b5e833529292b651b5671a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.3"

[[deps.CommonSolve]]
deps = ["PrecompileTools"]
git-tree-sha1 = "6c389fa857f6ca5a95474b52a52023fd77f24cb7"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.14"

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

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
version = "1.3.0+1"

[[deps.CompositionsBase]]
git-tree-sha1 = "802bb88cd69dfd1509f6670416bd4434015693ad"
uuid = "a33af91c-f02d-484b-be07-31d278c5ca2b"
version = "0.1.2"
weakdeps = ["InverseFunctions"]

    [deps.CompositionsBase.extensions]
    CompositionsBaseInverseFunctionsExt = "InverseFunctions"

[[deps.ConcreteStructs]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a72c3b5ce6d2a477f55b5c9b8756e91e695c67f6"
uuid = "2569d6c7-a4a2-43d3-a901-331e8e4be471"
version = "0.2.8"

[[deps.ConstructionBase]]
git-tree-sha1 = "b4b092499347b18a015186eae3042f72267106cb"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.6.0"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.Crayons]]
git-tree-sha1 = "54b76cbb40d9a0f5368c880725b2f141da77c94f"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.2.0"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "b0bc6d2cad1fed8b7fd59a1551a991cb3d2809e6"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.6"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DiffEqBase]]
deps = ["ArrayInterface", "BracketingNonlinearSolve", "ConcreteStructs", "DocStringExtensions", "FastBroadcast", "FastClosures", "FastPower", "FunctionWrappers", "FunctionWrappersWrappers", "LinearAlgebra", "Logging", "Markdown", "MuladdMacro", "PrecompileTools", "Printf", "RecursiveArrayTools", "Reexport", "RespecializeParams", "SciMLBase", "SciMLLogging", "SciMLOperators", "SciMLStructures", "Setfield", "StaticArraysCore", "SymbolicIndexingInterface", "TruncatedStacktraces"]
git-tree-sha1 = "4e3938f036cf93f3c6acf7a7008848675d3d130f"
uuid = "2b5f629d-d688-5b77-993f-72d75c75574e"
version = "7.21.3"

    [deps.DiffEqBase.extensions]
    DiffEqBaseCUDAExt = "CUDA"
    DiffEqBaseChainRulesCoreExt = "ChainRulesCore"
    DiffEqBaseDynamicQuantitiesExt = "DynamicQuantities"
    DiffEqBaseEnzymeExt = ["ChainRulesCore", "Enzyme"]
    DiffEqBaseFlexUnitsExt = "FlexUnits"
    DiffEqBaseForwardDiffExt = ["ForwardDiff"]
    DiffEqBaseGTPSAExt = "GTPSA"
    DiffEqBaseGeneralizedGeneratedExt = "GeneralizedGenerated"
    DiffEqBaseMPIExt = "MPI"
    DiffEqBaseMeasurementsExt = "Measurements"
    DiffEqBaseMonteCarloMeasurementsExt = "MonteCarloMeasurements"
    DiffEqBaseMooncakeExt = "Mooncake"
    DiffEqBaseReverseDiffExt = "ReverseDiff"
    DiffEqBaseSparseArraysExt = "SparseArrays"
    DiffEqBaseTrackerExt = "Tracker"
    DiffEqBaseUnitfulExt = "Unitful"

    [deps.DiffEqBase.weakdeps]
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
    DynamicQuantities = "06fc5a27-2a28-4c7c-a15d-362465fb6821"
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"
    FlexUnits = "76e01b6b-c995-4ce6-8559-91e72a3d4e95"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    GTPSA = "b27dd330-f138-47c5-815b-40db9dd9b6e8"
    GeneralizedGenerated = "6b9d7cbe-bcb9-11e9-073f-15a7a543e2eb"
    MPI = "da04e1cc-30fd-572f-bb4f-1f8673147195"
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    MonteCarloMeasurements = "0987c9cc-fe09-11e8-30f0-b96dd679fdca"
    Mooncake = "da2b9cff-9c12-43a0-ae48-6db2b0edb7d6"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "79a2aca180a85c690c58a020d47b426954b590f8"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.16.0"

[[deps.DifferentialEquations]]
deps = ["OrdinaryDiffEq", "PrecompileTools", "Reexport", "SciMLBase"]
git-tree-sha1 = "d167917674ca92bbf51b56a3e00d019792695110"
uuid = "0c46a032-eb83-5123-abaf-570d42b7fbaa"
version = "8.1.1"

[[deps.DifferentiationInterface]]
deps = ["ADTypes", "LinearAlgebra"]
git-tree-sha1 = "0693d8b0a4608ff289d228ab4c598df5894845cd"
uuid = "a0c0ee7d-e4b9-4e03-894e-1c5f64a51d63"
version = "0.7.21"

    [deps.DifferentiationInterface.extensions]
    DifferentiationInterfaceChainRulesCoreExt = "ChainRulesCore"
    DifferentiationInterfaceDiffractorExt = "Diffractor"
    DifferentiationInterfaceEnzymeExt = ["EnzymeCore", "Enzyme"]
    DifferentiationInterfaceFastDifferentiationExt = "FastDifferentiation"
    DifferentiationInterfaceFiniteDiffExt = "FiniteDiff"
    DifferentiationInterfaceFiniteDifferencesExt = "FiniteDifferences"
    DifferentiationInterfaceForwardDiffExt = ["ForwardDiff", "DiffResults"]
    DifferentiationInterfaceGPUArraysCoreExt = ["GPUArraysCore", "Adapt"]
    DifferentiationInterfaceGTPSAExt = "GTPSA"
    DifferentiationInterfaceHyperHessiansExt = "HyperHessians"
    DifferentiationInterfaceMooncakeExt = "Mooncake"
    DifferentiationInterfacePolyesterForwardDiffExt = ["PolyesterForwardDiff", "ForwardDiff", "DiffResults"]
    DifferentiationInterfaceReverseDiffExt = ["ReverseDiff", "DiffResults"]
    DifferentiationInterfaceSparseArraysExt = "SparseArrays"
    DifferentiationInterfaceSparseConnectivityTracerExt = "SparseConnectivityTracer"
    DifferentiationInterfaceSparseMatrixColoringsExt = "SparseMatrixColorings"
    DifferentiationInterfaceStaticArraysExt = "StaticArrays"
    DifferentiationInterfaceSymbolicsExt = "Symbolics"
    DifferentiationInterfaceTrackerExt = "Tracker"
    DifferentiationInterfaceZygoteExt = ["Zygote", "ForwardDiff"]

    [deps.DifferentiationInterface.weakdeps]
    Adapt = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DiffResults = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
    Diffractor = "9f5e2b26-1114-432f-b630-d3fe2085c51c"
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"
    FastDifferentiation = "eb9bf01b-bf85-4b60-bf87-ee5de06c00be"
    FiniteDiff = "6a86dc24-6348-571c-b903-95158fe2bd41"
    FiniteDifferences = "26cc04aa-876d-5657-8c51-4c34ba976000"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    GTPSA = "b27dd330-f138-47c5-815b-40db9dd9b6e8"
    HyperHessians = "06b494a0-c8e0-40cc-ad32-d99506a00a6c"
    Mooncake = "da2b9cff-9c12-43a0-ae48-6db2b0edb7d6"
    PolyesterForwardDiff = "98d1487c-24ca-40b6-b7ab-df2af84e126b"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SparseConnectivityTracer = "9f842d2f-2579-4b1d-911e-f412cf18a3f5"
    SparseMatrixColorings = "0a514795-09f3-496d-8182-132a7b665d35"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    Symbolics = "0c5d862f-8b57-4792-8d23-62f2024744c7"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.EnumX]]
git-tree-sha1 = "c49898e8438c828577f04b92fc9368c388ac783c"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.7"

[[deps.EnzymeCore]]
git-tree-sha1 = "04c4269956f90d8f5c9acc73b774c5293481f4d7"
uuid = "f151be2c-9106-41f4-ab19-57ee4f262869"
version = "0.8.26"

    [deps.EnzymeCore.extensions]
    AdaptExt = "Adapt"
    EnzymeCoreChainRulesCoreExt = "ChainRulesCore"

    [deps.EnzymeCore.weakdeps]
    Adapt = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d0f666deaf8099a7d7ac229a74402ada88898be1"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.9.0+0"

[[deps.ExprTools]]
git-tree-sha1 = "d2e49e7efd29719d6f28b891b0e0e159daa9d2b4"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.11"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "7bd13840b4148949e290748071bbe6826b3eabcd"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.6"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libva_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "d9d3cd382f2c999f684e6bfa4039fcc16c153b6f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "9.0.2+0"

[[deps.FastBroadcast]]
deps = ["ArrayInterface", "LinearAlgebra", "PrecompileTools"]
git-tree-sha1 = "c8f8eefadaa330d982bbf5e395c34e53a13ab668"
uuid = "7034ab61-46d4-4ed7-9d0f-46aef9175898"
version = "1.4.0"

    [deps.FastBroadcast.extensions]
    FastBroadcastPolyesterExt = "Polyester"
    FastBroadcastStaticExt = "Static"

    [deps.FastBroadcast.weakdeps]
    Polyester = "f517fe37-dbe3-4b94-8317-1923a5111588"
    Static = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"

[[deps.FastClosures]]
git-tree-sha1 = "acebe244d53ee1b461970f8910c235b259e772ef"
uuid = "9aa1b823-49e4-5ca5-8b0f-3971ec8bab6a"
version = "0.3.2"

[[deps.FastPower]]
deps = ["PrecompileTools"]
git-tree-sha1 = "3c7269c236978d434a16ebe99f9743b9d706270a"
uuid = "a4df4552-cc26-4903-aec0-212e50a0e84b"
version = "1.5.0"

    [deps.FastPower.extensions]
    FastPowerEnzymeExt = "Enzyme"
    FastPowerForwardDiffExt = "ForwardDiff"
    FastPowerMeasurementsExt = "Measurements"
    FastPowerMonteCarloMeasurementsExt = "MonteCarloMeasurements"
    FastPowerMooncakeExt = "Mooncake"
    FastPowerReverseDiffExt = "ReverseDiff"
    FastPowerTrackerExt = "Tracker"

    [deps.FastPower.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    MonteCarloMeasurements = "0987c9cc-fe09-11e8-30f0-b96dd679fdca"
    Mooncake = "da2b9cff-9c12-43a0-ae48-6db2b0edb7d6"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "417289ac840d201005d9ed16789a46defccbe36d"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.18.1"

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStaticArraysExt = "StaticArrays"
    FillArraysStatisticsExt = "Statistics"

    [deps.FillArrays.weakdeps]
    PDMats = "90014a1f-27ba-587c-ab20-58faa44d9150"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.FindFirstFunctions]]
deps = ["PrecompileTools"]
git-tree-sha1 = "dcce413ffacb0be72f38b491ae4887730343d451"
uuid = "64ca27bc-2ba2-4a57-88aa-44e436879224"
version = "3.4.0"

    [deps.FindFirstFunctions.extensions]
    FindFirstFunctionsEnzymeCoreExt = "EnzymeCore"
    FindFirstFunctionsMooncakeExt = "Mooncake"

    [deps.FindFirstFunctions.weakdeps]
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"
    Mooncake = "da2b9cff-9c12-43a0-ae48-6db2b0edb7d6"

[[deps.FiniteDiff]]
deps = ["ArrayInterface", "LinearAlgebra", "Setfield"]
git-tree-sha1 = "5031f23e040bf17082e5b52422d77b5e844eefb1"
uuid = "6a86dc24-6348-571c-b903-95158fe2bd41"
version = "2.33.0"

    [deps.FiniteDiff.extensions]
    FiniteDiffBandedMatricesExt = "BandedMatrices"
    FiniteDiffBlockBandedMatricesExt = "BlockBandedMatrices"
    FiniteDiffSparseArraysExt = "SparseArrays"
    FiniteDiffStaticArraysExt = "StaticArrays"

    [deps.FiniteDiff.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.FixedPointNumbers]]
deps = ["Random", "Statistics"]
git-tree-sha1 = "59af96b98217c6ef4ae0dfe065ac7c20831d1a84"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.6"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "e1e9ba3a8f5d71e6ae698f138a1362aeabb42e9f"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.18.3+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "3b0f72e2ffef1a139ac450725c9ecd01c0a3c050"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "1.4.6"

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

    [deps.ForwardDiff.weakdeps]
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d95a7a3a7e0f2fffc6291bd33035830aab01310b"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.15.0+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f3f50c8001bdfa84f312234fa86715b7c9243771"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.18+0"

[[deps.FunctionWrappers]]
git-tree-sha1 = "d62485945ce5ae9c0c48f124a84998d755bae00e"
uuid = "069b7b12-0de2-55c6-9aab-29f3d0a68a2e"
version = "1.1.3"

[[deps.FunctionWrappersWrappers]]
deps = ["FunctionWrappers", "PrecompileTools", "SciMLPublic"]
git-tree-sha1 = "2bcce3ad6f6977d617928d7707fdc86ac83cce03"
uuid = "77dc65aa-8811-40c2-897b-53d922fa7daf"
version = "1.13.0"

    [deps.FunctionWrappersWrappers.extensions]
    FunctionWrappersWrappersEnzymeExt = ["Enzyme", "EnzymeCore"]
    FunctionWrappersWrappersMooncakeExt = "Mooncake"

    [deps.FunctionWrappersWrappers.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"
    Mooncake = "da2b9cff-9c12-43a0-ae48-6db2b0edb7d6"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "64bbbb7d1499297751b536dd39c58b20750ab1db"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.5.1+0"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "0b2b3e8b8fb7c1f5ddbf498be2eb2b3b37c9c0ed"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.2.1"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "4d777f73c46b46b8b5276206059cf8a195499314"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.27"

    [deps.GR.extensions]
    IJuliaExt = "IJulia"

    [deps.GR.weakdeps]
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "f8eb8f7ba13ea75083531647fc8faeda8d541f07"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.27+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "ea9f1fb37ff10597353b56f3ba0ebd525acef6e0"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.90.1+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "69ffb934a5c5b7e086a0b4fee3427db2556fba6e"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.16+0"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "9e544f0758a2341e7e782fde6f3f67610366661c"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "100.14006.0+0"

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

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "ec1debd61c300961f98064cfb21287613ad7f303"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2025.2.0+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.InverseFunctions]]
git-tree-sha1 = "5cc6ad3e2bfc75a11eed92632ee341d37f4a4536"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.18"
weakdeps = ["Dates", "Test"]

    [deps.InverseFunctions.extensions]
    InverseFunctionsDatesExt = "Dates"
    InverseFunctionsTestExt = "Test"

[[deps.IrrationalConstants]]
git-tree-sha1 = "d22e8bdb3f03c300a103ff23c0dd5a654c6701de"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.7"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7204148362dafe5fe6a273f855b8ccbe4df8173e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.8.0"

[[deps.JSON]]
deps = ["Dates", "Logging", "Parsers", "PrecompileTools", "StructUtils", "UUIDs", "Unicode"]
git-tree-sha1 = "4657a834b01ce00f2b94546095c4350617b9af2c"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "1.10.0"

    [deps.JSON.extensions]
    JSONArrowExt = ["ArrowTypes"]

    [deps.JSON.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "037babc10853eeb8e585418922246cb97b8e5b74"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.2.0+1"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.Krylov]]
deps = ["LinearAlgebra", "Printf", "SparseArrays"]
git-tree-sha1 = "909890a0d1486c392128cf4bd6e038ee0c6a7af4"
uuid = "ba0b0d4f-ebba-5204-a429-3ac8c609bfb7"
version = "0.10.10"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "39bca05343661c347aae0bca57a5994a0bf4f08d"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.2.0+0"

[[deps.LHLFactorization]]
deps = ["LinearAlgebra", "PrecompileTools"]
git-tree-sha1 = "51d99d9892d0f95b4c9d4d7310785971f2d48298"
uuid = "2faa5264-e118-4071-8864-e10559f68c7c"
version = "2.2.2"

    [deps.LHLFactorization.extensions]
    LHLFactorizationPolyesterExt = "Polyester"
    LHLFactorizationSparseExt = ["PureKLU", "SparseArrays"]

    [deps.LHLFactorization.weakdeps]
    Polyester = "f517fe37-dbe3-4b94-8317-1923a5111588"
    PureKLU = "0c0d3e7f-3a8b-4f7e-b6f1-9a4d2e7c1f01"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e5b100780d4d30d63b4618d7930d48af409c1772"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "23.1.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f88f3ccef05a6a72a0cf0ed417c8fd68530f4ab2"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.1"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "df7566479bd64f20bd16b09960145e70160ffb3b"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.12"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"
version = "1.11.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.15.0+0"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b8a91037379e1fd661e9b5ff3d7a770424b1f9f2"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.42.4+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "aebd334d06cee9f24cea70bd19a39749daf73881"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.3+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "9e887184f306b28dbfcff88cefbb0ec80f1aa9e0"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.42.4+0"

[[deps.LineSearch]]
deps = ["ADTypes", "CommonSolve", "ConcreteStructs", "FastClosures", "LinearAlgebra", "MaybeInplace", "PrecompileTools", "SciMLBase", "SciMLJacobianOperators", "StaticArraysCore"]
git-tree-sha1 = "678bdf03a97059e018401d4482385548d61a3c73"
uuid = "87fe0de2-c867-4266-b59a-2f0a94fc965b"
version = "0.1.19"
weakdeps = ["LineSearches"]

    [deps.LineSearch.extensions]
    LineSearchLineSearchesExt = "LineSearches"

[[deps.LineSearches]]
deps = ["LinearAlgebra", "NLSolversBase", "NaNMath", "Printf"]
git-tree-sha1 = "a09a85e94e681def2446752cddaf9401a4d82b6d"
uuid = "d3d80556-e9d4-5f37-9878-2ab0fcc64255"
version = "7.8.2"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.LinearSolve]]
deps = ["AMD", "ArrayInterface", "ConcreteStructs", "DocStringExtensions", "EnumX", "GPUArraysCore", "InteractiveUtils", "Krylov", "LHLFactorization", "Libdl", "LinearAlgebra", "MKL_jll", "Markdown", "OpenBLAS_jll", "PrecompileTools", "Preferences", "PureKLU", "RecursiveArrayTools", "Reexport", "SciMLBase", "SciMLLogging", "SciMLOperators", "SciMLStructures", "Setfield", "SparseArrays", "SparseColumnPivotedQR", "StaticArraysCore"]
git-tree-sha1 = "308c25a9f0606d5f17770e21dc485fcac7df62cf"
uuid = "7ed4a6bd-45f5-4d41-b270-4a48e9bafcae"
version = "5.18.2"

    [deps.LinearSolve.extensions]
    LinearSolveAMDGPUExt = "AMDGPU"
    LinearSolveAMGXExt = ["AMGX", "CUDA"]
    LinearSolveAlgebraicMultigridExt = "AlgebraicMultigrid"
    LinearSolveArnoldiMethodExt = "ArnoldiMethod"
    LinearSolveArpackExt = "Arpack"
    LinearSolveBLISExt = ["blis_jll", "LAPACK_jll"]
    LinearSolveBandedMatricesExt = "BandedMatrices"
    LinearSolveBlockDiagonalsExt = "BlockDiagonals"
    LinearSolveCKTSOExt = "CKTSO"
    LinearSolveCUDAExt = ["cuSOLVER"]
    LinearSolveCUDSSExt = "CUDSS"
    LinearSolveCUSOLVERRFExt = "CUSOLVERRF"
    LinearSolveChainRulesCoreExt = "ChainRulesCore"
    LinearSolveCliqueTreesExt = "CliqueTrees"
    LinearSolveConjugateGradientsExt = "ConjugateGradients"
    LinearSolveElementalExt = "Elemental"
    LinearSolveEnzymeExt = "EnzymeCore"
    LinearSolveFastAlmostBandedMatricesExt = "FastAlmostBandedMatrices"
    LinearSolveFastLapackInterfaceExt = "FastLapackInterface"
    LinearSolveForwardDiffExt = "ForwardDiff"
    LinearSolveGinkgoExt = "Ginkgo"
    LinearSolveHSLExt = "HSL"
    LinearSolveHYPREExt = "HYPRE"
    LinearSolveIterativeSolversExt = "IterativeSolvers"
    LinearSolveJacobiDavidsonExt = "JacobiDavidson"
    LinearSolveKernelAbstractionsExt = "KernelAbstractions"
    LinearSolveKrylovKitExt = "KrylovKit"
    LinearSolveMUMPSExt = "MUMPS"
    LinearSolveMetalExt = "Metal"
    LinearSolveMooncakeExt = "Mooncake"
    LinearSolvePETScExt = ["PETSc", "SparseMatricesCSR"]
    LinearSolvePETScMPIExt = ["PETSc", "PartitionedArrays", "SparseMatricesCSR"]
    LinearSolveParUExt = "ParU_jll"
    LinearSolvePardisoExt = "Pardiso"
    LinearSolvePartitionedSolversExt = ["PartitionedArrays", "PartitionedSolvers"]
    LinearSolvePureUMFPACKExt = "PureUMFPACK"
    LinearSolveReactantExt = "Reactant"
    LinearSolveRecursiveFactorizationExt = ["RecursiveFactorization", "TriangularSolve"]
    LinearSolveSLATEExt = "SLATE_jll"
    LinearSolveSTRUMPACKExt = "STRUMPACK_jll"
    LinearSolveSparspakExt = "Sparspak"
    LinearSolveSpecializingFactorizationsExt = "SpecializingFactorizations"
    LinearSolveSuperLUDISTExt = "SuperLUDIST"

    [deps.LinearSolve.weakdeps]
    AMDGPU = "21141c5a-9bdb-4563-92ae-f87d6854732e"
    AMGX = "c963dde9-0319-47f5-bf0c-b07d3c80ffa6"
    AlgebraicMultigrid = "2169fc97-5a83-5252-b627-83903c6c433c"
    ArnoldiMethod = "ec485272-7323-5ecc-a04f-4719b315124d"
    Arpack = "7d9fca2a-8960-54d3-9f78-7d1dccf2cb97"
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockDiagonals = "0a1fb500-61f7-11e9-3c65-f5ef3456f9f0"
    CKTSO = "8e543fc2-2ef1-4e2d-a99e-39beaa046845"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CUDSS = "45b445bb-4962-46a0-9369-b4df9d0f772e"
    CUSOLVERRF = "a8cc9031-bad2-4722-94f5-40deabb4245c"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    CliqueTrees = "60701a23-6482-424a-84db-faee86b9b1f8"
    ConjugateGradients = "f59de78d-195d-4e7b-a078-2e47da4c3ad6"
    Elemental = "902c3f28-d1ec-5e7e-8399-a24c3845ee38"
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"
    FastAlmostBandedMatrices = "9d29842c-ecb8-4973-b1e9-a27b1157504e"
    FastLapackInterface = "29a986be-02c6-4525-aec4-84b980013641"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    Ginkgo = "4c8bd3c9-ead9-4b5e-a625-08f1338ba0ec"
    HSL = "34c5aeac-e683-54a6-a0e9-6e0fdc586c50"
    HYPRE = "b5ffcf37-a2bd-41ab-a3da-4bd9bc8ad771"
    IterativeSolvers = "42fd0dbc-a981-5370-80f2-aaf504508153"
    JLArrays = "27aeb0d3-9eb9-45fb-866b-73c2ecf80fcb"
    JacobiDavidson = "11c68b98-9c9b-11e8-267b-bbb95576cead"
    KernelAbstractions = "63c18a36-062a-441e-b654-da1e3ab1ce7c"
    KrylovKit = "0b1a1467-8014-51b9-945f-bf0ae24f4b77"
    LAPACK_jll = "51474c39-65e3-53ba-86ba-03b1b862ec14"
    MUMPS = "55d2b088-9f4e-11e9-26c0-150b02ea6a46"
    Metal = "dde4c033-4e86-420c-a63e-0dd931031962"
    Mooncake = "da2b9cff-9c12-43a0-ae48-6db2b0edb7d6"
    PETSc = "ace2c81b-2b5f-4b1e-a30d-d662738edfe0"
    ParU_jll = "9e0b026c-e8ce-559c-a2c4-6a3d5c955bc9"
    Pardiso = "46dd5b70-b6fb-5a00-ae2d-e8fea33afaf2"
    PartitionedArrays = "5a9dfac6-5c52-46f7-8278-5e2210713be9"
    PartitionedSolvers = "11b65f7f-80ac-401b-9ef2-3db765482d62"
    PureUMFPACK = "b7e1f0a2-3c4d-4e5f-9a0b-1c2d3e4f5a6b"
    Reactant = "3c362404-f566-11ee-1572-e11a4b42c853"
    RecursiveFactorization = "f2c3362d-daeb-58d1-803e-2bc74f2840b4"
    SLATE_jll = "cb01ff19-587c-516c-bcf9-532d49da298d"
    STRUMPACK_jll = "86fbd0b9-476f-557c-b766-62c724b42d8c"
    SparseMatricesCSR = "a0a7dd2c-ebf4-11e9-1f05-cf50bc540ca1"
    Sparspak = "e56a9233-b9d6-4f03-8d0f-1825330902ac"
    SpecializingFactorizations = "fa08b7a1-13d3-4faf-875d-5cbc1520e3f3"
    SuperLUDIST = "4cd002a6-0da4-410d-a012-232df062f478"
    TriangularSolve = "d5829a12-d9aa-46ab-831f-fb7c9ab06edf"
    blis_jll = "6136c539-28a5-5bf0-87cc-b183200dce32"
    cuSOLVER = "887afef0-6a32-4de5-add4-7827692ba8fc"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "b85e2797b2409570e84c4de46238c0ed5f6476ae"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "1.0.2"

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
version = "1.11.0"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f00544d95982ea270145636c181ceda21c4e2575"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.2.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "oneTBB_jll"]
git-tree-sha1 = "282cadc186e7b2ae0eeadbd7a4dffed4196ae2aa"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2025.2.0+0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MaybeInplace]]
deps = ["ArrayInterface", "LinearAlgebra", "MacroTools", "PrecompileTools"]
git-tree-sha1 = "f2cde0ae772162f20287b803e623966d0d94dea9"
uuid = "bb5d69b7-63fc-4a16-80bd-7e42200c7bdb"
version = "0.1.8"
weakdeps = ["SparseArrays"]

    [deps.MaybeInplace.extensions]
    MaybeInplaceSparseArraysExt = "SparseArrays"

[[deps.Measures]]
git-tree-sha1 = "b513cedd20d9c914783d8ad83d08120702bf2c77"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.3"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.11.4"

[[deps.MuladdMacro]]
deps = ["PrecompileTools"]
git-tree-sha1 = "283bf85d4a767481dd924dff0eee1735e95f449e"
uuid = "46d2c3a1-f734-5fdb-9937-b9b9aeba4221"
version = "0.2.7"

[[deps.NLSolversBase]]
deps = ["ADTypes", "DifferentiationInterface", "FiniteDiff", "LinearAlgebra"]
git-tree-sha1 = "f96d38936d92d610318dec4d3b5ef37b0373c20f"
uuid = "d41bc354-129a-5804-8e4c-c37616107c6c"
version = "8.0.1"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "676c0f1c1c34224d6869675047a54b42fdc7b8c5"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.5"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.NonlinearSolve]]
deps = ["ADTypes", "ArrayInterface", "BracketingNonlinearSolve", "CommonSolve", "ConcreteStructs", "DifferentiationInterface", "FastClosures", "FiniteDiff", "ForwardDiff", "LineSearch", "LinearAlgebra", "LinearSolve", "NonlinearSolveBase", "NonlinearSolveFirstOrder", "NonlinearSolveQuasiNewton", "NonlinearSolveSpectralMethods", "PrecompileTools", "Preferences", "Reexport", "SciMLBase", "Setfield", "SimpleNonlinearSolve", "StaticArraysCore", "SymbolicIndexingInterface"]
git-tree-sha1 = "90afae5b2b33dcd1098e4c1a7b6066f18741bf6f"
uuid = "8913a72c-1f9b-4ce2-8d82-65094dcecaec"
version = "4.32.0"

    [deps.NonlinearSolve.extensions]
    NonlinearSolveFastLevenbergMarquardtExt = "FastLevenbergMarquardt"
    NonlinearSolveFixedPointAccelerationExt = "FixedPointAcceleration"
    NonlinearSolveLeastSquaresOptimExt = "LeastSquaresOptim"
    NonlinearSolveMINPACKExt = "MINPACK"
    NonlinearSolveNLSolversExt = "NLSolvers"
    NonlinearSolveNLsolveExt = ["NLsolve", "LineSearches"]
    NonlinearSolvePETScExt = ["PETSc", "MPI", "SparseArrays"]
    NonlinearSolveSIAMFANLEquationsExt = "SIAMFANLEquations"
    NonlinearSolveSpeedMappingExt = "SpeedMapping"
    NonlinearSolveSundialsExt = "Sundials"

    [deps.NonlinearSolve.weakdeps]
    FastLevenbergMarquardt = "7a0df574-e128-4d35-8cbd-3d84502bf7ce"
    FixedPointAcceleration = "817d07cb-a79a-5c30-9a31-890123675176"
    LeastSquaresOptim = "0fc2ff8b-aaa3-5acd-a817-1944a5e08891"
    LineSearches = "d3d80556-e9d4-5f37-9878-2ab0fcc64255"
    MINPACK = "4854310b-de5a-5eb6-a2a5-c1dee2bd17f9"
    MPI = "da04e1cc-30fd-572f-bb4f-1f8673147195"
    NLSolvers = "337daf1e-9722-11e9-073e-8b9effe078ba"
    NLsolve = "2774e3e8-f4cf-5e23-947b-6d7e65073b56"
    PETSc = "ace2c81b-2b5f-4b1e-a30d-d662738edfe0"
    SIAMFANLEquations = "084e46ad-d928-497d-ad5e-07fa361a48c4"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SpeedMapping = "f1835b91-879b-4a3f-a438-e4baacf14412"
    Sundials = "c3572dad-4567-51f8-b174-8c6c989267f4"

[[deps.NonlinearSolveBase]]
deps = ["ADTypes", "Adapt", "ArrayInterface", "CommonSolve", "Compat", "ConcreteStructs", "DifferentiationInterface", "EnumX", "EnzymeCore", "FastClosures", "FunctionWrappers", "FunctionWrappersWrappers", "LinearAlgebra", "LogExpFunctions", "Markdown", "MaybeInplace", "PreallocationTools", "PrecompileTools", "Preferences", "Printf", "RecursiveArrayTools", "RespecializeParams", "SciMLBase", "SciMLJacobianOperators", "SciMLLogging", "SciMLOperators", "SciMLStructures", "Setfield", "StaticArraysCore", "SymbolicIndexingInterface", "TimerOutputs"]
git-tree-sha1 = "f4f5ebf8bfd9bfafdc4116fb3715dfd50fe4a7bd"
uuid = "be0214bd-f91f-a760-ac4e-3421ce2b2da0"
version = "2.54.1"

    [deps.NonlinearSolveBase.extensions]
    NonlinearSolveBaseBandedMatricesExt = "BandedMatrices"
    NonlinearSolveBaseChainRulesCoreExt = "ChainRulesCore"
    NonlinearSolveBaseEnzymeExt = ["ChainRulesCore", "Enzyme"]
    NonlinearSolveBaseForwardDiffExt = "ForwardDiff"
    NonlinearSolveBaseLineSearchExt = "LineSearch"
    NonlinearSolveBaseLinearSolveExt = "LinearSolve"
    NonlinearSolveBaseMooncakeExt = ["ChainRulesCore", "Mooncake"]
    NonlinearSolveBaseReverseDiffExt = "ReverseDiff"
    NonlinearSolveBaseSparseArraysExt = "SparseArrays"
    NonlinearSolveBaseSparseMatrixColoringsExt = "SparseMatrixColorings"
    NonlinearSolveBaseTrackerExt = "Tracker"

    [deps.NonlinearSolveBase.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    LineSearch = "87fe0de2-c867-4266-b59a-2f0a94fc965b"
    LinearSolve = "7ed4a6bd-45f5-4d41-b270-4a48e9bafcae"
    Mooncake = "da2b9cff-9c12-43a0-ae48-6db2b0edb7d6"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SparseMatrixColorings = "0a514795-09f3-496d-8182-132a7b665d35"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.NonlinearSolveFirstOrder]]
deps = ["ADTypes", "ArrayInterface", "CommonSolve", "ConcreteStructs", "FiniteDiff", "ForwardDiff", "LineSearch", "LinearAlgebra", "LinearSolve", "MaybeInplace", "NonlinearSolveBase", "PrecompileTools", "Reexport", "SciMLBase", "SciMLJacobianOperators", "SciMLLogging", "SciMLOperators", "Setfield", "Sobol", "StaticArraysCore"]
git-tree-sha1 = "95a105b647b656dfbd7985ede8eb0eaf4b836505"
uuid = "5959db7a-ea39-4486-b5fe-2dd0bf03d60d"
version = "2.10.0"

[[deps.NonlinearSolveQuasiNewton]]
deps = ["ArrayInterface", "CommonSolve", "ConcreteStructs", "LinearAlgebra", "LinearSolve", "MaybeInplace", "NonlinearSolveBase", "PrecompileTools", "Reexport", "SciMLBase", "SciMLLogging", "SciMLOperators", "StaticArraysCore"]
git-tree-sha1 = "db0bca65e9c849333023a0d5827813947d003f09"
uuid = "9a2c21bd-3a47-402d-9113-8faf9a0ee114"
version = "1.15.3"
weakdeps = ["ForwardDiff"]

    [deps.NonlinearSolveQuasiNewton.extensions]
    NonlinearSolveQuasiNewtonForwardDiffExt = "ForwardDiff"

[[deps.NonlinearSolveSpectralMethods]]
deps = ["CommonSolve", "ConcreteStructs", "LineSearch", "MaybeInplace", "NonlinearSolveBase", "PrecompileTools", "Reexport", "SciMLBase", "SciMLLogging"]
git-tree-sha1 = "c3e5a641a867b7f37155a78086cf3f22134c088f"
uuid = "26075421-4e9a-44e1-8bd1-420ed7ad02b2"
version = "1.8.3"
weakdeps = ["ForwardDiff"]

    [deps.NonlinearSolveSpectralMethods.extensions]
    NonlinearSolveSpectralMethodsForwardDiffExt = "ForwardDiff"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.7+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.Optim]]
deps = ["ADTypes", "EnumX", "FillArrays", "LineSearches", "LinearAlgebra", "NLSolversBase", "NaNMath", "PositiveFactorizations", "Printf", "SparseArrays", "Statistics"]
git-tree-sha1 = "81f338ad984b25bc82471db4d235e7b8bf21b8d6"
uuid = "429524aa-4258-5aef-a3af-852621145aeb"
version = "2.3.2"

    [deps.Optim.extensions]
    OptimMOIExt = "MathOptInterface"

    [deps.Optim.weakdeps]
    MathOptInterface = "b8f27783-ece8-5eb3-8dc8-9495eed66fee"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e2bb57a313a74b8104064b7efd01406c0a50d2ff"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.6.1+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "f9b03759e9ef463718934fbed30820b39997511e"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "2.0.2"

[[deps.OrdinaryDiffEq]]
deps = ["ADTypes", "CommonSolve", "DiffEqBase", "DocStringExtensions", "OrdinaryDiffEqBDF", "OrdinaryDiffEqCore", "OrdinaryDiffEqDefault", "OrdinaryDiffEqRosenbrock", "OrdinaryDiffEqTsit5", "OrdinaryDiffEqVerner", "SciMLBase", "SciMLLogging"]
git-tree-sha1 = "bae9b8e5f1d00e51c554648e5094e215164a19f8"
uuid = "1dea7af3-3e70-54e6-95c3-0bf5283fa5ed"
version = "7.8.1"

[[deps.OrdinaryDiffEqBDF]]
deps = ["ADTypes", "ArrayInterface", "DiffEqBase", "FastBroadcast", "LinearAlgebra", "MacroTools", "MuladdMacro", "OrdinaryDiffEqCore", "OrdinaryDiffEqDifferentiation", "OrdinaryDiffEqNonlinearSolve", "OrdinaryDiffEqSDIRK", "PrecompileTools", "Preferences", "RecursiveArrayTools", "Reexport", "SciMLBase", "TruncatedStacktraces"]
git-tree-sha1 = "42650454ef40bfd71443daa2751c6a6f9aa1120a"
uuid = "6ad6398a-0878-4a85-9266-38940aa047c8"
version = "2.4.12"

[[deps.OrdinaryDiffEqCore]]
deps = ["ADTypes", "Accessors", "Adapt", "ArrayInterface", "BinaryHeaps", "CommonSolve", "ConstructionBase", "DiffEqBase", "DocStringExtensions", "EnumX", "EnzymeCore", "FastBroadcast", "FastClosures", "FastPower", "FindFirstFunctions", "FunctionWrappers", "FunctionWrappersWrappers", "InteractiveUtils", "LinearAlgebra", "Logging", "MacroTools", "MuladdMacro", "PrecompileTools", "Preferences", "Printf", "Random", "RecursiveArrayTools", "Reexport", "SciMLBase", "SciMLLogging", "SciMLOperators", "SciMLStructures", "SymbolicIndexingInterface", "TruncatedStacktraces"]
git-tree-sha1 = "2815c99c179c5c9d1a82d63394a975b67ef6b69c"
uuid = "bbf590c4-e513-4bbe-9b18-05decba2e5d8"
version = "4.18.1"

    [deps.OrdinaryDiffEqCore.extensions]
    OrdinaryDiffEqCoreMooncakeExt = "Mooncake"
    OrdinaryDiffEqCorePolyesterExt = "Polyester"
    OrdinaryDiffEqCoreSparseArraysExt = "SparseArrays"

    [deps.OrdinaryDiffEqCore.weakdeps]
    Mooncake = "da2b9cff-9c12-43a0-ae48-6db2b0edb7d6"
    Polyester = "f517fe37-dbe3-4b94-8317-1923a5111588"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.OrdinaryDiffEqDefault]]
deps = ["ADTypes", "DiffEqBase", "EnumX", "LinearAlgebra", "LinearSolve", "OrdinaryDiffEqBDF", "OrdinaryDiffEqCore", "OrdinaryDiffEqRosenbrock", "OrdinaryDiffEqTsit5", "OrdinaryDiffEqVerner", "PrecompileTools", "Preferences", "Reexport", "SciMLBase"]
git-tree-sha1 = "1ce6ba1f52c94059089f835f173fddda90233959"
uuid = "50262376-6c5a-4cf5-baba-aaf4f84d72d7"
version = "2.6.2"

[[deps.OrdinaryDiffEqDifferentiation]]
deps = ["ADTypes", "ArrayInterface", "ConcreteStructs", "ConstructionBase", "DiffEqBase", "DifferentiationInterface", "FastBroadcast", "FiniteDiff", "ForwardDiff", "FunctionWrappersWrappers", "LinearAlgebra", "LinearSolve", "OrdinaryDiffEqCore", "SciMLBase", "SciMLOperators", "SparseMatrixColorings", "StaticArraysCore"]
git-tree-sha1 = "57ebe5c7130f1def087d4ebc01a4959bba8c7689"
uuid = "4302a76b-040a-498a-8c04-15b101fed76b"
version = "3.12.4"
weakdeps = ["SparseArrays"]

    [deps.OrdinaryDiffEqDifferentiation.extensions]
    OrdinaryDiffEqDifferentiationSparseArraysExt = "SparseArrays"

[[deps.OrdinaryDiffEqNonlinearSolve]]
deps = ["ADTypes", "ArrayInterface", "CommonSolve", "ConstructionBase", "DiffEqBase", "FastBroadcast", "FastClosures", "ForwardDiff", "LinearAlgebra", "LinearSolve", "MuladdMacro", "NonlinearSolve", "NonlinearSolveBase", "OrdinaryDiffEqCore", "OrdinaryDiffEqDifferentiation", "PreallocationTools", "RecursiveArrayTools", "SciMLBase", "SciMLOperators", "SciMLPublic", "SimpleNonlinearSolve", "SparseArrays", "StaticArraysCore"]
git-tree-sha1 = "3bc20fcc25eae4d01b2884a1e596af2a14ce7829"
uuid = "127b3ac7-2247-4354-8eb6-78cf4e7c58e8"
version = "2.9.9"

[[deps.OrdinaryDiffEqRosenbrock]]
deps = ["ADTypes", "ArrayInterface", "DiffEqBase", "DifferentiationInterface", "FastBroadcast", "FiniteDiff", "ForwardDiff", "LinearAlgebra", "LinearSolve", "MacroTools", "MuladdMacro", "OrdinaryDiffEqCore", "OrdinaryDiffEqDifferentiation", "OrdinaryDiffEqRosenbrockTableaus", "PrecompileTools", "Preferences", "RecursiveArrayTools", "Reexport", "SciMLBase"]
git-tree-sha1 = "4d6354525db068b9d1578389274b7e6cabc663b4"
uuid = "43230ef6-c299-4910-a778-202eb28ce4ce"
version = "2.7.5"

[[deps.OrdinaryDiffEqRosenbrockTableaus]]
git-tree-sha1 = "bab0d4ccee6fcb89a786b89207774314523e2e5d"
uuid = "b4bd8bb3-f80f-41d2-9b21-73a655b304b9"
version = "2.4.2"

[[deps.OrdinaryDiffEqSDIRK]]
deps = ["ADTypes", "CommonSolve", "ConstructionBase", "DiffEqBase", "FastBroadcast", "LinearAlgebra", "MacroTools", "MuladdMacro", "OrdinaryDiffEqCore", "OrdinaryDiffEqDifferentiation", "OrdinaryDiffEqNonlinearSolve", "PrecompileTools", "Preferences", "RecursiveArrayTools", "Reexport", "SciMLBase", "TruncatedStacktraces"]
git-tree-sha1 = "693be93138c2e1f13d56a8e4d0114936492dd3db"
uuid = "2d112036-d095-4a1e-ab9a-08536f3ecdbf"
version = "2.9.7"

[[deps.OrdinaryDiffEqTsit5]]
deps = ["CommonSolve", "DiffEqBase", "FastBroadcast", "LinearAlgebra", "MuladdMacro", "OrdinaryDiffEqCore", "PrecompileTools", "Preferences", "RecursiveArrayTools", "Reexport", "SciMLBase", "TruncatedStacktraces"]
git-tree-sha1 = "371de3eb5985febd9d7babb0937520653f2b15ca"
uuid = "b1df2697-797e-41e3-8120-5422d3b24e4a"
version = "2.1.5"

[[deps.OrdinaryDiffEqVerner]]
deps = ["DiffEqBase", "FastBroadcast", "LinearAlgebra", "MuladdMacro", "OrdinaryDiffEqCore", "PrecompileTools", "Preferences", "RecursiveArrayTools", "Reexport", "SciMLBase", "TruncatedStacktraces"]
git-tree-sha1 = "5a66a18325e678f260e849a62840cb4903ece511"
uuid = "79d7bb75-1356-48c1-b8c0-6832512096c2"
version = "2.4.2"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.44.0+1"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1912a9f1b9ca55005b03ba075f8e19993583e237"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.58.2+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools"]
git-tree-sha1 = "663e8b48b789916221e0765393b289ca6c88f24e"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "3.0.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "e4a6721aa89e62e5d4217c0b21bd714263779dda"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.46.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.12.1"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Reexport", "Statistics"]
git-tree-sha1 = "ddcc36fd83fb4cd459a53c891981697bde0d3de6"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.5.1"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "83bd514e8ff16b5858ac54c53fa0bcf6002a3b00"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.41.7"

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
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "e189d0623e7ce9c37389bac17e80aac3b0302e75"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.83"

[[deps.PositiveFactorizations]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "17275485f373e6673f7e7f97051f703ed5b15b20"
uuid = "85a6dd25-e78a-55b7-8502-1745935b8125"
version = "0.2.4"

[[deps.PreallocationTools]]
deps = ["Adapt", "ArrayInterface", "PrecompileTools", "SciMLPublic"]
git-tree-sha1 = "cd00e28071a75c98664663f87c2ae447d25c0503"
uuid = "d236fae5-4411-538c-8e31-a6e3d9e00b46"
version = "1.7.1"

    [deps.PreallocationTools.extensions]
    PreallocationToolsEnzymeCoreExt = "EnzymeCore"
    PreallocationToolsForwardDiffExt = "ForwardDiff"
    PreallocationToolsReverseDiffExt = "ReverseDiff"

    [deps.PreallocationTools.weakdeps]
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "edbeefc7a4889f528644251bdb5fc9ab5348bc2c"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.4"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "aef1987d90dcc2e2cbd919ad10b2d25bcce4f418"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.6.1"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "REPL", "Reexport", "StringManipulation", "StyledStrings", "Tables"]
git-tree-sha1 = "99fd8f32ab6728ff205cddd24e2d9ea6cbb498d3"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "3.5.0"

    [deps.PrettyTables.extensions]
    PrettyTablesExcelExt = "XLSX"
    PrettyTablesTypstryExt = "Typstry"
    PrettyTablesWriteDocxExt = "WriteDocx"

    [deps.PrettyTables.weakdeps]
    Typstry = "f0ed7684-a786-439e-b1e3-3b82803b501e"
    WriteDocx = "d049ceea-54ee-41d7-a26f-ba29db3b6599"
    XLSX = "fdbf4ff8-1666-58a4-91e7-1b58723a45e0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "4fbbafbc6251b883f4d2705356f3641f3652a7fe"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.4.0"

[[deps.PureKLU]]
deps = ["LinearAlgebra", "PrecompileTools", "SparseArrays"]
git-tree-sha1 = "ad0e84647fe7b3c2ae02aaeace1522139aaf6a27"
uuid = "0c0d3e7f-3a8b-4f7e-b6f1-9a4d2e7c1f01"
version = "1.6.0"
weakdeps = ["ForwardDiff"]

    [deps.PureKLU.extensions]
    PureKLUForwardDiffExt = "ForwardDiff"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "144895f6166994730ee7ff8113b981fc360638f1"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.10.2+2"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll", "Qt6Svg_jll"]
git-tree-sha1 = "159d253ab126d5b29230cf53521899bea4ef4648"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.10.2+2"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "4d85eedf69d875982c46643f6b4f66919d7e157b"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.10.2+1"

[[deps.Qt6Svg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "81587ff5ff25a4e1115ce191e36285ede0334c9d"
uuid = "6de9746b-f93d-5813-b365-ba18ad4a9cf3"
version = "6.10.2+0"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "672c938b4b4e3e0169a07a5f227029d4905456f2"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.10.2+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "0c0dcffc464cda2ff33fc8ffc1dd1bdd53cd98be"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.4.0"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.RecursiveArrayTools]]
deps = ["Adapt", "ArrayInterface", "GPUArraysCore", "LinearAlgebra", "PrecompileTools", "RecipesBase", "SciMLPublic", "SciMLStructures", "StaticArraysCore", "SymbolicIndexingInterface"]
git-tree-sha1 = "258850fd9188f5b1ac44bb03ab9225b4084500eb"
uuid = "731186ca-8d62-57ce-b412-fbd966d074cd"
version = "4.5.3"

    [deps.RecursiveArrayTools.extensions]
    RecursiveArrayToolsCUDAExt = "CUDA"
    RecursiveArrayToolsFastBroadcastExt = "FastBroadcast"
    RecursiveArrayToolsFastBroadcastPolyesterExt = ["FastBroadcast", "Polyester"]
    RecursiveArrayToolsForwardDiffExt = "ForwardDiff"
    RecursiveArrayToolsKernelAbstractionsExt = "KernelAbstractions"
    RecursiveArrayToolsMeasurementsExt = "Measurements"
    RecursiveArrayToolsMonteCarloMeasurementsExt = "MonteCarloMeasurements"
    RecursiveArrayToolsMooncakeExt = "Mooncake"
    RecursiveArrayToolsReverseDiffExt = ["ReverseDiff", "Zygote"]
    RecursiveArrayToolsSparseArraysExt = ["SparseArrays"]
    RecursiveArrayToolsStatisticsExt = "Statistics"
    RecursiveArrayToolsStructArraysExt = "StructArrays"
    RecursiveArrayToolsTablesExt = ["Tables"]
    RecursiveArrayToolsTrackerExt = "Tracker"
    RecursiveArrayToolsZygoteExt = "Zygote"

    [deps.RecursiveArrayTools.weakdeps]
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    FastBroadcast = "7034ab61-46d4-4ed7-9d0f-46aef9175898"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    KernelAbstractions = "63c18a36-062a-441e-b654-da1e3ab1ce7c"
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    MonteCarloMeasurements = "0987c9cc-fe09-11e8-30f0-b96dd679fdca"
    Mooncake = "da2b9cff-9c12-43a0-ae48-6db2b0edb7d6"
    Polyester = "f517fe37-dbe3-4b94-8317-1923a5111588"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Tables = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

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
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.RespecializeParams]]
deps = ["FunctionWrappersWrappers", "PrecompileTools"]
git-tree-sha1 = "140c074bb63518a0e1ec2c8aba2a8a5719bcf21c"
uuid = "9fe22ead-9e00-4db2-8b46-706a60d40f5e"
version = "1.3.0"

[[deps.RuntimeGeneratedFunctions]]
deps = ["ExprTools", "PrecompileTools", "SHA", "Serialization"]
git-tree-sha1 = "9bb075002b40849582905394bb3031fb77aa102d"
uuid = "7e49a35a-f44a-4d26-94aa-eba1b4ca6b47"
version = "0.5.27"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SciMLBase]]
deps = ["ADTypes", "Accessors", "Adapt", "ArrayInterface", "CommonSolve", "ConstructionBase", "Distributed", "DocStringExtensions", "EnumX", "FindFirstFunctions", "FunctionWrappersWrappers", "IteratorInterfaceExtensions", "LinearAlgebra", "Logging", "LoggingExtras", "Markdown", "PreallocationTools", "PrecompileTools", "Preferences", "Printf", "Random", "RecipesBase", "RecursiveArrayTools", "RuntimeGeneratedFunctions", "SciMLOperators", "SciMLPublic", "SciMLStructures", "StaticArraysCore", "Statistics", "SymbolicIndexingInterface"]
git-tree-sha1 = "46345faa1fa3f43c24c241653c3b2719672b8d99"
uuid = "0bca4576-84f4-4d90-8ffe-ffa030f20462"
version = "3.57.0"

    [deps.SciMLBase.extensions]
    SciMLBaseChainRulesCoreExt = "ChainRulesCore"
    SciMLBaseDifferentiationInterfaceExt = "DifferentiationInterface"
    SciMLBaseDistributionsExt = "Distributions"
    SciMLBaseEnzymeExt = "Enzyme"
    SciMLBaseForwardDiffExt = "ForwardDiff"
    SciMLBaseFunctionPropertiesExt = "FunctionProperties"
    SciMLBaseMakieExt = ["Makie", "GeometryBasics"]
    SciMLBaseMeasurementsExt = "Measurements"
    SciMLBaseMonteCarloMeasurementsExt = "MonteCarloMeasurements"
    SciMLBaseMooncakeExt = "Mooncake"
    SciMLBasePartialFunctionsExt = "PartialFunctions"
    SciMLBasePyCallExt = "PyCall"
    SciMLBasePythonCallExt = "PythonCall"
    SciMLBaseRCallExt = "RCall"
    SciMLBaseReactantCoreExt = "ReactantCore"
    SciMLBaseReverseDiffExt = ["ReverseDiff", "ForwardDiff"]
    SciMLBaseStaticArraysExt = "StaticArrays"
    SciMLBaseTrackerExt = "Tracker"
    SciMLBaseZygoteExt = ["Zygote", "ChainRulesCore", "ZygoteRules", "FillArrays"]

    [deps.SciMLBase.weakdeps]
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DifferentiationInterface = "a0c0ee7d-e4b9-4e03-894e-1c5f64a51d63"
    Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"
    FillArrays = "1a297f60-69ca-5386-bcde-b61e274b549b"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    FunctionProperties = "f62d2435-5019-4c03-9749-2d4c77af0cbc"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    Makie = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    MonteCarloMeasurements = "0987c9cc-fe09-11e8-30f0-b96dd679fdca"
    Mooncake = "da2b9cff-9c12-43a0-ae48-6db2b0edb7d6"
    PartialFunctions = "570af359-4316-4cb7-8c74-252c00c2016b"
    PyCall = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
    PythonCall = "6099a3de-0909-46bc-b1f4-468b9a2dfc0d"
    RCall = "6f49c342-dc21-5d91-9882-a32aef131414"
    ReactantCore = "a3311ec8-5e00-46d5-b541-4f83e724a433"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"
    ZygoteRules = "700de1a5-db45-46bc-99cf-38207098b444"

[[deps.SciMLJacobianOperators]]
deps = ["ADTypes", "ArrayInterface", "ConcreteStructs", "ConstructionBase", "DifferentiationInterface", "FastClosures", "LinearAlgebra", "SciMLBase", "SciMLOperators"]
git-tree-sha1 = "e58036956d27635a57276b05bdbbe8b22376a805"
uuid = "19f34311-ddf3-4b8b-af20-060888a46c0e"
version = "0.1.19"

[[deps.SciMLLogging]]
deps = ["Logging", "LoggingExtras", "PrecompileTools", "Preferences"]
git-tree-sha1 = "3aafee7edc2ec7e71f50dcc6816cb031fac390a0"
uuid = "a6db7da4-7206-11f0-1eab-35f2a5dbe1d1"
version = "2.1.0"

    [deps.SciMLLogging.extensions]
    SciMLLoggingTracyExt = "Tracy"

    [deps.SciMLLogging.weakdeps]
    Tracy = "e689c965-62c8-4b79-b2c5-8359227902fd"

[[deps.SciMLOperators]]
deps = ["Accessors", "Adapt", "ArrayInterface", "DocStringExtensions", "LinearAlgebra", "PrecompileTools", "SciMLPublic"]
git-tree-sha1 = "6c97cd41488ccd362363ff9c883dafcff18da45c"
uuid = "c0aeaf25-5076-4817-a8d5-81caf7dfa961"
version = "1.30.2"

    [deps.SciMLOperators.extensions]
    SciMLOperatorsLoopVectorizationExt = "LoopVectorization"
    SciMLOperatorsSparseArraysExt = "SparseArrays"

    [deps.SciMLOperators.weakdeps]
    LoopVectorization = "bdcacae8-1622-11e9-2a5c-532679323890"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SciMLPublic]]
deps = ["PrecompileTools"]
git-tree-sha1 = "74685afb51732a464fbce79a72708f7c4203ceb7"
uuid = "431bcebd-1456-4ced-9d72-93c2757fff0b"
version = "1.3.0"

[[deps.SciMLStructures]]
deps = ["ArrayInterface", "PrecompileTools"]
git-tree-sha1 = "4b8fc0ffe22b4ecba7a02f1fec0b3757db014d0c"
uuid = "53ae85a6-f571-4167-b2af-e1d143709226"
version = "1.10.6"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "c5391c6ace3bc430ca630251d02ea9687169ca68"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.2"

[[deps.Showoff]]
deps = ["Dates"]
git-tree-sha1 = "8238217340ad0aaabe11afe39c1098b5bc9f4c8e"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.1.1"

[[deps.SimpleNonlinearSolve]]
deps = ["ADTypes", "ArrayInterface", "BracketingNonlinearSolve", "CommonSolve", "ConcreteStructs", "DifferentiationInterface", "FastClosures", "FiniteDiff", "ForwardDiff", "LineSearch", "LinearAlgebra", "MaybeInplace", "NonlinearSolveBase", "PrecompileTools", "Reexport", "SciMLBase", "SciMLLogging", "Setfield", "StaticArraysCore"]
git-tree-sha1 = "8d9ec24ec7bd126abf97b44ba5bdd6d280572095"
uuid = "727e6d20-b764-4bd8-a329-72de5adea6c7"
version = "2.14.6"

    [deps.SimpleNonlinearSolve.extensions]
    SimpleNonlinearSolveChainRulesCoreExt = "ChainRulesCore"
    SimpleNonlinearSolveReverseDiffExt = "ReverseDiff"
    SimpleNonlinearSolveTrackerExt = "Tracker"

    [deps.SimpleNonlinearSolve.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Sobol]]
deps = ["DelimitedFiles", "Random"]
git-tree-sha1 = "5a74ac22a9daef23705f010f72c81d6925b19df8"
uuid = "ed01d8cd-4d21-5b2a-85b4-cc3bdc58bad4"
version = "1.5.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "13cd91cc9be159e3f4d95b857fa2aa383b53772a"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.3"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.12.0"

[[deps.SparseColumnPivotedQR]]
deps = ["LinearAlgebra", "PrecompileTools", "SparseArrays"]
git-tree-sha1 = "8cf1a59c78dd6f900feb366e5a574f99ed278ef1"
uuid = "a57abbd0-fea5-4d57-96be-5e525945e8e4"
version = "2.1.8"
weakdeps = ["AMD"]

    [deps.SparseColumnPivotedQR.extensions]
    SparseColumnPivotedQRAMDExt = "AMD"

[[deps.SparseMatrixColorings]]
deps = ["ADTypes", "DocStringExtensions", "LinearAlgebra", "PrecompileTools", "Random", "SparseArrays"]
git-tree-sha1 = "63e1776f40bbd5e7394edce08e62f852b1384baf"
uuid = "0a514795-09f3-496d-8182-132a7b665d35"
version = "0.4.28"

    [deps.SparseMatrixColorings.extensions]
    SparseMatrixColoringsCUDAExt = ["CUDA", "cuSPARSE"]
    SparseMatrixColoringsCliqueTreesExt = "CliqueTrees"
    SparseMatrixColoringsColorsExt = "Colors"
    SparseMatrixColoringsGPUArraysExt = "GPUArrays"
    SparseMatrixColoringsJuMPExt = ["JuMP", "MathOptInterface"]

    [deps.SparseMatrixColorings.weakdeps]
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CliqueTrees = "60701a23-6482-424a-84db-faee86b9b1f8"
    Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
    GPUArrays = "0c68f7d7-f131-5f86-a1c3-88cf8149b2d7"
    JuMP = "4076af6c-e467-56ae-b986-b466b2749572"
    MathOptInterface = "b8f27783-ece8-5eb3-8dc8-9495eed66fee"
    cuSPARSE = "b26da814-b3bc-49ef-b0ee-c816305aa060"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "88ef0d98204515bc53dd4aaea5f7788882d1b66c"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.9.1"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6ab403037779dae8c514bad259f32a447262455a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.4"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "e2b53ce13a53367e96601081e33d34746b571bad"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.5"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "178ed29fd5b2a2cfc3bd31c13375ae925623ff36"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.8.0"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "IrrationalConstants", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "adb9da019510162e67a4493fc235c23203d8b09e"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.13"

[[deps.StringManipulation]]
deps = ["PrecompileTools", "StyledStrings"]
git-tree-sha1 = "9e3a02d73a8f0a9be04e677dbef758aab40f8bea"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.6.1"

[[deps.StructUtils]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "b814d5005d6a529d740ffe06f8a86396f6501138"
uuid = "ec057cc2-7a8d-4b58-b3b3-92acb9f63b42"
version = "2.9.2"

    [deps.StructUtils.extensions]
    StructUtilsLazilyInitializedFieldsExt = ["LazilyInitializedFields"]
    StructUtilsMeasurementsExt = ["Measurements"]
    StructUtilsStaticArraysCoreExt = ["StaticArraysCore"]
    StructUtilsTablesExt = ["Tables"]

    [deps.StructUtils.weakdeps]
    LazilyInitializedFields = "0e77f7df-68c5-4e49-93ce-4cd80f5598bf"
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tables = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.8.3+2"

[[deps.SymbolicIndexingInterface]]
deps = ["Accessors", "ArrayInterface", "PrecompileTools", "RuntimeGeneratedFunctions", "StaticArraysCore"]
git-tree-sha1 = "7eb6da9656581ac9fbffaef3ef7950a090a5002a"
uuid = "2efcf032-c050-4f8e-a9bb-153293bab1f5"
version = "0.3.55"
weakdeps = ["PrettyTables"]

    [deps.SymbolicIndexingInterface.extensions]
    SymbolicIndexingInterfacePrettyTablesExt = "PrettyTables"

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
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "a94d9bdda1b7bed0046cea645639ab3f62196fac"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.14.0"

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
version = "1.11.0"

[[deps.TimerOutputs]]
deps = ["ExprTools", "PrettyTables", "Printf", "Tables"]
git-tree-sha1 = "2244393f04554e24b54896b430b2ab3850a2232d"
uuid = "a759f4b9-e2f1-59dc-863e-4aeb61b1ea8f"
version = "1.2.2"

    [deps.TimerOutputs.extensions]
    FlameGraphsExt = "FlameGraphs"

    [deps.TimerOutputs.weakdeps]
    FlameGraphs = "08572546-2f56-4bcf-ba4e-bab62c3a3f89"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.TruncatedStacktraces]]
deps = ["InteractiveUtils", "MacroTools", "Preferences"]
git-tree-sha1 = "ea3e54c2bdde39062abf5a9758a23735558705e1"
uuid = "781d530d-4396-4725-bb49-402e4bee1e77"
version = "1.4.0"

[[deps.URIs]]
deps = ["Serialization"]
git-tree-sha1 = "50eda8011f098869a76da69a524ff59e0298711a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.7.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

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
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e52eca002a11c30a858185efdfb15311e1c7a6bf"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.4+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "ce91b54a5f90c4f27df6950706234b34e49cf79e"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.14+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "1a4a26870bf1e5d26cd585e38038d399d7e65706"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.8+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "75e00946e43621e09d431d9b95818ee751e6b2ef"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.2+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "704274ca960c42049fd9bda089fc4be32af5cdca"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.5+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "0ba01bc7396896a4ace8aab67db31403c71628f4"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.7+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c174ef70c96c76f4c3f4d3cfbe09d018bcd1b53"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.6+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a54cf54677c9f6eac0d97e9d757c233b56bc21b9"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.13+0"

[[deps.Xorg_libpciaccess_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "58972370b81423fc546c56a60ed1a009450177c3"
uuid = "a65dc6b1-eb27-53a1-bb3e-dea574b5389e"
version = "0.19.0+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "ed756a03e95fff88d8f738ebc2849431bdd4fd1a"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.2.0+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "9750dc53819eba4e9a20be42349a6d3b86c7cdf8"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.6+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "9a5e6e8f1a7c40941465c04840145e527f0d6b4b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.5.0+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "df77b22eb77051b3d0ef30aab979684f7482c66f"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.48.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0343a4dc329ca4dd71bf5c5b3fc1a8c2f6e0692d"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.15.2+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "cb007192783c56d8249db4cf0e3495001edfe414"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.5+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libdrm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libpciaccess_jll"]
git-tree-sha1 = "28e57478e8a160d346a19c28b3fffb9273bcc9c2"
uuid = "8e53e030-5e6c-5a89-a30b-be5b7263a166"
version = "2.4.134+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "1fcd6cf05d23adab0b5ffc496d020537215751dc"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.59+1"

[[deps.libva_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll", "Xorg_libXfixes_jll", "libdrm_jll"]
git-tree-sha1 = "21cbc8fc2ac0bb182ed461e556d9c062ae6a3164"
uuid = "9a156e7d-b971-5f62-b2c9-67348b8fb97c"
version = "2.24.1+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.oneTBB_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "ed2d8d4ad96c03d3abe3382cdbbdea9489b63636"
uuid = "1317d2d5-d96f-522e-a858-c73665f53c3e"
version = "2023.1.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.7.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "a1fc6507a40bf504527d0d4067d718f8e179b2b8"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.13.0+0"
"""

# ╔═╡ Cell order:
# ╟─4c42c02f-206d-4ac9-b17a-9547bb9da4cd
# ╟─f83c7795-f18b-4b95-8944-ff934b291df9
# ╟─d37822d7-480c-4f7f-ab83-806655326573
# ╟─228e6502-1dad-447b-8684-2bf4115bb6cf
# ╠═1f07472c-99b1-448a-9fff-6d21c3a3653c
# ╟─c66ecc8a-9dd4-4244-ada6-48e9ad85c305
# ╟─d00d6273-7b7c-4fc3-b591-ebde3831f383
# ╟─5fbc47f1-3d0b-4db7-87a6-cafc71b1df91
# ╟─7b68aba2-181e-4f79-956d-81cb968539a1
# ╟─29fee2c7-1ebd-497c-8be2-e7883ac62011
# ╟─d1c225a8-1d13-4e99-a657-167f37524065
# ╟─f455f893-2ca2-49ff-a581-0e1fd04ef8cc
# ╠═7487e176-6d28-4ed2-bd57-d7a10e5c0af4
# ╟─69902876-e96f-46ab-bf25-7dc1e08bf4de
# ╟─37325f60-6e42-401c-bd5a-14fe3346008d
# ╠═30572dcb-d068-4289-95b5-0ae7f226cd45
# ╟─beb14444-3720-449c-b9b6-3a49d3f5efe5
# ╟─2c627e7f-b60c-49ec-ac83-1cc9bf8f93c3
# ╠═79e6eb38-8a95-4261-8bcf-cb8bc94b6966
# ╟─2fe9a793-b39f-42f7-8309-6eb08adf609b
# ╟─035e0c2b-da27-4ec6-8f7c-10d07197357f
# ╟─89974b10-40a8-418c-9f5f-6c000e4070d3
# ╟─d7942a99-8730-4911-afb3-5fcd9bf9504d
# ╠═97f3b97b-bee3-4314-9076-bca4e6d5e401
# ╟─d62512e5-9594-4a2e-9bb1-96a590d002d1
# ╠═253ef95f-1734-4e51-8592-85aa421b9f68
# ╟─60398575-8e55-4a36-966c-46822b43a5c0
# ╠═58b75390-8bbe-419e-a9e5-6b477deb4e56
# ╠═127d3343-1fdc-46e1-a831-0a9e2ddd30f7
# ╟─7641feae-e88e-46d8-948f-9321d8c05f64
# ╟─431b33e2-a912-4f06-8c18-8022f041960a
# ╟─743bf7f7-cb1f-4b5b-a3a2-033b61fc0d18
# ╠═adc26b63-b7d9-466e-b293-57d1c6c6d655
# ╟─3a0d542b-a24f-419a-937d-670498a0d588
# ╠═dd5ec77b-d541-4e6c-a1d3-5b75889079ba
# ╟─b1a0066a-7d45-4397-a6cf-d5657ee12a9d
# ╠═3acbb4d7-a48d-44f5-bddd-4420db2a6230
# ╠═1c215b55-d48c-44f3-9bdb-bd4f86c76d11
# ╟─18120e10-5bb6-4c6c-974f-97dca370e49e
# ╟─94abec7a-211e-4bfc-9df6-e51cb6cf5e30
# ╟─70690406-24ec-43ef-b7d4-5685304fcecb
# ╟─322db9b0-f40a-401f-9860-d3556b59b0de
# ╠═552bf189-aa47-46c2-b397-3a15b666e2a1
# ╟─18f377b7-13a4-4d05-866b-5aa7673bbf91
# ╠═0dec7897-abe4-4915-820f-4a641cddc9af
# ╟─a6ef954b-de4a-49d0-bf8a-aa0a3a27cd91
# ╠═1977c545-5213-4a53-9eeb-c5affdaa0b44
# ╠═d628e804-ae91-40e0-8707-7e928b02ab5d
# ╟─44560655-61cc-402a-aef7-7800c0fe27f1
# ╟─4488222b-3332-45f2-87e1-ee5562a622d3
# ╟─a1832207-f5b1-4617-9ff1-9d9b0ac1a5ec
# ╟─c64814cb-96a6-4677-8bec-4ef9a45492c8
# ╠═b70471d6-b236-4a45-847c-3f70eaf32547
# ╟─ab67a9df-c3a9-422c-b872-3c9146f9ce62
# ╟─69f0b870-6854-4cf1-b4d1-eaff9c2b54de
# ╟─df8ba077-c1f8-45f9-b35d-695da050ef60
# ╟─7a64aa81-cf01-4d0b-8829-713f3bb41b85
# ╟─3c4a0c66-6e87-46ee-a4d9-a8a8adb172ce
# ╠═4f407f00-5c0b-4549-b325-cfb1b9c6b794
# ╟─b4722136-23d0-462a-bc4a-7cc437dfa2e0
# ╠═ba28e078-7473-4b80-a327-06075f0fd896
# ╟─866c5782-fbab-4bfc-bad9-e87c6ff25d1a
# ╠═07be42af-7328-4ed0-a6d0-3399403f1495
# ╟─891ab2d0-4e78-46c4-83b2-c39487a28111
# ╠═1327ecc4-d5fa-4f87-b6f8-f5c77101f8e4
# ╠═7d0f1d07-e85a-4ede-86a1-a147d08e660a
# ╟─d2f8bd46-b802-41c0-af8d-b09d92e47fac
# ╟─801492a6-0c56-41c3-bd28-82d9dd59d79c
# ╟─e4e8d624-ca1b-49b3-bd90-0ef3d2cfde3a
# ╠═212d057a-302f-4e7e-a923-d907d322552f
# ╟─7a0cd968-b14e-4a05-9c6f-3052509bd468
# ╟─292d6659-8db3-4477-aa46-e60881d7c923
# ╟─11c6fe6a-7d01-464c-b31a-bf99b05ba9d2
# ╟─0e6e35b5-9cc5-40d4-84d1-370205c97df1
# ╟─fd1fd424-6f28-4c8a-88a6-89e8bae8db8d
# ╠═a1035046-1058-4e97-bc92-59f3282b7904
# ╟─f99b063a-f443-40c8-816a-18049277ec84
# ╠═ebe8f2d6-40f3-4c06-a169-60923cdfda14
# ╟─c3cc2a03-ed78-479f-b51c-200e132671a5
# ╠═bebec37c-dcb3-4023-9790-3ec5dd0ecc95
# ╟─e1663738-c3e7-405b-bcf1-9178cae3aec1
# ╠═a60eb433-067e-497d-891b-26f2216fef21
# ╠═6367f839-5eab-408c-83a9-bb5065a53391
# ╟─87a380f0-4c04-457d-b30f-bbf964a2a1c9
# ╟─7e6767f2-a6d4-4138-9d06-21587586b402
# ╟─081cb3c2-6527-4676-a238-99f7ff51c1c3
# ╟─4e370389-c16f-4496-9f7d-9a98f18df78f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
