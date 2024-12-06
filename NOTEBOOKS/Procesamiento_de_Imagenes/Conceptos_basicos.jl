### A Pluto.jl notebook ###
# v0.20.0

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

# ╔═╡ 69376a37-b807-4ba3-8b1a-3ce75f6a89e6
using PlutoUI

# ╔═╡ 6013c427-44da-44ce-bb61-3485cc326f01
begin
	using Plots,Colors,ColorVectorSpace,ImageShow,FileIO,ImageIO
	using HypertextLiteral
	using Images
	using Statistics,  Distributions, LinearAlgebra
	using StatsBase, StatsPlots
end

# ╔═╡ d10e8d7b-4bb4-4a07-b187-27398005974d
PlutoUI.TableOfContents(title="Conceptos Básicos", aside=true)

# ╔═╡ ab78e5c6-1d72-4443-ab02-ca841668dce5
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**.

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 85a2f3ce-482a-417a-9b17-238b8c468caf
md"""**Este cuaderno está basado en actividades del seminario Procesamiento de Imágenes de la Universidad Nacional de Colombia, sede Bogotá, dirigido por el profesor Jorge Mauricio Ruiz en 2024-2.**

Elaborado por Juan Galvis, Carlos Nosa, Jorge Mauricio Ruíz y Yessica Trujillo."""

# ╔═╡ 3259395b-4af3-4e59-ba4c-7e652bbb0842
md"""Vamos a usar las siguientes librerías:"""

# ╔═╡ 21dd2bb3-2290-4de8-8ef8-e319d7ed1f9b
md"""# Introducción"""

# ╔═╡ 0fe3dea5-4b20-4524-9cc5-67954323afe1
md"""El procesamiento de imágenes tiene aplicaciones en diversos campos como el arte y diseño, donde se utiliza para la restauración de obras deterioradas, así como en diseño gráfico y animación digital. En astronomía, se emplea para procesar imágenes de telescopios espaciales, mejorando la visibilidad de cuerpos celestes distantes. En el ámbito de la medicina, es fundamental para el procesamiento de imágenes médicas como rayos X, tomografías y resonancias magnéticas, además de la segmentación de tejidos y órganos en imágenes para la planificación quirúrgica. En meteorología, permite el análisis de imágenes satelitales para predecir patrones climáticos y fenómenos meteorológicos. Por último, en el transporte y desarrollo de vehículos autónomos, se utiliza para el reconocimiento de señales de tránsito y la detección de obstáculos en tiempo real."""

# ╔═╡ 4983e5dc-a0a2-4c3f-9656-0ac670bb3f57
md"""# Imágenes digitales en escala de grises

Una imagen digital en escala de grises es una matriz de tamaño $m \times n$ tal que

$A = \begin{bmatrix}
a_{1,1} & a_{1,2} & \cdots & a_{1,n-1} & a_{1,n} \\
a_{2,1} & a_{2,2} & \cdots & a_{2,n-1} & a_{2,n} \\
\cdots & \cdots & \cdots & \cdots & \cdots \\
a_{m-1,1} & a_{m-1,2} & \cdots & a_{m-1,n-1} & a_{m-1,n} \\
a_{m,1} & a_{m,2} & \cdots & a_{m,n-1} & a_{m,n}
\end{bmatrix}$

de valores de píxeles discretos. 

La intensidad máxima de la luz está representada por el valor del píxel $255$, y la ausencia de luz está representada por el valor del píxel $0$."""

# ╔═╡ a504d609-5bc9-4df1-8607-972fa9f02331
md"""**Ejemplo:**

Consideremos la matriz

$A = \begin{bmatrix}
56 & 65 & 21 & 125 & 78\\
95 & 240 & 9 & 26 & 22\\
2 & 120 & 9 & 6 & 200\\
5 & 27 & 97 & 204 & 28
\end{bmatrix}$"""

# ╔═╡ 8f138903-29c5-4f27-ad26-46872823f30f
A = [56 65 21 125 78;
		95 240 9 26 22;
		2 120 9 6 200;
		5 27 97 204 28] #Definimos la matriz

# ╔═╡ 76a1c4bd-9176-4646-b004-6ab40468095e
md"""Aquí, en Julia, los píxeles pueden tomar valores entre $0$ y $1$, donde $0$ representa el negro y $1$ el blanco. Reajustemos la matriz anterior."""

# ╔═╡ 3aea3830-27ad-4b12-9048-86c45c7dbd90
A1 = float(A/255)

# ╔═╡ c9a94e3a-6f3c-498d-9dc7-245c1614b228
md"""Así, la matriz $A$ representa la siguiente imagen:"""

# ╔═╡ 8d36189d-dd66-420d-98a7-b4242f1eb4a8
Gray.(A1)

# ╔═╡ f53a09e5-b9b2-4f5d-bff4-53321e41693d
md"""También podemos generar imágenes en escala de grises de la siguiente forma:"""

# ╔═╡ c4932ec0-5ebe-4f7e-9658-9161ee4dfb5f
img_gray = rand(Gray, 3, 3)

# ╔═╡ 458c9552-e895-4599-bc0d-3e36aa2b425a
md"""A continuación, se presentan diferentes imágenes para probar el procesamiento; dichas imágenes están disponibles en los URL indicados. Descomente la que desee trabajar."""

# ╔═╡ 170ad99c-0fc9-4e1c-a658-24e013f0a65f
md"""
Imagen de perros 'perdiguero de oro'
"""

# ╔═╡ 62886672-a4d1-466c-b726-30970da835ae
url="https://cdn.pixabay.com/photo/2023/04/28/12/18/dogs-7956516_1280.jpg"

# ╔═╡ 4fa370cb-9e66-4f54-b9ee-b8a2e52e2056
md"""Fotografía titulada Mirada:"""

# ╔═╡ 7a455519-99ff-4420-9fb0-ac557e539301
#url="https://upload.wikimedia.org/wikipedia/commons/0/07/Miradas.jpg"

# ╔═╡ f84c39f7-c307-411b-9353-bc1d4408affa
md"""Fotografía Puente sobre el río Oder, Fráncfort:"""

# ╔═╡ 7ede764b-a68e-4a33-8a5f-14aa19d1e4d8
#url="https://upload.wikimedia.org/wikipedia/commons/a/a6/Frankfurt-oder-sw-12.jpg"

# ╔═╡ 26b5c683-18ba-4f5a-bfc1-5f6a67b87aae
md"""Imagen de Charles Chaplin:"""

# ╔═╡ d286e195-1cba-40eb-9ff6-ca4335bd01ff
#url="https://upload.wikimedia.org/wikipedia/commons/e/ea/Chaplin_The_Kid_edit.jpg"

# ╔═╡ 9e38213e-7629-4e52-a5d6-1a19453addfe
md"""Ahora descargamos la imagen en la máquina local."""

# ╔═╡ 6e62bb42-4b32-419b-8114-a0b27a863577
fname = download(url)

# ╔═╡ 7a0d66e0-1045-4b74-b838-0d480db714bb
md"""Ahora declaramos la variable "imag", que corresponde a un tipo de dato que representa imágenes. Recuerde que, además de asignar la variable en una expresión del tipo "$x=1$", también se muestra la variable. En este caso, Pluto entiende que queremos ver la imagen representada por la variable.
"""

# ╔═╡ e886c58a-2720-43e8-916f-a34c3976c04d
imag = Gray.(load(fname))

# ╔═╡ 3a6847d6-52c5-4b98-b6ed-3ee3bfb93b7d
md"""$\texttt{Figura 1. Perros `perdiguero de oro'. Imagen tomada de Pixabay.}$"""

# ╔═╡ 841c7690-3903-4f10-8ed4-65f33fef15d8
md"""El formato usual de imágenes corresponde a un arreglo rectangular (o matriz) de píxeles enumerados por filas y columnas desde la parte superior izquierda. Las filas se enumeran de izquierda a derecha y las columnas de arriba hacia abajo. 
"""

# ╔═╡ 041305d7-1b61-41fe-aba0-5bd283f70ce2
typeof(imag)

# ╔═╡ 3be5741e-5a16-41e2-9b91-4febc3aacc38
md"""También podemos ver el "tamaño" de la imagen con la función $\texttt{size}$. El tamaño de la imagen es:"""

# ╔═╡ 858bed86-6ccf-4454-b7ab-be3519c63eac
m, n = size(imag)

# ╔═╡ 5a975a49-a101-43d0-9677-ad2f6ee840b8
md"""Podemos visualizar la matriz asociada a la imagen:"""

# ╔═╡ 648ce77c-2fa2-4d95-a759-fc65515dfd67
A₂ = float.(channelview(imag))

# ╔═╡ 071eaf55-5d9b-4abd-a517-a59c399093de
md"""
El tipo de dato básico es un píxel. Por ejemplo, el píxel en la fila 500 (hacia abajo) y en la columna 44 (hacia la derecha) puede accederse por:"""

# ╔═╡ 7d306619-0e61-453f-a155-ba0f823b2414
a_pixel = imag[50, 44]

# ╔═╡ c8eaa0fa-011a-4668-af4b-2f2838c0200e
typeof(a_pixel)

