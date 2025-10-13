### A Pluto.jl notebook ###
# v0.20.5

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

# ╔═╡ b01d7d50-c521-11ef-32ce-0751a4c10dc5
using PlutoUI

# ╔═╡ 3241856d-b2b9-4236-9759-49cd6e52e974
begin
	using Plots,Colors,ColorVectorSpace,ImageShow,FileIO,ImageIO
	using HypertextLiteral
	using Images, ImageShow 
	using TestImages, ImageFiltering
	using Statistics,  Distributions, LinearAlgebra
	using StatsBase, StatsPlots
end

# ╔═╡ 0108e854-2215-42ce-b522-7455e1c694ad
using FFTW

# ╔═╡ a11c6ad2-f459-4d17-9135-1c272a1f85eb
PlutoUI.TableOfContents(title="Transformada de Fourier en Imágenes", aside=true)

# ╔═╡ c7e5d4f1-65ab-4e6e-95fb-1fb293a4ac79
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**.

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 88e077fc-1e7c-4876-9075-f6d673988a11
md"""**Este cuaderno está basado en actividades del seminario Procesamiento de Imágenes de la Universidad Nacional de Colombia, sede Bogotá, dirigido por el profesor Jorge Mauricio Ruíz en 2024-2.**

Elaborado por Juan Galvis, Jorge Mauricio Ruíz, Yessica Trujillo y Carlos Nosa."""

# ╔═╡ 0d3693d4-ff96-4876-93bb-e6566ce14aa0
md"""Vamos a usar las siguientes librerías:"""

# ╔═╡ ea8f127b-729c-410d-be47-e15eb13a0e44
md"""
# Introducción
"""

# ╔═╡ 9bb3294c-79d3-495b-a75c-4a855e5113c3
md"""
La Transformada Discreta de Fourier (DFT) es una herramienta fundamental en procesamiento de señales e imágenes, ya que permite analizar el contenido en frecuencia de una señal discreta. Su aplicación en imágenes posibilita el filtrado, la compresión y la mejora de calidad, entre otros usos.

La DFT transforma una secuencia de valores en el dominio del tiempo o espacio a una representación en el dominio de la frecuencia. Esta transformación es especialmente útil para entender la composición de una señal y para realizar operaciones en dicho dominio, como la eliminación de ruido o la detección de características específicas.

"""

# ╔═╡ 678f6525-9cb9-414a-9d55-248956911512
md"""
En análisis de frecuencias en señales, las secuencias trigonométricas como el coseno y el seno juegan un papel fundamental. Estas secuencias se pueden definir como:

$c(k) = A \cos(2\pi f k)$
$s(k) = A \sin(2\pi f k)$

donde $A$ es la amplitud y $f$ es la frecuencia medida en revoluciones por muestra. Para simplificar el análisis, combinamos estas secuencias en una única secuencia exponencial compleja:

$w(k) = A e^{2\pi i f k} = A \cos(2\pi f k) + i A \sin(2\pi f k)$

Esta representación nos proporciona varias propiedades importantes:

1. **Periodicidad**: Mientras que una señal seno o coseno continua es siempre periódica, sus contrapartes discretas solo son $N$-periódicas si la frecuencia satisface $f = \frac{n}{N}$, donde $n$ es un entero. Esto implica que las secuencias trigonométricas discretas solo son periódicas si tienen frecuencias racionales.
2. **Simetría**:
   - El coseno discreto es una función par: $c(-k) = c(k)$ y, si es $N$-periódico, también satisface $c(N-k) = c(k)$.
   - El seno discreto es impar: $s(N-k) = -s(k)$.
   - La exponencial compleja cumple $w(N-k) = w(-k)$.
3. **Identidad de señales con frecuencias desplazadas**: En señales continuas, dos sinusoides de diferentes frecuencias son distintas. Sin embargo, en señales discretas, dos secuencias exponenciales con frecuencias $f_1$ y $f_2$ son idénticas si difieren en un número entero: $w(k) = e^{2\pi i (f+m) k}$ para cualquier entero $m$. Además, dos secuencias coseno de frecuencias $n_1$ y $n_2$ cumplen $c_1(k) = c_2(k)$ si $n_1 + n_2 = N$, y dos secuencias seno cumplen $s_1(k) = -s_2(k)$ en la misma condición.

Estas propiedades son clave para el desarrollo de la DFT, que utiliza una base de $N$ secuencias exponenciales complejas de la forma:

$w(k) = A e^{2\pi i n k / N}, \quad n = 0, \dots, N - 1$

para descomponer señales discretas en sus componentes espectrales. A partir de esta base, se establecen técnicas de análisis de frecuencia de señales periódicas y finitas.

"""

# ╔═╡ 3aa09adf-7454-4938-ba6b-2021093797f7
md"""
# Transformada discreta de Fourier en una dimensión
"""

# ╔═╡ 6240e543-bba8-4e7c-affe-d7323d181d2e
md"""
Dada una secuencia discreta de $N$ muestras $x[n]$, su Transformada Discreta de Fourier (DFT) se define como:

$X[k] = \sum_{n=0}^{N-1} x[n] e^{-i 2\pi k n / N}, \quad k = 0, 1, \dots, N-1$

donde:
-  $X[k]$ representa los coeficientes espectrales en el dominio de la frecuencia.
-  $x[n]$ es la señal en el dominio del tiempo.
-  $N$ es el número total de muestras de la señal.
-  $i$ es la unidad imaginaria $( i^2 = -1 )$.
-  La frecuencia discreta está dada por $f_k = \frac{k}{N} f_s$, donde $f_s$ es la frecuencia de muestreo que es la cantidad de muestras que se toman por segundo para digitalizar una señal analógica. Se mide en Hertz (Hz) y determina la resolución en el dominio del tiempo de la señal muestreada.

**Ejemplo.** Se considera una señal discreta construida como una onda senoidal con frecuencias de $10$ Hz , muestreadas a $f_s$ Hz durante $N$ muestras. Para estudiar su contenido espectral, se aplica la Transformada Discreta de Fourier (DFT) usando la función `fft` de Julia, que devuelve coeficientes complejos cuyos módulos representan la magnitud de las componentes en frecuencia. La frecuencia de cada componente en el espectro se obtiene como $f_k = k f_s / N$, permitiendo identificar picos en $10$ Hz y $f_s-10$ Hz, lo que confirma la presencia de dicha frecuencia en la señal original. Este análisis muestra cómo la DFT descompone la señal en sus componentes fundamentales.
"""


# ╔═╡ e0b31a67-f9a5-4273-85df-ca059936d4ee
begin
	# Parámetros de la señal
	N = 20  # Número de muestras
	fs = 60 # Frecuencia de muestreo en Hz
	t = (0:N-1) / fs  # Vector de tiempo
	
	# Generar una señal como combinación de dos senoidales
	f1 = 10  # Frecuencia (Hz)
	x = sin.(2π * f1 * t)   # Señal discreta
	
	# Calcular la DFT usando FFT
	X = fft(x)
	
	# Obtener la frecuencia correspondiente a cada coeficiente de la FFT
	freqs = (0:N-1) * (fs / N)
	
	# Graficar la señal original
	plot(t, x, xlabel="Tiempo (s)", ylabel="Amplitud", title="Señal Discreta", label="x(t)", lw=2,marker=:o)
end

# ╔═╡ b326acea-88a7-43b6-bda5-09284511fa99
md"""$\texttt{Figura 1. Señal discreta.}$"""

# ╔═╡ a6421d28-fc4e-41b7-8317-e3fa337bd8b4
# Graficar la magnitud de la DFT
plot(freqs[1:N], abs.(X[1:N]), seriestype=:stem, markershape=:circle, xlabel="Frecuencia (Hz)", ylabel="Magnitud", title="DFT de la Señal", label="|X(f)|", lw=2)

# ╔═╡ 6100e9bb-2b54-43ae-b41c-91724170d75a
md"""$\texttt{Figura 2. DFT de la Figura 1.}$"""

# ╔═╡ 9d06ba70-61f6-4199-835c-68f89d4b2b1f
md"""
La gráfica muestra la magnitud de la Transformada Discreta de Fourier (DFT) en función de la frecuencia. En el eje horizontal, se representan las frecuencias correspondientes a cada coeficiente $X[k]$, mientras que en el eje vertical, se muestra su magnitud $|X[k]|$. Los picos en la gráfica indican la presencia de componentes frecuenciales dominantes en la señal original, permitiendo identificar qué frecuencias están presentes y con qué intensidad. La visualización con marcadores mejora la interpretación al destacar los valores discretos de la DFT.
"""

# ╔═╡ 533c3579-7a43-4c89-a2d5-a881536723cf
begin
	X_shifted = fftshift(X)  # Centrar la transformada

	# Obtener magnitudes y fases de los coeficientes
	magnitudes = abs.(X_shifted)  # Módulo de X[k]
	fases = angle.(X_shifted)  # Fase de X[k]
	
	# Gráfica en coordenadas polares con vectores
	plot(proj=:polar, title="Coeficientes de la DFT en Coordenadas Polares")
	quiver!(zeros(N), zeros(N), quiver=(fases, magnitudes), color=:black, label="X[k]")  # Vectores
	scatter!(fases, magnitudes, color=:red, markersize=5, label="Puntos X[k]")  # Puntos en los extremos
end

# ╔═╡ 05c736e8-935d-4ce8-aed6-f59b47a65ca9
md"""$\texttt{Figura 3. Coeficientes de la DFT en Coordenadas Polares.}$"""

# ╔═╡ 756e320f-019a-4004-9db0-0005ad23dd90
md"""
La representación en coordenadas polares muestra los coeficientes de la Transformada Discreta de Fourier (DFT) como vectores radiales. Cada coeficiente $X[k]$ se visualiza con un ángulo correspondiente a su fase $\angle X[k]$ y una magnitud $|X[k]|$ que indica su contribución en la señal original. Los vectores, trazados en negro, parten del origen y terminan en la ubicación compleja de cada coeficiente, mientras que los puntos resaltan sus posiciones finales.
"""

