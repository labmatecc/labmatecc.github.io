### A Pluto.jl notebook ###
# v0.20.5

using Markdown
using InteractiveUtils

# ╔═╡ d3ebf255-4c5e-4ec0-bfcb-0b376dd66bf3
using PlutoUI

# ╔═╡ 402b40b3-ad31-4561-8880-adb973772f32
begin
	using Colors, ColorVectorSpace, ImageShow, FileIO, ImageIO
	using HypertextLiteral
	using Images, ImageShow 
	using Statistics,  Distributions, LinearAlgebra
	using StatsBase
	using Optimization, Zygote
end

# ╔═╡ bbcb1878-9890-41df-9433-2e893674376c
PlutoUI.TableOfContents(title="Difuminado y Ruido", aside=true)

# ╔═╡ e73fc4a9-e3f3-460e-b127-d4803bfeee03
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**.

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 8bc9f871-44df-4756-8e7e-c93bc4bc91f6
md"""**Este cuaderno está basado en actividades del seminario Procesamiento de Imágenes de la Universidad Nacional de Colombia, sede Bogotá, dirigido por el profesor Jorge Mauricio Ruiz en 2024-2.**

Elaborado por Jhon Acosta, Juan Galvis, Juan Diego Murcia, y Jorge Mauricio Ruíz."""

# ╔═╡ 617f2cb2-647e-4172-b3fc-be9b28f5df96
md"""Usaremos las siguientes librerías:"""

# ╔═╡ 76fafd3b-daa6-4bd3-a317-2ce3d6becc60
md"""Usaremos las siguientes funciones auxiliares:"""

# ╔═╡ 2ce1a017-29b1-416e-abf8-c4b4d515d5f8
# Función para calcular el Error Cuadrático Medio (ECM) entre dos matrices de imagen
function calcular_ecm(I, R)
	I = float64.(channelview(I))
	R = float64.(channelview(R))
	if size(I) != size(R)
		throw(ErrorException("Las imágenes deben tener el mismo tamaño"))
	end
	
	n, m = size(I)
	ecm = 0.0
	for i in 1:n
		for j in 1:m
			ecm += (I[i, j] - R[i, j])^2
		end
	end
	ecm /= (n * m)
	return ecm
end

# ╔═╡ 777189b5-933f-4eec-a88b-5ac34b7cb23d
function calcular_psnr(I, R, max_val)
	# Calcula el ECM entre las imágenes
	ecm = calcular_ecm(I, R)
	
	# Calcula el PSNR utilizando la fórmula
	psnr = 10 * log10((max_val^2) / ecm)
	return psnr
end

# ╔═╡ 467e25fd-7e29-4698-837a-41c619c90b42
# Función para calcular el índice SSIM entre dos imágenes
function calcular_ssim(I, R)
	I = float64.(channelview(I))
	R = float64.(channelview(R))
	# Asegúrate de que las imágenes tengan el mismo tamaño
	if size(I) != size(R)
		throw(ErrorException("Las imágenes deben tener el mismo tamaño"))
	end

	# Cálculos de las medias (μ) de las imágenes
	μI = mean(I)
	μR = mean(R)

	# Cálculos de las varianzas (σ²) y la covarianza (σ)
	σI2 = var(I)
	σR2 = var(R)
	σIR = cov(vec(I), vec(R))

	# Parámetros de estabilización
	c1 = (0.01)^2
    c2 = (0.03)^2

	# Fórmula SSIM con corrección de difusión
	numerator = (2 * μI * μR + c1) * (2 * σIR .+ c2)
	denominator = (μI^2 + μR^2 + c1) * (σI2 + σR2 + c2)

	ssim = numerator / denominator
	return ssim
end

# ╔═╡ 7f9ed75e-b606-4c1f-811b-137127fed66f
function calcular_error_relativo(I, R)
	# Calculamos la norma Frobenius de las matrices I - R y R
	I = float64.(channelview(I))
	R = float64.(channelview(R))
	error_frobenius = norm(vec(I-R))
	norma_frobenius_ref = norm(vec(R))
	
	# Calculamos el error relativo
	error_relativo = (error_frobenius / norma_frobenius_ref) * 100
	return error_relativo
end

# ╔═╡ 6c455d3d-f1e5-4c40-8724-a18d30166f36
md"""
# Introducción
"""

# ╔═╡ 899b6b24-4e39-491c-b4b2-b4484cb5e2d4
md"""
En este capítulo, se explorarán diversas transformaciones de restauración de imágenes y métodos de detección de bordes. Durante el proceso, se observará que, aunque estas transformaciones parezcan muy distintas entre si, todas están relacionadas matemáticamente a través de la operación de convolución.
"""

# ╔═╡ 8593931b-f918-4395-a600-ef51e151dd32
md"""
# Ruido en imágenes
"""

# ╔═╡ 3cda7462-9628-4006-b39d-f1cfbf61713e
md"""
A veces, una imágen (y, en general, cualquier tipo de señal), se ve afectada por una perturbación aleatoria, que resulta, por ejemplo, de interferencias o falta de memoria en los dispositivos. A este componente se le denomina *ruido*. A continuación, se ejemplifican distintos tipos.
"""

# ╔═╡ 4c606d57-c4a8-465b-a043-f89ee4f491b7
md"""##   $\cdot$ Ruido Blanco Gaussiano Aditivo (AWGN)"""

# ╔═╡ f4151cb3-8097-4da0-9f2d-a52118e23e37
md"""
En procesamiento de imagenes el **ruido** se puede definir como una variacion aleatoria no deseada en el brillo o el color de los pixeles. Este ruido generalmente se $\underline{\text{ modela }}$ agregando variables aleatorias que se distribuyen de manera independiente sobre los valores de los pixeles. 

Aunque el ruido puede provenir de diversas fuentes naturales, el modelo de ruido más común en procesamiento de señales e imágenes es el Ruido Blanco Gaussiano Aditivo **(AWGN)**. Este ruido se simula añadiendo variables aleatorias normales de **media cero** y una desviación estándar especificada a los valores de los píxeles.
"""

# ╔═╡ f2b3bbd9-2bd6-4d48-86db-93fbf736a20c
md""" Empleamos una conocida foto de Albert Einstein como ejemplo de imagen corrompida por **AWGN**. Usamos la funcion *randn* que genera numeros aleatorios con un distribucion normal y una desviacion estandar de $\sigma = 30$. 

"""

# ╔═╡ 41fa8758-47ef-400a-97dd-2e45fda34391
begin
	url="https://www.clarin.com/2021/04/17/GRzzW64Ad_1200x0__1.jpg"
	fname = download(url)
	A = Gray.(load(fname));
end

# ╔═╡ 01e29349-8d35-4f44-b9a4-0f9632269b62
md"""$\texttt{Figura 1. Albert Einstein. Imagen tomada de Clarin.}$"""

# ╔═╡ 0d8d6355-460e-404d-b6ce-713c0c6ed713
md"""
La siguiente funcion corrompe imagenes con ruido Gaussiano. 
"""

# ╔═╡ 9afafb0f-ac0b-470b-aab3-b41e0a0dc0f3
function ruido_gaussiano(A, sigma) 
    M, N = size(A)               
    AWGN = sigma * randn(M, N) #sigma entre (0,1) pues la imagen esta normalizada 
    An = A + AWGN                 
    return An
end


# ╔═╡ 11076927-b844-4261-8069-6e183f60844c
[A ruido_gaussiano(A,0.2)]

# ╔═╡ 1e797582-dfd6-4cb4-bc86-4bd1b5fb3c75
md"""$\texttt{Figura 2. Ruido Gaussiano aplicado a la Figura 1.}$"""