# ╔═╡ 16a0fca0-3086-4477-bc8c-0ba5be7792fa
md"""Podemos crear un píxel de la siguiente forma. """

# ╔═╡ 5ead5cc6-dfc1-485e-a2d6-c08fe9554c2e
a_pixel2=Gray(0.9)

# ╔═╡ 58fe7c61-a29e-4013-b16c-e687c9164fc2
md"""Podemos cambiar el rango de los píxeles, reescalando la matriz. Un ejemplo se muestra en la Figura 2."""

# ╔═╡ 9841cb7a-6282-4b71-9c5b-a6ba0ad7ddef
Gray.((A₂ .- minimum(A₂)) ./ (maximum(A₂) - minimum(A₂)))

# ╔═╡ 935a567e-24ae-49d5-833c-89e5a7d11566
md"""$\texttt{Figura 2. Imagen reescalada Perros `perdiguero de oro'.}$"""

# ╔═╡ 66e9b0bf-21f1-4e51-b83f-f1be71ff391e
md"""
También podemos aclarar u oscurecer la imagen añadiendo alguna cantidad a los píxeles, tal como se muestra en la Figura 3.
"""

# ╔═╡ 99f1e042-caa2-4d18-8177-34f886876ef2
begin
	traslacion = 100
	A₂₁ = min.(max.(A₂ .+ traslacion/255, 0),1)
	A₂₂ = min.(max.(A₂ .- traslacion/255, 0),1)
	plot(plot(Gray.(A₂₁),grid=false),plot(Gray.(A₂₂),grid=false), layout=(1,2),size=(800,600),xaxis=false,yaxis=false)
end

# ╔═╡ 5f743c4f-3bd7-4979-a5eb-cc5aeced6777
md"""$\texttt{Figura 3. Imagen aclarada y oscurecida.}$"""

# ╔═╡ 9a92ad72-2e74-4461-bf6a-7e377696e779
md"""## Construcción de objetos geométricos"""

# ╔═╡ 7b62a3d2-6362-4d19-8158-a79b2dd2f423
md"""Vamos a construir una matriz que represente los siguientes objetos geométricos:
  
A continuación, la Figura 4 presenta un cuadrado oscuro sobre un fondo claro."""

# ╔═╡ e16bebb4-556c-40ba-a465-bf7c9f9b0fb8
begin
	n₁ = 500
	img₁= fill(200, n₁, n₁)
	square_size = 200  # tamaño del cuadrado oscuro

	# Colocar el cuadrado oscuro (0 para negro) en el centro
	fila = div(n₁ - square_size, 2) + 1
	col = div(n₁ - square_size, 2) + 1
	
	for i in fila:fila + square_size - 1
	    for j in col:col + square_size - 1
	        img₁[i, j] = 0  # Asignar negro al cuadrado
	    end
	end
	Gray.(img₁ ./ 255)
end

# ╔═╡ f4333289-f350-4670-8b4d-5770bc602d19
md"""$\texttt{Figura 4. Cuadrado oscuro sobre un fondo claro.}$"""

# ╔═╡ 4fa17deb-d617-4149-bde3-034dd3326329
md"""La Figura 5 muestra un triángulo claro sobre un fondo oscuro."""

# ╔═╡ 1007f67f-5895-4d88-b3ea-b65abd578b60
begin
	n₂ = 500  # Tamaño de la imagen (n x n)
	img₂ = fill(0, n₂, n₂)  # Fondo oscuro (negro)
	
	# Dibujar el triángulo gris
	for i in 1:n₂, j in 1:n₂
	    # Definir las coordenadas para el triángulo inscrito en el cuadrado
	    centro = n₂/2
	    base_triangulo = n₂/2
	    altura_triangulo = n₂/4
	    if i >= centro - altura_triangulo && i <= centro && abs(j - centro) <= (centro - i)
	        img₂[i, j] = 128  # Triángulo gris
	    end
	end
	Gray.(img₂ ./ 255)
end

# ╔═╡ ed50d1e0-ce07-4572-b889-0949e191fd83
md"""$\texttt{Figura 5. Triángulo claro sobre un fondo oscuro.}$"""

# ╔═╡ f8dbf824-a5d4-4360-af10-4bb962239cf8
md"""En la Figura 6 se presenta un gráfico que muestra un diamante gris inscrito en un cuadrado claro, todo ello sobre un fondo oscuro."""

# ╔═╡ 27fa6ad4-2946-457f-b880-0c56de30711e
begin
	# Dimensiones de la imagen
	n₃ = 500  # Tamaño de la imagen (n x n)
	img₃ = fill(0, n₃, n₃)  # Fondo oscuro (negro)
	
	# Dibujar el cuadrado claro
	for i in 1:n₃, j in 1:n₃
	    if abs(i - n₃/2) <= n₃/4 && abs(j - n₃/2) <= n₃/4
	        img₃[i, j] = 211 # Cuadrado claro (gris claro)
	    end
	end
	
	# Dibujar el diamante gris
	for i in 1:n₃, j in 1:n₃
	    if abs(i - n₃/2) + abs(j - n₃/2) <= n₃/4
	        img₃[i, j] = 128  # Diamante gris
	    end
	end
	Gray.(img₃ ./ 255)
end

# ╔═╡ bb402045-312c-4b11-91ec-e4c86294e80b
md"""$\texttt{Figura 6. Diamante gris inscrito en un cuadrado claro.}$"""

# ╔═╡ 895ae5b2-3a9e-4ce0-86ee-414e53bfff63
md"""
Podemos "jugar" con las regiones creadas por diferentes desigualdades en el plano, tal como lo muestran la Figura 7.
"""

# ╔═╡ be669c5e-1181-4e12-8038-4d1d7bf3c558
begin
	# Dimensiones de la imagen
	n₄ = 500  # Tamaño de la imagen (n x n)
	img₄ = fill(0, n₄, n₄)  # Fondo
	
	for i in 1:n₄, j in 1:n₄
	    if abs(i - n₄/2) <= n₄/2 && abs(j - n₄/2) <= n₄/2
	        img₄[i, j] = 50
	    end
	end
	for i in 1:n₄, j in 1:n₄
	    if abs(i - n₄/2) + abs(j - n₄/2) <= n₄/4
	        img₄[i, j] = 100  
	    end
	end
	for i in 1:n₄, j in 1:n₄
	    if ((i - n₄/2)^2 + (j - n₄/2)^2)^(1/2) <= n₄/8
	        img₄[i, j] = 150  
	    end
	end
	for i in 1:n₄, j in 1:n₄
	    if (abs(i - n₄/2)^3 + abs(j - n₄/2)^3)^(1/3) <= n₄/16
	        img₄[i, j] = 200  
	    end
	end
	for i in 1:n₄, j in 1:n₄
	    if (abs(i - n₄/2)^4 + abs(j - n₄/2)^4)^(1/4) <= n₄/32
	        img₄[i, j] = 250  
	    end
	end

	# Dimensiones de la imagen
	n₅ = 500  # Tamaño de la imagen (n x n)
	img₅ = fill(0, n₅, n₅)  # Fondo
	listaux₅ = [[i,j] for i in 0:n₅ if i%100==0 for j in 0:n₅ if j%100==0]
	for item in listaux₅
		for i in 1:n₅, j in 1:n₅
			if (abs(i - item[1])^(1/2) + abs(j - item[2])^(1/2))^(2) <= n₅/16
	        	img₅[i, j] = 255  
	    	end
		end
	end
	listaux₅₀ = [[i,j] for i in 0:n₅ if i%50==0 for j in 0:n₅ if j%50==0]
	for item in listaux₅₀
		for i in 1:n₅, j in 1:n₅
			if (abs(i - item[1])^(1/2) + abs(j - item[2])^(1/2))^(2) <= n₅/32
	        	img₅[i, j] = 200 
	    	end
		end
	end
	
	[Gray.(img₄ ./ 255) Gray.(ones(500,100)) Gray.(img₅ ./ 255)]
end

# ╔═╡ ce573e5b-5d66-4f07-832d-45279813bc1f
md"""$\texttt{Figura 7. Regiones geométricas generadas por desigualdades en el plano.}$"""

# ╔═╡ cf559d3d-625f-4a24-898b-6f8f992d96bf
md"""En la Figura 8 se muestra un fractal de Sierpinski generado mediante una función recursiva."""

# ╔═╡ 0038eaef-b21e-4134-aaa9-0aa4b97040bf
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
	
	depth = 6
	n₆ = Int(3^depth)
	img₆ = fill(0, n₆, n₆)
	
	sierpinski!(img₆, 1, 1, n₆, depth)

	plot(Gray.(img₆ ./ 255),label="",size=(800,800),xaxis=false,yaxis=false)
end

# ╔═╡ da76b869-5f5d-4943-9dea-537af40cd244
md"""$\texttt{Figura 8. Fractal de Sierpinski.}$"""

# ╔═╡ ed57733c-8fb7-42a7-a2e6-bbfa49521d96
md"""
## Descripción estadística de las imágenes

Un histograma de una imagen es una representación gráfica que muestra la distribución de los valores de los píxeles, es decir, cuántas veces ocurre cada nivel de gris en la imagen. El análisis de un histograma permite entender aspectos clave de la imagen, como el brillo, el contraste o la predominancia de tonos claros u oscuros, lo cual es fundamental para técnicas de mejora como la aclaración, oscurecimiento o aumento del contraste.
"""