# ╔═╡ 77ab6c80-5ed1-43f7-a68e-5a8e4fb5680a
md"""
Considere la siguiente representación

$\boldsymbol{x} =
\begin{bmatrix}
x(0) \\
x(1) \\
\vdots \\
x(N - 1)
\end{bmatrix}\quad\text{ y }\quad\boldsymbol{X}=
\begin{bmatrix}
X(0) \\
X(1) \\
\vdots \\
X(N - 1)
\end{bmatrix}.$

Recordando que 

$X[k] = \sum_{n=0}^{N-1} x[n] e^{-i 2\pi k n / N}, \quad k = 0, 1, \dots, N-1,$

se puede hallar una relación matricial entre los vectores $\boldsymbol{x}$ y $\boldsymbol{X}$, en efecto, defina

$\omega_N =  e^{i\frac{2\pi}{N}}$

y para $1\leq i,j,\leq N$ sea $A_{ij} = \omega_{N}^{-(i-1)(j-1)}$ de esta manera se tiene la relación

$\boldsymbol{X} = A \cdot \boldsymbol{x}.$
"""

# ╔═╡ 574cfed5-ae2a-4362-82af-eda31021f8c4
md"""
**Teorema 1.** Para la matriz $A$ definida anteriormente se cumple que $\frac{1}{N}A^{\ast}A = \frac{1}{N}A A^{\ast} =  I$.

*Demostración.* Considere $1\leq j_1,j_2\leq N$, de esta manera, el producto interno entre la columna $j_1$ y la columna $j_2$ es igual a 

$\begin{align*}
col_{j_1}^\top \overline{col_{j_2}} &= \sum_{i=1}^{N} A_{ij_1}\overline{A_{ij_2}}\\
&= \sum_{i=1}^{N} \omega_{N}^{-(i-1)(j_1-1)}\overline{\omega_{N}^{-(i-1)(j_2-1)}}\\
&= \sum_{i=1}^{N} [\omega_{N}^{j_2-j_1}]^{i-1}\\
&= \sum_{i=0}^{N-1} [\omega_{N}^{j_2-j_1}]^{i}\\
&= \begin{cases}
N, & j_1 = j_2,\\
0, & j_1\not=j_2.
\end{cases}
\end{align*}$
"""

# ╔═╡ f100c697-d4a8-4a51-9d01-381b2b3412cf
md"""
De esta manera se tiene que $\frac{1}{N}A^\ast \boldsymbol{X} = \boldsymbol{x}$ y esto da paso a la definición de la inversa de la inversa de la transformada discreta de Fourier:




**Definción.** La inversa de la transformada discreta de Fourier se define como:


$x[n] = \frac{1}{N}\sum_{k=0}^{N-1} X[k] e^{i 2\pi k n / N}, \quad n = 0, 1, \dots, N-1.$


**Ejemplo.** Como primer y más sencillo ejemplo, calculamos la Transformada Discreta de Fourier (DFT) del impulso unitario periódico $\delta$, que, recordemos, está definido por  

$\delta(k) =
\begin{cases}
1, & k = 0 \mod N \\
0, & k \neq 0 \mod N.
\end{cases}$

Es evidente que  

$\Delta(n) = \delta(0) e^{-2\pi i n \cdot 0 / N} = 1$

para todo $n$ y, por lo tanto, el impulso unitario está compuesto por todas las frecuencias en el espectro. Como una variación de este ejemplo, también podemos considerar el impulso unitario desplazado $\delta_a$, definido por  

$\delta_a(k) =
\begin{cases}
1, & k = a \mod N \\
0, & k \neq a \mod N.
\end{cases}$

y observar que su DFT es  

$\Delta_a(n) = \delta(a)e^{-2\pi i n a / N} = e^{-2\pi i n \cdot a / N}$

para todo $n$, lo que equivale a la DFT del impulso unitario multiplicada por una exponencial compleja.  Este ejemplo es la motivación del siguiente teorema.

"""

# ╔═╡ c1996ac2-f26d-4201-8239-aa36fd93aa21
md"""
**Teorema 2.** El desplazamiento de un número $a$ de posiciones en una señal discreta finita o $N$-periódica es equivalente a la multiplicación de su Transformada Discreta de Fourier (DFT) por el factor $e^{-2\pi i a n / N}$. Más formalmente, si  $y(k) = x(k - a)$ entonces $Y(n) =e^{-2\pi i a n / N} X(n).$

"""

# ╔═╡ 74e1d603-f640-458b-bae7-710016ea7208
md"""
**Ejemplo.** Es intuitivamente evidente (a partir del significado y la definición de la transformada discreta de Fourier) que la DFT de la secuencia exponencial compleja  

$w_m(k) = e^{2\pi i k m / N}$

de longitud $N$ y frecuencia $m$ es $N\delta_m(n)$, lo que también puede confirmarse con el cálculo  

$W_m(n) = \sum_{k=0}^{N-1} e^{2\pi i k m / N} \cdot e^{-2\pi i k n / N}$
$= \sum_{k=0}^{N-1} e^{-2\pi i k (n - m) / N} = N\delta_m(n),$

como se puede verificar fácilmente.  

Se sigue que la DFT de la onda coseno discreta de frecuencia $m$, dada por  

$c_m(k) = A \cos\left(m \cdot \frac{2\pi k}{N}\right) = \frac{A}{2} \left(e^{m \cdot 2\pi i k / N} + e^{-m \cdot 2\pi i k / N}\right),$

es  

$C_m(n) = \frac{A N}{2} \left(\delta_m(n) + \delta_m(-n)\right),$

y que la DFT de la onda seno discreta análoga, dada por  

$s_m(k) = A \sin\left(m \cdot \frac{2\pi k}{N}\right) = \frac{A}{2i} \left(e^{m \cdot 2\pi i k / N} - e^{-m \cdot 2\pi i k / N}\right),$

es  

$S_m(n) = \frac{A N}{2i} \left(\delta_m(n) - \delta_m(-n)\right).$

"""

# ╔═╡ 249ca1f0-403a-464a-997e-c57c27fdde36
md"""
**Teorema 3.** Una modulación en frecuencia (es decir, la multiplicación por $e^{2\pi i k m / N}$) de una señal discreta $N$-periódica resulta en un desplazamiento de su DFT en \( m \) posiciones.  
Más formalmente, si  

$y(k) = x(k) e^{2\pi i k m / N}$

entonces  

$Y(n) = X(n - m).$
"""

# ╔═╡ 35660aee-510e-49d3-bfd3-8269aabf6b84
md"""
**Teorema 4.** Multiplicar una secuencia $N$-periódica $x(k)$ por la secuencia coseno discreta $N$-periódica de frecuencia $m$ es equivalente a tomar el promedio de los  
desplazamientos de su DFT en $m$ y $-m$ posiciones. Más formalmente, si  

$y(k) = x(k) \cos\left(\frac{2\pi k m}{N}\right)$

entonces  

$Y(n) = \frac{1}{2} \left[ X(n - m) + X(n + m) \right].$
"""

# ╔═╡ 3a1237cb-7acd-4672-802e-93918eaf3a8e
md"""
**Teorema 5.** La multiplicación componente a componente de secuencias finitas o $N$-periódicas es equivalente (hasta el factor constante $\frac{1}{N}$) a la convolución circular de sus transformadas de Fourier discretas. Formalmente, si  

$g(k) = x(k) \cdot y(k)$

entonces  

$G(n) = \frac{1}{N} (X * Y)(n).$
"""

# ╔═╡ 580b238c-c6d0-4bcd-9bcb-d8914d854661
md"""
**Teorema 6.** La convolución circular de secuencias finitas o $N$-periódicas es equivalente al producto punto a punto de sus transformadas de Fourier discretas. Formalmente, si  

$g(k) = (x * y)(k)$

entonces  

$G(n) = X(n) \cdot Y(n).$

"""

# ╔═╡ ae9ba491-f21e-4c2d-b6d7-a907eb324a9f
md"""
**Ejemplo.** Este ejemplo genera una señal discreta como la superposición de tres secuencias cosenoidales con diferentes frecuencias y amplitudes. La señal se construye con un número total de 60 muestras y se representa gráficamente mediante un gráfico de stem. Luego, se calcula la Transformada Discreta de Fourier (DFT) de la señal utilizando la función `fft` y se visualiza su magnitud, lo que permite analizar la distribución de las frecuencias presentes en la señal.
"""

# ╔═╡ 08a441f0-5e09-479f-af93-03449dc6ce28
begin
	N0 = 60  # Longitud de la señal
	k0 = 0:N-1  # Índices de la secuencia
	
	# Amplitudes de los componentes de la señal
	A10, A20, A30 = 9, 7, 5  
	
	# Frecuencias de los componentes de la señal
	f10, f20, f30 = 2, 6, 15  
	
	# Construcción de la señal como una superposición de cosenos
	x0 = A10 * cos.(2π * f10 * k0 / N0) .+ A20 * cos.(2π * f20 * k0 / N0) .+ A30 * cos.(2π * f30 * k0 / N0)
	
	# Cálculo de la DFT de x0
	X0 = fft(x0)
	
	# Gráficos
	plot(plot(k0, x0, seriestype=:stem, markershape=:circle, label="", xlabel="k", ylabel="x(k)", title="Superposición de tres secuencias coseno"),
	plot(k0, abs.(X0), seriestype=:stem, markershape=:circle, label="", xlabel="n", ylabel="|X(n)|", title="DFT X(n) de x(k)"),
	layout=(2,1))
	
end

# ╔═╡ dabd2108-2d88-4615-93da-34b2941935eb
md"""$\texttt{Figura 4. Visualización de una secuencia y su DFT.}$"""

# ╔═╡ 90b53c6c-e005-4ac1-a79f-c2d7604507da
md"""
## Transformaciones de Señales
"""

# ╔═╡ d54d6f0e-c5ed-4dd2-8017-98f681689b40
md"""
En el procesamiento de señales e imágenes, es fundamental enfocarse en transformaciones lineales, ya que son más fáciles de manejar. Estas cumplen la propiedad de linealidad:  

$T(ax + by) = aT(x) + bT(y)$

para cualquier par de vectores $x$ y $y$ y escalares $a$ y $b$.  

Además, una suposición clave es la **invariancia en el tiempo**, lo que implica que un retraso en la entrada genera el mismo retraso en la salida sin alteraciones adicionales. Formalmente, si $x(k)$ es la señal original y $y(k)$ su transformación, la transformación $T$ es invariante en el tiempo si se cumple:  

$T(x_{\tau}) = y_{\tau}$

para cualquier desplazamiento $\tau$ con $x_{\tau}(k) = x(k-\tau)$ y $y_{\tau}(k) = y(k-\tau)$.  

Esta propiedad es crucial, ya que cualquier transformación definida mediante convolución $T(x) = x \ast h$ es automáticamente lineal e invariante en el tiempo.


$\begin{align*}
T(x_{\tau})(k) &= (x_\tau \ast h)(k)\\
&= \sum_{m}x_{\tau}(k-m)h(m)\\
&= \sum_{m}x(k-m-\tau)h(m)\\
& = (x \ast h)(k - \tau) \\
& = (x \ast h)_\tau(k) \\
\end{align*}$


Además, toda transformación lineal e invariante en el tiempo puede expresarse como una convolución.
"""