# ╔═╡ 4629da30-05ff-4b00-a662-d9acf4f51540
begin
	ecm_value_2 = calcular_ecm(A, ruido_gaussiano(A,0.2))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_2")
	psnr_value_2 = calcular_psnr(A, ruido_gaussiano(A,0.2), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_2 dB")
	ssim_value_2 = calcular_ssim(A, ruido_gaussiano(A,0.2))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_2")
	error_relativo_value_2 = calcular_error_relativo(A, ruido_gaussiano(A,0.2))
	println("El error relativo es: $error_relativo_value_2%")
end

# ╔═╡ 7f82bbae-a8ae-46a8-8fc3-92dd23079590
md"""##   $\cdot$ Ruido Sal y Pimienta"""

# ╔═╡ 54390a0b-7335-4437-8e48-ee3391ca15b4
md"""
Es un ruido que se caracteriza por la presencia de pixeles blancos y negros en lugares aislados de la imagen. Puede presentarse por variaciones agudas y repentinas en la señal de la imagen. Se puede presentar por errores en la transmisión, elementos de pixel dañados en una cámara, o falta de capacidad de memoria. Su nombre se debe a que la imagen parece haber sido "cubierta" por sal y pimienta (*Wikipedia*).
"""

# ╔═╡ de95337f-073d-4cab-ad17-ac8e90192de4
function sal_y_pimienta(A, prob) 
    M, N = size(A)  
    imagen_ruidosa = copy(A) 
    for i in 1:M
        for j in 1:N
            rand_val = rand()
            if rand_val < prob/2
                imagen_ruidosa[i, j] = 0  #Pixel blanco
            elseif rand_val > 1 - prob/2
                imagen_ruidosa[i, j] = 1  #Pixel negro
            end
        end
    end
    return imagen_ruidosa
end


# ╔═╡ 1beec73a-f89d-4c68-9642-887a064e983a
[A sal_y_pimienta(A,0.2)]

# ╔═╡ 32a9b1f6-504e-41c5-8675-ee9b4e5641b9
md"""$\texttt{Figura 3. Ruido sal y pimienta aplicado a la Figura 1.}$"""

# ╔═╡ 28f5f7b1-fff2-46df-850a-759f2b06ca5e
begin
	ecm_value_3 = calcular_ecm(A, sal_y_pimienta(A,0.2))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_3")
	psnr_value_3 = calcular_psnr(A, sal_y_pimienta(A,0.2), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_3 dB")
	ssim_value_3 = calcular_ssim(A, sal_y_pimienta(A,0.2))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_3")
	error_relativo_value_3 = calcular_error_relativo(A, sal_y_pimienta(A,0.2))
	println("El error relativo es: $error_relativo_value_3%")
end

# ╔═╡ b8b84a35-4b7d-47be-ac66-0b2d490d5b65
md"""
##   $\cdot$ Ruido Speckle
"""

# ╔═╡ 3dfcbe46-a26a-484e-ad2d-f25dca23716b
md"""
Resulta de interferencia aleatoria, y, formalmente, no es ruido, sino un resultado de reflexiones difusas. Suele presentarse en radares, radares de apertura sintética, ultrasonido en medicina, y tomografías de coherencia óptica (*Wikipedia*). En el presente código, se genera al multiplicar el valor del pixel por una realización de $N(1,\sigma)$.
"""

# ╔═╡ d163328a-74cc-453c-9dbc-ee3b14ced35a
function agregar_ruido_speckle(A, sigma)
    M, N = size(A)  # Obtener las dimensiones de la imagen
    ruido = sigma * randn(M, N)  # Generar ruido normal multiplicativo
    noisy_image = A .* (1 .+ ruido)  # Multiplicar la imagen por el ruido
    
    return noisy_image
end

# ╔═╡ d02b4097-e9be-40f4-a52b-dc54ecd1fb2c
[A agregar_ruido_speckle(A,0.3)]

# ╔═╡ 595f957d-fc0c-4074-ad36-f789c8a3d306
md"""$\texttt{Figura 4. Ruido Speckle aplicado a la Figura 1.}$"""

# ╔═╡ 37bf4529-a387-40b6-9f27-610aa106fd23
begin
	ecm_value_4 = calcular_ecm(A, agregar_ruido_speckle(A,0.3))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_4")
	psnr_value_4 = calcular_psnr(A, agregar_ruido_speckle(A,0.3), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_4 dB")
	ssim_value_4 = calcular_ssim(A, agregar_ruido_speckle(A,0.3))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_4")
	error_relativo_value_4 = calcular_error_relativo(A, agregar_ruido_speckle(A,0.3))
	println("El error relativo es: $error_relativo_value_4%")
end

# ╔═╡ cb8d7d58-d0f8-43ed-a168-a292d7880f6d
md"""#  $\cdot$ Difuminado"""

# ╔═╡ 340808ee-0131-4c33-b17e-2b35067f93ae
md"""
Generalmente preferimos imagenes nitidas a las borrosas. Por ello desarrollamos tecnicas poderosas para agudizar imagenes. No obstante, en algunas ocasiones es necesario tambien hacer que una imagen parezca borrosa para algunas funciones como:

- Proteger la privacidad.
- Crear ilusión de mayor profundidad visual.
- Fotografía artística.
- Resaltar partes de imágenes.

Un método sencillo, y que igual funciona para el difuminado de imágenes, consiste en hallar un nuevo valor para cada pixel tomando el promedio de su valor con el de sus vecinos, por ejemplo, en una malla $3\times 3$, aplicamos sobre una imagen $A$ una transformación que reulta en una imagen $B$ (la versión borrosa de $A$) descrita como

$B\left[i,j\right]=\frac{1}{9}\sum_{k=-1}^{1}\sum_{l=-1}^{1}A\left[i+k,j+l\right]$

A continuación, se aplica difuminado sobre nuestra imagen de ejemplo.
"""

# ╔═╡ cc5d32c4-b124-4a5b-af7f-a69be2c309e1
function imagen_difuminada(A)
    A = Float64.(channelview(A))
    M, N = size(A)
    for m in 2:M-1
        for n in 2:N-1
            A[m, n] = (A[m-1, n-1] + A[m, n-1] + A[m+1, n-1] +
                       A[m-1, n] + A[m, n] + A[m+1, n] +
                       A[m-1, n+1] + A[m, n+1] + A[m+1, n+1]) / 9
        end
    end
	return Gray.(A)
end

# ╔═╡ 4943534b-e2a0-4733-b630-0f743df58f6f
[A imagen_difuminada(A)]

# ╔═╡ 5be15f32-6ae7-4bb0-8c8e-387a353883c8
md"""$\texttt{Figura 5. Difuminado de la Figura 1.}$"""

# ╔═╡ 1be0b4e1-3f70-4e94-9a18-49112d3cd519
begin
	ecm_value_5 = calcular_ecm(A, imagen_difuminada(A))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_5")
	psnr_value_5 = calcular_psnr(A, imagen_difuminada(A), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_5 dB")
	ssim_value_5 = calcular_ssim(A, imagen_difuminada(A))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_5")
	error_relativo_value_5 = calcular_error_relativo(A, imagen_difuminada(A))
	println("El error relativo es: $error_relativo_value_5%")
end

# ╔═╡ 417e745f-6380-472c-bfe2-18bb92f42a5f
md"""
Una de las principales aplicaciones del difuminado de imagenes es la eliminación de ruido. A continuación, intentaremos reducir cada uno de los tres ruidos generados anteriormente con este método "sencillo" e "ingenuo" de promedio sin ponderar.
"""

# ╔═╡ 226c10a9-2cd1-4683-8aff-38db6d54dc72
begin
	A1 = ruido_gaussiano(A,0.2);
	[A1 imagen_difuminada(A1)]
end

# ╔═╡ 7cbb7208-825d-496d-8563-25156f960a9b
md"""$\texttt{Figura 6. Ruido Gaussiano y difuminado de la Figura 1.}$"""

# ╔═╡ 38b90d54-a156-4fa9-b3f3-c8e1dd590840
begin
	ecm_value_6 = calcular_ecm(A, imagen_difuminada(A1))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_6")
	psnr_value_6 = calcular_psnr(A, imagen_difuminada(A1), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_6 dB")
	ssim_value_6 = calcular_ssim(A, imagen_difuminada(A1))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_6")
	error_relativo_value_6 = calcular_error_relativo(A, imagen_difuminada(A1))
	println("El error relativo es: $error_relativo_value_6%")
end

# ╔═╡ 3aa265d0-44d7-4e4b-aae2-b7b9d628d04b
begin
	A2 = sal_y_pimienta(A,0.2);
	[A2 imagen_difuminada(A2)]
end

# ╔═╡ 0b69512a-930d-4393-a6c8-989c82d76213
md"""$\texttt{Figura 7. Ruido sal y pimienta y difuminado de la Figura 1.}$"""

# ╔═╡ 3d7ca8b2-a210-437f-b5ca-87461f2bbfec
begin
	ecm_value_7 = calcular_ecm(A, imagen_difuminada(A2))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_7")
	psnr_value_7 = calcular_psnr(A, imagen_difuminada(A2), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_7 dB")
	ssim_value_7 = calcular_ssim(A, imagen_difuminada(A2))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_7")
	error_relativo_value_7 = calcular_error_relativo(A, imagen_difuminada(A2))
	println("El error relativo es: $error_relativo_value_7%")
end

# ╔═╡ aae5b170-5979-4b32-b92a-f0e5e563aa29
begin
	A3 = agregar_ruido_speckle(A, 0.3);
	[A3 imagen_difuminada(A3)]
end

# ╔═╡ f243f510-74e5-4695-9d23-a3f5fc9db103
md"""$\texttt{Figura 8. Ruido Speckle y difuminado de la Figura 1.}$"""

# ╔═╡ 2172e47f-fa86-42bf-b263-0f9052d12848
begin
	ecm_value_8 = calcular_ecm(A, imagen_difuminada(A3))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_8")
	psnr_value_8 = calcular_psnr(A, imagen_difuminada(A3), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_8 dB")
	ssim_value_8 = calcular_ssim(A, imagen_difuminada(A3))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_8")
	error_relativo_value_8 = calcular_error_relativo(A, imagen_difuminada(A3))
	println("El error relativo es: $error_relativo_value_8%")
end

# ╔═╡ 18db005d-d530-43ca-bc88-d00d0b39d8ca
md"""
Es evidente que los resultados varian dependiendo del tipo de ruido que hay en la imagen. Los reultados son relativamente satisfactorios para la primera y la tercera imagen, aunque se pierden ciertos aspectos de la imagen original. Para la segunda imagen, los resultados no son tan satisfactorios; ello se debe a la tendencia del promedio a verse afectado por los outliers (recuerde que en el ruido sal y pimienta, los pixeles afectados presentan valores extremos). 
"""

# ╔═╡ 28b1d1ac-1610-4a7c-b22d-9e66f1c8756b
md"""##   $\cdot$ Difuminado con pesos"""

# ╔═╡ 092b1c64-fbab-4d3a-afde-9c5220fcddac
md"""
Otro enfoque comúnmente utilizado es realizar un promedio ponderado con pesos sobre la vecindad de los pixeles. La elección de estos pesos puede depender, por ejemplo, de una función. A continuación, la *familia gaussiana de pesos*. Considere la función de densidad de una distribución gaussiana bivariada con variables independientes

$\large g(x, y) = \frac{1}{2\pi \sigma^2} \exp\left(-\frac{x^2 + y^2}{2 \sigma^2}\right)$
"""

# ╔═╡ cdc2a866-d7cc-4044-93b1-14828a18f527
md"""
Si quisiéramos difuminar una imagen con los valores que se presentan en una vecindad de tamaño $3\times 3$ de cada pixel, identificamos el pixel que se quiere transformar con el centro coordenado $x=y=0$, y la vecindad como se presenta a continuación.
"""

# ╔═╡ 410b6e39-bafd-4007-bdf1-29725bab4f62
md"""

$

\begin{array}{|c|c|c|}
\hline \\
\hspace{0.5cm}(1,-1)\hspace{0.5cm} & \hspace{0.5cm}(1,0)\hspace{0.5cm} & \hspace{0.5cm}(1,1)\hspace{0.5cm}  \\ \\
\hline \\
\hspace{0.5cm}(0,-1)\hspace{0.5cm} & \hspace{0.5cm}(0,0)\hspace{0.5cm} & \hspace{0.5cm}(0,1)\hspace{0.5cm} \\ \\ 
\hline \\
\hspace{0.5cm}(-1,-1)\hspace{0.5cm} & \hspace{0.5cm}(-1,0)\hspace{0.5cm} & \hspace{0.5cm}(-1,1)\hspace{0.5cm} \\ \\ 
\hline
\end{array}$
"""


# ╔═╡ cdd2a6f8-8e9f-40c4-90fd-f7f73b8091e3
md"""
Con $\sigma = 1$ evaluamos la funcion $g(x,y)$ en cada elemento de esta vecindad para obtener la matriz de pesos.
"""

# ╔═╡ 4ad86246-2890-43e1-a646-609e95fb47e7
md"""

$\large \begin{bmatrix}0.0585 & 0.0965 & 0.0585 \\
0.0965 & 0.1592 & 0.0965 \\
0.0585 & 0.0965 & 0.0585 \\ \end{bmatrix}$

"""

# ╔═╡ c242c040-224f-4d2f-86a7-7e8bb98c0e7f
md"""
Vemos que $2* 0.0293 \approx 0.0585$, $3*0.0293 = 0.0878 \approx 0.0965$ y $5*0.0293 = 0.1464 \approx 0.1592$. De esta forma, y aproximando de manera conveniente tal que la suma de todas las entradas en la matriz den $1$, obtenemos una matriz aproximada de pesos

$\LARGE \begin{bmatrix}\frac{2}{25} & \frac{3}{25} & \frac{2}{25} \\
\frac{3}{25} & \frac{5}{25} & \frac{3}{25} \\
\frac{2}{25} & \frac{3}{25} & \frac{2}{25} \\ \end{bmatrix}$

En este método, tanto el tamaño de la vecindad como la varianza de la distribución normal puede variar. Ejemplos de la utilización de este procedimiento (con una matriz de pesos $3\times 3$ y $\sigma=1$) se presentan a continuación.
"""

# ╔═╡ eda71d34-810a-4ce1-bc6b-3040651d7ec1
function imagen_difuminada_pesos(A)
    A = Float64.(channelview(A))
    M, N = size(A)
    for m in 2:M-1
        for n in 2:N-1
            A[m, n] = 2/25*A[m-1, n-1] + 3/25*A[m, n-1] + 2/25*A[m+1, n-1] +
                       3/25*A[m-1, n] + 5/25*A[m, n] + 3/25*A[m+1, n] +
                       2/25*A[m-1, n+1] + 3/25*A[m, n+1] + 2/25*A[m+1, n+1]
        end
    end
	return Gray.(A)
end

# ╔═╡ c15788f6-9a9f-49c5-8f3f-3efcb7d5e76c
[A imagen_difuminada(A) imagen_difuminada_pesos(A)]

# ╔═╡ 917525fb-46d8-4f2e-8d8d-ebe9e5fc236b
md"""$\texttt{Figura 9. Difuminado y difuminado con pesos de la Figura 1.}$"""

# ╔═╡ 64ba39ee-22c5-40a0-8bc9-1d03b02045ad
begin
	ecm_value_9= calcular_ecm(A, imagen_difuminada_pesos(A))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_9")
	psnr_value_9 = calcular_psnr(A, imagen_difuminada_pesos(A), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_9 dB")
	ssim_value_9 = calcular_ssim(A, imagen_difuminada_pesos(A))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_9")
	error_relativo_value_9 = calcular_error_relativo(A, imagen_difuminada_pesos(A))
	println("El error relativo es: $error_relativo_value_9%")
end

# ╔═╡ d813e58c-da2e-48d2-b81c-6c508f4d22db
[A1 imagen_difuminada_pesos(A1)]

# ╔═╡ 0d61add3-e1c1-411f-99e0-a1ecdb388796
md"""$\texttt{Figura 10. Ruido Gaussiano y difuminado con pesos de la Figura 1.}$"""

# ╔═╡ 377a2e9a-c0f9-4911-9e47-bb349c6643e7
begin
	ecm_value_10= calcular_ecm(A, imagen_difuminada_pesos(A1))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_10")
	psnr_value_10 = calcular_psnr(A, imagen_difuminada_pesos(A1), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_10 dB")
	ssim_value_10 = calcular_ssim(A, imagen_difuminada_pesos(A1))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_10")
	error_relativo_value_10 = calcular_error_relativo(A, imagen_difuminada_pesos(A1))
	println("El error relativo es: $error_relativo_value_10%")
end

# ╔═╡ 099b256d-ae64-4426-ab9c-166e45ce9cb2
[A2 imagen_difuminada_pesos(A2)]

# ╔═╡ b744eb10-e6a8-48da-929f-77eb90d3872f
md"""$\texttt{Figura 11. Ruido Sal y pimienta y difuminado con pesos de la Figura 1.}$"""

# ╔═╡ faed9cef-bdf6-40c0-b6c6-2930bed33336
begin
	ecm_value_11= calcular_ecm(A, imagen_difuminada_pesos(A2))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_11")
	psnr_value_11 = calcular_psnr(A, imagen_difuminada_pesos(A2), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_11 dB")
	ssim_value_11 = calcular_ssim(A, imagen_difuminada_pesos(A2))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_11")
	error_relativo_value_11 = calcular_error_relativo(A, imagen_difuminada_pesos(A2))
	println("El error relativo es: $error_relativo_value_11%")
end

# ╔═╡ 80df2389-a06f-4be7-b956-6da33b84fb36
[A3 imagen_difuminada_pesos(A3)]

# ╔═╡ 76520537-ffea-4f7f-b787-85b4a4c1a272
md"""$\texttt{Figura 12. Ruido Speckle y difuminado con pesos de la Figura 1.}$"""

# ╔═╡ ae12ef84-be11-4e92-ac19-ec2a8d78276e
begin
	ecm_value_12= calcular_ecm(A, imagen_difuminada_pesos(A3))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_12")
	psnr_value_12 = calcular_psnr(A, imagen_difuminada_pesos(A3), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_12 dB")
	ssim_value_12 = calcular_ssim(A, imagen_difuminada_pesos(A3))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_12")
	error_relativo_value_12 = calcular_error_relativo(A, imagen_difuminada_pesos(A3))
	println("El error relativo es: $error_relativo_value_12%")
end

# ╔═╡ 23dde8c5-ff59-48b7-b608-d48fb45001c1
md"""
Note cómo en la primera imagen también se reduce el ruido y, de cierta manera, aumenta la nitidez ligeralmente. Al procedimiento de reemplazar un pixel de la imagen con un promedio ponderado de su vecindad se le conoce como *convolución*. La matriz de pesos que se utiliza para realizar tal promedio es denominada *filtro* o *matriz de convolución*, y aplicar el procedimiento de *convolución* sobre una imagen con ruido bajo cierto *filtro* es denominado *filtrado*. Por ejemplo, en las anteriores imágenes, hemos aplicado filtrado de las imágenes con distintos ruidos usando los filtros

$\begin{bmatrix}\frac{1}{9} & \frac{1}{9} & \frac{1}{9} \\
\frac{1}{9} & \frac{1}{9} & \frac{1}{9} \\
\frac{1}{9} & \frac{1}{9} & \frac{1}{9} \\ \end{bmatrix} \textup{ y }\begin{bmatrix}\frac{2}{25} & \frac{3}{25} & \frac{2}{25} \\
\frac{3}{25} & \frac{5}{25} & \frac{3}{25} \\
\frac{2}{25} & \frac{3}{25} & \frac{2}{25} \\ \end{bmatrix}$

Al primero se le denomina *difuminado de promedio*, mientras que al segundo procedimiento, con cualquier tamaño de vecindad y cualquier desviación estándar, se le denomina *difuminado gaussiano*.

"""

# ╔═╡ 8bb59b12-5978-4b11-9c56-a2dbcf049f94
md"""
##    $\cdot$ Filtrado de mediana
"""

# ╔═╡ 434a8b4e-42a7-41c2-82a4-2e9ef36164c2
md"""
Un método que suele ser eficiente para reducir el ruido sal y pimienta es el ruido de la mediana. Como se mencionó anteriormente, al ser este un filtro que presenta "outliers", el promedio no parece ser la herramienta más adecuada para la eliminación del ruido, Utilizaremos la mediana. Para ello, transformaremos cada pixel en la mediana de los valores en su vecindad, que, en este ejemplo, tomaremos como $3\times 3$.
"""

# ╔═╡ 53f72643-39db-4202-ae6e-fff79e4539b3
function median_filtering(A)
	A = Float64.(channelview(A))
    M, N = size(A)
	for m in 2:M-1
        for n in 2:N-1
			x=[]
            for i in -1:1
				for j in -1:1
					append!(x,A[m+i,n+j])
				end
			end
			x=sort(x)
			A[m,n]=x[5]
        end
    end
	return Gray.(A)
end

# ╔═╡ fad9d583-58f3-4ec4-b4df-f4fd4d0e48be
[A2 median_filtering(A2)]

# ╔═╡ 6571a585-9fb0-4dcd-abda-63fc32ec8173
md"""$\texttt{Figura 13. Ruido Sal y pimienta y difuminado de mediana de la Figura 1.}$"""

# ╔═╡ 88a0f816-eb54-4d78-acc7-67368fb105a8
begin
	ecm_value_13= calcular_ecm(A, median_filtering(A2))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_13")
	psnr_value_13 = calcular_psnr(A, median_filtering(A2), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_13 dB")
	ssim_value_13 = calcular_ssim(A, median_filtering(A2))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_13")
	error_relativo_value_13 = calcular_error_relativo(A, median_filtering(A2))
	println("El error relativo es: $error_relativo_value_13%")
end

# ╔═╡ edfcd89d-3a7d-4f4e-b6c3-6534bd6854e3
md"""
##    $\cdot$ Filtrado de Variación Total
"""

# ╔═╡ bde84449-68fe-4069-8734-b406e29e2393
md"""
Otra opción es intentar traducir nuestro problema de filtrado en un problema de optimización. A partir de una imagen $B$ con ruido, quisieramos hallar un vector de $A$ que 

- Se parezca lo que más se pueda a la imagen con ruido $B$
- Tenga 'variación total' suave. Es decir, se minimice la diferencia entre los valores de un pixel y aquellos de su vecindad. 

Es decir, quisiéramos resolver el problema 

$\min_{A\in \mathbb{R}^{M\times N}} d(A,B)+\lambda v(A),$

donde $d(\cdot,\cdot)$ es una medida de distancia, $v(A)$ es una medida de la variación entre los pixeles, y $\lambda$ es un parámetro que mide la importancia que le damos a cada uno de estos factores (note que el problema con $\lambda=0$ tiene solución la matriz con ruido). Por ejemplo, podemos considerar el problema

$\min_{A\in \mathbb{R}^{M\times N}} \sum_{i=1}^{N}\sum_{j=1}^{k}(B[i,j]-A[i,j])^2$

$+\lambda \left(\sum_{i=1}^{N-1}\sum_{j=1}^{N-1} \left|A[i,j]-A[i,j+1]\right|+|A[i,j]-A[i+1,j]|\right)$

Se han desarrollado varios métodos que intentan resolver este problema de manera eficiente, incluyendo métodos variacionales que pretenden solucionar el problema variacional equivalente (reducir infinitesimalmente los pixeles de la imagen). No obstante, se escapan del alcance de este cuaderno, e intentaremos resolver este problema mediante optimización numérica.
"""

# ╔═╡ 1e758897-b3f6-4813-812c-70f2ee88a3b8
begin
	function total_var_segment(A,lambda)
		B = Float64.(channelview(A))
	    M, N = size(B)
		tam=M*N
		a=vec(B)
		f(x,_)=sum((a.-x).^2)+lambda*sum((x[i]-x[i-M])^2 for i in M+1:tam) + lambda*sum((x[i]-x[i+1])^2 for i in 2:tam if i%M !=0)
		x0=a
		p=0
		optf = OptimizationFunction(f, AutoZygote())
		prob = OptimizationProblem(optf, x0,p)
		sol=solve(prob, Optimization.LBFGS())
		B=reshape(sol.minimizer, size(A))
		return Gray.(B)
	end

	function total_variation(A,lambda)
		A = Float64.(channelview(A))
	    submatrix_size = 20
	    n, m = size(A)
	    B = copy(A)
	    for i in 1:submatrix_size:n
        	for j in 1:submatrix_size:m
            	fi = min(i + submatrix_size - 1, n)
            	fj = min(j + submatrix_size - 1, m)
            	submatrix = A[i:fi, j:fj]
            	B[i:fi, j:fj] = total_var_segment(submatrix, lambda)
        	end
    	end
	    return Gray.(B)
	end
end

# ╔═╡ fc3bc625-fd58-47a5-9c49-58fbf2b1eab8
begin
	B1 = total_variation(A1,1.5);
	[A1 B1]
end

# ╔═╡ 0550d6c9-a14f-4ec9-a72b-019071b24296
md"""$\texttt{Figura 14. Ruido Gaussiano y filtrado de variación total de la Figura 1.}$"""

# ╔═╡ 176846ab-3e8b-472c-bba0-5eb0477ce633
begin
	ecm_value_14= calcular_ecm(A, B1)
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_14")
	psnr_value_14 = calcular_psnr(A, B1, 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_14 dB")
	ssim_value_14 = calcular_ssim(A, B1)
	println("El índice de similitud estructural (SSIM) es: $ssim_value_14")
	error_relativo_value_14 = calcular_error_relativo(A, B1)
	println("El error relativo es: $error_relativo_value_14%")
end

# ╔═╡ 5a97dbdd-8fa7-4fcc-967c-fa7ef3e99f7d
begin
	B2 = total_variation(A2,1.2);
	[A2 B2]
end

# ╔═╡ 2cc9d721-f3b1-4f15-9a71-a416eba5c768
md"""$\texttt{Figura 15. Ruido sal y pimienta y filtrado de variación total de la Figura 1.}$"""

# ╔═╡ 6c722d39-0ef6-4049-8ab2-ad18d4fec0dd
begin
	ecm_value_15= calcular_ecm(A, B2)
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_15")
	psnr_value_15 = calcular_psnr(A, B2, 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_15 dB")
	ssim_value_15 = calcular_ssim(A, B2)
	println("El índice de similitud estructural (SSIM) es: $ssim_value_15")
	error_relativo_value_15 = calcular_error_relativo(A, B2)
	println("El error relativo es: $error_relativo_value_15%")
end

# ╔═╡ ba8214a4-b75e-4e0d-bd82-e4a57f030d02
begin
	B3 = total_variation(A3,1.5);
	[A3 B3]
end

# ╔═╡ 424797fe-63a2-4db5-ac3c-f2d84d63e36d
md"""$\texttt{Figura 16. Ruido Speckle y filtrado de variación total de la Figura 1.}$"""

# ╔═╡ 7814805b-7852-41d4-a45e-efb0cdc8a744
begin
	ecm_value_16= calcular_ecm(A, B3)
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_16")
	psnr_value_16 = calcular_psnr(A, B3, 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_16 dB")
	ssim_value_16 = calcular_ssim(A, B3)
	println("El índice de similitud estructural (SSIM) es: $ssim_value_16")
	error_relativo_value_16 = calcular_error_relativo(A, B3)
	println("El error relativo es: $error_relativo_value_16%")
end

# ╔═╡ f6304aa9-2385-4ca8-9404-97c371553a2b
md"""
Nótese que un parámetro $\lambda$ muy grande resulta en una imagen excesivamente borrosa, como se muestra a continuación.
"""

# ╔═╡ a175a1c9-32fa-4493-b7cb-4c630d51770d
begin
	B4 = total_variation(A1,3)
	[A1 B4]
end

# ╔═╡ e0b3498e-785f-4dae-9cd4-4cbb860e2444
md"""$\texttt{Figura 17. Ruido Speckle y filtrado de variación total de la Figura 1.}$"""

# ╔═╡ 70ca7df3-80ed-4e4e-8722-3314d69f677a
begin
	ecm_value_17= calcular_ecm(A, B4)
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_17")
	psnr_value_17 = calcular_psnr(A, B4, 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_17 dB")
	ssim_value_17 = calcular_ssim(A, B4)
	println("El índice de similitud estructural (SSIM) es: $ssim_value_17")
	error_relativo_value_17 = calcular_error_relativo(A, B4)
	println("El error relativo es: $error_relativo_value_17%")
end

# ╔═╡ ac4fd8ff-a4cd-4c5d-946c-931af96d540b
md"""##    $\cdot$ Ejemplo
Consideremos la siguiente imagen
"""

# ╔═╡ 05f8d1c7-689d-4267-b266-65571667fe7e
begin
	url1="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqj6eT_zM1XM_oYI9nVOY3lfKD5SKtqrHrjg&s"
	f1name = download(url1)
	T = Gray.(load(f1name));
end

# ╔═╡ b80c933c-82c4-4bcf-a6d6-4be2d8afb98b
md"""$\texttt{Figura 18. Águila. Imagen tomada de Wiki.}$"""

# ╔═╡ a6454a40-9f73-48e7-a83b-be5c6e33f70e
md"""Apliquemos los difuminados y ruidos mostrados anteriormente a la Figura 18.
"""

# ╔═╡ 3a34b778-cbbc-4c7c-adad-bbb2a73c3eb8
[T imagen_difuminada(T)]

# ╔═╡ 826aa656-e203-44bc-afd4-5887945846ac
md"""$\texttt{Figura 19. Difuminado de la Figura 18.}$"""

# ╔═╡ 015c21d7-2f50-4e2a-a13e-733bcaf6988e
begin
	ecm_value_19= calcular_ecm(T, imagen_difuminada(T))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_19")
	psnr_value_19 = calcular_psnr(T, imagen_difuminada(T), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_19 dB")
	ssim_value_19 = calcular_ssim(T,imagen_difuminada(T))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_19")
	error_relativo_value_19 = calcular_error_relativo(T, imagen_difuminada(T))
	println("El error relativo es: $error_relativo_value_19%")
end

# ╔═╡ 2a84219b-8f2e-4934-9831-b1484dec8de9
T1 = ruido_gaussiano(T,0.2);

# ╔═╡ 1a0ad46a-fa61-4191-87cc-f20ed6ba0bc8
T2 = sal_y_pimienta(T,0.1);

# ╔═╡ bf1e0a76-b741-43d4-aa30-6c67d3023062
T3 = agregar_ruido_speckle(T, 0.3);

# ╔═╡ 04778277-36c3-4e5b-b7e4-a2519631fe2a
md"""

Se aplican los distintos filtros presentados para la imagen con ruido.
"""

# ╔═╡ 73112f06-fdb8-4523-8f46-eddf36da04b2
[T1 imagen_difuminada(T1) imagen_difuminada_pesos(T1) median_filtering(T1) total_variation(T1,1)]

# ╔═╡ 948410c0-c1f4-4027-8f92-c21f1ee83a0a
md"""$\texttt{Figura 20. Filtros a la Figura 18.}$"""

# ╔═╡ 69a0f202-c5bf-465e-a48b-6485df8c3d0e
begin
	ecm_value_20= calcular_ecm(T, T1)
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_20")
	psnr_value_20 = calcular_psnr(T, T1, 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_20 dB")
	ssim_value_20 = calcular_ssim(T, T1)
	println("El índice de similitud estructural (SSIM) es: $ssim_value_20")
	error_relativo_value_20 = calcular_error_relativo(T, T1)
	println("El error relativo es: $error_relativo_value_20%")
	println(" ")

	ecm_value_21= calcular_ecm(T, imagen_difuminada(T1))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_21")
	psnr_value_21 = calcular_psnr(T, imagen_difuminada(T1), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_21 dB")
	ssim_value_21 = calcular_ssim(T,imagen_difuminada(T1))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_21")
	error_relativo_value_21 = calcular_error_relativo(T, imagen_difuminada(T1))
	println("El error relativo es: $error_relativo_value_21%")
	println(" ")

	ecm_value_22= calcular_ecm(T, imagen_difuminada_pesos(T1))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_22")
	psnr_value_22 = calcular_psnr(T, imagen_difuminada_pesos(T1), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_22 dB")
	ssim_value_22 = calcular_ssim(T,imagen_difuminada_pesos(T1))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_22")
	error_relativo_value_22 = calcular_error_relativo(T, imagen_difuminada_pesos(T1))
	println("El error relativo es: $error_relativo_value_22%")
	println(" ")

	ecm_value_23= calcular_ecm(T, median_filtering(T1))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_23")
	psnr_value_23 = calcular_psnr(T, median_filtering(T1), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_23 dB")
	ssim_value_23 = calcular_ssim(T, median_filtering(T1))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_23")
	error_relativo_value_23 = calcular_error_relativo(T, median_filtering(T1))
	println("El error relativo es: $error_relativo_value_23%")
	println(" ")

	ecm_value_24= calcular_ecm(T, total_variation(T1,1))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_24")
	psnr_value_24 = calcular_psnr(T, total_variation(T1,1), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_24 dB")
	ssim_value_24 = calcular_ssim(T, total_variation(T1,1))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_24")
	error_relativo_value_24 = calcular_error_relativo(T, total_variation(T1,1))
	println("El error relativo es: $error_relativo_value_24%")
	println(" ")
end

# ╔═╡ 5fed002f-0a43-4fb1-99a4-fb18aa9674ea
[T2 imagen_difuminada(T2) imagen_difuminada_pesos(T2) median_filtering(T2) total_variation(T2,1)]

# ╔═╡ 4b72aa51-730d-4528-947e-88a4f98030e6
md"""$\texttt{Figura 21. Filtros a la Figura 18.}$"""

# ╔═╡ 09fe1505-3a5e-4434-9087-60153cfff655
begin
	ecm_value_20_1= calcular_ecm(T, T2)
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_20_1")
	psnr_value_20_1 = calcular_psnr(T, T2, 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_20_1 dB")
	ssim_value_20_1 = calcular_ssim(T, T2)
	println("El índice de similitud estructural (SSIM) es: $ssim_value_20_1")
	error_relativo_value_20_1 = calcular_error_relativo(T, T2)
	println("El error relativo es: $error_relativo_value_20_1%")
	println(" ")

	ecm_value_21_1= calcular_ecm(T, imagen_difuminada(T2))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_21_1")
	psnr_value_21_1 = calcular_psnr(T, imagen_difuminada(T2), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_21_1 dB")
	ssim_value_21_1 = calcular_ssim(T,imagen_difuminada(T2))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_21_1")
	error_relativo_value_21_1 = calcular_error_relativo(T, imagen_difuminada(T2))
	println("El error relativo es: $error_relativo_value_21_1%")
	println(" ")

	ecm_value_22_1= calcular_ecm(T, imagen_difuminada_pesos(T2))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_22_1")
	psnr_value_22_1 = calcular_psnr(T, imagen_difuminada_pesos(T2), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_22_1 dB")
	ssim_value_22_1 = calcular_ssim(T,imagen_difuminada_pesos(T2))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_22_1")
	error_relativo_value_22_1 = calcular_error_relativo(T, imagen_difuminada_pesos(T2))
	println("El error relativo es: $error_relativo_value_22_1%")
	println(" ")

	ecm_value_23_1= calcular_ecm(T, median_filtering(T2))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_23_1")
	psnr_value_23_1 = calcular_psnr(T, median_filtering(T2), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_23_1 dB")
	ssim_value_23_1 = calcular_ssim(T, median_filtering(T2))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_23_1")
	error_relativo_value_23_1 = calcular_error_relativo(T, median_filtering(T2))
	println("El error relativo es: $error_relativo_value_23_1%")
	println(" ")

	ecm_value_24_1= calcular_ecm(T, total_variation(T2,1))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_24_1")
	psnr_value_24_1 = calcular_psnr(T, total_variation(T2,1), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_24_1 dB")
	ssim_value_24_1 = calcular_ssim(T, total_variation(T2,1))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_24_1")
	error_relativo_value_24_1 = calcular_error_relativo(T, total_variation(T2,1))
	println("El error relativo es: $error_relativo_value_24_1%")
	println(" ")
end

# ╔═╡ 490055bf-cf98-4e51-81ea-822c8db1a9ce
[T3 imagen_difuminada(T3) imagen_difuminada_pesos(T3) median_filtering(T3) total_variation(T3,1)]

# ╔═╡ a83c53c1-dcc7-404d-98eb-ed5827c70c91
md"""$\texttt{Figura 22. Filtros a la Figura 18.}$"""

# ╔═╡ d701b871-bebb-4825-b2b8-6bc4466bf661
begin
	ecm_value_20_2= calcular_ecm(T, T3)
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_20_2")
	psnr_value_20_2 = calcular_psnr(T, T3, 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_20_2 dB")
	ssim_value_20_2 = calcular_ssim(T, T3)
	println("El índice de similitud estructural (SSIM) es: $ssim_value_20_2")
	error_relativo_value_20_2 = calcular_error_relativo(T, T3)
	println("El error relativo es: $error_relativo_value_20_2%")
	println(" ")

	ecm_value_21_2= calcular_ecm(T, imagen_difuminada(T3))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_21_2")
	psnr_value_21_2 = calcular_psnr(T, imagen_difuminada(T3), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_21_2 dB")
	ssim_value_21_2 = calcular_ssim(T,imagen_difuminada(T3))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_21_2")
	error_relativo_value_21_2 = calcular_error_relativo(T, imagen_difuminada(T3))
	println("El error relativo es: $error_relativo_value_21_2%")
	println(" ")

	ecm_value_22_2= calcular_ecm(T, imagen_difuminada_pesos(T3))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_22_2")
	psnr_value_22_2 = calcular_psnr(T, imagen_difuminada_pesos(T3), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_22_2 dB")
	ssim_value_22_2 = calcular_ssim(T,imagen_difuminada_pesos(T3))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_22_2")
	error_relativo_value_22_2 = calcular_error_relativo(T, imagen_difuminada_pesos(T3))
	println("El error relativo es: $error_relativo_value_22_2%")
	println(" ")

	ecm_value_23_2= calcular_ecm(T, median_filtering(T3))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_23_2")
	psnr_value_23_2 = calcular_psnr(T, median_filtering(T3), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_23_2 dB")
	ssim_value_23_2 = calcular_ssim(T, median_filtering(T3))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_23_2")
	error_relativo_value_23_2 = calcular_error_relativo(T, median_filtering(T3))
	println("El error relativo es: $error_relativo_value_23_2%")
	println(" ")

	ecm_value_24_2= calcular_ecm(T, total_variation(T3,1))
	println("El Error Cuadrático Medio (ECM) es: $ecm_value_24_2")
	psnr_value_24_2 = calcular_psnr(T, total_variation(T3,1), 1.0)
	println("La Relación Señal-Ruido Máxima (PSNR) es: $psnr_value_24_2 dB")
	ssim_value_24_2 = calcular_ssim(T, total_variation(T3,1))
	println("El índice de similitud estructural (SSIM) es: $ssim_value_24_2")
	error_relativo_value_24_2 = calcular_error_relativo(T, total_variation(T3,1))
	println("El error relativo es: $error_relativo_value_24_2%")
	println(" ")
end

# ╔═╡ 3f3147c9-4de4-414b-9840-728aac57a86b
md"""
# Referencias
[1] Galperin, Y. V. (2020). An image processing tour of college mathematics. Chapman & Hall/CRC Press.

[2] JuliaImages. (s.f.). JuliaImages Documentation. Recuperado de [https://juliaimages.org/stable/](https://juliaimages.org/stable/).

[3] McAndrew, A. (2015). A computational introduction to digital image processing. CRC Press.

[4] JuliaImages. (s.f.). TestImages: Image data for Julia. Recuperado de [https://testimages.juliaimages.org/stable/](https://testimages.juliaimages.org/stable/)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ColorVectorSpace = "c3611d14-8923-5661-9e6a-0046d554d3a4"
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
ImageIO = "82e4d734-157c-48bb-816b-45c225c6df19"
ImageShow = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Optimization = "7f7a1694-90dd-40f0-9382-eb1efda571ba"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[compat]
ColorVectorSpace = "~0.10.0"
Colors = "~0.12.11"
Distributions = "~0.25.113"
FileIO = "~1.16.6"
HypertextLiteral = "~0.9.5"
ImageIO = "~0.6.9"
ImageShow = "~0.3.8"
Images = "~0.26.1"
Optimization = "~4.0.5"
PlutoUI = "~0.7.60"
StatsBase = "~0.34.3"
Zygote = "~0.6.73"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "f839e9885779ab5c0811005d0003bf080b610a9c"

[[deps.ADTypes]]
git-tree-sha1 = "e2478490447631aedba0823d4d7a80b2cc8cdb32"
uuid = "47edcb42-4c32-4615-8424-f2b9edc5f35b"
version = "1.14.0"

    [deps.ADTypes.extensions]
    ADTypesChainRulesCoreExt = "ChainRulesCore"
    ADTypesConstructionBaseExt = "ConstructionBase"
    ADTypesEnzymeCoreExt = "EnzymeCore"

    [deps.ADTypes.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"

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

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.Accessors]]
deps = ["CompositionsBase", "ConstructionBase", "Dates", "InverseFunctions", "MacroTools"]
git-tree-sha1 = "3b86719127f50670efe356bc11073d84b4ed7a5d"
uuid = "7d9f7c33-5ae7-4f3b-8dc6-eff91059b697"
version = "0.1.42"

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

[[deps.Atomix]]
deps = ["UnsafeAtomics"]
git-tree-sha1 = "b5bb4dc6248fde467be2a863eb8452993e74d402"
uuid = "a9b6321e-bd34-4604-b9c9-b65b8de01458"
version = "1.1.1"

    [deps.Atomix.extensions]
    AtomixCUDAExt = "CUDA"
    AtomixMetalExt = "Metal"
    AtomixOpenCLExt = "OpenCL"
    AtomixoneAPIExt = "oneAPI"

    [deps.Atomix.weakdeps]
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    Metal = "dde4c033-4e86-420c-a63e-0dd931031962"
    OpenCL = "08131aa3-fb12-5dee-8b74-c09406e224a2"
    oneAPI = "8f75cd03-7ff8-4ecb-9b8f-daf728133b1b"

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

[[deps.BitTwiddlingConvenienceFunctions]]
deps = ["Static"]
git-tree-sha1 = "f21cfd4950cb9f0587d5067e69405ad2acd27b87"
uuid = "62783981-4cbd-42fc-bca8-16325de8dc4b"
version = "0.1.6"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CPUSummary]]
deps = ["CpuId", "IfElse", "PrecompileTools", "Static"]
git-tree-sha1 = "5a97e67919535d6841172016c9530fd69494e5ec"
uuid = "2a0fbf3d-bb9c-48f3-b0a9-814d99fd7ab9"
version = "0.2.6"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRules]]
deps = ["Adapt", "ChainRulesCore", "Compat", "Distributed", "GPUArraysCore", "IrrationalConstants", "LinearAlgebra", "Random", "RealDot", "SparseArrays", "SparseInverseSubset", "Statistics", "StructArrays", "SuiteSparse"]
git-tree-sha1 = "a975ae558af61a2a48720a6271661bf2621e0f4e"
uuid = "082447d4-558c-5d27-93f4-14fc19e9eca2"
version = "1.72.3"

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

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "403f2d8e209681fcbd9468a8514efff3ea08452e"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.29.0"

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
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "362a287c3aa50601b0bc359053d5c2468f0e7ce0"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.11"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

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

[[deps.CompositionsBase]]
git-tree-sha1 = "802bb88cd69dfd1509f6670416bd4434015693ad"
uuid = "a33af91c-f02d-484b-be07-31d278c5ca2b"
version = "0.1.2"
weakdeps = ["InverseFunctions"]

    [deps.CompositionsBase.extensions]
    CompositionsBaseInverseFunctionsExt = "InverseFunctions"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.ConsoleProgressMonitor]]
deps = ["Logging", "ProgressMeter"]
git-tree-sha1 = "3ab7b2136722890b9af903859afcf457fa3059e8"
uuid = "88cd18e8-d9cc-4ea6-8889-5259c0d15c8b"
version = "0.1.2"

[[deps.ConstructionBase]]
git-tree-sha1 = "76219f1ed5771adbb096743bff43fb5fdd4c1157"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.8"
weakdeps = ["IntervalSets", "LinearAlgebra", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

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

[[deps.DifferentiationInterface]]
deps = ["ADTypes", "LinearAlgebra"]
git-tree-sha1 = "70e500f6d5d50091d87859251de7b8cd060c1cce"
uuid = "a0c0ee7d-e4b9-4e03-894e-1c5f64a51d63"
version = "0.6.50"

    [deps.DifferentiationInterface.extensions]
    DifferentiationInterfaceChainRulesCoreExt = "ChainRulesCore"
    DifferentiationInterfaceDiffractorExt = "Diffractor"
    DifferentiationInterfaceEnzymeExt = ["EnzymeCore", "Enzyme"]
    DifferentiationInterfaceFastDifferentiationExt = "FastDifferentiation"
    DifferentiationInterfaceFiniteDiffExt = "FiniteDiff"
    DifferentiationInterfaceFiniteDifferencesExt = "FiniteDifferences"
    DifferentiationInterfaceForwardDiffExt = ["ForwardDiff", "DiffResults"]
    DifferentiationInterfaceGTPSAExt = "GTPSA"
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
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DiffResults = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
    Diffractor = "9f5e2b26-1114-432f-b630-d3fe2085c51c"
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"
    FastDifferentiation = "eb9bf01b-bf85-4b60-bf87-ee5de06c00be"
    FiniteDiff = "6a86dc24-6348-571c-b903-95158fe2bd41"
    FiniteDifferences = "26cc04aa-876d-5657-8c51-4c34ba976000"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    GTPSA = "b27dd330-f138-47c5-815b-40db9dd9b6e8"
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

[[deps.EnumX]]
git-tree-sha1 = "bddad79635af6aec424f53ed8aad5d7555dc6f00"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.5"

[[deps.ExprTools]]
git-tree-sha1 = "27415f162e6028e81c72b82ef756bf321213b6ec"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.10"

[[deps.ExproniconLite]]
git-tree-sha1 = "c13f0b150373771b0fdc1713c97860f8df12e6c2"
uuid = "55351af7-c7e9-48d6-89ff-24e801d99491"
version = "0.10.14"

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

[[deps.FastClosures]]
git-tree-sha1 = "acebe244d53ee1b461970f8910c235b259e772ef"
uuid = "9aa1b823-49e4-5ca5-8b0f-3971ec8bab6a"
version = "0.3.2"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "2dd20384bf8c6d411b5c7370865b1e9b26cb2ea3"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.6"

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

    [deps.FileIO.weakdeps]
    HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"

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

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "a2df1b776752e3f344e5116c06d75a10436ab853"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.38"
weakdeps = ["StaticArrays"]

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

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

[[deps.GPUArrays]]
deps = ["Adapt", "GPUArraysCore", "KernelAbstractions", "LLVM", "LinearAlgebra", "Printf", "Random", "Reexport", "ScopedValues", "Serialization", "Statistics"]
git-tree-sha1 = "eea7b3a1964b4de269bb380462a9da604be7fcdb"
uuid = "0c68f7d7-f131-5f86-a1c3-88cf8149b2d7"
version = "11.2.2"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "83cf05ab16a73219e5f6bd1bdfa9848fa24ac627"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.2.0"

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

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "a641238db938fff9b2f60d08ed9030387daf428c"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.3"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "3169fd3440a02f35e549728b0890904cfd4ae58a"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.12.1"

[[deps.HashArrayMappedTries]]
git-tree-sha1 = "2eaa69a7cab70a52b9687c8bf950a5a93ec895ae"
uuid = "076d061b-32b6-4027-95e0-9a2c6f6d7e74"
version = "0.2.0"

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

[[deps.IRTools]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "950c3717af761bc3ff906c2e8e52bd83390b6ec2"
uuid = "7869d1d1-7146-5819-86e3-90919afe41df"
version = "0.4.14"

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

    [deps.Interpolations.extensions]
    InterpolationsUnitfulExt = "Unitful"

    [deps.Interpolations.weakdeps]
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.InverseFunctions]]
git-tree-sha1 = "a779299d77cd080bf77b97535acecd73e1c5e5cb"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.17"
weakdeps = ["Dates", "Test"]

    [deps.InverseFunctions.extensions]
    InverseFunctionsDatesExt = "Dates"
    InverseFunctionsTestExt = "Test"

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

[[deps.Jieko]]
deps = ["ExproniconLite"]
git-tree-sha1 = "2f05ed29618da60c06a87e9c033982d4f71d0b6c"
uuid = "ae98c720-c025-4a4a-838c-29b094483192"
version = "0.2.1"

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

[[deps.KernelAbstractions]]
deps = ["Adapt", "Atomix", "InteractiveUtils", "MacroTools", "PrecompileTools", "Requires", "StaticArrays", "UUIDs"]
git-tree-sha1 = "80d268b2f4e396edc5ea004d1e0f569231c71e9e"
uuid = "63c18a36-062a-441e-b654-da1e3ab1ce7c"
version = "0.9.34"

    [deps.KernelAbstractions.extensions]
    EnzymeExt = "EnzymeCore"
    LinearAlgebraExt = "LinearAlgebra"
    SparseArraysExt = "SparseArrays"

    [deps.KernelAbstractions.weakdeps]
    EnzymeCore = "f151be2c-9106-41f4-ab19-57ee4f262869"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.LBFGSB]]
deps = ["L_BFGS_B_jll"]
git-tree-sha1 = "e2e6f53ee20605d0ea2be473480b7480bd5091b5"
uuid = "5be7bae1-8223-5378-bac3-9e7378a2f6e6"
version = "0.4.1"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVM]]
deps = ["CEnum", "LLVMExtra_jll", "Libdl", "Preferences", "Printf", "Unicode"]
git-tree-sha1 = "5fcfea6df2ff3e4da708a40c969c3812162346df"
uuid = "929cbde3-209d-540e-8aea-75f648917ca0"
version = "9.2.0"

    [deps.LLVM.extensions]
    BFloat16sExt = "BFloat16s"

    [deps.LLVM.weakdeps]
    BFloat16s = "ab4f0b2a-ad5b-11e8-123f-65d77653426b"

[[deps.LLVMExtra_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl", "TOML"]
git-tree-sha1 = "4b5ad6a4ffa91a00050a964492bc4f86bb48cea0"
uuid = "dad2f222-ce93-54a1-a47d-0025e8a3acab"
version = "0.0.35+0"

[[deps.L_BFGS_B_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "77feda930ed3f04b2b0fbb5bea89e69d3677c6b0"
uuid = "81d17ec3-03a1-5e46-b53e-bddc35a13473"
version = "3.0.1+0"

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

[[deps.LeftChildRightSiblingTrees]]
deps = ["AbstractTrees"]
git-tree-sha1 = "fb6803dafae4a5d62ea5cab204b1e657d9737e7f"
uuid = "1d6d02ad-be62-4b6b-8a6d-2f90e265016e"
version = "0.2.0"

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

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

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
weakdeps = ["ChainRulesCore", "ForwardDiff", "SpecialFunctions"]

    [deps.LoopVectorization.extensions]
    ForwardDiffExt = ["ChainRulesCore", "ForwardDiff"]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

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

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

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

[[deps.Moshi]]
deps = ["ExproniconLite", "Jieko"]
git-tree-sha1 = "453de0fc2be3d11b9b93ca4d0fddd91196dcf1ed"
uuid = "2e0e35c7-a2e4-4343-998d-7ef72827ed2d"
version = "0.3.5"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

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

[[deps.OffsetArrays]]
git-tree-sha1 = "a414039192a155fb38c4599a60110f0018c6ec82"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.16.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

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

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.Optimization]]
deps = ["ADTypes", "ArrayInterface", "ConsoleProgressMonitor", "DocStringExtensions", "LBFGSB", "LinearAlgebra", "Logging", "LoggingExtras", "OptimizationBase", "Printf", "ProgressLogging", "Reexport", "SciMLBase", "SparseArrays", "TerminalLoggers"]
git-tree-sha1 = "4b59eef21418fbdf28afbe2d7e945d8efbe5057d"
uuid = "7f7a1694-90dd-40f0-9382-eb1efda571ba"
version = "4.0.5"

[[deps.OptimizationBase]]
deps = ["ADTypes", "ArrayInterface", "DifferentiationInterface", "DocStringExtensions", "FastClosures", "LinearAlgebra", "PDMats", "Reexport", "Requires", "SciMLBase", "SparseArrays", "SparseConnectivityTracer", "SparseMatrixColorings"]
git-tree-sha1 = "070d2c33da5f0b33d57b61f7f601c4ea6185af15"
uuid = "bca83a33-5cc9-4baa-983d-23429ab6bcbb"
version = "2.5.0"

    [deps.OptimizationBase.extensions]
    OptimizationEnzymeExt = "Enzyme"
    OptimizationFiniteDiffExt = "FiniteDiff"
    OptimizationForwardDiffExt = "ForwardDiff"
    OptimizationMLDataDevicesExt = "MLDataDevices"
    OptimizationMLUtilsExt = "MLUtils"
    OptimizationMTKExt = "ModelingToolkit"
    OptimizationReverseDiffExt = "ReverseDiff"
    OptimizationSymbolicAnalysisExt = "SymbolicAnalysis"
    OptimizationZygoteExt = "Zygote"

    [deps.OptimizationBase.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"
    FiniteDiff = "6a86dc24-6348-571c-b903-95158fe2bd41"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    MLDataDevices = "7e8f7934-dd98-4c1a-8fe8-92b47a384d40"
    MLUtils = "f1d291b0-491e-4a28-83b9-f70985020b54"
    ModelingToolkit = "961ee093-0014-501f-94e3-6117800e7a78"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SymbolicAnalysis = "4297ee4d-0239-47d8-ba5d-195ecdf594fe"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.OrderedCollections]]
git-tree-sha1 = "cc4054e898b852042d7b503313f7ad03de99c3dd"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.0"

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

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "d3de2694b52a01ce61a036f18ea9c0f61c4a9230"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.62"

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

[[deps.ProgressLogging]]
deps = ["Logging", "SHA", "UUIDs"]
git-tree-sha1 = "80d919dee55b9c50e8d9e2da5eeafff3fe58b539"
uuid = "33c8b6b6-d38a-422a-b730-caa89a2f386c"
version = "0.1.4"

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

[[deps.RecursiveArrayTools]]
deps = ["Adapt", "ArrayInterface", "DocStringExtensions", "GPUArraysCore", "IteratorInterfaceExtensions", "LinearAlgebra", "RecipesBase", "StaticArraysCore", "Statistics", "SymbolicIndexingInterface", "Tables"]
git-tree-sha1 = "112c876cee36a5784df19098b55db2b238afc36a"
uuid = "731186ca-8d62-57ce-b412-fbd966d074cd"
version = "3.31.2"

    [deps.RecursiveArrayTools.extensions]
    RecursiveArrayToolsFastBroadcastExt = "FastBroadcast"
    RecursiveArrayToolsForwardDiffExt = "ForwardDiff"
    RecursiveArrayToolsMeasurementsExt = "Measurements"
    RecursiveArrayToolsMonteCarloMeasurementsExt = "MonteCarloMeasurements"
    RecursiveArrayToolsReverseDiffExt = ["ReverseDiff", "Zygote"]
    RecursiveArrayToolsSparseArraysExt = ["SparseArrays"]
    RecursiveArrayToolsStructArraysExt = "StructArrays"
    RecursiveArrayToolsTrackerExt = "Tracker"
    RecursiveArrayToolsZygoteExt = "Zygote"

    [deps.RecursiveArrayTools.weakdeps]
    FastBroadcast = "7034ab61-46d4-4ed7-9d0f-46aef9175898"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    MonteCarloMeasurements = "0987c9cc-fe09-11e8-30f0-b96dd679fdca"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

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

[[deps.RuntimeGeneratedFunctions]]
deps = ["ExprTools", "SHA", "Serialization"]
git-tree-sha1 = "04c968137612c4a5629fa531334bb81ad5680f00"
uuid = "7e49a35a-f44a-4d26-94aa-eba1b4ca6b47"
version = "0.5.13"

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

[[deps.SciMLBase]]
deps = ["ADTypes", "Accessors", "ArrayInterface", "CommonSolve", "ConstructionBase", "Distributed", "DocStringExtensions", "EnumX", "FunctionWrappersWrappers", "IteratorInterfaceExtensions", "LinearAlgebra", "Logging", "Markdown", "Moshi", "PrecompileTools", "Preferences", "Printf", "RecipesBase", "RecursiveArrayTools", "Reexport", "RuntimeGeneratedFunctions", "SciMLOperators", "SciMLStructures", "StaticArraysCore", "Statistics", "SymbolicIndexingInterface"]
git-tree-sha1 = "6f3987e7fed3239d06985a4752670ca5ff25c695"
uuid = "0bca4576-84f4-4d90-8ffe-ffa030f20462"
version = "2.82.0"

    [deps.SciMLBase.extensions]
    SciMLBaseChainRulesCoreExt = "ChainRulesCore"
    SciMLBaseMLStyleExt = "MLStyle"
    SciMLBaseMakieExt = "Makie"
    SciMLBasePartialFunctionsExt = "PartialFunctions"
    SciMLBasePyCallExt = "PyCall"
    SciMLBasePythonCallExt = "PythonCall"
    SciMLBaseRCallExt = "RCall"
    SciMLBaseZygoteExt = ["Zygote", "ChainRulesCore"]

    [deps.SciMLBase.weakdeps]
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    MLStyle = "d8e11817-5142-5d16-987a-aa16d5891078"
    Makie = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
    PartialFunctions = "570af359-4316-4cb7-8c74-252c00c2016b"
    PyCall = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
    PythonCall = "6099a3de-0909-46bc-b1f4-468b9a2dfc0d"
    RCall = "6f49c342-dc21-5d91-9882-a32aef131414"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.SciMLOperators]]
deps = ["Accessors", "ArrayInterface", "DocStringExtensions", "LinearAlgebra", "MacroTools"]
git-tree-sha1 = "1c4b7f6c3e14e6de0af66e66b86d525cae10ecb4"
uuid = "c0aeaf25-5076-4817-a8d5-81caf7dfa961"
version = "0.3.13"
weakdeps = ["SparseArrays", "StaticArraysCore"]

    [deps.SciMLOperators.extensions]
    SciMLOperatorsSparseArraysExt = "SparseArrays"
    SciMLOperatorsStaticArraysCoreExt = "StaticArraysCore"

[[deps.SciMLStructures]]
deps = ["ArrayInterface"]
git-tree-sha1 = "566c4ed301ccb2a44cbd5a27da5f885e0ed1d5df"
uuid = "53ae85a6-f571-4167-b2af-e1d143709226"
version = "1.7.0"

[[deps.ScopedValues]]
deps = ["HashArrayMappedTries", "Logging"]
git-tree-sha1 = "1147f140b4c8ddab224c94efa9569fc23d63ab44"
uuid = "7e506255-f358-4e82-b7e4-beb19740aa63"
version = "1.3.0"

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

[[deps.SparseConnectivityTracer]]
deps = ["ADTypes", "DocStringExtensions", "FillArrays", "LinearAlgebra", "Random", "SparseArrays"]
git-tree-sha1 = "9603842a7a68464a066b5754e89fc7f810db8ae7"
uuid = "9f842d2f-2579-4b1d-911e-f412cf18a3f5"
version = "0.6.15"

    [deps.SparseConnectivityTracer.extensions]
    SparseConnectivityTracerDataInterpolationsExt = "DataInterpolations"
    SparseConnectivityTracerLogExpFunctionsExt = "LogExpFunctions"
    SparseConnectivityTracerNNlibExt = "NNlib"
    SparseConnectivityTracerNaNMathExt = "NaNMath"
    SparseConnectivityTracerSpecialFunctionsExt = "SpecialFunctions"

    [deps.SparseConnectivityTracer.weakdeps]
    DataInterpolations = "82cc6244-b520-54b8-b5a6-8a565e85f1d0"
    LogExpFunctions = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
    NNlib = "872c559c-99b0-510c-b3b7-b6c96a88d5cd"
    NaNMath = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.SparseInverseSubset]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "52962839426b75b3021296f7df242e40ecfc0852"
uuid = "dc90abb0-5640-4711-901d-7e5b23a2fada"
version = "0.1.2"

[[deps.SparseMatrixColorings]]
deps = ["ADTypes", "DocStringExtensions", "LinearAlgebra", "Random", "SparseArrays"]
git-tree-sha1 = "d59566cf03c67733edce6d80e0fb17e183ab31ba"
uuid = "0a514795-09f3-496d-8182-132a7b665d35"
version = "0.4.16"

    [deps.SparseMatrixColorings.extensions]
    SparseMatrixColoringsCliqueTreesExt = "CliqueTrees"
    SparseMatrixColoringsColorsExt = "Colors"

    [deps.SparseMatrixColorings.weakdeps]
    CliqueTrees = "60701a23-6482-424a-84db-faee86b9b1f8"
    Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "64cca0c26b4f31ba18f13f6c12af7c85f478cfde"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.5.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

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
weakdeps = ["ChainRulesCore", "InverseFunctions"]

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

[[deps.StructArrays]]
deps = ["ConstructionBase", "DataAPI", "Tables"]
git-tree-sha1 = "8ad2e38cbb812e29348719cc63580ec1dfeb9de4"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.7.1"
weakdeps = ["Adapt", "GPUArraysCore", "KernelAbstractions", "LinearAlgebra", "SparseArrays", "StaticArrays"]

    [deps.StructArrays.extensions]
    StructArraysAdaptExt = "Adapt"
    StructArraysGPUArraysCoreExt = ["GPUArraysCore", "KernelAbstractions"]
    StructArraysLinearAlgebraExt = "LinearAlgebra"
    StructArraysSparseArraysExt = "SparseArrays"
    StructArraysStaticArraysExt = "StaticArrays"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.SymbolicIndexingInterface]]
deps = ["Accessors", "ArrayInterface", "RuntimeGeneratedFunctions", "StaticArraysCore"]
git-tree-sha1 = "d6c04e26aa1c8f7d144e1a8c47f1c73d3013e289"
uuid = "2efcf032-c050-4f8e-a9bb-153293bab1f5"
version = "0.3.38"

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

[[deps.TerminalLoggers]]
deps = ["LeftChildRightSiblingTrees", "Logging", "Markdown", "Printf", "ProgressLogging", "UUIDs"]
git-tree-sha1 = "f133fab380933d042f6796eda4e130272ba520ca"
uuid = "5d786b92-1e48-4d6f-9151-6b4477ca9bed"
version = "0.1.7"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

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

[[deps.UnsafeAtomics]]
git-tree-sha1 = "b13c4edda90890e5b04ba24e20a310fbe6f249ff"
uuid = "013be700-e6cd-48c3-b4a1-df204f14c38f"
version = "0.3.0"
weakdeps = ["LLVM"]

    [deps.UnsafeAtomics.extensions]
    UnsafeAtomicsLLVM = ["LLVM"]

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "4ab62a49f1d8d9548a1c8d1a75e5f55cf196f64e"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.71"

[[deps.WebP]]
deps = ["CEnum", "ColorTypes", "FileIO", "FixedPointNumbers", "ImageCore", "libwebp_jll"]
git-tree-sha1 = "aa1ca3c47f119fbdae8770c29820e5e6119b83f2"
uuid = "e3aaa7dc-3e4b-44e0-be63-ffb868ccd7c1"
version = "0.1.3"

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

[[deps.Zygote]]
deps = ["AbstractFFTs", "ChainRules", "ChainRulesCore", "DiffRules", "Distributed", "FillArrays", "ForwardDiff", "GPUArrays", "GPUArraysCore", "IRTools", "InteractiveUtils", "LinearAlgebra", "LogExpFunctions", "MacroTools", "NaNMath", "PrecompileTools", "Random", "Requires", "SparseArrays", "SpecialFunctions", "Statistics", "ZygoteRules"]
git-tree-sha1 = "3c73ed65f928f8602e9a30e93125b209133498a9"
uuid = "e88e6eb3-aa80-5325-afca-941959d7151f"
version = "0.6.76"

    [deps.Zygote.extensions]
    ZygoteColorsExt = "Colors"
    ZygoteDistancesExt = "Distances"
    ZygoteTrackerExt = "Tracker"

    [deps.Zygote.weakdeps]
    Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
    Distances = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.ZygoteRules]]
deps = ["ChainRulesCore", "MacroTools"]
git-tree-sha1 = "434b3de333c75fc446aa0d19fc394edafd07ab08"
uuid = "700de1a5-db45-46bc-99cf-38207098b444"
version = "0.2.7"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

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
"""

# ╔═╡ Cell order:
# ╟─d3ebf255-4c5e-4ec0-bfcb-0b376dd66bf3
# ╟─bbcb1878-9890-41df-9433-2e893674376c
# ╟─e73fc4a9-e3f3-460e-b127-d4803bfeee03
# ╟─8bc9f871-44df-4756-8e7e-c93bc4bc91f6
# ╟─617f2cb2-647e-4172-b3fc-be9b28f5df96
# ╠═402b40b3-ad31-4561-8880-adb973772f32
# ╟─76fafd3b-daa6-4bd3-a317-2ce3d6becc60
# ╠═2ce1a017-29b1-416e-abf8-c4b4d515d5f8
# ╠═777189b5-933f-4eec-a88b-5ac34b7cb23d
# ╠═467e25fd-7e29-4698-837a-41c619c90b42
# ╠═7f9ed75e-b606-4c1f-811b-137127fed66f
# ╟─6c455d3d-f1e5-4c40-8724-a18d30166f36
# ╟─899b6b24-4e39-491c-b4b2-b4484cb5e2d4
# ╟─8593931b-f918-4395-a600-ef51e151dd32
# ╟─3cda7462-9628-4006-b39d-f1cfbf61713e
# ╟─4c606d57-c4a8-465b-a043-f89ee4f491b7
# ╟─f4151cb3-8097-4da0-9f2d-a52118e23e37
# ╟─f2b3bbd9-2bd6-4d48-86db-93fbf736a20c
# ╟─41fa8758-47ef-400a-97dd-2e45fda34391
# ╟─01e29349-8d35-4f44-b9a4-0f9632269b62
# ╟─0d8d6355-460e-404d-b6ce-713c0c6ed713
# ╠═9afafb0f-ac0b-470b-aab3-b41e0a0dc0f3
# ╠═11076927-b844-4261-8069-6e183f60844c
# ╟─1e797582-dfd6-4cb4-bc86-4bd1b5fb3c75
# ╟─4629da30-05ff-4b00-a662-d9acf4f51540
# ╟─7f82bbae-a8ae-46a8-8fc3-92dd23079590
# ╟─54390a0b-7335-4437-8e48-ee3391ca15b4
# ╠═de95337f-073d-4cab-ad17-ac8e90192de4
# ╟─1beec73a-f89d-4c68-9642-887a064e983a
# ╟─32a9b1f6-504e-41c5-8675-ee9b4e5641b9
# ╟─28f5f7b1-fff2-46df-850a-759f2b06ca5e
# ╟─b8b84a35-4b7d-47be-ac66-0b2d490d5b65
# ╟─3dfcbe46-a26a-484e-ad2d-f25dca23716b
# ╠═d163328a-74cc-453c-9dbc-ee3b14ced35a
# ╟─d02b4097-e9be-40f4-a52b-dc54ecd1fb2c
# ╟─595f957d-fc0c-4074-ad36-f789c8a3d306
# ╟─37bf4529-a387-40b6-9f27-610aa106fd23
# ╟─cb8d7d58-d0f8-43ed-a168-a292d7880f6d
# ╟─340808ee-0131-4c33-b17e-2b35067f93ae
# ╠═cc5d32c4-b124-4a5b-af7f-a69be2c309e1
# ╟─4943534b-e2a0-4733-b630-0f743df58f6f
# ╟─5be15f32-6ae7-4bb0-8c8e-387a353883c8
# ╟─1be0b4e1-3f70-4e94-9a18-49112d3cd519
# ╟─417e745f-6380-472c-bfe2-18bb92f42a5f
# ╟─226c10a9-2cd1-4683-8aff-38db6d54dc72
# ╟─7cbb7208-825d-496d-8563-25156f960a9b
# ╟─38b90d54-a156-4fa9-b3f3-c8e1dd590840
# ╟─3aa265d0-44d7-4e4b-aae2-b7b9d628d04b
# ╟─0b69512a-930d-4393-a6c8-989c82d76213
# ╟─3d7ca8b2-a210-437f-b5ca-87461f2bbfec
# ╟─aae5b170-5979-4b32-b92a-f0e5e563aa29
# ╟─f243f510-74e5-4695-9d23-a3f5fc9db103
# ╟─2172e47f-fa86-42bf-b263-0f9052d12848
# ╟─18db005d-d530-43ca-bc88-d00d0b39d8ca
# ╟─28b1d1ac-1610-4a7c-b22d-9e66f1c8756b
# ╟─092b1c64-fbab-4d3a-afde-9c5220fcddac
# ╟─cdc2a866-d7cc-4044-93b1-14828a18f527
# ╟─410b6e39-bafd-4007-bdf1-29725bab4f62
# ╟─cdd2a6f8-8e9f-40c4-90fd-f7f73b8091e3
# ╟─4ad86246-2890-43e1-a646-609e95fb47e7
# ╟─c242c040-224f-4d2f-86a7-7e8bb98c0e7f
# ╠═eda71d34-810a-4ce1-bc6b-3040651d7ec1
# ╟─c15788f6-9a9f-49c5-8f3f-3efcb7d5e76c
# ╟─917525fb-46d8-4f2e-8d8d-ebe9e5fc236b
# ╟─64ba39ee-22c5-40a0-8bc9-1d03b02045ad
# ╟─d813e58c-da2e-48d2-b81c-6c508f4d22db
# ╟─0d61add3-e1c1-411f-99e0-a1ecdb388796
# ╟─377a2e9a-c0f9-4911-9e47-bb349c6643e7
# ╟─099b256d-ae64-4426-ab9c-166e45ce9cb2
# ╟─b744eb10-e6a8-48da-929f-77eb90d3872f
# ╟─faed9cef-bdf6-40c0-b6c6-2930bed33336
# ╟─80df2389-a06f-4be7-b956-6da33b84fb36
# ╟─76520537-ffea-4f7f-b787-85b4a4c1a272
# ╟─ae12ef84-be11-4e92-ac19-ec2a8d78276e
# ╟─23dde8c5-ff59-48b7-b608-d48fb45001c1
# ╟─8bb59b12-5978-4b11-9c56-a2dbcf049f94
# ╟─434a8b4e-42a7-41c2-82a4-2e9ef36164c2
# ╠═53f72643-39db-4202-ae6e-fff79e4539b3
# ╟─fad9d583-58f3-4ec4-b4df-f4fd4d0e48be
# ╟─6571a585-9fb0-4dcd-abda-63fc32ec8173
# ╟─88a0f816-eb54-4d78-acc7-67368fb105a8
# ╟─edfcd89d-3a7d-4f4e-b6c3-6534bd6854e3
# ╟─bde84449-68fe-4069-8734-b406e29e2393
# ╠═1e758897-b3f6-4813-812c-70f2ee88a3b8
# ╟─fc3bc625-fd58-47a5-9c49-58fbf2b1eab8
# ╟─0550d6c9-a14f-4ec9-a72b-019071b24296
# ╟─176846ab-3e8b-472c-bba0-5eb0477ce633
# ╟─5a97dbdd-8fa7-4fcc-967c-fa7ef3e99f7d
# ╟─2cc9d721-f3b1-4f15-9a71-a416eba5c768
# ╟─6c722d39-0ef6-4049-8ab2-ad18d4fec0dd
# ╟─ba8214a4-b75e-4e0d-bd82-e4a57f030d02
# ╟─424797fe-63a2-4db5-ac3c-f2d84d63e36d
# ╟─7814805b-7852-41d4-a45e-efb0cdc8a744
# ╟─f6304aa9-2385-4ca8-9404-97c371553a2b
# ╟─a175a1c9-32fa-4493-b7cb-4c630d51770d
# ╟─e0b3498e-785f-4dae-9cd4-4cbb860e2444
# ╟─70ca7df3-80ed-4e4e-8722-3314d69f677a
# ╟─ac4fd8ff-a4cd-4c5d-946c-931af96d540b
# ╟─05f8d1c7-689d-4267-b266-65571667fe7e
# ╟─b80c933c-82c4-4bcf-a6d6-4be2d8afb98b
# ╟─a6454a40-9f73-48e7-a83b-be5c6e33f70e
# ╟─3a34b778-cbbc-4c7c-adad-bbb2a73c3eb8
# ╟─826aa656-e203-44bc-afd4-5887945846ac
# ╟─015c21d7-2f50-4e2a-a13e-733bcaf6988e
# ╠═2a84219b-8f2e-4934-9831-b1484dec8de9
# ╠═1a0ad46a-fa61-4191-87cc-f20ed6ba0bc8
# ╠═bf1e0a76-b741-43d4-aa30-6c67d3023062
# ╟─04778277-36c3-4e5b-b7e4-a2519631fe2a
# ╟─73112f06-fdb8-4523-8f46-eddf36da04b2
# ╟─948410c0-c1f4-4027-8f92-c21f1ee83a0a
# ╟─69a0f202-c5bf-465e-a48b-6485df8c3d0e
# ╟─5fed002f-0a43-4fb1-99a4-fb18aa9674ea
# ╟─4b72aa51-730d-4528-947e-88a4f98030e6
# ╟─09fe1505-3a5e-4434-9087-60153cfff655
# ╟─490055bf-cf98-4e51-81ea-822c8db1a9ce
# ╟─a83c53c1-dcc7-404d-98eb-ed5827c70c91
# ╟─d701b871-bebb-4825-b2b8-6bc4466bf661
# ╟─3f3147c9-4de4-414b-9840-728aac57a86b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