# ╔═╡ 505dca82-0eec-4068-b7d7-ce5184a4f280
md"""Vamos a ilustrar cómo se trabaja esto considerando la Figura 9."""

# ╔═╡ fd1d9539-b29c-436e-810d-d1a301a107d8
begin
	url1="https://upload.wikimedia.org/wikipedia/commons/f/ff/Yellow_tree.jpg"
	fname1 = download(url1)
	imag1 = Gray.(load(fname1))
end

# ╔═╡ a08d4836-0a6f-43a1-ba55-f106223811d1
md"""$\texttt{Figura 9. Árbol tropical en Campeche. Imagen tomada de Wikipedia.}$"""

# ╔═╡ 0b26b02d-0287-4fa6-ad26-74316de84b44
md"""Para ver el histograma de una imagen digital, primero se reorganiza la matriz 2D que representa la imagen en una lista unidimensional de valores, esto se realiza con la función $\texttt{vec()}$, y luego con la función $\texttt{histogram()}$ visualizamos el histograma."""

# ╔═╡ b0518a53-89e0-48c0-9db3-aa24219cb330
md"""Así el histograma de la Figura 9 es presentado a continuación."""

# ╔═╡ d8176e80-2558-470e-9043-a009fe57b3ab
begin
	B1 = Float64.(channelview(imag1))
	histogram(vec(B1),label="", title = "Histograma de la Figura 9",color="gray",bins=50)
end

# ╔═╡ 35c76ddf-2d53-4b07-9988-d49abb65ef70
md"""$\texttt{Figura 10. Histograma de la Figura 9.}$"""

# ╔═╡ df657372-48d8-4dc8-a949-aadef2220511
md"""Aunque el rango total de valores de píxeles es relevante, es el rango intercuartílico el que influye principalmente en el nivel de contraste de una imagen.

Para determinar la mediana y los cuartiles de una imagen digital, se convierte la matriz $2D$ de la imagen en una lista unidimensional de valores, se ordena dicha lista de menor a mayor, y luego se identifica el valor central, junto con los valores de $Q_1$ y $Q_3$ correspondientes a las mitades inferior y superior."""

# ╔═╡ 6a0dd188-51e0-4e58-b46d-e1d25927b446
md"""Por ejemplo, continuemos trabajando con la Figura 9 y calculemos algunas estadísticas:"""

# ╔═╡ e9b9ce5c-be98-4bdf-ba0f-69a7cddd6bfa
Mínimo = minimum(vec(B1))

# ╔═╡ b366b266-dc83-4b60-b62b-71447a872519
Q1 = quantile(vec(B1), 0.25)

# ╔═╡ c7d2b404-74e5-4606-97de-73bbb66477f7
Mediana = quantile(vec(B1), 0.50)

# ╔═╡ 980da483-0e30-4973-83da-ff5c2b409a13
Media = mean(vec(B1))

# ╔═╡ f11f0a38-80d3-4383-9ed1-6fa556efc98f
Q3 = quantile(vec(B1), 0.75)

# ╔═╡ c61eaf53-568c-4db6-b4d7-4b6cc67ceaba
quantile(vec(B1), 1.0)

# ╔═╡ 21a6e96a-b744-4173-9f18-39f825063a6a
Máximo = maximum(vec(B1))

# ╔═╡ 456eb878-dc37-46e2-8c53-0f6bd6489feb
IQR = Q3 - Q1 

# ╔═╡ 4b1e5e1b-121d-49a4-9e36-b5a47d86b414
Varianza = var(vec(B1))

# ╔═╡ 65ae4195-fc70-4076-bbca-a6b43ece75cf
md"""
En la siguiente imagen (Figura 11) se muestra la Figura 9 usando solo $5$ tonos en la escala de grises correspondientes a las estadísticas mínimo, cuartil uno, mediana, cuartil tres y máximo de los valores de la imagen original.
"""

# ╔═╡ cdc98503-e26e-4608-b041-ba32fa12325c
@bind k Slider(1:1:10, show_value=true, default=5)

# ╔═╡ 13d12821-68f2-4c4c-ab69-f0e67a6e9793
begin
	reduced_image = zeros(Float64, size(B1))
	nocolors = k
	quantilesgray = [quantile(vec(B1), p) for p in 0:1/(nocolors-1):1]
	
	for i in 1:size(B1, 1)
	    for j in 1:size(B1, 2)
	        near_quantile = findmin(abs.(B1[i, j] .- quantilesgray))[2]
			reduced_image[i, j] = quantilesgray[near_quantile]
	    end
	end
	Gray.(reduced_image)
end

# ╔═╡ 57c76756-2f19-4c85-a4f1-308860ed3020
md"""$\texttt{Figura 11. Imagen resultante de usar 5 tonos en la}$
$\texttt{escala de grises en la Figura 9.}$"""

# ╔═╡ 74cf7e53-d17c-4327-a395-26792b07a4df
md"""A continuación en la Figura 12 se presenta el histograma de la Figura 11."""

# ╔═╡ baaf7cc2-2933-4a1f-99c9-458a0cae0095
histogram(vec(reduced_image),label="", title = "Histograma de la Figura 2 con $nocolors colores",color="gray",bins=50)

# ╔═╡ 749ff365-e249-4d05-ad0c-d6a10f8e9956
md"""$\texttt{Figura 12. Histograma de la Figura 10.}$"""

# ╔═╡ c754f505-ec3b-4c7d-b39d-54d39ae5d32c
md"""
# Imágenes digitales a color
"""

# ╔═╡ f495bebc-5d3f-4f4e-a645-01c454164012
md"""
## Formato RGB
"""

# ╔═╡ d4cdc837-f791-4add-9729-809153d1e5d8
md"""
Si se tiene una imagen a color de tamaño $m \times n$, la imagen en color se representa utilizando tres matrices bidimensionales separadas para los canales de color rojo ($R$), verde ($G$) y azul ($B$). Las matrices $R$, $G$ y $B$ serán de tamaño $m \times n$. La representación completa de la imagen a color será una matriz tridimensional $A$ de tamaño $m \times n \times 3$, donde $R=A(i,j,1)$, $G=A(i,j,2)$ y $B=A(i,j,3)$ son las intensidades de rojo, verde y azul del píxel en la posición $(i,j)$, respectivamente.

El valor de cada canal generalmente se mide en el rango de 0 a 255, donde 0 indica ausencia de color y 255 indica máxima intensidad.

Estas matrices se ven de la siguiente forma:

$R = \begin{bmatrix} r_{11} & r_{21} & \cdots & r_{m1} \\ r_{12} & r_{22} & \cdots & r_{m2} \\ \vdots & \vdots & \ddots & \vdots \\ r_{1n} & r_{2n} & \cdots & r_{mn} \end{bmatrix},$

$G = \begin{bmatrix} g_{11} & g_{21} & \cdots & g_{m1} \\ g_{12} & g_{22} & \cdots & g_{m2} \\ \vdots & \vdots & \ddots & \vdots \\ g_{1n} & g_{2n} & \cdots & g_{mn} \end{bmatrix},$

$B = \begin{bmatrix} b_{11} & b_{21} & \cdots & b_{m1} \\ b_{12} & b_{22} & \cdots & b_{m2} \\ \vdots & \vdots & \ddots & \vdots \\ b_{1n} & b_{2n} & \cdots & b_{mn} \end{bmatrix}.$

Donde $r_{ij}$, $g_{ij}$ y $b_{ij}$ representan los valores de los píxeles correspondientes a los canales de rojo, verde y azul, respectivamente, en la posición $(i,j)$.
"""

# ╔═╡ 20fad2ff-77b6-4428-98f9-f2ef147d5dd9
md"""A continuación se muestran los canales, respectivamente:"""

# ╔═╡ 09a36d89-b9cd-4adc-bcb7-c1812cdd89ba
begin
	Red_color = RGB(1.0, 0.0, 0.0)
	Green_color = RGB(0.0, 1.0, 0.0)
	Blue_color = RGB(0.0, 0.0, 1.0)
	[Red_color, Green_color, Blue_color]
end

# ╔═╡ 20d255b3-0eb2-41c3-b6b1-aab7d08ba16c
md"""La suma de los 3 colores produce el color blanco:"""

# ╔═╡ 96460cc0-0191-4e6a-b560-ca712bb251bd
White_color = Red_color + Green_color + Blue_color

# ╔═╡ bcaeacca-63cd-49e0-915a-14ceaaacc98d
White_color == RGB(1.0, 1.0, 1.0)

# ╔═╡ f299663b-c7d2-45a6-b1e2-dc5d6890efd2
Black_color = RGB(0.0, 0.0, 0.0)

# ╔═╡ d0ff380a-3235-4e9d-990f-22f2f94ee7fe
md"""Consideremos la siguiente imagen a color, ver Figura 13."""

# ╔═╡ 5a74bb35-bd65-4e42-a112-f71cdf336682
begin
	url₂ = "https://github.com/ytrujillol/Procesamiento-de-imagenes/blob/main/Images/Bandera_Seychelles.jpg?raw=true"
	fname₂ = download(url₂)
	image₂ = load(fname₂)