# ╔═╡ 73a26fa3-02b0-4876-ac2d-403c8e7ed83a
md"""
**Teorema 7.** Sea $x$ una señal y $T$ una transformación lineal y con invarianza en el tiempo, de esta manera $T(x) = x\ast h$ con $h= T(\delta)$ y $\delta$ el impulso unitario.

*Demostración.* Dado que la secuencia $x$ puede expresarse como la convolución con un delta de Dirac $\delta$, se tiene:  

$x(k) = \sum_{m} x(m) \delta(k - m)$

Por lo tanto, aplicando la transformación $T$ a ambos lados:  

$T(x)(k) = T \left( \sum_{m} x(m) \delta(k - m) \right)$

Por la linealidad de $T$:  

$T(x)(k) = \sum_{m} x(m) T(\delta_m)(k)$

Por la invariancia en el tiempo de $T$:  

$T(x)(k) = \sum_{m} x(m) T(\delta)(k - m)$

Dado que $h(k) = T(\delta)(k)$, se obtiene la expresión de convolución:  

$T(x)(k) = (x \ast h)(k).$


**Definición.** La imagen $h$ de la secuencia impulso unitario $\delta$ bajo la transformación $T$ se denomina **respuesta al impulso** de $T$. La transformada de Fourier discreta $H$ de la respuesta al impulso $h$ se denomina **función de transferencia** de la transformación $T$, y está dada por:

$H(n) = \sum_{k=0}^{N-1} h(k)e^{-2\pi i n k / N}.$

"""

# ╔═╡ 5a91f2fd-5b3e-40a2-ab0f-b7519ff2d179
md"""
Los resultados anteriores sugieren una estrategia efectiva para transformar señales manipulando su contenido de frecuencia. La clave es diseñar una secuencia $h$ cuya transformada de Fourier discreta $H$ enfatice las frecuencias deseadas y suprima las no deseadas. Luego, se aplica la transformación lineal e invariante en el tiempo con respuesta al impulso $h$ a la señal de entrada.  

El proceso de mejora de una señal $x$ mediante análisis de frecuencia se desarrolla en los siguientes pasos:  

1. Se calcula la transformada de Fourier discreta $X$ de la señal $x$, lo que representa el espectro de frecuencia de la señal a mejorar.  
2. Se computa el producto punto a punto $Y = X \odot H$, donde $Y$ es el espectro de frecuencia de la versión mejorada $y$ de $x$.  
3. Se utiliza la fórmula de inversión de la DFT para obtener $y$, que idealmente estará libre de la mayoría de las deficiencias y artefactos no deseados de $x$.  



Cuando una señal original $x$ es distorsionada por un sistema con una respuesta al impulso $h$ conocida o aproximada, se recibe una versión distorsionada $y$, que es la convolución de $x$ con $h$. En este caso, el procedimiento para restaurar la señal original es:  

1. Se calcula la transformada de Fourier discreta $Y$ de la señal distorsionada $y$ con el objetivo de eliminar las distorsiones.  
2. Se divide $Y$ componente a componente por la función de transferencia del sistema $H$, siempre que $H(n) \neq 0$. Esto permite recuperar la DFT $X$ de la señal original. Si $H(n) = 0$ para algún $n$, la señal original no puede reconstruirse completamente, solo aproximarse.  
3. Finalmente, se usa la fórmula de inversión de la DFT para reconstruir $x$.  
"""

# ╔═╡ ef94cde7-1783-424e-8ff6-ccfb1894e084
md"""
**Ejemplo.
pag238**
"""

# ╔═╡ c88b7a67-5d04-4f0f-9b0d-b68a831b26b0
md"""
# Transformada discreta de Fourier en dos dimensiones
"""

# ╔═╡ 18e29310-82fe-41b6-99cc-7b7088df7b6c
md"""
Para extender la Transformada de Fourier Discreta (DFT) a matrices de tamaño \( M \times N \), se puede aplicar la DFT primero a las columnas y luego a las filas de la matriz dada. Esto da lugar a la **transformada de Fourier discreta en dos dimensiones (2-D DFT)**, formalmente definida como:  

**Definición.** La 2-D DFT de una matriz $A$ de tamaño $M \times N$ está dada por:  

$\hat{A}(m, n) =
\sum_{k=0}^{M-1} \sum_{l=0}^{N-1} A(k, l) e^{-2\pi i mk/M - 2\pi i nl/N}$

Gracias a los desarrollos previos, se puede prever un método para reconstruir una matriz a partir de su 2-D DFT utilizando la **fórmula de inversión en dos dimensiones**:  

$A(k, l) = \frac{1}{MN} \sum_{m=0}^{M-1} \sum_{n=0}^{N-1} \hat{A}(m, n) e^{2\pi i mk/M + 2\pi i nl/N}$

Esta fórmula puede verificarse reconstruyendo la matriz $A$ separadamente en cada dimensión (filas y columnas).  


Las propiedades de la 2-D DFT son análogas a las de la DFT en una dimensión. Por ejemplo, la 2-D DFT del **impulso unitario en dos dimensiones** $\delta(k, l)$ definido como:  

$\delta(k, l) =
\begin{cases} 
1, & \text{si } (k, l) = (0,0) \\
0, & \text{si } (k, l) \neq (0,0)
\end{cases}$

es la **secuencia constante unitaria en dos dimensiones**:  

$\hat{\delta}(m, n) = 1, \quad \text{para todo } \; 0 \leq m < M, \; 0 \leq n < N$

Recíprocamente, la 2-D DFT de la **secuencia constante unitaria en dos dimensiones** es el **impulso unitario en dos dimensiones**, multiplicado por $M \times N$.

"""

# ╔═╡ 475d326b-b21e-4508-b386-f2cd2c68926c
md"""
**Teorema 8.** La **multiplicación elemento a elemento** de dos matrices $M \times N$ es equivalente (hasta un factor constante) a la **convolución cíclica** de sus transformadas de Fourier discreta en dos dimensiones (2-D DFT).  

Formalmente, si:  

$C(k, l) = A(k, l) \cdot B(k, l)$

entonces su 2-D DFT está dada por:  

$\hat{C}(m, n) = \frac{1}{MN} \left( \hat{A} * \hat{B} \right)(m, n)$

donde $*$ denota la convolución cíclica en dos dimensiones. 



**Teorema 9.** La **convolución cíclica** de dos matrices $M \times N$ es equivalente a la **multiplicación elemento a elemento** de sus transformadas de Fourier discreta en dos dimensiones (2-D DFT).  

Formalmente, si:  

$C(k, l) = (A * B)(k, l)$

entonces su 2-D DFT está dada por:  

$\hat{C}(m, n) = \hat{A}(m, n) \cdot \hat{B}(m, n)$

donde $*$ denota la convolución cíclica en dos dimensiones.  
"""

# ╔═╡ 750a01bf-b4e9-412a-bce7-9bb72e2b3a55
md"""
Como análogo a las transformaciones invariantes en el tiempo para secuencias, se pueden definir **transformaciones invariantes en el espacio** que operan sobre matrices. Sea $T$ una transformación lineal que actúa sobre matrices de tamaño $M \times N$, y sea $B = T(A)$. Se definen las matrices desplazadas $A_{(u,v)}$ y $B_{(u,v)}$ como:  

$A_{(u,v)}(k, l) = A(k - u, l - v)$

$B_{(u,v)}(k, l) = B(k - u, l - v)$

donde la resta se realiza módulo $M$ y $N$ respectivamente, o se combina con **zero-padding**, dependiendo de las circunstancias.  

Una transformación **invariante en el espacio** $T$ cumple la propiedad:

$T(A_{(u,v)}) = B_{(u,v)}$


para todos los valores de $u$ y $v$.  


Así como cualquier secuencia finita o infinita se puede escribir como la convolución consigo misma con el **impulso unitario** $\delta(k)$, cualquier matriz $A$ se puede escribir como la convolución consigo misma con el **impulso unitario 2-D** $\delta(k, l)$.  

Por lo tanto, la imagen de la matriz $A$ bajo la transformación lineal e invariante en el espacio $T$ se expresa como:

$B = T(A) = A \ast H$

donde $H = T(\delta)$ es la **respuesta al impulso** de la transformación $T$. En el contexto bidimensional, particularmente en imágenes digitales, esta respuesta se denomina **función de dispersión de punto (PSF, Point Spread Function)** de la transformación $T$.  

Se sigue que:

$\hat{B}(m, n) = \hat{A}(m, n) \odot \hat{H}(m, n)$

donde $\hat{H}$ es la transformada de Fourier discreta de la PSF $H$, conocida en el contexto de imágenes digitales como la **función de transferencia óptica (OTF, Optical Transfer Function)**.  
"""

# ╔═╡ 51b22df4-9388-4111-809d-24d3ea383f3c
md"""
**Ejemplo.** El código en Julia genera una matriz $A_1$ de tamaño $20 \times 20$, donde los valores varían según una función coseno en las columnas. La expresión $1/2 + \cos(2\pi \cdot 4 \cdot j / 20)/2$ crea un patrón oscilatorio con una frecuencia de 4 ciclos en 20 columnas. Luego, se calcula la transformada discreta de Fourier (DFT) de la matriz usando `fft(A1)`, y se toma su magnitud con `abs.` para obtener la intensidad de las frecuencias. Se aplica `log.(...)` para mejorar la visualización de las amplitudes y evitar que los valores más altos dominen la imagen. Finalmente, se generan dos gráficos en una disposición de $1 \times 2$: uno muestra la señal original como un mapa de calor y el otro muestra la magnitud logarítmica de su DFT, permitiendo analizar el contenido frecuencial de la matriz.

"""

# ╔═╡ 80bfafec-7dc1-4d03-8cdf-ecdb087544f9
begin	
	# Crear la matriz
	A1 = [1/2 + cos(2π * 4 * j / 20)/2 for i in 1:20, j in 1:20]
	log_DFT_A1 = log.(abs.(fft(A1)) .+ 1 )
	
	# Visualización
	plot(heatmap(A1, color=:grays, title="Señal"),
	heatmap(log_DFT_A1, color=:grays, title="log-DFT de la señal"),
	layout=(1,2), size=(800,400))