end

# ╔═╡ 20cedaf5-ece2-4b20-82e2-9815a51e841e
md"""$\texttt{Figura 13. Flag of Seychelles. Imagen tomada de Wikipedia}$"""

# ╔═╡ 0df909e9-1907-4def-9844-8364abeebfe0
begin
	B₂ = Float64.(channelview(image₂))
	Red = B₂[1, :, :]
	Green = B₂[2, :, :]
	Blue = B₂[3, :, :]
end;

# ╔═╡ ddd71b1f-7867-4603-a0fb-ccd86265b839
function rotar(matriz)
    # Intercambiar las filas
    matriz_rotada = reverse(matriz, dims=1)
    return matriz_rotada
end;

# ╔═╡ 5f20feec-b0a5-4c94-a07d-5f84059f1d15
md"""Los canales de color R, G y B (rojo, verde y azul), respectivamente, de la imagen se muestran a continuación."""

# ╔═╡ 8e0bf959-2faf-4821-bb25-1b590edab1bf
begin
	p1 = heatmap(rotar(Red), color=:reds, axis=false, legend=false,title="R")
	p2 = heatmap(rotar(Green), color=:greens, axis=false, legend=false,title="G")
	p3 = heatmap(rotar(Blue), color=:blues, axis=false, legend=false,title="B")
	
	plot(p1, p2, p3, layout = (1, 3) , size=(900, 200))
end

# ╔═╡ 60ea5c79-9830-4977-9867-08cab423bbd7
md"""$\texttt{Figura 14. Canales de color R, G y B de la Figura 13.}$"""

# ╔═╡ 19288a59-0392-46c8-a946-c4f10613e0e0
md"""En la siguiente figura (Figura 15) se presentan las imágenes anteriores pero en escala de grises."""

# ╔═╡ 5652fd36-bde9-4084-9cbf-9e6e62381f79
[RGB.(Red) RGB.(ones(size(Red)[1], 400)) RGB.(Green) RGB.(ones(size(Red)[1], 400)) RGB.(Blue)]

# ╔═╡ 7bbea68e-46e8-4739-8d45-a4008d767934
md"""$\texttt{Figura 15. Escala de grises de los canales R, G y B de la Figura 13.}$"""

# ╔═╡ f10c3863-89b9-4913-a095-7feb46827238
md"""Los histogramas de cada uno de los canales de color de la Figura 13 son presentados a continuación."""

# ╔═╡ f7e94893-886f-4131-896c-e9cc322cad68
begin
	p111 = plot(title="Histograma de la imagen en RGB")
	for comp in (red, green, blue)
	    hist = fit(Histogram, reinterpret.(comp.(vec(image₂))), 0:256).weights
	    p111 = plot!(hist, c="$comp",fill=(0,"$comp"), fillalpha=0.1,label="Canal $comp")
	end
	p111
end

# ╔═╡ bc25c3ac-8de8-4b8d-8b3a-397421f05f83
md"""$\texttt{Figura 16. Histogramas de los canales de color de la Figura 13.}$"""

# ╔═╡ a38e06ea-6e86-4feb-8bae-e8a74192adcc
md"""## Formato CMY"""

# ╔═╡ 070824d2-fb08-4323-87cf-93f5442e533d
md"""
El espacio CMY (Cyan, Magenta, Yellow) es un modelo de color sustractivo, en este espacio el color se obtiene eliminando (o sustrayendo) componentes de luz blanca. Cada color en CMY corresponde a la cantidad de cian, magenta y amarillo que debe restarse de la luz blanca para obtener un color específico. 

CMY es esencialmente el inverso del espacio de color RGB. Un color en CMY se obtiene restando los valores de RGB de $1$:
   
$Cyan = 1 - Red, \quad Magenta = 1 - Green, \quad Yellow = 1 - Blue$

Las impresoras utilizan tintas de color cian, magenta y amarillo para producir una amplia gama de colores en papel. Cuando estas tintas se combinan, bloquean o reflejan diferentes longitudes de onda de luz para crear los colores deseados. El modelo CMY suele extenderse al modelo *CMYK*, donde la "K" representa el color negro (Key). Esto se hace porque la mezcla de cian, magenta y amarillo en teoría debería producir negro, pero en la práctica resulta en un marrón oscuro; por eso, se añade una tinta negra para obtener mejores resultados."""

# ╔═╡ dc8fe48a-2a02-4ac2-9a5d-7eff264e6792
md"""**Ejemplos de mezclas**

Consideremos los colores principales del formato RGB:"""

# ╔═╡ daf2fcd8-9d4f-40ba-bfa3-6fd33f532aaf
[Red_color, Green_color, Blue_color]

# ╔═╡ 37537b42-228b-4fc3-8218-27fca454bef5
RGB(1.0, 1.0, 1.0) - Red_color #Cyan_color

# ╔═╡ b90774df-cbfb-4b67-a49b-2481d5e444f4
RGB(1.0, 1.0, 1.0) - Green_color #Magenta_color

# ╔═╡ 85fa46bd-7873-4d2e-8449-e2029e5f3c04
RGB(1.0, 1.0, 1.0) - Blue_color #Yellow_color

# ╔═╡ 6073f551-5f38-444e-b9f8-903aea1bd476
begin
	Cyan_color = RGB(0.0, 1.0, 1.0)
	Magenta_color = RGB(1.0, 0.0, 1.0)
	Yellow_color = RGB(1.0, 1.0, 0.0)
	[Cyan_color, Magenta_color, Yellow_color]
end

# ╔═╡ 159721cc-2899-4685-a4ff-47401d388271
Cyan_color - Magenta_color - Yellow_color

# ╔═╡ 41db01ba-af3a-43e4-b572-884a4820da83
md"""Las mezclas anteriormente descritas se evidencian en la Figura 17."""

# ╔═╡ 10584a0d-efc7-46fb-b0d8-dab738842fca
begin
	URL = "https://upload.wikimedia.org/wikipedia/commons/6/69/CMY%E6%B7%B7%E8%89%B2%E6%A8%A1%E5%BC%8F.png"
	Fname = download(URL)
	IMAGE = load(Fname)
end

# ╔═╡ deb95abb-bbb0-437d-b359-ca9475a50cad
md"""$\texttt{Figura 17. Formato CMY. Imagen tomada de Wikipedia.}$"""

# ╔═╡ fc1caf73-cf17-47ab-8367-8b4ea1b6c74c
md"""
La Figura 18 muestra los canales de color C, M y Y (cyan, magenta, yellow), respectivamente, de la Figura 13.
"""

# ╔═╡ 79ad57d8-b2ae-4721-804b-1749bcc710c6
begin
	# Función para convertir un solo píxel RGB a CMY
	function rgb_to_cmy(pixel::RGB)
		C = 1.0 - red(pixel)
		M = 1.0 - green(pixel)
		Y = 1.0 - blue(pixel)
		return (C, M, Y)
	end
	
	img_cmy = map(rgb_to_cmy, image₂); # Convertir la imagen RGB a CMY	
	
	C_channel = map(c -> c[1], img_cmy)  # Canal Cyan
	M_channel = map(c -> c[2], img_cmy)  # Canal Magenta
	Y_channel = map(c -> c[3], img_cmy)  # Canal Yellow
	
	# Crear imágenes para cada canal en colores RGB
	img_cyan = map(c -> RGB(1.0 - c, 1.0, 1.0), C_channel)   # Cyan
	img_magenta = map(c -> RGB(1.0 - c, 0.0, 1.0), M_channel)  # Magenta
	img_yellow = map(c -> RGB(1.0 - c, 0.0, 0.0), Y_channel)   # Yellow
	
	plot(heatmap(img_cyan, aspect_ratio=:equal, title="C",colorbar=false, xaxis=false, yaxis=false), heatmap(img_magenta, aspect_ratio=:equal, title="M",colorbar=false, xaxis=false, yaxis=false), heatmap(img_yellow, aspect_ratio=:equal, title="Y",colorbar=false, xaxis=false, yaxis=false), layout=(1, 3), size=(900, 300))
end

# ╔═╡ a675264a-777a-4809-8372-c46333eab0ba
md"""$\texttt{Figura 18. Canales C, M y Y de la Figura 13.}$"""

# ╔═╡ 0f327941-098c-4030-b868-7a1b3bb5c4fb
md"""
## Formato YCbCr
"""

# ╔═╡ b1e736cc-f330-4c2c-9156-d560807b575f
md"""El formato YCbCr nació como una versión digital del modelo YUV $[6]$, pensado para optimizar la transmisión y compresión de video. Diseñado para televisión digital, aprovecha que el ojo humano percibe más la luminancia que la crominancia, lo que permite reducir datos sin sacrificar calidad visual.

El modelo de color YCbCr es un espacio de color utilizado principalmente en aplicaciones de video y compresión de imágenes. Se basa en la luminancia (Y) y en dos componentes de crominancia (Cb y Cr). Ver $[5]$. Esta representación es especialmente útil en la transmisión de video y la compresión de imágenes, ya que permite separar la información de brillo de la información de color. La componente Y representa la luminancia (brillo) de la imagen, mientras que Cb y Cr representan las diferencias de color, facilitando así la compresión y el procesamiento de imágenes.

La conversión de RGB (Rojo, Verde, Azul) a YCbCr se realiza mediante las siguientes ecuaciones, ver $[4]$:

$\begin{align}
    Y & = 0.299 \cdot R + 0.587 \cdot G + 0.114 \cdot B \\
    Cb & = -0.1687 \cdot R - 0.3313 \cdot G + 0.5 \cdot B + 128 \\
    Cr & = 0.5 \cdot R - 0.4187 \cdot G - 0.0813 \cdot B + 128 
\end{align}$

La descripción de cada uno de estos canales se hace a continuación
- **Y**: Componente de luminancia, que define el brillo de la imagen.
- **Cb**: Componente de crominancia azul, que representa la diferencia entre el azul y la luminancia.
- **Cr**: Componente de crominancia roja, que representa la diferencia entre el rojo y la luminancia.

Esta transformación permite una mejor compresión y procesamiento de imágenes al separar la información de brillo de la de color.

"""

# ╔═╡ 608851fe-9281-487d-ba20-a2186816d2e1
md"""
Los canales de color Y, Cb y Cr (luminancia, crominancia azul y crominancia roja), respectivamente, de la Figura 13 se muestran en la Figura 19.
"""

# ╔═╡ cbc12e57-2d16-4541-ab72-fb1a9d14563d
begin
	# Función para convertir un solo píxel RGB a YCbCr
	function rgb_to_ycbcr(R, G, B)
	    Y  =  0.299 * R + 0.587 * G + 0.114 * B
	    Cb = -0.1687 * R - 0.3313 * G + 0.5 * B + 128
	    Cr =  0.5 * R - 0.4187 * G - 0.0813 * B + 128
	    return Y, Cb, Cr
	end
	
	# Función para convertir toda una imagen de RGB a YCbCr
	function image_to_ycbcr(image_rgb)
	    YCbCr_image = similar(image_rgb)  # Crear un array para la imagen YCbCr
	    for i in 1:size(image_rgb, 1), j in 1:size(image_rgb, 2)
	        R, G, B = image_rgb[i, j, :]
	        YCbCr_image[i, j, :] .= rgb_to_ycbcr(R, G, B)
	    end
	    return YCbCr_image
	end
	
	# Ejemplo de uso: Imagen RGB de ejemplo (3 canales)
	image_rgb = zeros(size(Red)[1], size(Red)[2], 3)  # Imagen aleatoria 256x256 en RGB
	image_rgb[:,:,1] = Red *256
	image_rgb[:,:,2] = Green *256
	image_rgb[:,:,3] = Blue *256
	
	# Convertir la imagen RGB a YCbCr
	image_ycbcr = image_to_ycbcr(image_rgb)/256;


	plot(heatmap(rotar(image_ycbcr[:,:,1]), color=:gray, c=:grays, title="Y",colorbar=false, xaxis=false, yaxis=false), 
	heatmap(rotar(image_ycbcr[:,:,2]), color=:blue, c=:blues, title="Cb",colorbar=false, xaxis=false, yaxis=false), 
	heatmap(rotar(image_ycbcr[:,:,3]), color=:red, c=:reds, title="Cr",colorbar=false, xaxis=false, yaxis=false), 
	layout = (1, 3) , size=(900, 200))
end

# ╔═╡ 98378c96-6a33-4419-a1ef-fbd5e6b9b15d
md"""$\texttt{Figura 19. Canales Y, Cb y Cr de la Figura 13.}$"""

# ╔═╡ 103a9b75-0424-4c7b-97ca-13cfaaff2725
md""" A continuación se presenta la imagen convertida del formato RGB al formato YCbCr. """

# ╔═╡ 742c3af1-1639-469e-bc58-c2816cb13f8e
begin
	imagen_YCbCr = permutedims(cat(dims=3, image_ycbcr[:,:,1], image_ycbcr[:,:,2], image_ycbcr[:,:,3]), [3, 1, 2]);
	colorview(RGB, imagen_YCbCr)
end

# ╔═╡ 6c8c4b2f-775a-493e-b986-7fd921a083f7
md"""$\texttt{Figura 20. Formato YCbCr de la Figura 13.}$"""

# ╔═╡ 4484331a-f74e-4f72-b43c-6c3ade5d5687
md"""# Espacio vectorial RGB

El espacio de color RGB puede ser representado como un espacio vectorial $V_{RGB} = \mathbb{R}^3$, con las operaciones de adición de vectores y multiplicación por escalar definidas usualmente, donde cada pixel de color $v \in \mathbb{R}^3$ en el espacio RGB se representa como:

$v = \begin{pmatrix} R \\ G \\ B \end{pmatrix}$

donde $R$, $G$ y $B$ toman valores entre $0$ y $1$, que indican la intensidad de cada componente."""

# ╔═╡ e1594a1d-5b76-4e73-8133-3d2ba4b27a95
md"""El espacio de color CMY puede verse como una transformación afin del espacio RGB, ya que

$C = 1 - R, \quad M = 1 - G, \quad Y = 1 - B.$

Podemos definir un color en el espacio CMY como el vector:

$w = \begin{pmatrix} C \\ M \\ Y \end{pmatrix} = \begin{pmatrix} 1 - R \\ 1 - G \\ 1 - B \end{pmatrix}.$

Expresemos la transformación de RGB a CMY como una operación matricial.

Dado un vector $v_{RGB} = \begin{pmatrix} R \\ G \\ B \end{pmatrix}$ en RGB, su correspondiente vector $w_{CMY}$ en CMY se puede obtener mediante la transformación:

$w_{CMY} = A_1 v_{RGB} + b_1,$

donde $A_1 = \begin{pmatrix} -1 & 0 & 0 \\ 0 & -1 & 0 \\ 0 & 0 & -1 \end{pmatrix}, \quad b_1 = \begin{pmatrix} 1 \\ 1 \\ 1 \end{pmatrix},$ 
esta matriz que define la relación lineal entre los dos espacios y $b$ es un vector constante, es decir,

$\begin{align}
w_{CMY} &= \begin{pmatrix} -1 & 0 & 0 \\ 0 & -1 & 0 \\ 0 & 0 & -1 \end{pmatrix} \begin{pmatrix} R \\ G \\ B \end{pmatrix} + \begin{pmatrix} 1 \\ 1 \\ 1 \end{pmatrix}\\
&= \begin{pmatrix} 1 - R \\ 1 - G \\ 1 - B \end{pmatrix}
\end{align}.$"""

# ╔═╡ f8ce4130-9ba6-4a3e-b630-bb709521ffa2
md"""Esta transformación la podemos representar como el cubo mostrado en la Figura 21."""

# ╔═╡ ba17c664-07be-4f2e-a0b4-abd6632ac87e
load(download("https://github.com/ytrujillol/Procesamiento-de-imagenes/blob/main/Images/Cubo.png?raw=true"))

# ╔═╡ 40706af2-fc1d-4ae0-acca-64d362662664
md"""$\texttt{Figura 21. Espacio de colores RGB y CMY. Imagen tomada de [7].}$"""

# ╔═╡ da86eb54-ac72-4d9a-9788-1044185fbafa
md"""De igual forma, el espacio YCbCr está relacionado con RGB a través de una transformación afin.
El vector 

$v_{RGB} = \begin{pmatrix} R \\ G \\ B \end{pmatrix}$ se transforma en el vector 
$w_{YCbCr}$ mediante una matriz de transformación $A_2$ y un vector de desplazamiento $b_2$, de la siguiente forma:

$w_{YCbCr} = A_2 v_{RGB} + b_2.$
Como ya vimos, la transformación de RGB a YCbCr se define de la siguiente manera:

$\begin{align}
    Y & = 0.299 \cdot R + 0.587 \cdot G + 0.114 \cdot B \\
    Cb & = -0.1687 \cdot R - 0.3313 \cdot G + 0.5 \cdot B + 128 \\
    Cr & = 0.5 \cdot R - 0.4187 \cdot G - 0.0813 \cdot B + 128 
\end{align}.$
En forma matricial, esto se puede representar como:

$\begin{pmatrix} Y \\ Cb \\ Cr \end{pmatrix} = \begin{pmatrix} 0.299 & 0.587 & 0.114 \\ -0.1687 & -0.3313 & 0.5 \\ 0.5 & -0.4187 & -0.0813 \end{pmatrix} \begin{pmatrix} R \\ G \\ B \end{pmatrix} + \begin{pmatrix} 0 \\ 128 \\ 128 \end{pmatrix}.$
"""

# ╔═╡ 9849bf25-ddbe-4ac3-8400-afc04c93db81
md"""## Ejemplos"""

# ╔═╡ 20a95407-0b33-46c1-9fb8-b5f4c2490c63
md"""Definamos la matriz $A_1$ y el vector $b_1$ de la transformación RGB a CMY:"""

# ╔═╡ 2fa13862-4d50-4cc7-926c-d715147b56f1
A₁ = [-1 0 0; 0 -1 0; 0 0 -1]

# ╔═╡ 87355aa8-2c36-4fdc-917d-7d259400d16c
b₁ = [1; 1; 1]