end

# ╔═╡ 63259eaf-c707-4370-84ec-8ce1c32a8665
md"""$\texttt{Figura 5. }$"""

# ╔═╡ b372a69e-edb1-4956-9ccb-fa939fb21287
md"""
La señal está dada por:

$A1(i, j) = \frac{1}{2} + \frac{1}{2} \cos\left( 2\pi \cdot 4 \cdot \frac{j}{20} \right)$

donde $j$ representa la coordenada horizontal.

Esta ecuación describe una onda cosenoidal con una frecuencia espacial de 4 ciclos en 20 unidades. Es decir, la señal tiene 4 repeticiones completas a lo largo de la dirección horizontal (cada 5 unidades se repite el patrón).

La Transformada Discreta de Fourier (DFT) descompone la señal en sus componentes de frecuencia. En este caso, la señal es esencialmente una suma de una constante $\frac{1}{2}$ y una función coseno con frecuencia espacial 4 en la dirección horizontal.

- La DFT de un coseno puro genera dos picos simétricos en la frecuencia correspondiente (positiva y negativa).
- Como la señal tiene una frecuencia de 4 ciclos en un dominio de 20 puntos, la DFT muestra picos en la posición correspondiente a $k = 4$ y su simétrica en $k = -4$. En una DFT discreta, esta última se ve reflejada en el final del eje de frecuencias.

En la imagen de la log-DFT, los puntos brillantes aparecen en la cuarta posición en la dirección horizontal. Esto ocurre porque:

- La frecuencia fundamental de la transformada discreta de Fourier está indexada de $0$ a $N-1$ (en este caso, de 0 a 19).
- La frecuencia 4 y su simétrica $N - 4 = 16$ aparecen como los valores dominantes, reflejando la periodicidad observada en la señal.

Los picos brillantes en la DFT se deben a la naturaleza periódica de la señal en la dirección horizontal. Como la señal tiene 4 ciclos a lo largo de 20 píxeles, la DFT identifica estas frecuencias y genera picos en las posiciones esperadas.

"""

# ╔═╡ f324ed85-8a3a-43bf-abe7-3171b1c38a13
md"""
# DFT en procesamiento de imágenes
"""

# ╔═╡ ebb95a43-c333-48b7-bdb0-a760945560cf
md"""
Antes de aplicar el análisis de frecuencia en el procesamiento de imágenes digitales, es importante familiarizarse con ciertas técnicas para visualizar la Transformada Discreta de Fourier (DFT) en dos dimensiones. Existen tres puntos clave a considerar:

1. Representación de la DFT en imágenes  

La forma más común de visualizar la DFT de una imagen digital es interpretando sus valores como niveles de brillo en una escala de grises. Sin embargo, los valores de la DFT pueden ser negativos o complejos. Para solucionar esto, se muestra el **valor absoluto** de la DFT.

2. Coeficiente DC y transformación logarítmica  

El coeficiente **DC**, definido como:

$\hat{A}(0,0) = \sum_{k=0}^{M-1} \sum_{l=0}^{N-1} A(k,l)$

es generalmente mucho mayor que los demás valores de la DFT, lo que hace que la imagen bruta de la DFT parezca un cielo nocturno con pocos puntos brillantes. Para mejorar la visualización, se aplica una **transformación logarítmica**:

$x \to \log(1 + |x|)$

seguida de un reescalado a un rango entre 0 y 255.

3. Posición del origen en la DFT 

En matemáticas, el origen suele esperarse en el centro de una imagen. Sin embargo, en una imagen digital representada como matriz, los índices de fila y columna comienzan en la esquina superior izquierda. Para ajustar la visualización al esquema matemático, se utiliza una reorganización de los cuadrantes, como la función `fftshift` en Julia.

Este conocimiento es fundamental para interpretar correctamente la DFT en imágenes digitales y aprovechar su potencial en análisis de frecuencia.  

"""

# ╔═╡ 931a4907-e078-414b-85bf-cd989017babf
md"""
**Ejemplo.** Continuando con el ejemplo en que la señal está definida por:

$A1(i, j) = \frac{1}{2} + \frac{1}{2} \cos\left( 2\pi \cdot 4 \cdot \frac{j}{20} \right)$

donde $j$ representa la coordenada horizontal, se hace la traslación para que las coordenadas del centro de la imágen coincidan con el origen de coordenadas
"""

# ╔═╡ 7c611333-4c51-49e9-b3cf-ef19788323c2
begin	
	# Crear la matriz
	# A1 = [1/2 + cos(2π * 4 * j / 20)/2 for i in 1:20, j in 1:20]
	# log_DFT_A1 = log.(abs.(fft(A1)) .+ 1 )
	log_DFT_A1_shift = log.(abs.(fftshift(fft(A1)) .+ 1 ))
	
	# Visualización
	plot(heatmap(log_DFT_A1, color=:grays, title="log-DFT de la señal"),
	heatmap(log_DFT_A1_shift, color=:grays, title="log-DFT movida de la señal"),
	layout=(1,2), size=(800,400))
end

# ╔═╡ 1beb1b74-6fc1-4109-aad9-f6ef40a523c8
function imageDFT(img)
	A = channelview(img)
	l = abs.(fftshift(fft(A))) 
	logDFTshift = log.(l .+ minimum(l) .+ 1 )
	logDFTshift = logDFTshift / maximum(logDFTshift)
	return logDFTshift
end

# ╔═╡ 10f46e3e-cd96-433f-a9be-12c603906c52
md"""$\texttt{Figura 6.}$"""

# ╔═╡ 2d642832-3619-4996-ab6d-0596232763ec
md"""
**Ejemplo.**
"""

# ╔═╡ 4b29af6c-673e-4a2b-9a17-f5bf105eadb9
begin
	A2 = zeros(500,500)
	for i in 1:500, j in 1:500
		if (i-250)^2+(j-250)^2 <= 25^2
			A2[i,j] = 1.0
		end
	end

	plot(heatmap(A2, color=:grays, title="Señal"),
	heatmap(imageDFT(A2), color=:RdBu, title="log-DFT de la señal"),
	layout=(1,2), size=(800,400))
end

# ╔═╡ 538992e0-e080-4034-ac76-687f4897f133
md"""$\texttt{Figura 7.}$"""

# ╔═╡ b845dbc0-2bd1-4217-8682-af74adbf1ab7
md"""
**Ejemplo.**
"""

# ╔═╡ 7f6a0ba5-52d5-4674-bf32-8c9064c2cac2
begin
	A3 = zeros(300,300)
	for i in 1:300, j in 1:300
		if abs(i-125)+abs(j-125) <= 25
			A3[i,j] = 1.0
		end
		if abs(i-150)+abs(j-150) <= 25
			A3[i,j] = 1.0
		end
		if abs(i-175)+abs(j-175) <= 25
			A3[i,j] = 1.0
		end
	end

	plot(heatmap(A3, color=:grays, title="Señal"),
	heatmap(imageDFT(Gray.(A3)), color=:RdBu, title="log-DFT de la señal"),
	layout=(1,2), size=(800,400))
end

# ╔═╡ 497026d7-145c-48c5-ba08-b2e04c3878c6
md"""$\texttt{Figura 8.}$"""

# ╔═╡ 4ee16828-ebb6-4627-b8c2-5ef752f05e04
md"""
**Ejemplo.**
"""

# ╔═╡ a8f6926d-8780-4efd-801a-d39a96240f95
begin
	function sierpinski!(img, x, y, size, depth)
	    if depth == 0
	        return
	    end
	    step = div(size, 3)
	
	    for i in 0:2, j in 0:2
	        if i == 1 && j == 1
	            img[x+step*(i):x+step*(i+1)-1, y+step*(j):y+step*(j+1)-1] .= 255
	        else
	            sierpinski!(img, x + step*i, y + step*j, step, depth - 1)
	        end
	    end
	end
	A4 = fill(0, 3^3, 3^3)
	sierpinski!(A4, 1, 1, 3^3, 3)

	A4 = A4 /255

	plot(heatmap(A4, color=:grays, title="Señal"),
	heatmap(imageDFT(Gray.(A4)), color=:RdBu, title="log-DFT de la señal"),
	layout=(1,2), size=(900,400))
end

# ╔═╡ 0cfd8bc0-c259-48ca-bfa3-2e11f5323d6b
md"""$\texttt{Figura 9.}$"""

# ╔═╡ 85e7761b-c6d1-46cf-8f6f-73e06208b206
md"""## Filtrado en el dominio de la frecuencia

### Filtrado Paso-Bajo 

Supongamos que tenemos una matriz de Transformada de Fourier \( F \), desplazada de modo que el coeficiente DC esté en el centro.  

Realizaremos un filtrado pasa-bajo multiplicando la transformada por una matriz de tal manera que los valores centrales se mantengan y los valores alejados del centro sean eliminados o minimizados.  

Una forma de hacer esto es multiplicando por una matriz ideal de filtrado pasa-bajo, que es una matriz binaria $m$ definida por:  

$m(x,y) =
\begin{cases} 
1 & \text{si } (x,y) \text{ está más cerca del centro que algún valor } D, \\
0 & \text{si } (x,y) \text{ está más lejos del centro que } D.
\end{cases}$

El círculo $c$ mostrado en la Figura 7 es precisamente una de estas matrices.

Entonces, la Transformada de Fourier inversa del producto elemento a elemento de $F$ y $m$ es el resultado que necesitamos:

$\mathcal{F}^{-1} (F \cdot m).$

Veamos qué sucede si aplicamos este filtro a una imagen. Primero obtenemos una imagen y su DFT."""

# ╔═╡ e1fc9cf1-5d1e-446e-b159-004d5573fbf1
md"""**Ejemplo:**"""

# ╔═╡ fac50950-66dc-48ad-b079-c148bac9fad2
begin
	url = "https://image.jimcdn.com/app/cms/image/transf/none/path/s6b62474d6def2639/image/i2284a58ede66cadc/version/1420667431/image.gif"  
	cuborubik = Gray.(1 .- Float64.(Gray.( load(download(url)) )))
	Acuborubik = channelview(cuborubik)

	plot(heatmap(Acuborubik, color=:grays, title="Señal"),
	heatmap(imageDFT(cuborubik), color=:RdBu, title="log-DFT de la señal"),
	layout=(1,2), size=(900,400))
end

# ╔═╡ a4043c54-b713-4490-a8e0-8cdfe606ec50
md"""$\texttt{Figura 10.}$"""