# ╔═╡ d499009e-37f9-4be0-9676-64c881f57b25
md"""Así si consideramos el siguiente pixel"""

# ╔═╡ 1e589995-c097-4378-bb39-f14b0e1903c6
c₁ = [0.5, 0.04, 0.7]

# ╔═╡ b692374a-685c-4c3a-b5a5-1595225f90e5
colorview(RGB, reshape(c₁, 3, 1, 1))

# ╔═╡ dab700dc-2f99-4f06-b2ff-16387ad1dbb4
md"""La tranformación $w_{CMY} = A_1 v_{RGB} + b_1,$ nos lleva al siguiente pixel"""

# ╔═╡ 18b7b972-4cc0-42a6-bb3a-daf886990d9f
A₁*c₁ + b₁

# ╔═╡ d048876f-43cc-4bf7-84b7-932422b223f5
colorview(RGB, reshape(A₁*c₁ + b₁, 3, 1, 1))

# ╔═╡ 2ac47708-fd5b-4f12-8b3f-84111cff43f5
md"""Ahora, definamos la matriz $A_2$ y el vector $b_2$ de la tranformación RGB a YCbCr:"""

# ╔═╡ 00609a19-b333-4c2f-8133-f49fc6ff3f69
A2 = [0.299 0.587 0.114; -0.1687 -0.3313 0.5; 0.5 -0.4187 -0.0813]

# ╔═╡ d72c680c-cbfa-4d9b-aa2b-baa509632211
b₂ = [0; 128; 128]

# ╔═╡ 032a66eb-d63f-4776-84c6-0ba4dfbb07c6
md"""Consideremos el pixel trabajado anteriormente"""

# ╔═╡ 5fd669d9-4d51-4afe-8503-3f787dbd5d1a
colorview(RGB, reshape(c₁, 3, 1, 1))

# ╔═╡ 942adb72-0acc-4d73-8dc3-3f7cb591caa2
md"""Así, la tranformación $w_{YCbCr} = A_2 v_{RGB} + b_2,$ nos lleva al siguiente pixel"""

# ╔═╡ 1423f7bd-075e-4cad-bbf6-3557e2c357a8
colorview(RGB, reshape((256*A2*c₁ + b₂)/256, 3, 1, 1))

# ╔═╡ ad8239cc-604d-4eca-9621-5c3218b411e9
md"""# Referencias

[1] Galperin, Y. V. (2020). An image processing tour of college mathematics. Chapman & Hall/CRC Press.

[2] JuliaImages. (s.f.). JuliaImages Documentation. Recuperado de [https://juliaimages.org/stable/](https://juliaimages.org/stable/).

[3] MIT Computational Thinking. (2023). Images Abstractions. Recuperado de [https://computationalthinking.mit.edu/Fall22/images_abstractions/images/](https://computationalthinking.mit.edu/Fall22/images_abstractions/images/)

[4] Unión Internacional de Telecomunicaciones, ed. (2012). [«Recomendación UIT-R BT.601-7»](http://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.601-7-201103-I!!PDF-S.pdf). Consultado el 16 de octubre de 2024.

[5] MathWorks. (n.d.). Understanding color spaces and color space conversion. MathWorks. Recuperado de [https://la.mathworks.com/help/images/understanding-color-spaces-and-color-space-conversion.html](https://la.mathworks.com/help/images/understanding-color-spaces-and-color-space-conversion.html)

[6] PCMag. (n.d.). YUV. PCMag Encyclopedia. Recuperado de [https://www.pcmag.com/encyclopedia/term/yuv](https://www.pcmag.com/encyclopedia/term/yuv)

[7] McAndrew, A. (2015). A computational introduction to digital image processing. CRC Press."""

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
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
StatsPlots = "f3b207a7-027a-5e70-b257-86293d7955fd"

[compat]
ColorVectorSpace = "~0.10.0"
Colors = "~0.12.11"
Distributions = "~0.25.112"
FileIO = "~1.16.3"
HypertextLiteral = "~0.9.5"
ImageIO = "~0.6.8"
ImageShow = "~0.3.8"
Images = "~0.26.1"
Plots = "~1.40.7"
PlutoUI = "~0.7.60"
StatsBase = "~0.34.3"
StatsPlots = "~0.15.7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.0"
manifest_format = "2.0"
project_hash = "e455de68b30ffbf8273d5c2c8f1c4d73383cfdcf"

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
git-tree-sha1 = "6a55b747d1812e699320963ffde36f1ebdda4099"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.0.4"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

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
git-tree-sha1 = "3640d077b6dafd64ceb8fd5c1ec76f7ca53bcf76"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.16.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = "CUDSS"
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
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

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
version = "1.11.0"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

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
git-tree-sha1 = "009060c9a6168704143100f36ab08f06c2af4642"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.2+1"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "3e4b134270b372f2ed4d4d0e936aabaefc1802bc"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.25.0"
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
git-tree-sha1 = "9ebb045901e9bbf58767a9f34ff89831ed711aae"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.15.7"

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
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "362a287c3aa50601b0bc359053d5c2468f0e7ce0"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.11"

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
git-tree-sha1 = "ea32b83ca4fefa1768dc84e504cc0a94fb1ab8d1"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.2"

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
git-tree-sha1 = "f9d7112bfff8a19a3a4ea4e03a8e6a91fe8456bf"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.3"

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
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fc173b380865f70627d7dd1190dc2fce6cc105af"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.14.10+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "66c4c81f259586e8f002eacebc177e1fb06363b0"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.11"
weakdeps = ["ChainRulesCore", "SparseArrays"]

    [deps.Distances.extensions]
    DistancesChainRulesCoreExt = "ChainRulesCore"
    DistancesSparseArraysExt = "SparseArrays"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "d7477ecdafb813ddee2ae727afa94e9dcb5f3fb0"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.112"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

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
git-tree-sha1 = "4820348781ae578893311153d69049a93d05f39d"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.8.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4d81ed14783ec49ce9f2e168208a12ce1815aa25"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+1"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "62ca0547a14c57e98154423419d8a342dca75ca9"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.4"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

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
git-tree-sha1 = "db16beca600632c95fc8aca29890d83788dd8b23"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.96+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

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

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "532f9126ad901533af1d4f5c198867227a7bb077"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+1"

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

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "674ff0db93fffcd11a3573986e550d66cd4fd71f"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.80.5+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "1dc470db8b1131cfc7fb4c115de89fe391b9e780"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.12.0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "d1d712be3164d61d1fb98e7ce9bcbc6cc06b45ed"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.8"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "401e4f3f30f43af2c8478fc008da50096ea5240f"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.3.1+0"

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

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "2e4520d67b0cef90865b3ef727594d2a58e0e1f8"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.11"

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
git-tree-sha1 = "b2a7eaa169c13f5bcae8131a83bc30eff8f71be0"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.10.2"

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
git-tree-sha1 = "432ae2b430a18c58eb7eca9ef8d0f2db90bc749c"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.8"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "437abb322a41d527c197fa800455f79d414f0a3c"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.8"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "8e2eae13d144d545ef829324f1f0a5a4fe4340f3"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.3.1"

[[deps.ImageMagick_jll]]
deps = ["Artifacts", "Ghostscript_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "OpenJpeg_jll", "Pkg", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "8d2e786fd090199a91ecbf4a66d03aedd0fb24d4"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "6.9.11+4"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "355e2b974f2e3212a75dfb60519de21361ad3cb7"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.9"

[[deps.ImageMorphology]]
deps = ["DataStructures", "ImageCore", "LinearAlgebra", "LoopVectorization", "OffsetArrays", "Requires", "TiledIteration"]
git-tree-sha1 = "6f0a801136cb9c229aebea0df296cdcd471dbcd1"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.4.5"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "LazyModules", "OffsetArrays", "PrecompileTools", "Statistics"]
git-tree-sha1 = "783b70725ed326340adf225be4889906c96b8fd1"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.7"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "3ff0ca203501c3eedde3c6fa7fd76b703c336b5f"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.8.2"

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
git-tree-sha1 = "12fdd617c7fe25dc4a6cc804d657cc4b2230302b"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.26.1"

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
git-tree-sha1 = "be8e690c3973443bec584db3346ddc904d4884eb"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.5"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "10bd689145d2c3b2a9844005d01087cc1194e79e"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2024.2.1+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

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
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

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
git-tree-sha1 = "a0746c21bdc986d0dc293efa6b1faee112c37c28"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.53"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "39d64b09147620f5ffbf6b2d3255be3c901bec63"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.8"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "be3dc50a92e5a386872a493a10050136d4703f9b"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.6.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "fa6d0bcff8583bac20f1ffa708c3913ca605c611"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.5"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "25ee0be4d43d0269027024d75a24c24d6c6e590c"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.4+0"

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
git-tree-sha1 = "854a9c268c43b77b0a27f22d7fab8d33cdb3a731"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.2+1"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "ce5f5621cac23a86011836badfedf664a612cee4"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.5"

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
version = "1.11.0"

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
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "5ee6203157c120d79034c748a2acba45b82b8807"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.1+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LittleCMS_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg"]
git-tree-sha1 = "110897e7db2d6836be22c18bffd9422218ee6284"
uuid = "d3a379c0-f9a3-5b72-a4c0-6bf4d2e8af0f"
version = "2.12.0+0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "a2d09619db4e765091ee5c6ffe8872849de0feea"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.28"

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
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

[[deps.LoopVectorization]]
deps = ["ArrayInterface", "CPUSummary", "CloseOpenIntervals", "DocStringExtensions", "HostCPUFeatures", "IfElse", "LayoutPointers", "LinearAlgebra", "OffsetArrays", "PolyesterWeave", "PrecompileTools", "SIMDTypes", "SLEEFPirates", "Static", "StaticArrayInterface", "ThreadingUtilities", "UnPack", "VectorizationBase"]
git-tree-sha1 = "8084c25a250e00ae427a379a5b607e7aed96a2dd"
uuid = "bdcacae8-1622-11e9-2a5c-532679323890"
version = "0.12.171"

    [deps.LoopVectorization.extensions]
    ForwardDiffExt = ["ChainRulesCore", "ForwardDiff"]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.LoopVectorization.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "oneTBB_jll"]
git-tree-sha1 = "f046ccd0c6db2832a9f639e2c669c6fe867e5f4f"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2024.2.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

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
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "1130dbe1d5276cb656f6e1094ce97466ed700e5a"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.7.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.MultivariateStats]]
deps = ["Arpack", "Distributions", "LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI", "StatsBase"]
git-tree-sha1 = "816620e3aac93e5b5359e4fdaf23ca4525b00ddf"
uuid = "6f286f6a-111f-5878-ab1e-185364afe411"
version = "0.10.3"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "3cebfc94a0754cc329ebc3bab1e6c89621e791ad"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.20"

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
git-tree-sha1 = "1a27764e945a152f7ca7efa04de513d473e9542e"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.14.1"
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
version = "0.3.27+1"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

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
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6703a85cb3781bd5909d48730a67205f3f31a575"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.3+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "949347156c25054de2db3b166c52ac4728cbad65"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.31"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "67186a2bc9a90f9f85ff3cc8277868961fb57cbd"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.3"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e127b609fb9ecba6f201ba7ab753d5a605d53801"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.54.1+0"

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
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

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
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PolyesterWeave]]
deps = ["BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "Static", "ThreadingUtilities"]
git-tree-sha1 = "645bed98cd47f72f67316fd42fc47dee771aefcd"
uuid = "1d0040c9-8b98-4ee7-8388-3f51789ca0ad"
version = "0.2.2"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "RecipesBase", "Requires", "Setfield", "SparseArrays"]
git-tree-sha1 = "1a9cfb2dc2c2f1bd63f1906d72af39a79b49b736"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "4.0.11"

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
version = "1.11.0"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "8f6bc219586aef8baf0ff9a5fe16ee9c70cb65e4"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.10.2"

[[deps.PtrArrays]]
git-tree-sha1 = "77a42d78b6a92df47ab37e177b2deac405e1c88f"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.2.1"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "cda3b045cf9ef07a08ad46731f5a3165e56cf3da"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.1"

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
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

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
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

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
git-tree-sha1 = "98ca7c29edd6fc79cd74c61accb7010a4e7aee33"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.6.0"

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
git-tree-sha1 = "ff11acffdb082493657550959d4feb4b6149e73a"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.5"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"
version = "1.11.0"

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
git-tree-sha1 = "4b33e0e081a825dbfaf314decf58fa47e53d6acb"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.4.0"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "2da10356e31327c7096832eb9cd86307a50b1eb6"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2f5d4697f21388cbe1ff299430dd169ef97d7e14"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.4.0"
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
git-tree-sha1 = "87d51a3ee9a4b0d2fe054bdd3fc2436258db2603"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "1.1.1"

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
git-tree-sha1 = "eeafab08ae20c62c44c8399ccb9354a04b80db50"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.7"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

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
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "b423576adc27097764a90e163157bcfc9acf0f46"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.2"

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

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

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
version = "1.11.0"

[[deps.ThreadingUtilities]]
deps = ["ManualMemory"]
git-tree-sha1 = "eda08f7e9818eb53661b3deb74e3159460dfbc27"
uuid = "8290d209-cae3-49c0-8002-c8c24d57dab5"
version = "0.5.2"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "38f139cc4abf345dd4f22286ec000728d5e8e097"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.10.2"

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
version = "1.11.0"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "d95fe458f26209c66a187b1114df96fd70839efd"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.21.0"

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
git-tree-sha1 = "e7f5b81c65eb858bed630fe006837b935518aca5"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.70"

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