# ╔═╡ 42048529-4531-4061-a70f-02a3b9e52593
begin
	Center = zeros(500,500)
	for i in 1:500, j in 1:500
		if (i-250)^2+(j-250)^2 <= 20^2
			Center[i,j] = 1.0
		end
	end
	DFT_rubik_centerin = fftshift(fft(Acuborubik)) .* Center
	IDFT_rubik_centerin = ifft(DFT_rubik_centerin)
	
	rubik1 = heatmap(log.(abs.(DFT_rubik_centerin) .+ 1), color=:RdBu, title="")
	rubik2 = heatmap(log.(abs.(IDFT_rubik_centerin) .+ 1), color=:grays, title="")

	plot(rubik1,rubik2,layout=(1,2),size=(900,400))
end

# ╔═╡ 752144bf-dc01-4fd3-9290-ce0989823da3
md"""$\texttt{Figura 11}$"""

# ╔═╡ c7c4d069-9de0-4bbe-a562-76ed10eef97a
md"""**Ejemplo:**

"""

# ╔═╡ 58f5c17a-5765-495f-b1f2-425e0423d9bc
begin
	camoriginal = Gray.(testimage("cameraman.tif"))
	camDFT = imageDFT(camoriginal)

	[camoriginal Gray.(camDFT)]
end

# ╔═╡ 4c672598-29cf-4fae-929f-4ec77b1502ec
md"""$\texttt{Figura 12.}$"""

# ╔═╡ 54f94eba-b01d-47fc-b475-f99a29a909d0
n = @bind nn Slider(0:1:512, show_value=true, default=25)

# ╔═╡ fc86bb52-43fe-43e7-9183-c889dd79904a
begin
	A₃ = zeros(512,512)
	for i in 1:512, j in 1:512
		if (i-256)^2+(j-256)^2 <= nn^2
			A₃[i,j] = 1.0
		end
	end
	
	DFT_camoriginal = fftshift(fft(channelview(camoriginal))) .* A₃
	IDFT_camoriginal = ifft(DFT_camoriginal)

	[Gray.(log.(abs.(DFT_camoriginal) .+ 1)) Gray.(log.(abs.(IDFT_camoriginal) .+ 1))]
end

# ╔═╡ 0e40e6db-6c6f-46f0-b17f-804a461d6401
md"""$\texttt{Figura 13.}$"""

# ╔═╡ 620de51c-4329-4efa-9bde-0f2d900aad18
md"""### Filtrado de Paso-Alto

Así como podemos realizar un filtrado de paso bajo manteniendo los valores centrales de la DFT (Transformada Discreta de Fourier) y eliminando los demás, el filtrado de paso alto se puede realizar de manera opuesta: eliminando los valores centrales y manteniendo los demás. Esto se puede hacer con una pequeña modificación del método anterior de filtrado de paso bajo."""

# ╔═╡ 32d159c4-e667-4020-84b5-ca1417538b41
md"""
**Ejemplo.**
"""

# ╔═╡ ccb26d93-d403-4d0b-9085-317de4cc3a2a
begin
	DFT_rubik_centerout = fftshift(fft(Acuborubik)) .* (1 .-Center)
	IDFT_rubik_centerout = ifft(DFT_rubik_centerout)
	
	rubik3 = heatmap(log.(abs.(DFT_rubik_centerout) .+ 1), color=:RdBu, title="")
	rubik4 = heatmap(log.(abs.(IDFT_rubik_centerout) .+ 1), color=:grays, title="")

	plot(rubik3,rubik4,layout=(1,2),size=(900,400))
end

# ╔═╡ 45c1af7e-61a7-48f5-81b8-9def858163eb
md"""$\texttt{Figura 14.}$"""

# ╔═╡ d7bb978e-c4ab-4c60-acee-0c9f3f831376
n₂ = @bind n2 Slider(0:1:512, show_value=true, default=25)

# ╔═╡ f89c0037-c02e-4af0-ab26-849462f5935e
begin
	A₄ = zeros(512,512)
	for i in 1:512, j in 1:512
		if (i-256)^2+(j-256)^2 <= n2^2
			A₄[i,j] = 1.0
		end
	end
	
	DFT_camoriginal_on = fftshift(fft(channelview(camoriginal))) .* (1 .-A₄)
	IDFT_camoriginal_on = ifft(DFT_camoriginal_on)

	[Gray.(log.(abs.(DFT_camoriginal_on) .+ 1)) Gray.(log.(abs.(IDFT_camoriginal_on) .+ 1))]
end

# ╔═╡ cbfd979d-8865-4fb2-9107-ab7289c11a6b
md"""$\texttt{Figura 15.}$"""

# ╔═╡ d149cf31-fb7c-4236-8a87-8bcd11811cc3
md"""### Filtrado Gaussiano

De manera analoga a los experimentos anteriores, buscamos crear un filtro gaussiano, multiplicarlo por la transformada de la imagen e invertir el resultado."""

# ╔═╡ 54d6dac8-d075-4df0-bb22-65b3670098b2
md"""
**Ejemplo.**
"""

# ╔═╡ c0e1321f-2723-4e1c-8d1e-613216124ede
σ₁ = @bind σ Slider(0:1:100, show_value=true, default=30)

# ╔═╡ b5ce1b92-184d-4f0a-81d4-398f020734d2
begin
	rows, cols = size(camoriginal)
	g = zeros(Float64, rows, cols)
	center_x = cols / 2
	center_y = rows / 2
	
	for i in 1:rows
	    for j in 1:cols
	        x = i - center_y
	        y = j - center_x
	        g[i, j] = exp(-(x^2 + y^2) / (σ^2))
	    end
	end
	g ./= maximum(g)
end;

# ╔═╡ 4ec08f1a-d9d6-4468-b693-835b0f9b166e
begin
	DFT_camoriginal_g = fftshift(fft(channelview(camoriginal))) .*g
	IDFT_camoriginal_g = ifft(DFT_camoriginal_g)

	[Gray.(log.(abs.(DFT_camoriginal_g) .+ 1)) Gray.(log.(abs.(IDFT_camoriginal_g) .+ 1))]
end

# ╔═╡ c04bb0a7-02eb-49f3-b37e-0afa62578974
md"""$\texttt{Figura 16.}$"""

# ╔═╡ e30fa056-7cae-41c4-89a7-03bebe3ecf25
begin
	h1 = 1 .- g
	DFT_camoriginal_h1 = fftshift(fft(channelview(camoriginal))) .*h1
	IDFT_camoriginal_h1 = ifft(DFT_camoriginal_h1)

	[Gray.(log.(abs.(DFT_camoriginal_h1) .+ 1)) Gray.(log.(abs.(IDFT_camoriginal_h1) .+ 1))]
end

# ╔═╡ 33c6a7c0-9f59-4cab-97c2-17352abfa383
md"""$\texttt{Figura 17.}$"""

# ╔═╡ 78403afb-106c-4922-9fc8-b377f6b8b0e6
md"""
# Referencias
"""