[[deps.Widgets]]
deps = ["Colors", "Dates", "Observables", "OrderedCollections"]
git-tree-sha1 = "fcdae142c1cfc7d89de2d11e08721d0f2f86c98a"
uuid = "cc8bc4a8-27d6-5769-a93b-9d913e69aa62"
version = "0.6.6"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c1a7aa6219628fcd757dede0ca95e245c5cd9511"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "1.0.0"

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
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "555d1076590a6cc2fdee2ef1469451f872d8b41b"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.6+1"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "936081b536ae4aa65415d869287d43ef3cb576b2"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.53.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1827acba325fdcdf1d2647fc8d5301dd9ba43a9d"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.9.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e17c115d55c5fbb7e52ebedb427a0dca79d4484e"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.2+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

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
git-tree-sha1 = "b70c870239dc3d7bc094eb2d6be9b73d27bef280"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.44+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "7dfa0fd9c783d3d0cc43ea1af53d69ba45c447df"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+1"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "490376214c4721cdaca654041f635213c6165cb3"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+2"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.oneTBB_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7d0ea0f4895ef2f5cb83645fa689e52cb55cf493"
uuid = "1317d2d5-d96f-522e-a858-c73665f53c3e"
version = "2021.12.0+0"

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
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╟─69376a37-b807-4ba3-8b1a-3ce75f6a89e6
# ╟─d10e8d7b-4bb4-4a07-b187-27398005974d
# ╟─ab78e5c6-1d72-4443-ab02-ca841668dce5
# ╟─85a2f3ce-482a-417a-9b17-238b8c468caf
# ╟─3259395b-4af3-4e59-ba4c-7e652bbb0842
# ╠═6013c427-44da-44ce-bb61-3485cc326f01
# ╟─21dd2bb3-2290-4de8-8ef8-e319d7ed1f9b
# ╟─0fe3dea5-4b20-4524-9cc5-67954323afe1
# ╟─4983e5dc-a0a2-4c3f-9656-0ac670bb3f57
# ╟─a504d609-5bc9-4df1-8607-972fa9f02331
# ╠═8f138903-29c5-4f27-ad26-46872823f30f
# ╟─76a1c4bd-9176-4646-b004-6ab40468095e
# ╠═3aea3830-27ad-4b12-9048-86c45c7dbd90
# ╟─c9a94e3a-6f3c-498d-9dc7-245c1614b228
# ╠═8d36189d-dd66-420d-98a7-b4242f1eb4a8
# ╟─f53a09e5-b9b2-4f5d-bff4-53321e41693d
# ╟─c4932ec0-5ebe-4f7e-9658-9161ee4dfb5f
# ╟─458c9552-e895-4599-bc0d-3e36aa2b425a
# ╟─170ad99c-0fc9-4e1c-a658-24e013f0a65f
# ╠═62886672-a4d1-466c-b726-30970da835ae
# ╟─4fa370cb-9e66-4f54-b9ee-b8a2e52e2056
# ╠═7a455519-99ff-4420-9fb0-ac557e539301
# ╟─f84c39f7-c307-411b-9353-bc1d4408affa
# ╠═7ede764b-a68e-4a33-8a5f-14aa19d1e4d8
# ╟─26b5c683-18ba-4f5a-bfc1-5f6a67b87aae
# ╠═d286e195-1cba-40eb-9ff6-ca4335bd01ff
# ╟─9e38213e-7629-4e52-a5d6-1a19453addfe
# ╠═6e62bb42-4b32-419b-8114-a0b27a863577
# ╟─7a0d66e0-1045-4b74-b838-0d480db714bb
# ╠═e886c58a-2720-43e8-916f-a34c3976c04d
# ╟─3a6847d6-52c5-4b98-b6ed-3ee3bfb93b7d
# ╟─841c7690-3903-4f10-8ed4-65f33fef15d8
# ╠═041305d7-1b61-41fe-aba0-5bd283f70ce2
# ╟─3be5741e-5a16-41e2-9b91-4febc3aacc38
# ╠═858bed86-6ccf-4454-b7ab-be3519c63eac
# ╟─5a975a49-a101-43d0-9677-ad2f6ee840b8
# ╠═648ce77c-2fa2-4d95-a759-fc65515dfd67
# ╟─071eaf55-5d9b-4abd-a517-a59c399093de
# ╠═7d306619-0e61-453f-a155-ba0f823b2414
# ╠═c8eaa0fa-011a-4668-af4b-2f2838c0200e
# ╟─16a0fca0-3086-4477-bc8c-0ba5be7792fa
# ╠═5ead5cc6-dfc1-485e-a2d6-c08fe9554c2e
# ╟─58fe7c61-a29e-4013-b16c-e687c9164fc2
# ╟─9841cb7a-6282-4b71-9c5b-a6ba0ad7ddef
# ╟─935a567e-24ae-49d5-833c-89e5a7d11566
# ╟─66e9b0bf-21f1-4e51-b83f-f1be71ff391e
# ╟─99f1e042-caa2-4d18-8177-34f886876ef2
# ╟─5f743c4f-3bd7-4979-a5eb-cc5aeced6777
# ╟─9a92ad72-2e74-4461-bf6a-7e377696e779
# ╟─7b62a3d2-6362-4d19-8158-a79b2dd2f423
# ╟─e16bebb4-556c-40ba-a465-bf7c9f9b0fb8
# ╟─f4333289-f350-4670-8b4d-5770bc602d19
# ╟─4fa17deb-d617-4149-bde3-034dd3326329
# ╟─1007f67f-5895-4d88-b3ea-b65abd578b60
# ╟─ed50d1e0-ce07-4572-b889-0949e191fd83
# ╟─f8dbf824-a5d4-4360-af10-4bb962239cf8
# ╟─27fa6ad4-2946-457f-b880-0c56de30711e
# ╟─bb402045-312c-4b11-91ec-e4c86294e80b
# ╟─895ae5b2-3a9e-4ce0-86ee-414e53bfff63
# ╟─be669c5e-1181-4e12-8038-4d1d7bf3c558
# ╟─ce573e5b-5d66-4f07-832d-45279813bc1f
# ╟─cf559d3d-625f-4a24-898b-6f8f992d96bf
# ╟─0038eaef-b21e-4134-aaa9-0aa4b97040bf
# ╟─da76b869-5f5d-4943-9dea-537af40cd244
# ╟─ed57733c-8fb7-42a7-a2e6-bbfa49521d96
# ╟─505dca82-0eec-4068-b7d7-ce5184a4f280
# ╟─fd1d9539-b29c-436e-810d-d1a301a107d8
# ╟─a08d4836-0a6f-43a1-ba55-f106223811d1
# ╟─0b26b02d-0287-4fa6-ad26-74316de84b44
# ╟─b0518a53-89e0-48c0-9db3-aa24219cb330
# ╟─d8176e80-2558-470e-9043-a009fe57b3ab
# ╟─35c76ddf-2d53-4b07-9988-d49abb65ef70
# ╟─df657372-48d8-4dc8-a949-aadef2220511
# ╟─6a0dd188-51e0-4e58-b46d-e1d25927b446
# ╠═e9b9ce5c-be98-4bdf-ba0f-69a7cddd6bfa
# ╠═b366b266-dc83-4b60-b62b-71447a872519
# ╠═c7d2b404-74e5-4606-97de-73bbb66477f7
# ╠═980da483-0e30-4973-83da-ff5c2b409a13
# ╠═f11f0a38-80d3-4383-9ed1-6fa556efc98f
# ╠═c61eaf53-568c-4db6-b4d7-4b6cc67ceaba
# ╠═21a6e96a-b744-4173-9f18-39f825063a6a
# ╠═456eb878-dc37-46e2-8c53-0f6bd6489feb
# ╠═4b1e5e1b-121d-49a4-9e36-b5a47d86b414
# ╟─65ae4195-fc70-4076-bbca-a6b43ece75cf
# ╟─cdc98503-e26e-4608-b041-ba32fa12325c
# ╟─13d12821-68f2-4c4c-ab69-f0e67a6e9793
# ╟─57c76756-2f19-4c85-a4f1-308860ed3020
# ╟─74cf7e53-d17c-4327-a395-26792b07a4df
# ╟─baaf7cc2-2933-4a1f-99c9-458a0cae0095
# ╟─749ff365-e249-4d05-ad0c-d6a10f8e9956
# ╟─c754f505-ec3b-4c7d-b39d-54d39ae5d32c
# ╟─f495bebc-5d3f-4f4e-a645-01c454164012
# ╟─d4cdc837-f791-4add-9729-809153d1e5d8
# ╟─20fad2ff-77b6-4428-98f9-f2ef147d5dd9
# ╠═09a36d89-b9cd-4adc-bcb7-c1812cdd89ba
# ╟─20d255b3-0eb2-41c3-b6b1-aab7d08ba16c
# ╠═96460cc0-0191-4e6a-b560-ca712bb251bd
# ╠═bcaeacca-63cd-49e0-915a-14ceaaacc98d
# ╠═f299663b-c7d2-45a6-b1e2-dc5d6890efd2
# ╟─d0ff380a-3235-4e9d-990f-22f2f94ee7fe
# ╟─5a74bb35-bd65-4e42-a112-f71cdf336682
# ╟─20cedaf5-ece2-4b20-82e2-9815a51e841e
# ╟─0df909e9-1907-4def-9844-8364abeebfe0
# ╟─ddd71b1f-7867-4603-a0fb-ccd86265b839
# ╟─5f20feec-b0a5-4c94-a07d-5f84059f1d15
# ╟─8e0bf959-2faf-4821-bb25-1b590edab1bf
# ╟─60ea5c79-9830-4977-9867-08cab423bbd7
# ╟─19288a59-0392-46c8-a946-c4f10613e0e0
# ╟─5652fd36-bde9-4084-9cbf-9e6e62381f79
# ╟─7bbea68e-46e8-4739-8d45-a4008d767934
# ╟─f10c3863-89b9-4913-a095-7feb46827238
# ╟─f7e94893-886f-4131-896c-e9cc322cad68
# ╟─bc25c3ac-8de8-4b8d-8b3a-397421f05f83
# ╟─a38e06ea-6e86-4feb-8bae-e8a74192adcc
# ╟─070824d2-fb08-4323-87cf-93f5442e533d
# ╟─dc8fe48a-2a02-4ac2-9a5d-7eff264e6792
# ╠═daf2fcd8-9d4f-40ba-bfa3-6fd33f532aaf
# ╠═37537b42-228b-4fc3-8218-27fca454bef5
# ╠═b90774df-cbfb-4b67-a49b-2481d5e444f4
# ╠═85fa46bd-7873-4d2e-8449-e2029e5f3c04
# ╠═6073f551-5f38-444e-b9f8-903aea1bd476
# ╠═159721cc-2899-4685-a4ff-47401d388271
# ╟─41db01ba-af3a-43e4-b572-884a4820da83
# ╟─10584a0d-efc7-46fb-b0d8-dab738842fca
# ╟─deb95abb-bbb0-437d-b359-ca9475a50cad
# ╟─fc1caf73-cf17-47ab-8367-8b4ea1b6c74c
# ╟─79ad57d8-b2ae-4721-804b-1749bcc710c6
# ╟─a675264a-777a-4809-8372-c46333eab0ba
# ╟─0f327941-098c-4030-b868-7a1b3bb5c4fb
# ╟─b1e736cc-f330-4c2c-9156-d560807b575f
# ╟─608851fe-9281-487d-ba20-a2186816d2e1
# ╟─cbc12e57-2d16-4541-ab72-fb1a9d14563d
# ╟─98378c96-6a33-4419-a1ef-fbd5e6b9b15d
# ╟─103a9b75-0424-4c7b-97ca-13cfaaff2725
# ╟─742c3af1-1639-469e-bc58-c2816cb13f8e
# ╟─6c8c4b2f-775a-493e-b986-7fd921a083f7
# ╟─4484331a-f74e-4f72-b43c-6c3ade5d5687
# ╟─e1594a1d-5b76-4e73-8133-3d2ba4b27a95
# ╟─f8ce4130-9ba6-4a3e-b630-bb709521ffa2
# ╟─ba17c664-07be-4f2e-a0b4-abd6632ac87e
# ╟─40706af2-fc1d-4ae0-acca-64d362662664
# ╟─da86eb54-ac72-4d9a-9788-1044185fbafa
# ╟─9849bf25-ddbe-4ac3-8400-afc04c93db81
# ╟─20a95407-0b33-46c1-9fb8-b5f4c2490c63
# ╠═2fa13862-4d50-4cc7-926c-d715147b56f1
# ╠═87355aa8-2c36-4fdc-917d-7d259400d16c
# ╟─d499009e-37f9-4be0-9676-64c881f57b25
# ╠═1e589995-c097-4378-bb39-f14b0e1903c6
# ╟─b692374a-685c-4c3a-b5a5-1595225f90e5
# ╟─dab700dc-2f99-4f06-b2ff-16387ad1dbb4
# ╠═18b7b972-4cc0-42a6-bb3a-daf886990d9f
# ╟─d048876f-43cc-4bf7-84b7-932422b223f5
# ╟─2ac47708-fd5b-4f12-8b3f-84111cff43f5
# ╠═00609a19-b333-4c2f-8133-f49fc6ff3f69
# ╠═d72c680c-cbfa-4d9b-aa2b-baa509632211
# ╟─032a66eb-d63f-4776-84c6-0ba4dfbb07c6
# ╟─5fd669d9-4d51-4afe-8503-3f787dbd5d1a
# ╟─942adb72-0acc-4d73-8dc3-3f7cb591caa2
# ╟─1423f7bd-075e-4cad-bbf6-3557e2c357a8
# ╟─ad8239cc-604d-4eca-9621-5c3218b411e9
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