# ╔═╡ fc8bb555-4e29-4064-bdb3-312d05988d03
md"""
[1] Galperin, Y. V. (2020). An image processing tour of college mathematics. Chapman & Hall/CRC Press.

[2] McAndrew, A. (2015). A computational introduction to digital image processing (2nd ed.). CRC Press.

[3] First Principles of Computer Vision, Image Filtering in Frequency Domain | Image Processing II (2 de marzo de 2021), YouTube. Recuperado 24 de febrero de 2025, de [https://www.youtube.com/watch?si=l5PBkKI-MUQKlKYE&v=OOu5KP3Gvx0&feature=youtu.be](https://www.youtube.com/watch?si=l5PBkKI-MUQKlKYE&v=OOu5KP3Gvx0&feature=youtu.be)

[4] JuliaImages. (s.f.). JuliaImages Documentation. Recuperado de [https://juliaimages.org/stable/](https://juliaimages.org/stable/).
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ColorVectorSpace = "c3611d14-8923-5661-9e6a-0046d554d3a4"
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
FFTW = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
ImageFiltering = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
ImageIO = "82e4d734-157c-48bb-816b-45c225c6df19"
ImageShow = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
StatsPlots = "f3b207a7-027a-5e70-b257-86293d7955fd"
TestImages = "5e47fb64-e119-507b-a336-dd2b206d9990"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "21b402e783f7657fffb6e7e762090b53f05f8d2f"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"
weakdeps = ["ChainRulesCore", "Test"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"
    AbstractFFTsTestExt = "Test"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "f7817e2e585aa6d924fd714df1e2a84be7896c60"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.3.0"
weakdeps = ["SparseArrays", "StaticArrays"]

    [deps.Adapt.extensions]
    AdaptSparseArraysExt = "SparseArrays"
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "d57bd3762d308bded22c3b82d033bff85f6195c6"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.4.0"

[[deps.Arpack]]
deps = ["Arpack_jll", "Libdl", "LinearAlgebra", "Logging"]
git-tree-sha1 = "9b9b347613394885fd1c8c7729bfc60528faa436"
uuid = "7d9fca2a-8960-54d3-9f78-7d1dccf2cb97"
version = "0.5.4"

[[deps.Arpack_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "OpenBLAS_jll", "Pkg"]
git-tree-sha1 = "5ba6c757e8feccf03a1554dfaf3e26b3cfc7fd5e"
uuid = "68821587-b530-5797-8361-c406ea357684"
version = "3.5.1+1"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra"]
git-tree-sha1 = "017fcb757f8e921fb44ee063a7aafe5f89b86dd1"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.18.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = "CUDSS"
    ArrayInterfaceChainRulesCoreExt = "ChainRulesCore"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceReverseDiffExt = "ReverseDiff"
    ArrayInterfaceSparseArraysExt = "SparseArrays"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CUDSS = "45b445bb-4962-46a0-9369-b4df9d0f772e"
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "01b8ccb13d68535d73d2b0c23e39bd23155fb712"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.1.0"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "16351be62963a67ac4083f748fdb3cca58bfd52f"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.7"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.BitTwiddlingConvenienceFunctions]]
deps = ["Static"]
git-tree-sha1 = "f21cfd4950cb9f0587d5067e69405ad2acd27b87"
uuid = "62783981-4cbd-42fc-bca8-16325de8dc4b"
version = "0.1.6"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CPUSummary]]
deps = ["CpuId", "IfElse", "PrecompileTools", "Static"]
git-tree-sha1 = "5a97e67919535d6841172016c9530fd69494e5ec"
uuid = "2a0fbf3d-bb9c-48f3-b0a9-814d99fd7ab9"
version = "0.2.6"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "2ac646d71d0d24b44f3f8c84da8c9f4d70fb67df"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.4+0"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "1713c74e00545bfe14605d2a2be1712de8fbcb58"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.25.1"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CloseOpenIntervals]]
deps = ["Static", "StaticArrayInterface"]
git-tree-sha1 = "05ba0d07cd4fd8b7a39541e31a7b0254704ea581"
uuid = "fb6a15b2-703c-40df-9091-08a04967cfa9"
version = "0.1.13"

[[deps.Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "Random", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "3e22db924e2945282e70c33b75d4dde8bfa44c94"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.15.8"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "403f2d8e209681fcbd9468a8514efff3ea08452e"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.29.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

    [deps.ColorTypes.weakdeps]
    StyledStrings = "f489334b-da3d-4c2e-b8f0-e476e12c162b"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "64e15186f0aa277e174aa81798f7eb8598e0157e"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.0"

[[deps.CommonWorldInvalidations]]
git-tree-sha1 = "ae52d1c52048455e85a387fbee9be553ec2b68d0"
uuid = "f70d9fcc-98c5-4d4a-abd7-e4cdeebd8ca8"
version = "1.0.0"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

[[deps.ConstructionBase]]
git-tree-sha1 = "76219f1ed5771adbb096743bff43fb5fdd4c1157"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.8"
weakdeps = ["IntervalSets", "LinearAlgebra", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "a692f5e257d332de1e554e4566a4e5a8a72de2b2"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.4"

[[deps.CpuId]]
deps = ["Markdown"]
git-tree-sha1 = "fcbb72b032692610bfbdb15018ac16a36cf2e406"
uuid = "adafc99b-e345-5852-983c-f28acb93d879"
version = "0.3.1"

[[deps.CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4e1fe97fdaed23e9dc21d4d664bea76b65fc50a0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.22"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

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

[[deps.Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "c7e3a542b999843086e2f29dac96a618c105be1d"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.12"
weakdeps = ["ChainRulesCore", "SparseArrays"]

    [deps.Distances.extensions]
    DistancesChainRulesCoreExt = "ChainRulesCore"
    DistancesSparseArraysExt = "SparseArrays"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "0b4190661e8a4e51a842070e7dd4fae440ddb7f4"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.118"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
git-tree-sha1 = "e7b7e6f178525d17c720ab9c081e4ef04429f860"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.4"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d55dffd9ae73ff72f1c0482454dcf2ec6c6c4a63"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.5+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "53ebe7511fa11d33bec688a9178fac4e49eeee00"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.2"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "7de7c78d681078f027389e067864a8d53bd7c3c9"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.8.1"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6d6219a004b8cf1e0b4dbe27a2860b8e04eba0be"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.11+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "b66970a70db13f45b7e57fbda1736e1cf72174ea"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.17.0"
weakdeps = ["HTTP"]

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "6a70198746448456524cb442b8af316927ff3e1a"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.13.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "301b5d5d731a0654825f1f2e906990f7141a106b"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.16.0+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "2c5512e11c791d1baed2049c5652441b28fc6a31"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "fcb0584ff34e25155876418979d4c8971243bb89"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+2"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "8e2d86e06ceb4580110d9e716be26658effc5bfd"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.8"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "da121cbdc95b065da07fbb93638367737969693f"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.8+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "43ba3d3c82c18d88471cfd2924931658838c9d8f"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.0+4"

[[deps.Giflib_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6570366d757b50fabae9f4315ad74d2e40c0560a"
uuid = "59f7168a-df46-5410-90c8-f2779963d0ec"
version = "5.2.3+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "b0036b392358c80d2d2124746c2bf3d48d457938"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.82.4+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "a641238db938fff9b2f60d08ed9030387daf428c"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.3"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "3169fd3440a02f35e549728b0890904cfd4ae58a"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.12.1"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "c67b33b085f6e2faf8bf79a61962e7339a81129c"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.15"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "55c53be97790242c29031e5cd45e8ac296dadda3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.0+0"

[[deps.HistogramThresholding]]
deps = ["ImageBase", "LinearAlgebra", "MappedArrays"]
git-tree-sha1 = "7194dfbb2f8d945abdaf68fa9480a965d6661e69"
uuid = "2c695a8d-9458-5d45-9878-1b8a99cf7853"
version = "0.3.1"

[[deps.HostCPUFeatures]]
deps = ["BitTwiddlingConvenienceFunctions", "IfElse", "Libdl", "Static"]
git-tree-sha1 = "8e070b599339d622e9a081d17230d74a5c473293"
uuid = "3e5b6fbb-0976-4d2c-9146-d79de83f2fb0"
version = "0.1.17"

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "68c173f4f449de5b438ee67ed0c9c748dc31a2ec"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.28"

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
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "e12629406c6c4442539436581041d372d69c55ba"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.12"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "eb49b82c172811fd2c86759fa0553a2221feb909"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.7"

[[deps.ImageBinarization]]
deps = ["HistogramThresholding", "ImageCore", "LinearAlgebra", "Polynomials", "Reexport", "Statistics"]
git-tree-sha1 = "33485b4e40d1df46c806498c73ea32dc17475c59"
uuid = "cbc4b850-ae4b-5111-9e64-df94c024a13d"
version = "0.3.1"

[[deps.ImageContrastAdjustment]]
deps = ["ImageBase", "ImageCore", "ImageTransformations", "Parameters"]
git-tree-sha1 = "eb3d4365a10e3f3ecb3b115e9d12db131d28a386"
uuid = "f332f351-ec65-5f6a-b3d1-319c6670881a"
version = "0.3.12"

[[deps.ImageCore]]
deps = ["ColorVectorSpace", "Colors", "FixedPointNumbers", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "PrecompileTools", "Reexport"]
git-tree-sha1 = "8c193230235bbcee22c8066b0374f63b5683c2d3"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.10.5"

[[deps.ImageCorners]]
deps = ["ImageCore", "ImageFiltering", "PrecompileTools", "StaticArrays", "StatsBase"]
git-tree-sha1 = "24c52de051293745a9bad7d73497708954562b79"
uuid = "89d5987c-236e-4e32-acd0-25bd6bd87b70"
version = "0.1.3"

[[deps.ImageDistances]]
deps = ["Distances", "ImageCore", "ImageMorphology", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "08b0e6354b21ef5dd5e49026028e41831401aca8"
uuid = "51556ac3-7006-55f5-8cb3-34580c88182d"
version = "0.2.17"

[[deps.ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageBase", "ImageCore", "LinearAlgebra", "OffsetArrays", "PrecompileTools", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "33cb509839cc4011beb45bde2316e64344b0f92b"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.9"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs", "WebP"]
git-tree-sha1 = "696144904b76e1ca433b886b4e7edd067d76cbf7"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.9"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "8582eca423c1c64aac78a607308ba0313eeaed56"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.4.1"

[[deps.ImageMagick_jll]]
deps = ["Artifacts", "Ghostscript_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "OpenJpeg_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fa01c98985be12e5d75301c4527fff2c46fa3e0e"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "7.1.1+1"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "2a81c3897be6fbcde0802a0ebe6796d0562f63ec"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.10"

[[deps.ImageMorphology]]
deps = ["DataStructures", "ImageCore", "LinearAlgebra", "LoopVectorization", "OffsetArrays", "Requires", "TiledIteration"]
git-tree-sha1 = "cffa21df12f00ca1a365eb8ed107614b40e8c6da"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.4.6"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "LazyModules", "OffsetArrays", "PrecompileTools", "Statistics"]
git-tree-sha1 = "783b70725ed326340adf225be4889906c96b8fd1"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.7"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "3db3bb9f7014e86f13692581fa2feb6460bdee7e"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.8.4"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "3b5344bcdbdc11ad58f3b1956709b5b9345355de"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.8"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "e0884bdf01bbbb111aea77c348368a86fb4b5ab6"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.10.1"

[[deps.Images]]
deps = ["Base64", "FileIO", "Graphics", "ImageAxes", "ImageBase", "ImageBinarization", "ImageContrastAdjustment", "ImageCore", "ImageCorners", "ImageDistances", "ImageFiltering", "ImageIO", "ImageMagick", "ImageMetadata", "ImageMorphology", "ImageQualityIndexes", "ImageSegmentation", "ImageShow", "ImageTransformations", "IndirectArrays", "IntegralArrays", "Random", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "TiledIteration"]
git-tree-sha1 = "a49b96fd4a8d1a9a718dfd9cde34c154fc84fcd5"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.26.2"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0936ba688c6d201805a83da835b55c61a180db52"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.11+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "d1b1b796e47d94588b3757fe84fbf65a5ec4a80d"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.5"

[[deps.IntegralArrays]]
deps = ["ColorTypes", "FixedPointNumbers", "IntervalSets"]
git-tree-sha1 = "b842cbff3f44804a84fda409745cc8f04c029a20"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.6"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "0f14a5456bdc6b9731a5682f439a672750a09e48"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2025.0.4+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "88a101217d7cb38a7b481ccd50d21876e1d1b0e0"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.15.1"
weakdeps = ["Unitful"]

    [deps.Interpolations.extensions]
    InterpolationsUnitfulExt = "Unitful"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.IrrationalConstants]]
git-tree-sha1 = "e2222959fbc6c19554dc15174c81bf7bf3aa691c"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.4"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "PrecompileTools", "Requires", "TranscodingStreams"]
git-tree-sha1 = "1059c071429b4753c0c869b75c859c44ba09a526"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.5.12"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "1d4015b1eb6dc3be7e6c400fbd8042fe825a6bac"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.10"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "a007feb38b422fbdab534406aeca1b86823cb4d6"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "9496de8fb52c224a2e3f9ff403947674517317d9"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.6"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eac1206917768cb54957c65a615460d87b455fc1"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.1+0"

[[deps.KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "7d703202e65efa1369de1279c162b915e245eed1"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.9"

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
git-tree-sha1 = "78211fb6cbc872f77cad3fc0b6cf647d923f4929"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "cd714447457c660382fe634710fb56eb255ee42e"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.6"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LayoutPointers]]
deps = ["ArrayInterface", "LinearAlgebra", "ManualMemory", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "a9eaadb366f5493a5654e843864c13d8b107548c"
uuid = "10f19ff3-798f-405d-979b-55457f8fc047"
version = "0.1.17"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

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
git-tree-sha1 = "27ecae93dd25ee0909666e6835051dd684cc035e"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+2"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "d77592fa54ad343c5043b6f38a03f1a3c3959ffe"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.11.1+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "ff3b4b9d35de638936a525ecd36e86a8bb919d11"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "df37206100d39f79b3376afb6b9cee4970041c61"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.51.1+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a31572773ac1b745e0343fe5e2c8ddda7a37e997"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "321ccef73a96ba828cd51f2ab5b9f917fa73945a"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LittleCMS_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg"]
git-tree-sha1 = "110897e7db2d6836be22c18bffd9422218ee6284"
uuid = "d3a379c0-f9a3-5b72-a4c0-6bf4d2e8af0f"
version = "2.12.0+0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

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
git-tree-sha1 = "f02b56007b064fbfddb4c9cd60161b6dd0f40df3"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.1.0"

[[deps.LoopVectorization]]
deps = ["ArrayInterface", "CPUSummary", "CloseOpenIntervals", "DocStringExtensions", "HostCPUFeatures", "IfElse", "LayoutPointers", "LinearAlgebra", "OffsetArrays", "PolyesterWeave", "PrecompileTools", "SIMDTypes", "SLEEFPirates", "Static", "StaticArrayInterface", "ThreadingUtilities", "UnPack", "VectorizationBase"]
git-tree-sha1 = "e5afce7eaf5b5ca0d444bcb4dc4fd78c54cbbac0"
uuid = "bdcacae8-1622-11e9-2a5c-532679323890"
version = "0.12.172"

    [deps.LoopVectorization.extensions]
    ForwardDiffExt = ["ChainRulesCore", "ForwardDiff"]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.LoopVectorization.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "oneTBB_jll"]
git-tree-sha1 = "5de60bc6cb3899cd318d80d627560fae2e2d99ae"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2025.0.1+1"

[[deps.MacroTools]]
git-tree-sha1 = "72aebe0b5051e5143a079a4685a46da330a40472"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.15"

[[deps.ManualMemory]]
git-tree-sha1 = "bcaef4fc7a0cfe2cba636d84cda54b5e4e4ca3cd"
uuid = "d125e4d3-2237-4719-b19c-fa641b8a4667"
version = "0.1.8"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

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

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "e9650bea7f91c3397eb9ae6377343963a22bf5b8"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.8.0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.MultivariateStats]]
deps = ["Arpack", "Distributions", "LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI", "StatsBase"]
git-tree-sha1 = "816620e3aac93e5b5359e4fdaf23ca4525b00ddf"
uuid = "6f286f6a-111f-5878-ab1e-185364afe411"
version = "0.10.3"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "8a3271d8309285f4db73b4f662b1b290c715e85e"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.21"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Observables]]
git-tree-sha1 = "7438a59546cf62428fc9d1bc94729146d37a7225"
uuid = "510215fc-4207-5dde-b226-833fc4488ee2"
version = "0.5.5"

[[deps.OffsetArrays]]
git-tree-sha1 = "a414039192a155fb38c4599a60110f0018c6ec82"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.16.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "97db9e07fe2091882c765380ef58ec553074e9c7"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.3"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "8292dd5c8a38257111ada2174000a33745b06d4e"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.2.4+0"

[[deps.OpenJpeg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libtiff_jll", "LittleCMS_jll", "Pkg", "libpng_jll"]
git-tree-sha1 = "76374b6e7f632c130e78100b166e5a48464256f8"
uuid = "643b3616-a352-519d-856d-80112ee9badc"
version = "2.4.0+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "38cb508d080d21dc1128f7fb04f20387ed4c0af4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.3"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ad31332567b189f508a3ea8957a2640b1147ab00"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.23+1"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6703a85cb3781bd5909d48730a67205f3f31a575"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.3+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "cc4054e898b852042d7b503313f7ad03de99c3dd"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "48566789a6d5f6492688279e22445002d171cf76"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.33"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "cf181f0b1e6a18dfeb0ee8acc4a9d1672499626c"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.4"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3b31172c032a1def20c98dae3f2cdc9d10e3b561"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.1+0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "f202a1ca4f6e165238d8175df63a7e26a51e04dc"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.7"

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
deps = ["AbstractPlutoDingetjes", "Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "5152abbdab6488d5eec6a01029ca6697dff4ec8f"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.23"

[[deps.PolyesterWeave]]
deps = ["BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "Static", "ThreadingUtilities"]
git-tree-sha1 = "645bed98cd47f72f67316fd42fc47dee771aefcd"
uuid = "1d0040c9-8b98-4ee7-8388-3f51789ca0ad"
version = "0.2.2"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "OrderedCollections", "RecipesBase", "Requires", "Setfield", "SparseArrays"]
git-tree-sha1 = "555c272d20fc80a2658587fb9bbda60067b93b7c"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "4.0.19"

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

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "13c5103482a8ed1536a54c08d0e742ae3dca2d42"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.10.4"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "8b3fc30bc0390abdce15f8822c889f669baed73d"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.1"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9da16da70037ba9d701192e27befedefb91ec284"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.2"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random", "RealDot"]
git-tree-sha1 = "994cc27cdacca10e68feb291673ec3a76aa2fae9"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.7.6"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.RealDot]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9f0a1b71baaf7650f4fa8a1d168c7fb6ee41f0c9"
uuid = "c1ae055f-0cd5-4b69-90a6-9a35b1a98df9"
version = "0.1.0"

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

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

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

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "852bd0f55565a9e973fcfee83a84413270224dc4"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.8.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays"]
git-tree-sha1 = "5680a9276685d392c87407df00d57c9924d9f11e"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.7.1"
weakdeps = ["RecipesBase"]

    [deps.Rotations.extensions]
    RotationsRecipesBaseExt = "RecipesBase"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "fea870727142270bdf7624ad675901a1ee3b4c87"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.7.1"

[[deps.SIMDTypes]]
git-tree-sha1 = "330289636fb8107c5f32088d2741e9fd7a061a5c"
uuid = "94e857df-77ce-4151-89e5-788b33177be4"
version = "0.1.0"

[[deps.SLEEFPirates]]
deps = ["IfElse", "Static", "VectorizationBase"]
git-tree-sha1 = "456f610ca2fbd1c14f5fcf31c6bfadc55e7d66e0"
uuid = "476501e8-09a2-5ece-8869-fb82de89a1fa"
version = "0.6.43"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "712fb0231ee6f9120e005ccd56297abbc053e7e0"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.8"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "c5391c6ace3bc430ca630251d02ea9687169ca68"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.2"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.SimpleWeightedGraphs]]
deps = ["Graphs", "LinearAlgebra", "Markdown", "SparseArrays"]
git-tree-sha1 = "3e5f165e58b18204aed03158664c4982d691f454"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.5.0"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "2da10356e31327c7096832eb9cd86307a50b1eb6"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "64cca0c26b4f31ba18f13f6c12af7c85f478cfde"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.5.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "83e6cce8324d49dfaf9ef059227f91ed4441a8e5"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.2"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.Static]]
deps = ["CommonWorldInvalidations", "IfElse", "PrecompileTools"]
git-tree-sha1 = "f737d444cb0ad07e61b3c1bef8eb91203c321eff"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "1.2.0"

[[deps.StaticArrayInterface]]
deps = ["ArrayInterface", "Compat", "IfElse", "LinearAlgebra", "PrecompileTools", "Static"]
git-tree-sha1 = "96381d50f1ce85f2663584c8e886a6ca97e60554"
uuid = "0d7ed370-da01-4f52-bd93-41d350b8b718"
version = "1.8.0"
weakdeps = ["OffsetArrays", "StaticArrays"]

    [deps.StaticArrayInterface.extensions]
    StaticArrayInterfaceOffsetArraysExt = "OffsetArrays"
    StaticArrayInterfaceStaticArraysExt = "StaticArrays"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "0feb6b9031bd5c51f9072393eb5ab3efd31bf9e4"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.13"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

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
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "29321314c920c26684834965ec2ce0dacc9cf8e5"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.4"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "35b09e80be285516e52c9054792c884b9216ae3c"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.4.0"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StatsPlots]]
deps = ["AbstractFFTs", "Clustering", "DataStructures", "Distributions", "Interpolations", "KernelDensity", "LinearAlgebra", "MultivariateStats", "NaNMath", "Observables", "Plots", "RecipesBase", "RecipesPipeline", "Reexport", "StatsBase", "TableOperations", "Tables", "Widgets"]
git-tree-sha1 = "3b1dcbf62e469a67f6733ae493401e53d92ff543"
uuid = "f3b207a7-027a-5e70-b257-86293d7955fd"
version = "0.15.7"

[[deps.StringDistances]]
deps = ["Distances", "StatsAPI"]
git-tree-sha1 = "5b2ca70b099f91e54d98064d5caf5cc9b541ad06"
uuid = "88034a9c-02f8-509d-84a9-84ec65e18404"
version = "0.11.3"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableOperations]]
deps = ["SentinelArrays", "Tables", "Test"]
git-tree-sha1 = "e383c87cf2a1dc41fa30c093b2a19877c83e1bc1"
uuid = "ab02a1b2-a7df-11e8-156e-fb1833f50b87"
version = "1.2.0"

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
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TestImages]]
deps = ["AxisArrays", "ColorTypes", "FileIO", "ImageIO", "ImageMagick", "OffsetArrays", "Pkg", "StringDistances"]
git-tree-sha1 = "fc32a2c7972e2829f34cf7ef10bbcb11c9b0a54c"
uuid = "5e47fb64-e119-507b-a336-dd2b206d9990"
version = "1.9.0"

[[deps.ThreadingUtilities]]
deps = ["ManualMemory"]
git-tree-sha1 = "eda08f7e9818eb53661b3deb74e3159460dfbc27"
uuid = "8290d209-cae3-49c0-8002-c8c24d57dab5"
version = "0.5.2"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "f21231b166166bebc73b99cea236071eb047525b"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.11.3"

[[deps.TiledIteration]]
deps = ["OffsetArrays", "StaticArrayInterface"]
git-tree-sha1 = "1176cc31e867217b06928e2f140c90bd1bc88283"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.5.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "6cae795a5a9313bbb4f60683f7263318fc7d1505"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.10"

[[deps.URIs]]
git-tree-sha1 = "cbbebadbcc76c5ca1cc4b4f3b0614b3e603b5000"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "c0667a8e676c53d390a09dc6870b3d8d6650e2bf"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.22.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "975c354fcd5f7e1ddcc1f1a23e6e091d99e99bc8"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.4"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "4ab62a49f1d8d9548a1c8d1a75e5f55cf196f64e"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.71"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "85c7811eddec9e7f22615371c3cc81a504c508ee"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+2"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "5db3e9d307d32baba7067b13fc7b5aa6edd4a19a"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.36.0+0"

[[deps.WebP]]
deps = ["CEnum", "ColorTypes", "FileIO", "FixedPointNumbers", "ImageCore", "libwebp_jll"]
git-tree-sha1 = "aa1ca3c47f119fbdae8770c29820e5e6119b83f2"
uuid = "e3aaa7dc-3e4b-44e0-be63-ffb868ccd7c1"
version = "0.1.3"

[[deps.Widgets]]
deps = ["Colors", "Dates", "Observables", "OrderedCollections"]
git-tree-sha1 = "e9aeb174f95385de31e70bd15fa066a505ea82b9"
uuid = "cc8bc4a8-27d6-5769-a93b-9d913e69aa62"
version = "0.6.7"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c1a7aa6219628fcd757dede0ca95e245c5cd9511"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "1.0.0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "b8b243e47228b4a3877f1dd6aee0c5d56db7fcf4"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.6+1"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "82df486bfc568c29de4a207f7566d6716db6377c"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.43+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "9dafcee1d24c4f024e7edc92603cedba72118283"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+3"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e9216fdcd8514b7072b43653874fd688e4c6c003"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.12+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "807c226eaf3651e7b2c468f687ac788291f9a89b"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.3+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "89799ae67c17caa5b3b5a19b8469eeee474377db"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.5+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "d7155fea91a4123ef59f42c4afb5ab3b4ca95058"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+3"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "6fcc21d5aea1a0b7cce6cab3e62246abd1949b86"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.0+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "984b313b049c89739075b8e2a94407076de17449"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.2+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a1a7eaf6c3b5b05cb903e35e8372049b107ac729"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.5+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "b6f664b7b2f6a39689d822a6300b14df4668f0f4"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.4+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a490c6212a0e90d2d55111ac956f7c4fa9c277a6"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+1"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c57201109a9e4c0585b208bb408bc41d205ac4e9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.2+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "1a74296303b6524a0472a8cb12d3d87a78eb3612"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "dbc53e4cf7701c6c7047c51e17d6e64df55dca94"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+1"

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
git-tree-sha1 = "ab2221d309eda71020cdda67a973aa582aa85d69"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+1"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6e50f145003024df4f5cb96c7fce79466741d601"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.56.3+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "522c1df09d05a71785765d19c9524661234738e9"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.11.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e17c115d55c5fbb7e52ebedb427a0dca79d4484e"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.2+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a22cf860a7d27e4f3498a0fe0811a7957badb38"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.3+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "068dfe202b0a05b8332f1e8e6b4080684b9c7700"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.47+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "libpng_jll"]
git-tree-sha1 = "c1733e347283df07689d71d61e14be986e49e47a"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.5+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "490376214c4721cdaca654041f635213c6165cb3"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+2"

[[deps.libwebp_jll]]
deps = ["Artifacts", "Giflib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libglvnd_jll", "Libtiff_jll", "libpng_jll"]
git-tree-sha1 = "ccbb625a89ec6195856a50aa2b668a5c08712c94"
uuid = "c5f90fcd-3b7e-5836-afba-fc50a0988cb2"
version = "1.4.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.oneTBB_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d5a767a3bb77135a99e433afe0eb14cd7f6914c3"
uuid = "1317d2d5-d96f-522e-a858-c73665f53c3e"
version = "2022.0.0+0"

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
git-tree-sha1 = "63406453ed9b33a0df95d570816d5366c92b7809"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+2"
"""

# ╔═╡ Cell order:
# ╟─b01d7d50-c521-11ef-32ce-0751a4c10dc5
# ╟─a11c6ad2-f459-4d17-9135-1c272a1f85eb
# ╟─c7e5d4f1-65ab-4e6e-95fb-1fb293a4ac79
# ╟─88e077fc-1e7c-4876-9075-f6d673988a11
# ╟─0d3693d4-ff96-4876-93bb-e6566ce14aa0
# ╠═3241856d-b2b9-4236-9759-49cd6e52e974
# ╠═0108e854-2215-42ce-b522-7455e1c694ad
# ╟─ea8f127b-729c-410d-be47-e15eb13a0e44
# ╟─9bb3294c-79d3-495b-a75c-4a855e5113c3
# ╟─678f6525-9cb9-414a-9d55-248956911512
# ╟─3aa09adf-7454-4938-ba6b-2021093797f7
# ╟─6240e543-bba8-4e7c-affe-d7323d181d2e
# ╟─e0b31a67-f9a5-4273-85df-ca059936d4ee
# ╟─b326acea-88a7-43b6-bda5-09284511fa99
# ╟─a6421d28-fc4e-41b7-8317-e3fa337bd8b4
# ╟─6100e9bb-2b54-43ae-b41c-91724170d75a
# ╟─9d06ba70-61f6-4199-835c-68f89d4b2b1f
# ╟─533c3579-7a43-4c89-a2d5-a881536723cf
# ╟─05c736e8-935d-4ce8-aed6-f59b47a65ca9
# ╟─756e320f-019a-4004-9db0-0005ad23dd90
# ╟─77ab6c80-5ed1-43f7-a68e-5a8e4fb5680a
# ╟─574cfed5-ae2a-4362-82af-eda31021f8c4
# ╟─f100c697-d4a8-4a51-9d01-381b2b3412cf
# ╟─c1996ac2-f26d-4201-8239-aa36fd93aa21
# ╟─74e1d603-f640-458b-bae7-710016ea7208
# ╟─249ca1f0-403a-464a-997e-c57c27fdde36
# ╟─35660aee-510e-49d3-bfd3-8269aabf6b84
# ╟─3a1237cb-7acd-4672-802e-93918eaf3a8e
# ╟─580b238c-c6d0-4bcd-9bcb-d8914d854661
# ╟─ae9ba491-f21e-4c2d-b6d7-a907eb324a9f
# ╟─08a441f0-5e09-479f-af93-03449dc6ce28
# ╟─dabd2108-2d88-4615-93da-34b2941935eb
# ╟─90b53c6c-e005-4ac1-a79f-c2d7604507da
# ╟─d54d6f0e-c5ed-4dd2-8017-98f681689b40
# ╟─73a26fa3-02b0-4876-ac2d-403c8e7ed83a
# ╟─5a91f2fd-5b3e-40a2-ab0f-b7519ff2d179
# ╠═ef94cde7-1783-424e-8ff6-ccfb1894e084
# ╟─c88b7a67-5d04-4f0f-9b0d-b68a831b26b0
# ╟─18e29310-82fe-41b6-99cc-7b7088df7b6c
# ╟─475d326b-b21e-4508-b386-f2cd2c68926c
# ╟─750a01bf-b4e9-412a-bce7-9bb72e2b3a55
# ╟─51b22df4-9388-4111-809d-24d3ea383f3c
# ╟─80bfafec-7dc1-4d03-8cdf-ecdb087544f9
# ╟─63259eaf-c707-4370-84ec-8ce1c32a8665
# ╟─b372a69e-edb1-4956-9ccb-fa939fb21287
# ╟─f324ed85-8a3a-43bf-abe7-3171b1c38a13
# ╟─ebb95a43-c333-48b7-bdb0-a760945560cf
# ╟─931a4907-e078-414b-85bf-cd989017babf
# ╟─7c611333-4c51-49e9-b3cf-ef19788323c2
# ╠═1beb1b74-6fc1-4109-aad9-f6ef40a523c8
# ╟─10f46e3e-cd96-433f-a9be-12c603906c52
# ╟─2d642832-3619-4996-ab6d-0596232763ec
# ╟─4b29af6c-673e-4a2b-9a17-f5bf105eadb9
# ╟─538992e0-e080-4034-ac76-687f4897f133
# ╟─b845dbc0-2bd1-4217-8682-af74adbf1ab7
# ╟─7f6a0ba5-52d5-4674-bf32-8c9064c2cac2
# ╟─497026d7-145c-48c5-ba08-b2e04c3878c6
# ╟─4ee16828-ebb6-4627-b8c2-5ef752f05e04
# ╟─a8f6926d-8780-4efd-801a-d39a96240f95
# ╟─0cfd8bc0-c259-48ca-bfa3-2e11f5323d6b
# ╟─85e7761b-c6d1-46cf-8f6f-73e06208b206
# ╟─e1fc9cf1-5d1e-446e-b159-004d5573fbf1
# ╟─fac50950-66dc-48ad-b079-c148bac9fad2
# ╟─a4043c54-b713-4490-a8e0-8cdfe606ec50
# ╟─42048529-4531-4061-a70f-02a3b9e52593
# ╟─752144bf-dc01-4fd3-9290-ce0989823da3
# ╟─c7c4d069-9de0-4bbe-a562-76ed10eef97a
# ╟─58f5c17a-5765-495f-b1f2-425e0423d9bc
# ╟─4c672598-29cf-4fae-929f-4ec77b1502ec
# ╟─54f94eba-b01d-47fc-b475-f99a29a909d0
# ╟─fc86bb52-43fe-43e7-9183-c889dd79904a
# ╟─0e40e6db-6c6f-46f0-b17f-804a461d6401
# ╟─620de51c-4329-4efa-9bde-0f2d900aad18
# ╟─32d159c4-e667-4020-84b5-ca1417538b41
# ╟─ccb26d93-d403-4d0b-9085-317de4cc3a2a
# ╟─45c1af7e-61a7-48f5-81b8-9def858163eb
# ╠═d7bb978e-c4ab-4c60-acee-0c9f3f831376
# ╟─f89c0037-c02e-4af0-ab26-849462f5935e
# ╟─cbfd979d-8865-4fb2-9107-ab7289c11a6b
# ╟─d149cf31-fb7c-4236-8a87-8bcd11811cc3
# ╟─54d6dac8-d075-4df0-bb22-65b3670098b2
# ╟─c0e1321f-2723-4e1c-8d1e-613216124ede
# ╟─b5ce1b92-184d-4f0a-81d4-398f020734d2
# ╟─4ec08f1a-d9d6-4468-b693-835b0f9b166e
# ╟─c04bb0a7-02eb-49f3-b37e-0afa62578974
# ╟─e30fa056-7cae-41c4-89a7-03bebe3ecf25
# ╟─33c6a7c0-9f59-4cab-97c2-17352abfa383
# ╟─78403afb-106c-4922-9fc8-b377f6b8b0e6
# ╟─fc8bb555-4e29-4064-bdb3-312d05988d03
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
