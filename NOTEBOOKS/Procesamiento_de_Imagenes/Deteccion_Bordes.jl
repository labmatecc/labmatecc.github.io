### A Pluto.jl notebook ###
# v0.20.5

using Markdown
using InteractiveUtils

# ╔═╡ 6713acb0-c521-11ef-06ce-8942b7488bb8
using PlutoUI

# ╔═╡ 1b555545-a928-4af8-988b-129488d360d8
begin
	using Plots,Colors,ColorVectorSpace,ImageShow,FileIO,ImageIO
	using HypertextLiteral
	using Images, ImageShow 
	using TestImages, ImageFiltering
	using Statistics,  Distributions, LinearAlgebra
	using StatsBase, StatsPlots
	using Images
end

# ╔═╡ 4b70e335-e5fe-4168-8532-e4bebdcb78ff
PlutoUI.TableOfContents(title="Detección de bordes", aside=true)

# ╔═╡ b4bacb19-324f-4899-ad9c-b99c3b9badea
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**.

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 113a6488-ca77-4648-bb68-46fd1ba0f100
md"""**Este cuaderno está basado en actividades del seminario Procesamiento de Imágenes de la Universidad Nacional de Colombia, sede Bogotá, dirigido por el profesor Jorge Mauricio Ruíz en 2024-2.**

Elaborado por Juan Galvis, Jorge Mauricio Ruíz."""

# ╔═╡ cc5d746f-1c38-4ae9-a007-8f9224dc7ff1
md"""Vamos a usar las siguientes librerías:"""

# ╔═╡ 3c5bf908-21fb-4e00-b518-14204d1934c5
md"""
# Introducción
"""

# ╔═╡ e39d5424-e21a-4d14-bb85-fab59a9d7e61
md"""
Hemos explorado diversos conceptos fundamentales del procesamiento de imágenes, desde transformaciones básicas hasta técnicas para mejorar y analizar sus características. En este cuaderno nos enfocaremos en una tarea fundamental en la comprensión y segmentación de imágenes: la detección de bordes.

La **detección de bordes** es un procedimiento que identifica los límites de los objetos dentro de una imagen. Esta labor resulta esencial en el análisis de imágenes, ya que permite reconocer figuras, segmentar regiones y extraer características clave. A continuación, se introducen algunas técnicas orientadas a este propósito.
"""

# ╔═╡ 46a2aa32-0727-49f2-a5c5-a438fb316681
md"""
# Método del Gradiente
"""

# ╔═╡ 651d2183-3e2c-434e-9f16-290892c56f81
md"""
Los métodos de detección de bordes consisten en identificar cambios bruscos y significativos en la intensidad de la luz dentro de una imagen. Una herramienta probada y confiable para medir este cambio es la derivada.

Denotemos por $f(x,y)$ la intensidad de la luz en el punto $(x,y)$, Así, la tasa de cambio de la intensidad de luz en dirección del eje $x$, en el punto $(a,b)$, está dada por la derivada parcial:
"""

# ╔═╡ 92b16f5e-4123-4601-af30-824fc2b5072e
md"""
$f_x(a,b) = \lim_{h \rightarrow 0} \frac{f(a+h,b)-f(a,b)}{h}$
"""

# ╔═╡ 1ae8bd14-5c0e-4918-a909-ac9303e1f75f
md"""
Sin embargo, cuando trabajamos con imágenes digitales, el valor más pequeño que $h$ puede tomar es $h=1$. Por lo tanto, la derivada parcial en dirección $x$ se puede aproximar como:
"""

# ╔═╡ cf9561d3-8ea3-4dc0-94e7-483ffb74e4a7
md"""
$f_x(a,b) \approx f(a+1,b) - f(a,b)$
"""

# ╔═╡ 1e6325df-34a7-45d6-94d0-09684f39a5d0
md"""
De manera similar, la tasa de cambio de la intensidad de luz en direccion del eje $y$:
"""

# ╔═╡ 7c9acb49-741c-4e19-b229-09d9fa14524f
md"""
$f_y(a,b) \approx f(a,b+1) - f(a,b)$
"""

# ╔═╡ 46a4f0c3-1c2f-4e85-ab96-e55b07eabe89
md"""
Recordemos que una imagen digital en escala de grises $A$ puede considerarse como una función de dos variables enteras $m$ y $n$. El valor $A = A(m,n)$ representa la intensidad de la luz en el píxel ubicado en $(m,n)$, donde $m$ corresponde a la posición vertical del píxel y $n$, a su posición horizontal.

De esta forma, podemos aproximar su tasa de cambio en dirección horizontal como:
"""

# ╔═╡ ceba1255-8401-45fd-8cda-23127e292b76
md"""
$G_x(m,n) = A(m,n+1) - A(m,n)$
"""

# ╔═╡ a849d800-d560-4ff5-9813-069a3cdb1800
md"""
Y, de manera análoga, en dirección vertical:

"""

# ╔═╡ 76715d35-af08-449b-8dc3-7ce8b9b7dd0f
md"""
$G_y(m,n) = A(m+1,n) - A(m,n)$
"""

# ╔═╡ 17dd73b9-bacf-427a-8a2b-fc62ddf531a7
md"""
Recordemos, por otro lado, que el **vector gradiente** de una función diferenciable $f$ de dos variables $x$ e $y$, en el punto $(a,b)$, se define como:
"""

# ╔═╡ 07f12cb1-276b-4f0f-ab26-f6330ed90451
md"""
$\nabla f(a,b) = f_x(a,b)\textbf{i}+ f_y(a,b)\textbf{j}$
"""

# ╔═╡ f3ca0f82-2f54-4a4f-a78b-d2b836fb65ba
md"""
Donde $f_x(a,b)$ y $f_y(a,b)$ son las derivadas parciales de $f$ con respecto a $x$ e $y$ respectivamente.
"""

# ╔═╡ 0596ac0b-831f-4e1d-9b7e-5cc6ff815ee7
md"""
Su $\underline{\text{magnitud}}$ está dada por:
"""

# ╔═╡ 9cdddfd8-6e95-46ce-aba5-28b8a45870b0
md"""
$\| \nabla f(a,b)\| = \sqrt{f_x(a,b)^2 + f_y(a,b)^2}$
"""

# ╔═╡ c384b872-39e3-42c4-8fa8-17e9132df8f2
md"""
y representa la **tasa de cambio máxima** de $f$ en el punto $(a,b)$.
"""

# ╔═╡ aecb8c50-2d08-4dce-8c15-f510c0aee0d5
md"""
La $\underline{\text{direccion}}$ $\theta$ del vector gradiente, se puede determinar mediante la ecuación:
"""

# ╔═╡ 7bc09fd4-296e-4d1d-9162-a6b96dfa8eb8
md"""
$\tan{\theta} = \frac{f_y(a,b)}{f_x(a,b)}$
"""

# ╔═╡ 2978be1a-f219-480c-8621-a2831d5cd3ab
md"""
e indica la **dirección en la que $f$ aumenta más rápidamente** en el punto $(a,b)$.
"""

# ╔═╡ e52e663a-b713-428a-b9fd-18deffaa5320
md"""
En nuestro contexto de imagenes digitales, la $\underline{\text{magnitud}}$ del **vector gradiente** de la intensidad de luz en el punto $(m,n)$ puede interpretarse como la 'fuerza' general del borde en ese punto. Calculada:
"""

# ╔═╡ d505e609-c8d1-4282-9a5d-70a2dd28cf0e
md"""
$\begin{align*}
\|G(m,n)\| &= \sqrt{G_x(m,n)^2 + G_y(m,n)^2}\\
&= \sqrt{| A(m,n+1) - A(m,n) | ^2 + | A(m+1,n) - A(m,n)|^2}
\end{align*}$
"""

# ╔═╡ 991350c5-2af4-4ca8-8ae7-6a0cbe0e7d82
md"""
Asimismo, la $\underline{\text{direccion}}$ del **vector gradiente** en el punto $(m,n)$ puede interpretarse como la 'orientación' del borde que pasa por ese punto. Y se aproxima como: 
"""

# ╔═╡ ab3d4423-4dcb-495d-94e8-076957415a73
md"""
$\begin{align*}
\tan{(\theta)} &\approx \frac{G_y(m,n)}{G_x(m,n)} \\ \\
&= \frac{A(m+1,n) - A(m,n)}{A(m,n+1) - A(m,n)}
\end{align*}$
"""

# ╔═╡ 6b593a16-e78f-4dbc-b3ed-24375f62a80f
md"""
Es hora de poner a prueba todas estas consideraciones teóricas. La siguiente imagen es la vista de la fachada de la Casa Pashkov, el edificio principal de la Biblioteca Estatal Rusa en Moscú.
"""

# ╔═╡ cb905eb6-273f-411b-a3c0-4853e5d2ac3a
begin
	url="https://github.com/ytrujillol/Procesamiento-de-imagenes/blob/main/Images/Moscow_July_2011-14a.jpg?raw=true"
	fname = download(url)
	Ant=load(fname)
	A = Gray.(load(fname));
end

# ╔═╡ 10aa4366-4082-48e3-a72f-6567c192af8e
md"""*Figura 1. Casa Pashkov. Imagen tomada de Wikipedia.*"""

# ╔═╡ 43b299c4-0a59-47b8-9623-49da62fc1d0a
md"""
La siguiente función calcula los gradientes vertical y horizontal de una imagen, asi como su respectiva magnitud. 
"""

# ╔═╡ 1c81c5e5-2111-4c31-bce9-63c42e14a0dc
function metodo_gradiente(A)
    M, N = size(A) 
    G = zeros(Float64, M, N)
    Gx = zeros(Float64, M, N)
    Gy = zeros(Float64, M, N)
	
    for m in 1:M-1
        for n in 1:N-1
            Gx[m, n] = abs.(float64(A[m, n + 1]) - float64(A[m, n]))   # Gradiente horizontal
            Gy[m, n] = abs.(float64(A[m + 1, n]) - float64(A[m, n]))   # Gradiente vertical
            G[m, n] = sqrt(Gx[m, n]^2 + Gy[m, n]^2) # Magnitud del gradiente
        end
    end

    return G, Gx, Gy
end

# ╔═╡ ff7236a5-a4a4-4a23-b365-9f47fe1c4d79
md"""
Para una mejor visualización, en la siguiente visualización se aplica función exponencial con $\gamma=0.5$ a las imágenes resultantes de los métodos, con el fin de ver de mejor manera aquellos valores cercanos a cero.
"""

# ╔═╡ 73b0037e-d454-46a5-b218-d9032c3a9671
G, Gx, Gy = metodo_gradiente(A);

# ╔═╡ 60dd8866-f083-4bc9-b6a7-617844281648
begin
    [Gray.(A) RGB.(ones(size(A)[1], 10)) Gray.(Gx.^0.5);
     RGB.(ones(10, size(A)[2])) RGB.(ones(10, 10)) RGB.(ones(10, size(A)[2]));
     Gray.(Gy.^0.5) RGB.(ones(size(A)[1], 10)) Gray.(G.^0.5)]
end

# ╔═╡ fcab4790-2f0c-4f70-bff6-ce0c8b878762
md"""*Figura 2. Aplicación del método del gradiente. Arriba a la izquierda, la imagen original; arriba a la derecha, método del gradiente horizontal; abajo a la izquierda, método del gradiente vertical; abajo a la derecha, método de magnitud del gradiente.*"""

# ╔═╡ ee69cd0d-cd4c-4c93-aedc-37e5c94b416c
md"""
Destaca a simple vista el detalle de las columnas en los gradientes horizontal y vertical. **El gradiente horizontal** resalta las acanaladuras características de la arquitectura romana en los pilares, revelando a grandes rasgos la forma estructural de las columnas. Por otro lado, el **gradiente vertical** genera una sombra rectangular sin ningún detalle. Esto confirma lo que la teoría anticipa: el gradiente vertical percibe las columnas como homogéneas, ya que no detecta cambios en dirección vertical. 

Finalmente, cuando se calcula la $\underline{\text{magnitud}}$ del gradiente, se combinan los cambios de intensidad en ambas direcciones, y es precisamente allí cuando aparecen los bordes de la foto con claridad. De igual manera al anterior ejemplo, se aplica una función exponencial con $\gamma=0.5$ para una mejor visualización.
"""

# ╔═╡ 73310144-5140-4bfc-8baf-ca575dfdf6be
begin
	url1="https://github.com/ytrujillol/Procesamiento-de-imagenes/blob/main/Images/Apuntes.jpg?raw=true"
	fname1 = download(url1)
	B = Gray.(load(fname1));
	G1, Gx1, Gy1 = metodo_gradiente(B);
	nothing
end

# ╔═╡ 3455191f-0b15-4d2b-8260-4cc6febea54d
md"""
Veamos a continuación otro ejemplo:
"""

# ╔═╡ 71f64a9f-36a0-4ca5-9f79-302a3c91542c
begin
    [Gray.(B) RGB.(ones(size(B)[1], 10)) Gray.(Gx1.^0.5);
     RGB.(ones(10, size(B)[2])) RGB.(ones(10, 10)) RGB.(ones(10, size(B)[2]));
     Gray.(Gy1.^0.5) RGB.(ones(size(B)[1], 10)) Gray.(G1.^0.5)]
end

# ╔═╡ 17763dc7-d98c-4bf4-88ec-d155d61c67dc
md"""*Figura 3. Aplicación del método del gradiente sobre imagen de apuntes. Misma distribución de imágenes que en la Figura 2.*"""

# ╔═╡ 88cff233-cfff-4243-b966-287bd3b13cbc
md"""
La hoja cuadriculada ilustra perfectamente el comportamiento de los gradientes vertical y horizontal. Recordemos que los gradientes responden únicamente a los cambios en la dirección de su cálculo. Podemos imaginarlo como un escáner, una recta que recorre la imagen en un solo sentido.

En este contexto, el **gradiente horizontal** aplicado a los apuntes se desliza sobre las líneas horizontales sin detectarlas, ya que estas son continuas y su intensidad de luz es constante. Sin embargo, fuera de ellas, cuando el gradiente horizontal cruza una línea vertical, detecta un cambio abrupto de intensidad: pasa de una intensidad alta, correspondiente a un cuadro blanco, a una intensidad baja, correspondiente a una línea oscura. Es en este punto donde registra el cambio, lo que se refleja en la imagen, donde solo vemos lineas verticales. De manera análoga para el **gradiente vertical** en sentido opuesto.

Finalmente, en la imagen que muestra la $\underline{\text{magnitud}}$ del gradiente, se combinan simultáneamente los cambios de ambas direcciones. El resultado es una representación similar a una fotocopia, donde se resaltan claramente los trazos (o bordes) presentes en la imagen original.
"""

# ╔═╡ 71b07bbb-8bec-4f89-a3cc-dca92c1de74c
begin
	url2="https://github.com/ytrujillol/Procesamiento-de-imagenes/blob/main/Images/mickey.jpg?raw=true"
	fname2 = download(url2)
	C = Gray.(load(fname2));
	G2, Gx2, Gy2 = metodo_gradiente(C);
	nothing
end

# ╔═╡ 2cdec2e8-a7d6-4021-8c53-f265192c2bb6
md"""
Otro ejemplo:
"""

# ╔═╡ a261677a-edc4-4068-bb71-eff15d30d3f9
begin
    [Gray.(C) RGB.(ones(size(C)[1], 10)) Gray.(1 .- Gx2);
     RGB.(ones(10, size(C)[2])) RGB.(ones(10, 10)) RGB.(ones(10, size(C)[2]));
     Gray.(1 .- Gy2) RGB.(ones(size(C)[1], 10)) Gray.(1 .- G2)]
end

# ╔═╡ fe9888f8-c02c-4c5d-870c-8d211f1507f1
md"""*Figura 4. Imagen tomada de [2]. Negativo de la aplicación del método del gradiente. Misma distribución de imágenes que en la Figura 2.*"""

# ╔═╡ 4769a925-394b-4f50-88e2-31cbff226a4f
md"""
Esta imagen, a diferencia de las anteriores, presenta únicamente dos tonalidades. Esto permite que el cálculo de la $\underline{\text{magnitud}}$ del gradiente produzca una representación más limpia, con bordes claramente definidos. El resultado es similar a un dibujo para colorear, donde los contornos resaltan de manera sencilla y precisa.
"""

# ╔═╡ 02a61f53-b110-43b1-9b9b-2d434de85f9b
md"""
En conclusión, el **método del gradiente** es una herramienta efectiva para detectar bordes en imágenes ya que identifica cambios abruptos en la intensidad de los píxeles. La combinación de los gradientes horizontal y vertical, a través de la magnitud, ofrece una representación completa de los bordes. No obstante, como vimos, su capacidad para resaltar detalles depende directamente de las variaciones en la tonalidad y estructura de la imagen.
"""

# ╔═╡ 7f47eb29-9e7d-4679-a937-ef970357940f
md"""**Nota:** A todas las imagenes correspondientes a la magnitud se le aplicó el negativo."""

# ╔═╡ 45ac892f-c288-4754-aab9-59dadf9612bf
md"""
# Operador Cruzado de Roberts
"""

# ╔═╡ bed18606-26c3-4fca-b722-4a33b50d9cb8
md"""
No todas las imágenes están dominadas por líneas horizontales y verticales. A menudo, las líneas diagonales son más predominantes, y es precisamente por esta razón que uno de los detectores de bordes más antiguos jamás desarrollados, el **Operador Cruzado de Roberts**, está diseñado para maximizar su respuesta a los bordes que corren a $45^{\circ}$ con respecto a los ejes coordenados.
"""

# ╔═╡ 00bf4107-9cdb-4f02-bc85-2934552b7ebe
md"""
La derivada de una función diferencial $f$ de dos variables $x$ e $y$. en el punto $(a,b)$, en la dirección del vector $\vec{u} = u_1\vec{i} + u_2\vec{j}$, se define como:
"""

# ╔═╡ 5672b3ca-7dab-466c-a982-dd56a03e084c
md"""
$f_{\vec{u}}(a,b) = \lim_{h \rightarrow 0} \frac{f(a+hu_1, b+hu_2) - f(a,b)}{h \| \vec{u} \|}$
"""

# ╔═╡ dc0e4dc6-e645-4cf5-94da-11d7ebea553c
md"""
donde $\vec{u}$ generalmente se toma como un vector unitario.
"""

# ╔═╡ 9c982d79-b2b5-4bce-b24b-a269b490e19b
md"""
En nuestro contexto, cuando trabajamos con imágenes digitales, el valor más pequeño que $h$ puede alcanzar es $h = 1$. De esta manera, podemos aproximar la **derivada direccional** como:    
"""

# ╔═╡ 5ccfb327-666c-4b68-ba5e-7e778feec244
md"""
$f_{\vec{u}}(a,b) \approx \frac{1}{\|\vec{u}\|}[f(a+u_1,b+u_2) - f(a,b)]$
"""

# ╔═╡ ffe70d14-f3b5-4ab5-9b70-0639ce6b7c1d
md"""
Los dos vectores a $45^{\circ}$ que necesitamos son:	
"""

# ╔═╡ f67df333-f38d-4456-b1c3-a6c588a0f98e
md"""$\vec{u} = \vec{i} + \vec{j} \quad \quad \quad \quad \quad \vec{v} = \vec{i} - \vec{j}$"""

# ╔═╡ d3b0198d-939c-4b0c-98e1-e1d3162a8e74
md"""ambos de magnitud $\sqrt{2}$."""

# ╔═╡ 9708b3df-68e5-4d21-858d-dac8d12a311d
md"""
Las derivadas en las direcciones de estos vectores en el punto $(a,b)$ se pueden aproximar como:
"""

# ╔═╡ 6f65acb8-1b70-4a10-ac17-7ceacaf0184b
md"""
$f_{\vec{u}} (a,b) \approx \frac{\sqrt{2}}{2} [f(a+1,b+1) - f(a,b)]$ 
"""

# ╔═╡ 5bcdc064-b6fb-470e-84cb-ff07553e3012
md"""y"""

# ╔═╡ e0b92450-53ed-4d6d-8735-d2bca80d7eec
md"""
$f_{\vec{v}} (a,b) \approx \frac{\sqrt{2}}{2} [f(a+1,b-1) - f(a,b)]$ 
"""

# ╔═╡ 7448a102-ab0b-4867-b7ba-c4a13abff755
md"""
En el caso de una imagen digital $A$, esto da lugar a:
"""

# ╔═╡ f5ab3f5e-5e56-429c-8668-f889ba852ca8
md"""
$G_1(m,n) = A(m+1,n+1) - A(m,n)$
"""

# ╔═╡ 8ea5d74c-60a4-4198-a2b5-94c8dfb9cff2
md"""y"""

# ╔═╡ 740f96ae-2e33-46e5-a880-30fe1f106db9
md"""
$G_2(m,n) = A(m+1,n) - A(m,n+1)$
"""

# ╔═╡ d8fbb3bd-b1c0-474a-919c-bb03884e31e5
md"""despues de algunos ajustes y escalamientos (para eliminar $\frac{\sqrt{2}}{2}$)."""

# ╔═╡ f91055ed-3d48-4c51-a4dd-54869977e6d9
md"""
Estas dos anteriores formulas describen el funcionamiento del **Operador Cruzado de Roberts** en una imagen digital. Similar al detector de bordes por **Gradiente**, la 'intensidad' del borde en el punto $(m,n)$ se mide mediante:
"""

# ╔═╡ edcb20a3-afe1-44b0-a19a-c1e9b2e04c7f
md"""
$\| G(m,n)\| = \sqrt{G_1(m,n)^2 + G_2(m,n)^2}$
"""

# ╔═╡ 9044af63-5085-4947-9669-a3250d2ecc42
md"""
La siguiente figura muestra una imagen de las pirámides de Guiza, caracterizada por la predominancia de líneas diagonales. Apliquemos los dos métodos de detección de bordes expuestos hasta el momento y analicemos su desempeño.
"""

# ╔═╡ c03fe7b6-d88b-4397-bfd1-c2841dd2e537
begin
	url3="https://github.com/ytrujillol/Procesamiento-de-imagenes/blob/main/Images/piramide.jpg?raw=true"
	fname3 = download(url3)
	D = Gray.(load(fname3));
end

# ╔═╡ a3b70409-f9d1-4f86-a65a-c305b929c663
md"""*Figura 5. Piramides de Guiza. Imagen tomada de [3].*"""

# ╔═╡ e7164555-3ca4-4130-9b0b-28e5a89fd5ac
md"""A continuación, se presenta la función correspondiente al Operador Cruzado de Roberts."""

# ╔═╡ 865ebdf1-a2b4-4be6-a9d0-62af510ae847
function roberts(A)
	M,N = size(A)
	G = zeros(Float64,M,N)
	G1 = zeros(Float64,M,N)
	G2 = zeros(Float64,M,N)

	for m in 1:M-1
		for n in 1:N-1
			G1[m, n] = float64(A[m+1, n+1]) - float64(A[m, n]); #Diagonal en sentido positivo
			G2[m, n] = float64(A[m+1, n]) - float64(A[m, n+1]); #Diagonal en sentido negativo
			G[m, n] = sqrt(G1[m, n]^2 + G2[m, n]^2); #Magnitud
		end
	end

	return abs.(G), abs.(G1), abs.(G2)
end

# ╔═╡ 74ca05b0-d9d1-4145-a863-d4ce8a814546
G_r,G1_r,G2_r = roberts(D);

# ╔═╡ dd1d780c-9bb7-4a3b-a33b-6762a6e5cedc
begin
	D_grad_1,D_grad_2, D_grad= metodo_gradiente(D)
    [Gray.(D) RGB.(ones(size(D)[1], 10)) Gray.(D_grad) RGB.(ones(size(D)[1], 10)) Gray.(G_r)]
end

# ╔═╡ f288e946-bab0-4822-96d2-19d5b480800e
md"""*Figura 6. Piramides de Guiza original a la izquierda; en el centro, aplicación del método del gradiente; a la derecha, aplicación del método de Roberts.*"""

# ╔═╡ b3b8d413-86af-426f-a94b-e39f7b537e51
md"""
Es importante notar que la imagen de las pirámides favorece a la detección de bordes mediante el filtro diagonal, dada la forma de los bordes en la imagen.
"""

# ╔═╡ 12f4cd0b-9e90-4a42-8f6b-783ef61686ae
G_r3,G1_r3,G2_r3 = roberts(A);

# ╔═╡ 7c0ae831-b147-4210-9b71-9d2bad84a740
[Gray.(A) Gray.(G) Gray.(G_r3)]

# ╔═╡ 1bfe0a93-a540-468c-bf2a-8c0fd7593d0d
md"""
*Figura 7. Imagen de la casa Pashkov original a la izquierda; en el centro, aplicación del método de gradiente; a la derecha, aplicación del método de Roberts.*
"""

# ╔═╡ cae0a996-e619-4724-8603-d9ff3d1a3afc
G_r4,G1_r4,G2_r4 = roberts(C);

# ╔═╡ 0ac2047c-6641-4bad-a388-c37eb142bbe9
[Gray.(C) Gray.(1 .- G2) Gray.(1 .- G_r4)]

# ╔═╡ 9a57b1ae-0198-4130-9665-36d62175ce17
md"""
*Figura 8. Imagen de Mickey Mouse original a la izquierda; en el centro, el negativo de la aplicación del método del gradiente; a la derecha, el negativo de la aplicación del método de Roberts.*
"""

# ╔═╡ 5639c253-413d-4152-b551-5be89f4c952a
md"""
Observamos que el método de Roberts resalta mejor los bordes que el método del gradiente en todos los casos, siendo particularmente notoria la diferencia en la imagen de las pirámides.
"""

# ╔═╡ 730d2663-7c4e-4050-af4a-33bb2f848e54
md"""
# Método de Prewitt
"""

# ╔═╡ 15d3b444-cc04-4f9a-922f-8d952f69d757
md"""
En las dos subsecciones anteriores hemos utilizado los conceptos de derivadas parciales y direccionales para desarrollar detectores de bordes rudimentarios. Ahora surge la pregunta: ¿Cómo podemos mejorar y desarrollar aún más nuestros métodos de detección de bordes? 
"""

# ╔═╡ 698b5fa9-651a-413d-a2aa-d1d40e32a96f
md"""
De inmediato se identifican dos posibles áreas de mejora:

- Queremos que los bordes detectados sean mas gruesos y prominentes.
- Queremos que nuestro detector de bordes sea menos susceptible al ruido de la imagen.
"""

# ╔═╡ 99b8fcd0-9423-4c3d-8478-b14ea6899b86
md"""
Ambos objetivos pueden lograrse utilizando estrategias similares. 'Anticipamos' un borde que se aproxima un paso más adelante permitiendo que su rastro 'perdure' un paso adicional, así 'detectamos' aquellos bordes que están ligeramente al costado de nuestro camino principal.
"""

# ╔═╡ 17112ce5-4664-4dac-a962-8e94638dc502
md"""
Pongamos estas ideas en práctica. Calculamos las $\underline{\text{diferencias horizontales}}$ en un punto $(m,n)$, sumando así las diferencias en los valores de los píxeles inmediatamente 'antes' y 'después' de ese punto. De esta manera,
"""

# ╔═╡ cb2b8746-5853-40d2-9c7a-67ca99564477
md"""
$\begin{align*}\triangle_{\leftrightarrow} &= [A(m,n+1) - A(m,n)] + [A(m,n) - A(m,n-1)] \\ \\
&= A(m,n+1) - A(m,n-1)
\end{align*}$
"""

# ╔═╡ 4c157594-2b24-4bcc-a595-fe2ff30014dc
md"""Podríamos hacer lo mismo una fila de píxeles arriba y una fila de píxeles abajo del punto $(m, n)$:"""

# ╔═╡ 6d87f23c-0925-484d-996a-7e7223ff9e5d
md"""
$\begin{align*}\triangle_{\uparrow} &= [A(m+1,n+1) - A(m+1,n)] + [A(m+1,n) - (m+1,n-1)]\\ \\
&= A(m+1,n+1) - A(m+1,n-1)
\end{align*}$
"""

# ╔═╡ b9067573-5134-47ce-b102-a7064589cdb8
md"""y"""

# ╔═╡ 3755e5f6-5ba1-4743-bce5-42b00bde8fbd
md"""
$\begin{align*}\triangle_{\downarrow} &= [A(m-1,n+1) - A(m-1,n)] + [A(m-1,n) - A(m-1,n-1)]\\ \\
&= A(m-1,n+1) - A(m-1,n-1)
\end{align*}$
"""

# ╔═╡ a7a02000-e433-49e8-97c3-75db080d0dbd
md"""
Sumando las ecuaciones:
"""

# ╔═╡ df96f2f8-5e17-4b93-ae29-b478344cc25d
md"""
$\begin{align*}
G_x(m,n) &= \triangle_{\leftrightarrow} + \triangle_{\uparrow} + \triangle_{\downarrow}\\ \\
&= A(m,n+1) - A(m,n-1) + A(m+1,n+1) - A(m+1,n-1) \\ \\ &+ A(m-1, n+1) - A(m-1,n-1)
\end{align*}$
"""

# ╔═╡ 6f25e0c8-364c-41d7-a15d-ad2baa1d3691
md"""Podemos interpretarlo como un sensor ubicado a los costados de cada píxel en cuestión, cuya tarea es detectar la presencia de un borde un paso antes de estar sobre él."""

# ╔═╡ 568b29dc-72cc-46e7-9052-0fc74b495870
begin
	url6="https://github.com/ytrujillol/Procesamiento-de-imagenes/blob/main/Images/horizontal.png?raw=true"
	fname6 = download(url6)
	H = Gray.(load(fname6));
end

# ╔═╡ 5ac1a56e-3632-434a-aa09-3c6e8411f841
md"""
*Figura 9. Ilustración de la columna que se tiene en cuenta en el método de Prewitt*
"""

# ╔═╡ 17006a62-4aca-480a-8049-b0fba2a84a07
md"""
De manera análoga, para las $\underline{\text{diferencias verticales}}$ calculamos: 
"""

# ╔═╡ a23e21c6-8e73-4a84-a181-222af8a83bf4
md"""
$\begin{align*}
G_x(m,n) &= \triangle_{\updownarrow} + \triangle_{\rightarrow} + \triangle_{\leftarrow}\\ \\
&= A(m+1,n) - A(m-1,n) + A(m+1,n+1) - A(m-1,n+1) \\ \\ &+ A(m+1, n-1) - A(m-1,n-1)
\end{align*}$
"""

# ╔═╡ 949eae3b-e226-49ca-8c04-5f215fa196e5
begin
	url7="https://github.com/ytrujillol/Procesamiento-de-imagenes/blob/main/Images/vertical.png?raw=true"
	fname7 = download(url7)
	I = Gray.(load(fname7));
end

# ╔═╡ 75934bc9-cdcc-46bb-8b0c-c1c41063641e
md"""
*Figura 10. Ilustración de la fila que se tiene en cuenta en el método de Prewitt.*
"""

# ╔═╡ 071a29bb-40da-495e-9150-bfcf55f663da
md"""
Finalmente, calculamos la 'fuerza' o 'intensidad' del borde en el punto $(m,n)$ mediante:
"""

# ╔═╡ 60fbd42d-560a-4d92-9ae9-8e11fa624a4e
md"""
$\begin{align*}
\|G(m,n)\| &= \sqrt{G_x(m,n)^2 + G_y(m,n)^2}
\end{align*}$
"""

# ╔═╡ c8455850-d63c-4bc8-b7c7-923fa334e76b
md"""
La dirección $\theta$ del borde en el punto $(m,n)$ puede estimarse mediante:
"""

# ╔═╡ b29be758-dc30-41b5-bd1a-a0323b542487
md"""
$\begin{align*}
\tan{(\theta)} &= \frac{G_y(m,n)}{G_x(m,n)}

\end{align*}$
"""

# ╔═╡ 69a707a5-41dd-4508-8282-e41a51c6a611
md"""de manera similar al caso del detector de bordes por **Gradiente**."""

# ╔═╡ 2a661c14-8747-4b1f-a077-2d9356695a0a
md"""
En conjunto, estas cuatro últimas fórmulas constituyen el **Método de Prewitt** para la detección de bordes. No obstante, $G_x$ y $G_y$ son cálculos engorrosos y poco resumidos, por lo que podríamos comenzar a buscar una notación más eficiente. Afortunadamente, gracias al cuaderno de **Convolución y Filtrado**, contamos con exactamente el tipo de notación y terminología que necesitamos.
""" 

# ╔═╡ cfb9608e-b789-4daf-a92a-70f7abf61b3d
md"""
Todo lo que realmente estamos haciendo al calcular $G_x$ y $G_y$ es tomar la convolución de la imagen con las matrices de filtro:
"""

# ╔═╡ e9e9b82d-2dc9-47cc-8dda-7d7340cbd148
md"""
$P_x = \begin{bmatrix} 1 & 0 & -1 \\ 1 & 0 & -1 \\ 1 & 0 & -1 \end{bmatrix} \quad \quad \text{y}  \quad \quad P_y = \begin{bmatrix} 1 & 1 & 1 \\ 0 & 0 & 0 \\ -1 & -1 & -1 \end{bmatrix}$
"""

# ╔═╡ 41421a54-3c57-4888-aee5-da6ac30516e5
md"""respectivamente. En su forma mas concisa, la acción del **Método de Prewitt** sobre la imagen $A$ puede expresarse como:"""

# ╔═╡ b8596693-af10-478d-b94f-28c62ca18aac
md"""$G_x = A * P_x \quad \quad \quad \text{y} \quad \quad \quad G_y = A*P_y$"""

# ╔═╡ a3829937-d920-415b-873e-7929f17ef888
md"""
La siguiente función corresponde al **Detector de Bordes de Prewitt**:
"""


# ╔═╡ 58ce3ead-36fd-4267-ace7-30842603bdc3
function metodo_prewitt(A)
	Px = [1 0 -1; 1 0 -1; 1 0 -1]
	Py = [1 1 1; 0 0 0; -1 -1 -1]

	Gx = imfilter(A, Px)
	Gy = imfilter(A, Py)

	G = sqrt.(Gx.^2 + Gy.^2)
	return G
end

# ╔═╡ b3eb56ca-f6c4-458d-91db-e2446c7f89c8
[A metodo_prewitt(A)]

# ╔═╡ 789548bf-5d2a-4dbb-8351-01aca4f41313
md"""
*Figura 11. Aplicación del método de Prewitt sobre la imagen de la casa Pashkov.*
"""

# ╔═╡ bb10e114-aa49-42cf-a59d-9ea185e13cf6
[B metodo_prewitt(B)]

# ╔═╡ b8474ebe-7a1c-47b4-a799-5a3c3081d06f
md"""
*Figura 12. Aplicación del método de Prewitt sobre la imagen de apuntes de clase.*
"""

# ╔═╡ b58c468e-2224-4d7c-9e8c-ca9add2ca1f4
[C 1 .- metodo_prewitt(C)]

# ╔═╡ 5828bbf6-92cd-443b-945b-0d1b716c37b3
md"""
*Figura 13. Aplicación del método de Prewitt sobre la imagen de Mickey Mouse.*
"""

# ╔═╡ 18c7cbdf-5fde-4dc0-a478-f89097a26271
md"""
Podemos notar que este método resalta aún mejor los bordes, siendo estos más gruesos que en los anteriores dos métodos; ello se debe a que este método tiene en cuenta una vecindad más grande para determinar el valor de un pixel.
"""

# ╔═╡ 18daed9b-bbaf-4587-8873-588d48e946e3
md"""
# Método de Sobel
"""

# ╔═╡ 84bb12d7-bcfb-4d08-ae29-bb091f59b350
md"""
La construcción del **Detector de Bordes de Prewitt** asigna el mismo peso a todos los píxeles alrededor del punto $(m, n)$. Sin embargo, parece razonable argumentar que los píxeles inmediatamente contiguos en las direcciones vertical y horizontal contribuyen más a la 'intensidad' del borde en ese punto que los píxeles diagonales.
"""

# ╔═╡ 223f1823-71b0-48bf-832a-8e18b1e57f60
md"""Estas consideraciones conducen a lo que se conoce como el **Detector de Bordes de Sobel**, definido por las matrices de filtro:"""

# ╔═╡ ec46985d-2e9f-4e1e-9213-2785b40880c3
md"""
$S_x = \begin{bmatrix} 1 & 0 & -1 \\ 2 & 0 & -2 \\ 1 & 0 & -1 \end{bmatrix} \quad \quad \text{y}  \quad \quad S_y = \begin{bmatrix} 1 & 2 & 1 \\ 0 & 0 & 0 \\ -1 & -2 & -1 \end{bmatrix}$
"""

# ╔═╡ b14db9c9-e780-4f13-aa26-a48777576d84
md"""
Este método puede describirse de manera concisa como:
"""


# ╔═╡ f276d41e-b2c9-4ac2-bd8d-ffe05192db40
md"""$G_x = A * S_x \quad \quad \quad \text{y} \quad \quad \quad G_y = A*S_y$"""

# ╔═╡ eac77951-e5cc-49e2-a25a-c0280c8077a5
md"""
La función correspondiente al **Método de Sobel** se presenta a continuación:
"""

# ╔═╡ f6e38c6a-7cd2-41f9-b212-1455db697d39
function metodo_sobel(A)
	Px = [1 0 -1; 2 0 -2; 1 0 -1]
	Py = [1 2 1; 0 0 0; -1 -2 -1]

	Gx = imfilter(A, Px)
	Gy = imfilter(A, Py)

	G = sqrt.(Gx.^2 + Gy.^2)
	return G
end

# ╔═╡ 752b8464-a5a4-4e44-8d15-fd69839dc3c4
[A metodo_sobel(A)]

# ╔═╡ 3c3bf216-0077-4c09-ad55-ca108cdeb3ae
md"""
*Figura 14. Aplicación del método de Sobel sobre la imagen de la casa Pashkov.*
"""

# ╔═╡ aa8a84ea-3db5-4add-9d79-0676758373ff
[Gray.(A)  metodo_prewitt(A) metodo_sobel(A)]

# ╔═╡ 822470ce-7512-4f2b-87a0-2311b95fc35a
md"""
*Figura 15. Imagen original de la casa Pashkov a la izquierda; en el centro, aplicación del método Prewitt; a la derecha, aplicación del método Sobel.*
"""

# ╔═╡ 393528e1-071b-45df-b811-e2ce4fbbb7dc
[C metodo_prewitt(C) metodo_sobel(C)]

# ╔═╡ c56df18f-60d3-4177-b918-3fdbcfb1b209
md"""
*Figura 16. Imagen original de Mickey Mouse a la izquierda; en el centro, aplicación del método Prewitt; a la derecha, aplicación del método Sobel.*
"""

# ╔═╡ 56439048-6f7a-4b04-ac3c-21cbaf3db85b
[B metodo_prewitt(B) metodo_sobel(B)]

# ╔═╡ 1ab9c985-f644-43c0-b835-b1e8eebd4bc2
md"""
*Figura 17. Imagen original de apuntes de clase a la izquierda; en el centro, aplicación del método Prewitt; a la derecha, aplicación del método Sobel.*
"""

# ╔═╡ fc85c890-787c-446f-a174-eef1a9ee3e58
md"""
Notamos que, usando el método Sobel, los bordes aparecen más brillantes y definidos que respecto al método Prewitt.
"""

# ╔═╡ 46f40f56-694c-4ca2-a9c1-1dc027c27049
md"""
# Detector Laplaciano
"""

# ╔═╡ 4ff3a98b-e95f-453c-a77e-c08baf5c2987
md"""
Todos los métodos de detección de bordes que hemos estudiado hasta ahora miden la tasa de cambio en los píxeles de manera separada en las direcciones de dos ejes ortogonales. Como resultado, estos métodos requieren dos filtros y, en consecuencia, dos convoluciones. Esto nos lleva a preguntarnos: ¿es posible detectar los bordes utilizando un único filtro?
"""

# ╔═╡ a2e76a25-cc61-44a8-a3d8-a44cf33395bb
md"""La respuesta es sí, y el instrumento matemático que podemos utilizar para este propósito se llama **Laplaciano**, que se define para funciones suaves y diferenciables como:
"""

# ╔═╡ 9212fdcd-b8aa-4d63-a350-210be7e8bc59
md"""
$\nabla^2 f(x,y) = f_{xx}(x,y) + f_{yy}(x,y)$
"""

# ╔═╡ fd316d9e-645d-452f-b1f6-d155d4d418ad
md"""
Nuestra primera tarea es derivar una aproximación del Laplaciano en el contexto discreto. Por definición, la segunda derivada parcial de una función suave y diferenciable $f$ con respecto a $x$ está dada por:
"""

# ╔═╡ d0d3498a-bfee-4bd4-8f17-81cf3c8861be
md"""
$f_{xx}(x,y) = \lim_{h \rightarrow 0} \frac{f_x(x+h, y) - f_x(x,y)}{h}$
"""

# ╔═╡ fe0e0154-4fc5-4e4d-a90f-5a690b9eb5ad
md"""En el contexto de imágenes digitales, el valor más pequeño que $h$ puede tomar es $h=1$ o $h=−1$. Sustituimos $h=−1$ en la fórmula y obtenemos:"""

# ╔═╡ 986ddeac-d6ef-4882-bcab-2ade0e27657e
md"""
$\begin{align*}
f_{xx}(x,y) &\approx \frac{f_x(x-1,y) - f_x(x,y)}{-1}\\ \\
&= f_x(x,y) - f_x(x-1,y)
\end{align*}$
"""

# ╔═╡ cb8c3a81-698d-4e68-983b-400cd4e4b3fc
md"""Sustituimos en la expresión obtenida en el **Método del Gradiente**:
"""

# ╔═╡ 942c7419-0d79-489c-bad0-322996e64eda
md"""
$\begin{align*}f_{xx}(x,y) &\approx f(x+1,y) - f(x,y) - [f(x,y) - f(x-1,y)] \\ \\
&= f(x+1,y) - 2f(x,y) + f(x-1,y)
\end{align*}$
"""

# ╔═╡ 913aab27-35a6-4842-9995-2a90114742ed
md"""
De manera análoga,
"""

# ╔═╡ 3bdf2eff-b716-46d3-b3f5-d78bfb4f68f6
md"""
$f_{yy} \approx f(x,y+1) - 2f(x,y) + f(x,y-1)$
"""

# ╔═╡ 0f248157-a39d-48a7-8c77-13ac34ba3518
md"""
Sumando estas dos últimas ecuaciones, obtenemos la aproximación deseada del Laplaciano discreto:
"""

# ╔═╡ b6cf59b0-4b11-47be-91c3-31b05da1320b
md"""
$\begin{align*}\nabla^2 f(x,y) &\approx f(x+1,y) + f(x, y+1) - 4f(x,y) \\ \\ &+ f(x-1,y) + f(x,y-1)\end{align*}$
"""

# ╔═╡ c50e541b-9874-4d78-815f-45b6803c8b0a
md"""Podemos esperar que esta aproximación discreta del operador Laplaciano sea sensible a los cambios en las direcciones de los ejes coordenados. Por lo tanto, es razonable suponer que será eficaz para detectar bordes horizontales y verticales. Sin embargo, como descubrimos al experimentar con el **Operador Cruzado de Roberts**, también es fundamental considerar los bordes diagonales para lograr una detección de bordes más completa."""

# ╔═╡ afa39f6a-a77a-40a3-9c78-48754314912c
md"""Así, procedamos a calcular las segundas derivadas direccionales en las direcciones de los vectores:"""

# ╔═╡ c6845328-023e-4009-a8c7-fc7910da7d35
md"""$\vec{u} = \vec{i} + \vec{j} \quad \quad \quad \quad \quad \vec{v} = \vec{i} - \vec{j}$"""

# ╔═╡ f1c00713-53b5-4f66-b07f-af52bed2d2f5
md"""
Obtendríamos (después de omitir el factor molesto $\frac{\sqrt{2}}{2}$) la siguiente estimación:"""

# ╔═╡ 53f081c3-fb57-4a0a-8f2a-292248979440
md"""
$\begin{align*}\nabla^2 f(x,y) &\approx f(x+1,y+1) + f(x+1, y-1) - 4f(x,y) \\ \\ &+ f(x-1,y-1) + f(x-1,y+1)\end{align*}$
"""

# ╔═╡ 2660118f-72cd-4057-b650-51bb9e149e70
md"""Sumando ahora las estimaciones vertical-horizontal y las diagonales, y factorizando el $-1$, obtenemos la matriz de filtro Laplaciana:"""

# ╔═╡ 9f84955a-019e-4739-890f-741aa0703a67
md""" 
$\large
L = \begin{bmatrix} -1 & -1 & -1 \\ -1 & 8 & -1 \\ -1 & -1 & -1 
\end{bmatrix}$
"""

# ╔═╡ d83269e0-73a5-4c32-89eb-a61fbf3a78f9
md"""La acción del **Detector de Bordes Laplaciano** puede expresarse como:"""

# ╔═╡ 358b804f-e7fb-4871-9395-86917421612b
md"""$G = A*L,$"""

# ╔═╡ 788fd90a-24cc-4daa-94eb-fb73ec642804
md"""ocupando asi una sola convolución a diferencia de los métodos expuestos anteriormente. Es importante mencionar que, si un pixel resultante de la convolución resulta siendo negativo, ello sugiere la presencia de cierta concavidad de la función (lo que ocurre en máximos locales) y si el pixel resulta siendo positivo, ello implica convexidad de la función (lo cual ocurre en mínimos locales). Como nos interesan valores donde esta curvatura sea marcada, sin importar la dirección, tomamos al final el valor absoluto del resultado de la convolución. """

# ╔═╡ 1e79a2ab-244a-4ef5-a561-31f6673aa3b7
function laplaciano(A)
	L = [-1 -1 -1; -1 8 -1; -1 -1 -1]

	G = abs.(imfilter(float64.(A), L))
	return G
end

# ╔═╡ ac1d9e21-866f-4ce9-babb-2d482fc0da58
[A laplaciano(A)]

# ╔═╡ 42255042-55a1-492f-b3a9-44f89418b137
md"""
*Figura 18. Aplicación del filtrado laplaciano sobre la imagen de la casa Pashkov.*
"""

# ╔═╡ 86864051-70ad-4710-83e7-687a7657a25b
[B Gray.(G1) metodo_prewitt(B) metodo_sobel(B) laplaciano(B)]

# ╔═╡ 622731f8-236d-4a72-83d8-16b9f04e8f14
md"""
*Figura 19. Comparación de métodos de detección de bordes sobre imagen de apuntes de clase. De izquierda a derecha: imágen original, aplicación del método del gradiente, aplicación del método de Prewitt, aplicación del método de Sobel, y aplicación del método del laplaciano.*
"""

# ╔═╡ f68ace2b-e1da-4f90-8a2d-9affbad14e94
[D laplaciano(D)]

# ╔═╡ a1057f86-14ad-4ef1-aa9a-be90fbb6eaf0
md"""
*Figura 20. Aplicación del método del laplaciano sobre imagen de las pirámides de Giza.*
"""

# ╔═╡ 19b27ab7-4e0a-4f6e-bb92-da3864759fd2
md"""
# Detector de Bordes en Imagenes con Ruido
"""

# ╔═╡ 881e3f9a-0f70-407a-9a19-3d2a6c99d70e
md"""
En la práctica, todas las imágenes contienen cierto grado de ruido, lo que puede comprometer la eficacia de los detectores de bordes. Aplicar un detector directamente a una imagen ruidosa no siempre produce resultados óptimos, ya que el ruido puede confundirse con los bordes reales. Apliquemos lo aprendido del cuaderno $\texttt{Difuminado y Ruido}$ y apliquemos **Ruido Gaussiano** a las imágenes que hemos venido trabajando con $\sigma = 0.1$ (recuerde que estamos trabajando con valores en una escala entre 0 y 1).
"""

# ╔═╡ 4f9dfc44-2662-4750-a229-7416d5479744
function ruido_gaussiano(A, sigma) 
    M, N = size(A)               
    AWGN = sigma * randn(M, N) #sigma entre (0,1) pues la imagen esta normalizada 
    An = float64.(A) + AWGN                 
    return An
end

# ╔═╡ 16cacfeb-70be-4f40-87a7-656be34d1935
ruido_gaussiano(A,0.1)

# ╔═╡ ec41081f-e622-4842-a556-745d70d2a7a4
md"""
*Figura 21. Imagen de la casa Pashkov con ruido Gaussiano con $\sigma=0.1$.*
"""

# ╔═╡ ecdb0e5d-68ca-400c-be9e-66be72e4a1ba
md"""Ahora veamos como el ruido afecta los anteriores métodos."""

# ╔═╡ bb465631-3e07-4a53-8b42-9139f1f315a5
begin
	Aruid=ruido_gaussiano(A, 0.1);
	Bruid=ruido_gaussiano(B, 0.1);
	Cruid=ruido_gaussiano(C, 0.1);
	Gn, Gxn, Gyn = metodo_gradiente(Aruid);
	Gn1, Gxn1, Gyn1 = metodo_gradiente(Bruid);
	Gn2, Gxn2, Gyn2 = metodo_gradiente(Cruid);
	nothing
end

# ╔═╡ b5148658-c15d-4d80-9f53-a55135a568a1
[Gray.(Gn) metodo_prewitt(Aruid); metodo_sobel(Aruid) laplaciano(Aruid)]

# ╔═╡ e1de3112-2dca-4e94-880a-63992b959707
md"""
*Figura 22. Aplicación de métodos sobre imagen de la casa Pashkov con ruido Gaussiano. Arriba a la izquierda, método del gradiente; arriba a la derecha, método de Prewitt; abajo a la izquierda, método de Sobel; abajo a la derecha, método del laplaciano.*
"""

# ╔═╡ e2bee96d-3123-4710-aae3-fc93fd7e2340
[Gray.(Gn1) metodo_prewitt(Bruid); metodo_sobel(Bruid) laplaciano(Bruid)]

# ╔═╡ 1cf70dea-34b6-4608-9068-696c096b7f29
md"""
*Figura 23. Aplicación de los filtros trabajados a la imagen de apuntes de clase. Misma distribución de imagenes que en la Figura 22.*
"""

# ╔═╡ af1a14fe-cf9c-4a7c-ae2d-10ed4aa852fa
[Gray.(Gn2) metodo_prewitt(Cruid); metodo_sobel(Cruid) laplaciano(Cruid)]

# ╔═╡ 8e079f5f-5f87-4ef4-bf54-cd367cb420e7
md"""
*Figura 24. Aplicación de los filtros trabajados a la imagen de Mickey Mouse. Misma distribución de imagenes que en la Figura 22.*
"""

# ╔═╡ 85eb5f78-c7e5-4159-9929-c09f49a5f35e
md"""Notamos que el detector de bordes laplaciano es el que más se ve afectado por el ruido seguido por el detector de bordes que usa el métodos del gradiente. 
"""

# ╔═╡ 7f524bae-a288-4488-9f48-2e675e973892
md"""Una forma razonable de abordar este problema es intentar reducir el nivel de ruido antes de calcular los bordes, utilizando los métodos descritos en el cuaderno $\texttt{Difuminado y Ruido}$. Intentamos entonces aplicar primero el **Filtro Gaussiano**:"""

# ╔═╡ 121f490d-5a7c-41bf-8acb-d8c362cb7c7a
md""" 
$\large
W = \begin{bmatrix} \frac{2}{25} & \frac{3}{25} & \frac{2}{25} \\ \frac{3}{25} & \frac{5}{25} & \frac{3}{25} \\ \frac{2}{25} & \frac{3}{25} & \frac{2}{25} 
\end{bmatrix}$
"""

# ╔═╡ 6126b2c2-c3c0-4b61-a60e-ffe88bf027aa
md"""
Para el filtro laplaciano, es conveniente analizar las operaciones que se ejecutan. Nótese que el proceso:
"""

# ╔═╡ 29678621-a791-4dc6-b19f-5a49404eaade
md"""$A \longrightarrow A*W \longrightarrow (A*W)*L$
"""

# ╔═╡ a9564957-8db6-489d-87da-113b8fc3db40
md"""requiere dos convoluciones, involucrando matrices de tamaño considerable. ¡Pero hay un truco! Como aprendimos en el cuaderno de $\texttt{Convolución y Filtrado}$, la convolución es asociativa. Por lo tanto, no es necesario realizar los cálculos en este orden ineficiente. En su lugar, podemos usar el siguiente enfoque optimizado:"""

# ╔═╡ 8bcba161-2dc7-4be8-80ce-9995f2495bea
md"""$A \longrightarrow A*(W*L)$
"""

# ╔═╡ 9bf574c6-99c4-49d4-a5aa-a886c3348142
md"""completando el proceso de filtrado de la imagen con una sola convolución."""

# ╔═╡ 2b7c8657-1f82-4015-a434-e61dd6ec1b30
md"""Para esta realización generamos la matriz llamada Laplaciano de **Gaussiana (LdG)** que se obtiene de convolucionar $W$ y $L$. Esto da lugar a:"""

# ╔═╡ 546fc1b8-b442-41a7-914e-21bb91c9c079
md""" 
$\begin{align*}
LdG &= L * W \\ 
&= \begin{bmatrix} 
-1 & -1 & -1 \\ 
-1 & 8 & -1 \\ 
-1 & -1 & -1 
\end{bmatrix} *
\begin{bmatrix} 
\frac{2}{25} & \frac{3}{25} & \frac{2}{25} \\ 
\frac{3}{25} & \frac{5}{25} & \frac{3}{25} \\ 
\frac{2}{25} & \frac{3}{25} & \frac{2}{25} 
\end{bmatrix} \\
&= \frac{1}{25} 
\begin{bmatrix} 
-2 & -5 & -7 \\ 
-5 & 5 & 9 \\ 
-7 & 9 & 20 
\end{bmatrix} 
\end{align*}$
"""

# ╔═╡ 8a61f9d6-94f4-457e-bd17-a42c6da67900
function LaplaGauss(A)
	LdG = (1/25) .* [
		-2 -5 -7 -5 -2;
		-5 5 9 5 -5;
		-7 9 20 9 -7;
		-5 5 9 5 -5;
		-2 -5 -7 -5 -2]

	G = abs.(imfilter(float64.(A), LdG))
	return Gray.(G)
end

# ╔═╡ aaa0704b-1705-4722-b30d-374736ef54e3
[laplaciano(Aruid) LaplaGauss(Aruid)]

# ╔═╡ e1a72480-5dd8-4c57-9717-afcf7ff31e3e
md"""
*Figura 25. Comparación entre aplicación del método laplaciano en la imagen de la casa Pashkov sin eliminación de ruido (izquierda) y con eliminación de ruido (derecha).*
"""

# ╔═╡ ee7cfd7c-2ef7-4425-a6c7-42eeb8f356ae
[laplaciano(Cruid) LaplaGauss(Cruid)]

# ╔═╡ 187a5ec5-d67f-4681-bc60-d2c85bba8c44
md"""
*Figura 25. Comparación entre aplicación del método laplaciano en la imagen de Mickey mouse sin eliminación de ruido (izquierda) y con eliminación de ruido (derecha).*
"""

# ╔═╡ 515a94a7-7882-444a-ab64-9cb8cf765ec3
md"""
Considerando que todas las imágenes tienen un ruido inherente, evaluemos los resultados de aplicar el Detector de Bordes Laplaciano a las imagenes originales:
"""

# ╔═╡ cdaf7fc7-c301-449d-9803-5709aafdc84f
[Gray.(D) LaplaGauss(D)]

# ╔═╡ 815c3090-2294-4d03-bbe0-1fd7509b59bf
md"""
*Figura 26. Aplicación del método laplaciano con eliminación de ruido para la imagen de las pirámides de Giza.*
"""

# ╔═╡ b699df4d-95ff-4965-8a8b-b6c7a37ac613
md"""
# Convolución Booleana y Dilatación de Bordes
"""

# ╔═╡ 60bfb18f-4e9b-40b2-b15b-0639c1e5c3b5
md"""
En caso de que, al aplicar algún método de detección de bordes, el usuario no quede satisfecho, existe un método que permite aumentar el grosor de los bordes obtenidos. Para ello, se asume que la imagen obtenida es de tipo binario, es decir, los pixeles tienen valor $0$ o $1$. Para obtener este tipo de imagen, podemos aplicar, por ejemplo, un condicional sobre la imagen obtenida a apartir de cualquier método (asignar $0$ si el valor del pixel es menor o igual a un valor específico y $1$ en caso contrario). Trabajaremos aquí la imagen de la casa Pashkov con el método Sobel normalizada. El valor de ruptura usado para la creación de la matriz booleana es de $0.8$.
"""

# ╔═╡ f275d0a6-35ff-4396-9c4d-414a00a6cea0
begin
	sob_A=float64.(metodo_sobel(A));
	norm_sob_A=(sob_A .- minimum(sob_A))./(maximum(sob_A)-minimum(sob_A));
	nothing
end

# ╔═╡ b9816868-55b1-4923-b674-555ec76a88b1
begin
	M, N = size(norm_sob_A) 
    sob_A_bool = zeros(Float64, M, N)
	for m in 1:M
		for n in 1:N
			if norm_sob_A[m,n]>0.08
				sob_A_bool[m,n]=1
			end
		end
	end
end

# ╔═╡ f9010c9d-18ca-4845-8dc5-f1cbe11a32d6
Gray.(sob_A_bool)

# ╔═╡ 76bdddc8-f0ca-49fb-91ee-0bb815b325ef
md"""
*Figura 27. Versión binaria de la aplicación del método de Sobel sobre la imagen de la casa Pashkov.*
"""

# ╔═╡ 7a0dd37f-ab2d-46db-bbe1-263b317056d9
md"""
Definimos la *convolución booleana lineal* de una matriz $A$ de tamaño $M\times N$ con un "elemento estructural" $H$ (que no es más que otra matriz binaria) como

$(A \oplus H)(m,n):=\bigvee_{k,l} A(k,l)\land H(m-k,n-l),$
donde $\lor$ hace referencia al operador lógico "or", y $\wedge$, al operador lógico "and". Cuando $H$ tiene dimensiones impares, se suele tomar el número de la posición central como $1$, indicando que esta operación solo modifica aquellos pixeles nulos en la imagen original. Para cada uno de estos pixeles nulo, intuitivamente, esta operación verifica si hay algún valor no nulo en la vecindad del pixel. En caso de ser así, convierte este valor a $1$; en caso, contrario, deja igual este pixel. 

Aplicar esta operación tiene el efecto de ampliar y "redondear" los bordes, así como unir algunas regiones separadas. Realizaremos esta convolución para dos elementos estructurales

$H_1=\begin{pmatrix} 1 & 1 & 1 \\ 1 & 1 & 1 \\ 1 & 1 & 1\end{pmatrix} ~\textup{ y }~ H_2=\begin{pmatrix} 0 & 0 & 0 & 1 & 0 & 0 & 0\\ 0 & 0 & 0 & 1 & 0 & 0 & 0\\ 0 & 0 & 0 & 1 & 0 & 0 & 0 \\ 0 & 0 & 0 & 1 & 0 & 0 & 0\\ 0 & 0 & 0 & 1 & 0 & 0 & 0\\ 0 & 0 & 0 & 1 & 0 & 0 & 0 \\ 0 & 0 & 0 & 1 & 0 & 0 & 0\end{pmatrix}$
"""

# ╔═╡ 00e8ad98-92b8-41d1-a59e-706d96ade34e
begin
	function bool_conv_1(A)
		M,N=size(A)
		H=deepcopy(A)
		for m in 2:M-1
			for n in 2:N-1
				if A[m,n]==0
					for i in -1:1
						for j in -1:1
							if A[m+i,n+j]==1
								H[m,n]=1
								break
								break
							end
						end
					end
				end
			end
		end
		return Gray.(H)
	end
end

# ╔═╡ 0b43d963-5242-4624-80c3-089a578078bf
[Gray.(sob_A_bool) bool_conv_1(sob_A_bool)]

# ╔═╡ 222328ad-3c1b-492f-9bba-daec33bb032d
md"""
*Figura 28. Aplicación booleana con el elemento estructural $H_1$ de la imagen binaria resultante de aplicar el método de Sobel sobre la imagen de la casa de Pashkov.*
"""

# ╔═╡ 23b1f2a0-1b03-4de9-bdaf-e1f5ff5e4496
begin
	function bool_conv_2(A)
		M,N=size(A)
		H=deepcopy(A)
		for m in 4:M-3
			for n in 4:N-3
				if A[m,n]==0
					for i in 1:3
						if A[m-i,n]==1 || A[m+i,n]==1
							H[m,n]=1
						break
						break
						end
					end
				end
			end
		end
		return Gray.(H)
	end
end

# ╔═╡ 54384463-f7c2-4635-bb3d-ae2ecb3ffe4a
[Gray.(sob_A_bool) bool_conv_2(sob_A_bool)]

# ╔═╡ bad4f71a-6ace-40b8-b6c7-8a4894fc6e45
md"""
*Figura 28. Aplicación booleana con el elemento estructural $H_2$ de la imagen binaria resultante de aplicar el método de Sobel sobre la imagen de la casa de Pashkov.*
"""

# ╔═╡ e9e717b3-1e20-4d8a-8401-14c90732a7f4
md"""
Nótese cómo afecta el elemento estructural a los resultados obtenidos. El elemento $H_2$, por ejemplo, amplía únicamente los bordes horizontales.
"""

# ╔═╡ 6fa6f04f-9a30-4ae6-97e2-67cf0ea52d4d
md"""
# Referencias
"""

# ╔═╡ 641a6361-85d0-4918-864e-b8821d9107e8
md"""
[1]

[2] https://mx.pinterest.com/pin/468726273728145498/

[3] https://i.etsystatic.com/28965733/r/il/6a471e/4789778319/il_1080xN.4789778319_2erm.jpg
"""

# ╔═╡ 8c4a1506-3775-4696-a9f6-4d643a98e5a5


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ColorVectorSpace = "c3611d14-8923-5661-9e6a-0046d554d3a4"
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
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

[compat]
ColorVectorSpace = "~0.10.0"
Colors = "~0.12.11"
Distributions = "~0.25.113"
FileIO = "~1.16.6"
HypertextLiteral = "~0.9.5"
ImageFiltering = "~0.7.9"
ImageIO = "~0.6.9"
ImageShow = "~0.3.8"
Images = "~0.26.1"
Plots = "~1.40.7"
PlutoUI = "~0.7.60"
StatsBase = "~0.34.3"
StatsPlots = "~0.15.7"
TestImages = "~1.9.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "51c834a5012bbf99bde0cd64c2cd6bfe64952085"

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
git-tree-sha1 = "9606d7832795cbef89e06a550475be300364a8aa"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.19.0"

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
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "06ee8d1aa558d2833aa799f6f0b31b30cada405f"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.25.2"
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
git-tree-sha1 = "a656525c8b46aa6a1c76891552ed5381bb32ae7b"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.30.0"

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
git-tree-sha1 = "0037835448781bb46feb39866934e243886d756a"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.0"
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
git-tree-sha1 = "b4b092499347b18a015186eae3042f72267106cb"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.6.0"
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
git-tree-sha1 = "3e6d038b77f22791b8e3472b7c633acea1ecac06"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.120"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

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
git-tree-sha1 = "83dc665d0312b41367b7263e8a4d172eac1897f4"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.4"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "3a948313e7a41eb1db7a1e733e6335f17b4ab3c4"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "7.1.1+0"

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "797762812ed063b9b94f6cc7742bc8883bb5e69e"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.9.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6d6219a004b8cf1e0b4dbe27a2860b8e04eba0be"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.11+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "2dd20384bf8c6d411b5c7370865b1e9b26cb2ea3"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.6"
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
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "629693584cef594c3f6f99e76e7a7ad17e60e8d5"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.7"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a8863b69c2a0859f2c2c87ebdc4c6712e88bdf0d"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.7+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

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
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "35fbd0cefb04a516104b8e183ce0df11b70a3f1a"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.84.3+0"

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
deps = ["ArnoldiMethod", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "c5abfa0ae0aaee162a3fbb053c13ecda39be545b"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.13.0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "ed5e9c58612c4e081aecdb6e1a479e18462e041e"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

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
git-tree-sha1 = "eea3a5095c0c5f143e62773164ab11f67e43c4bb"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.10"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs", "WebP"]
git-tree-sha1 = "696144904b76e1ca433b886b4e7edd067d76cbf7"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.9"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "8e64ab2f0da7b928c8ae889c514a52741debc1c2"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.4.2"

[[deps.ImageMagick_jll]]
deps = ["Artifacts", "Ghostscript_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "OpenJpeg_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "afde851466407a99d48829051c36ac80749d8d7c"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "7.1.1048+0"

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
git-tree-sha1 = "7196039573b6f312864547eb7a74360d6c0ab8e6"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.9.0"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "3b5344bcdbdc11ad58f3b1956709b5b9345355de"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.8"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "dfde81fafbe5d6516fb864dc79362c5c6b973c82"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.10.2"

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
git-tree-sha1 = "ec1debd61c300961f98064cfb21287613ad7f303"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2025.2.0+0"

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
git-tree-sha1 = "5fbb102dcb8b1a858111ae81d56682376130517d"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.11"
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
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "PrecompileTools", "ScopedValues", "TranscodingStreams"]
git-tree-sha1 = "d97791feefda45729613fafeccc4fbef3f539151"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.5.15"
weakdeps = ["UnPack"]

    [deps.JLD2.extensions]
    UnPackExt = "UnPack"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

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
git-tree-sha1 = "ba51324b894edaf1df3ab16e2cc6bc3280a2f1a7"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.10"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eb62a3deb62fc6d8822c0c4bef73e4412419c5d8"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.8+0"

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
git-tree-sha1 = "4f34eaabe49ecb3fb0d58d6015e32fd31a733199"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.8"

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
git-tree-sha1 = "a31572773ac1b745e0343fe5e2c8ddda7a37e997"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "321ccef73a96ba828cd51f2ab5b9f917fa73945a"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LittleCMS_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll"]
git-tree-sha1 = "fa7fd067dca76cadd880f1ca937b4f387975a9f5"
uuid = "d3a379c0-f9a3-5b72-a4c0-6bf4d2e8af0f"
version = "2.16.0+0"

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
git-tree-sha1 = "ca7e18198a166a1f3eb92a3650d53d94ed8ca8a1"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.22"

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
git-tree-sha1 = "117432e406b5c023f665fa73dc26e79ec3630151"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.17.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libtiff_jll", "LittleCMS_jll", "libpng_jll"]
git-tree-sha1 = "7dc7028a10d1408e9103c0a77da19fdedce4de6c"
uuid = "643b3616-a352-519d-856d-80112ee9badc"
version = "2.5.4+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "f1a7e086c677df53e064e0fdd2c9d0b0833e3f6e"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.5.0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "87510f7292a2b21aeff97912b0898f9553cc5c2c"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.1+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c392fc5dd032381919e3b22dd32d6443760ce7ea"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.5.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "f07c06228a1c670ae4c87d1276b92c7c597fdda0"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.35"

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
git-tree-sha1 = "275a9a6d85dc86c24d03d1837a0010226a96f540"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.3+0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

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
git-tree-sha1 = "3db9167c618b290a05d4345ca70de6d95304a32a"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.17"

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
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "2d7662f95eafd3b6c346acdbfc11a762a2256375"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.69"

[[deps.PolyesterWeave]]
deps = ["BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "Static", "ThreadingUtilities"]
git-tree-sha1 = "645bed98cd47f72f67316fd42fc47dee771aefcd"
uuid = "1d0040c9-8b98-4ee7-8388-3f51789ca0ad"
version = "0.2.2"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "OrderedCollections", "RecipesBase", "Requires", "Setfield", "SparseArrays"]
git-tree-sha1 = "972089912ba299fba87671b025cd0da74f5f54f7"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "4.1.0"

    [deps.Polynomials.extensions]
    PolynomialsChainRulesCoreExt = "ChainRulesCore"
    PolynomialsFFTWExt = "FFTW"
    PolynomialsMakieExt = "Makie"
    PolynomialsMutableArithmeticsExt = "MutableArithmetics"

    [deps.Polynomials.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    FFTW = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
    Makie = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
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

[[deps.ScopedValues]]
deps = ["HashArrayMappedTries", "Logging"]
git-tree-sha1 = "7f44eef6b1d284465fafc66baf4d9bdcc239a15b"
uuid = "7e506255-f358-4e82-b7e4-beb19740aa63"
version = "1.4.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

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
git-tree-sha1 = "0494aed9501e7fb65daba895fb7fd57cc38bc743"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.5"

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
git-tree-sha1 = "41852b8679f78c8d8961eeadc8f62cef861a52e3"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.5.1"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "95af145932c2ed859b63329952ce8d633719f091"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.3"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "be1cf4eb0ac528d96f5115b4ed80c26a8d8ae621"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.2"

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
git-tree-sha1 = "cbea8a6bd7bed51b1619658dec70035e07b8502f"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.14"
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
git-tree-sha1 = "9d72a13a3f4dd3795a195ac5a44d7d6ff5f552ff"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.1"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "b81c5035922cc89c2d9523afc6c54be512411466"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.5"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "8e45cecc66f3b42633b8ce14d431e8e57a3e242e"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.5.0"

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
git-tree-sha1 = "f2c1efbc8f3a609aadf318094f8fc5204bdaf344"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.1"

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
git-tree-sha1 = "d969183d3d244b6c33796b5ed01ab97328f2db85"
uuid = "8290d209-cae3-49c0-8002-c8c24d57dab5"
version = "0.5.5"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "PrecompileTools", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "02aca429c9885d1109e58f400c333521c13d48a0"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.11.4"

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
git-tree-sha1 = "0fc001395447da85495b7fef1dfae9789fdd6e31"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.11"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

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
git-tree-sha1 = "6258d453843c466d84c17a58732dda5deeb8d3af"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.24.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    ForwardDiffExt = "ForwardDiff"
    InverseFunctionsUnitfulExt = "InverseFunctions"
    PrintfExt = "Printf"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"
    Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "af305cc62419f9bd61b6644d19170a4d258c7967"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.7.0"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "4ab62a49f1d8d9548a1c8d1a75e5f55cf196f64e"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.71"

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

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee71455b0aaa3440dfdd54a9a36ccef829be7d4"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.1+0"

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
git-tree-sha1 = "b5899b25d17bf1889d25906fb9deed5da0c15b3b"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.12+0"

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
git-tree-sha1 = "a4c0ee07ad36bf8bbce1c3bb52d21fb1e0b987fb"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.7+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "9caba99d38404b285db8801d5c45ef4f4f425a6d"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.1+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "a376af5c7ae60d29825164db40787f15c80c7c54"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.3+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a5bc75478d323358a90dc36766f3c99ba7feb024"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.6+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "aff463c82a773cb86061bce8d53a0d976854923e"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.5+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "e3150c7400c41e207012b41659591f083f3ef795"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.3+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "c5bf2dad6a03dfef57ea0a170a1fe493601603f2"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.5+0"

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
git-tree-sha1 = "801a858fc9fb90c11ffddee1801bb06a738bda9b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.7+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "00af7ebdc563c9217ecc67776d1bbf037dbcebf4"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.44.0+0"

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
git-tree-sha1 = "4bba74fa59ab0755167ad24f98800fe5d727175b"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.12.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "125eedcb0a4a0bba65b657251ce1d27c8714e9d6"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.4+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

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
git-tree-sha1 = "07b6a107d926093898e82b3b1db657ebe33134ec"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.50+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "libpng_jll"]
git-tree-sha1 = "c1733e347283df07689d71d61e14be986e49e47a"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.5+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.libwebp_jll]]
deps = ["Artifacts", "Giflib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libglvnd_jll", "Libtiff_jll", "libpng_jll"]
git-tree-sha1 = "ccbb625a89ec6195856a50aa2b668a5c08712c94"
uuid = "c5f90fcd-3b7e-5836-afba-fc50a0988cb2"
version = "1.4.0+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

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
git-tree-sha1 = "fbf139bce07a534df0e699dbb5f5cc9346f95cc1"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.9.2+0"
"""

# ╔═╡ Cell order:
# ╟─6713acb0-c521-11ef-06ce-8942b7488bb8
# ╟─4b70e335-e5fe-4168-8532-e4bebdcb78ff
# ╟─b4bacb19-324f-4899-ad9c-b99c3b9badea
# ╟─113a6488-ca77-4648-bb68-46fd1ba0f100
# ╟─cc5d746f-1c38-4ae9-a007-8f9224dc7ff1
# ╠═1b555545-a928-4af8-988b-129488d360d8
# ╟─3c5bf908-21fb-4e00-b518-14204d1934c5
# ╟─e39d5424-e21a-4d14-bb85-fab59a9d7e61
# ╟─46a2aa32-0727-49f2-a5c5-a438fb316681
# ╟─651d2183-3e2c-434e-9f16-290892c56f81
# ╟─92b16f5e-4123-4601-af30-824fc2b5072e
# ╟─1ae8bd14-5c0e-4918-a909-ac9303e1f75f
# ╟─cf9561d3-8ea3-4dc0-94e7-483ffb74e4a7
# ╟─1e6325df-34a7-45d6-94d0-09684f39a5d0
# ╟─7c9acb49-741c-4e19-b229-09d9fa14524f
# ╟─46a4f0c3-1c2f-4e85-ab96-e55b07eabe89
# ╟─ceba1255-8401-45fd-8cda-23127e292b76
# ╟─a849d800-d560-4ff5-9813-069a3cdb1800
# ╟─76715d35-af08-449b-8dc3-7ce8b9b7dd0f
# ╟─17dd73b9-bacf-427a-8a2b-fc62ddf531a7
# ╟─07f12cb1-276b-4f0f-ab26-f6330ed90451
# ╟─f3ca0f82-2f54-4a4f-a78b-d2b836fb65ba
# ╟─0596ac0b-831f-4e1d-9b7e-5cc6ff815ee7
# ╟─9cdddfd8-6e95-46ce-aba5-28b8a45870b0
# ╟─c384b872-39e3-42c4-8fa8-17e9132df8f2
# ╟─aecb8c50-2d08-4dce-8c15-f510c0aee0d5
# ╟─7bc09fd4-296e-4d1d-9162-a6b96dfa8eb8
# ╟─2978be1a-f219-480c-8621-a2831d5cd3ab
# ╟─e52e663a-b713-428a-b9fd-18deffaa5320
# ╟─d505e609-c8d1-4282-9a5d-70a2dd28cf0e
# ╟─991350c5-2af4-4ca8-8ae7-6a0cbe0e7d82
# ╟─ab3d4423-4dcb-495d-94e8-076957415a73
# ╟─6b593a16-e78f-4dbc-b3ed-24375f62a80f
# ╟─cb905eb6-273f-411b-a3c0-4853e5d2ac3a
# ╟─10aa4366-4082-48e3-a72f-6567c192af8e
# ╟─43b299c4-0a59-47b8-9623-49da62fc1d0a
# ╠═1c81c5e5-2111-4c31-bce9-63c42e14a0dc
# ╟─ff7236a5-a4a4-4a23-b365-9f47fe1c4d79
# ╠═73b0037e-d454-46a5-b218-d9032c3a9671
# ╟─60dd8866-f083-4bc9-b6a7-617844281648
# ╟─fcab4790-2f0c-4f70-bff6-ce0c8b878762
# ╟─ee69cd0d-cd4c-4c93-aedc-37e5c94b416c
# ╟─73310144-5140-4bfc-8baf-ca575dfdf6be
# ╟─3455191f-0b15-4d2b-8260-4cc6febea54d
# ╟─71f64a9f-36a0-4ca5-9f79-302a3c91542c
# ╟─17763dc7-d98c-4bf4-88ec-d155d61c67dc
# ╟─88cff233-cfff-4243-b966-287bd3b13cbc
# ╟─71b07bbb-8bec-4f89-a3cc-dca92c1de74c
# ╟─2cdec2e8-a7d6-4021-8c53-f265192c2bb6
# ╟─a261677a-edc4-4068-bb71-eff15d30d3f9
# ╟─fe9888f8-c02c-4c5d-870c-8d211f1507f1
# ╟─4769a925-394b-4f50-88e2-31cbff226a4f
# ╟─02a61f53-b110-43b1-9b9b-2d434de85f9b
# ╟─7f47eb29-9e7d-4679-a937-ef970357940f
# ╟─45ac892f-c288-4754-aab9-59dadf9612bf
# ╟─bed18606-26c3-4fca-b722-4a33b50d9cb8
# ╟─00bf4107-9cdb-4f02-bc85-2934552b7ebe
# ╟─5672b3ca-7dab-466c-a982-dd56a03e084c
# ╟─dc0e4dc6-e645-4cf5-94da-11d7ebea553c
# ╟─9c982d79-b2b5-4bce-b24b-a269b490e19b
# ╟─5ccfb327-666c-4b68-ba5e-7e778feec244
# ╟─ffe70d14-f3b5-4ab5-9b70-0639ce6b7c1d
# ╟─f67df333-f38d-4456-b1c3-a6c588a0f98e
# ╟─d3b0198d-939c-4b0c-98e1-e1d3162a8e74
# ╟─9708b3df-68e5-4d21-858d-dac8d12a311d
# ╟─6f65acb8-1b70-4a10-ac17-7ceacaf0184b
# ╟─5bcdc064-b6fb-470e-84cb-ff07553e3012
# ╟─e0b92450-53ed-4d6d-8735-d2bca80d7eec
# ╟─7448a102-ab0b-4867-b7ba-c4a13abff755
# ╟─f5ab3f5e-5e56-429c-8668-f889ba852ca8
# ╟─8ea5d74c-60a4-4198-a2b5-94c8dfb9cff2
# ╟─740f96ae-2e33-46e5-a880-30fe1f106db9
# ╟─d8fbb3bd-b1c0-474a-919c-bb03884e31e5
# ╟─f91055ed-3d48-4c51-a4dd-54869977e6d9
# ╟─edcb20a3-afe1-44b0-a19a-c1e9b2e04c7f
# ╟─9044af63-5085-4947-9669-a3250d2ecc42
# ╟─c03fe7b6-d88b-4397-bfd1-c2841dd2e537
# ╟─a3b70409-f9d1-4f86-a65a-c305b929c663
# ╟─e7164555-3ca4-4130-9b0b-28e5a89fd5ac
# ╠═865ebdf1-a2b4-4be6-a9d0-62af510ae847
# ╠═74ca05b0-d9d1-4145-a863-d4ce8a814546
# ╟─dd1d780c-9bb7-4a3b-a33b-6762a6e5cedc
# ╟─f288e946-bab0-4822-96d2-19d5b480800e
# ╟─b3b8d413-86af-426f-a94b-e39f7b537e51
# ╠═12f4cd0b-9e90-4a42-8f6b-783ef61686ae
# ╟─7c0ae831-b147-4210-9b71-9d2bad84a740
# ╟─1bfe0a93-a540-468c-bf2a-8c0fd7593d0d
# ╟─cae0a996-e619-4724-8603-d9ff3d1a3afc
# ╠═0ac2047c-6641-4bad-a388-c37eb142bbe9
# ╟─9a57b1ae-0198-4130-9665-36d62175ce17
# ╟─5639c253-413d-4152-b551-5be89f4c952a
# ╟─730d2663-7c4e-4050-af4a-33bb2f848e54
# ╟─15d3b444-cc04-4f9a-922f-8d952f69d757
# ╟─698b5fa9-651a-413d-a2aa-d1d40e32a96f
# ╟─99b8fcd0-9423-4c3d-8478-b14ea6899b86
# ╟─17112ce5-4664-4dac-a962-8e94638dc502
# ╟─cb2b8746-5853-40d2-9c7a-67ca99564477
# ╟─4c157594-2b24-4bcc-a595-fe2ff30014dc
# ╟─6d87f23c-0925-484d-996a-7e7223ff9e5d
# ╟─b9067573-5134-47ce-b102-a7064589cdb8
# ╟─3755e5f6-5ba1-4743-bce5-42b00bde8fbd
# ╟─a7a02000-e433-49e8-97c3-75db080d0dbd
# ╟─df96f2f8-5e17-4b93-ae29-b478344cc25d
# ╟─6f25e0c8-364c-41d7-a15d-ad2baa1d3691
# ╟─568b29dc-72cc-46e7-9052-0fc74b495870
# ╟─5ac1a56e-3632-434a-aa09-3c6e8411f841
# ╟─17006a62-4aca-480a-8049-b0fba2a84a07
# ╟─a23e21c6-8e73-4a84-a181-222af8a83bf4
# ╟─949eae3b-e226-49ca-8c04-5f215fa196e5
# ╟─75934bc9-cdcc-46bb-8b0c-c1c41063641e
# ╟─071a29bb-40da-495e-9150-bfcf55f663da
# ╟─60fbd42d-560a-4d92-9ae9-8e11fa624a4e
# ╟─c8455850-d63c-4bc8-b7c7-923fa334e76b
# ╟─b29be758-dc30-41b5-bd1a-a0323b542487
# ╟─69a707a5-41dd-4508-8282-e41a51c6a611
# ╟─2a661c14-8747-4b1f-a077-2d9356695a0a
# ╟─cfb9608e-b789-4daf-a92a-70f7abf61b3d
# ╟─e9e9b82d-2dc9-47cc-8dda-7d7340cbd148
# ╟─41421a54-3c57-4888-aee5-da6ac30516e5
# ╟─b8596693-af10-478d-b94f-28c62ca18aac
# ╟─a3829937-d920-415b-873e-7929f17ef888
# ╠═58ce3ead-36fd-4267-ace7-30842603bdc3
# ╟─b3eb56ca-f6c4-458d-91db-e2446c7f89c8
# ╟─789548bf-5d2a-4dbb-8351-01aca4f41313
# ╟─bb10e114-aa49-42cf-a59d-9ea185e13cf6
# ╟─b8474ebe-7a1c-47b4-a799-5a3c3081d06f
# ╟─b58c468e-2224-4d7c-9e8c-ca9add2ca1f4
# ╟─5828bbf6-92cd-443b-945b-0d1b716c37b3
# ╟─18c7cbdf-5fde-4dc0-a478-f89097a26271
# ╟─18daed9b-bbaf-4587-8873-588d48e946e3
# ╟─84bb12d7-bcfb-4d08-ae29-bb091f59b350
# ╟─223f1823-71b0-48bf-832a-8e18b1e57f60
# ╟─ec46985d-2e9f-4e1e-9213-2785b40880c3
# ╟─b14db9c9-e780-4f13-aa26-a48777576d84
# ╟─f276d41e-b2c9-4ac2-bd8d-ffe05192db40
# ╟─eac77951-e5cc-49e2-a25a-c0280c8077a5
# ╠═f6e38c6a-7cd2-41f9-b212-1455db697d39
# ╟─752b8464-a5a4-4e44-8d15-fd69839dc3c4
# ╟─3c3bf216-0077-4c09-ad55-ca108cdeb3ae
# ╟─aa8a84ea-3db5-4add-9d79-0676758373ff
# ╟─822470ce-7512-4f2b-87a0-2311b95fc35a
# ╟─393528e1-071b-45df-b811-e2ce4fbbb7dc
# ╟─c56df18f-60d3-4177-b918-3fdbcfb1b209
# ╟─56439048-6f7a-4b04-ac3c-21cbaf3db85b
# ╟─1ab9c985-f644-43c0-b835-b1e8eebd4bc2
# ╟─fc85c890-787c-446f-a174-eef1a9ee3e58
# ╟─46f40f56-694c-4ca2-a9c1-1dc027c27049
# ╟─4ff3a98b-e95f-453c-a77e-c08baf5c2987
# ╟─a2e76a25-cc61-44a8-a3d8-a44cf33395bb
# ╟─9212fdcd-b8aa-4d63-a350-210be7e8bc59
# ╟─fd316d9e-645d-452f-b1f6-d155d4d418ad
# ╟─d0d3498a-bfee-4bd4-8f17-81cf3c8861be
# ╟─fe0e0154-4fc5-4e4d-a90f-5a690b9eb5ad
# ╟─986ddeac-d6ef-4882-bcab-2ade0e27657e
# ╟─cb8c3a81-698d-4e68-983b-400cd4e4b3fc
# ╟─942c7419-0d79-489c-bad0-322996e64eda
# ╟─913aab27-35a6-4842-9995-2a90114742ed
# ╟─3bdf2eff-b716-46d3-b3f5-d78bfb4f68f6
# ╟─0f248157-a39d-48a7-8c77-13ac34ba3518
# ╟─b6cf59b0-4b11-47be-91c3-31b05da1320b
# ╟─c50e541b-9874-4d78-815f-45b6803c8b0a
# ╟─afa39f6a-a77a-40a3-9c78-48754314912c
# ╟─c6845328-023e-4009-a8c7-fc7910da7d35
# ╟─f1c00713-53b5-4f66-b07f-af52bed2d2f5
# ╟─53f081c3-fb57-4a0a-8f2a-292248979440
# ╟─2660118f-72cd-4057-b650-51bb9e149e70
# ╟─9f84955a-019e-4739-890f-741aa0703a67
# ╟─d83269e0-73a5-4c32-89eb-a61fbf3a78f9
# ╟─358b804f-e7fb-4871-9395-86917421612b
# ╟─788fd90a-24cc-4daa-94eb-fb73ec642804
# ╠═1e79a2ab-244a-4ef5-a561-31f6673aa3b7
# ╠═ac1d9e21-866f-4ce9-babb-2d482fc0da58
# ╟─42255042-55a1-492f-b3a9-44f89418b137
# ╠═86864051-70ad-4710-83e7-687a7657a25b
# ╟─622731f8-236d-4a72-83d8-16b9f04e8f14
# ╠═f68ace2b-e1da-4f90-8a2d-9affbad14e94
# ╟─a1057f86-14ad-4ef1-aa9a-be90fbb6eaf0
# ╟─19b27ab7-4e0a-4f6e-bb92-da3864759fd2
# ╟─881e3f9a-0f70-407a-9a19-3d2a6c99d70e
# ╠═4f9dfc44-2662-4750-a229-7416d5479744
# ╟─16cacfeb-70be-4f40-87a7-656be34d1935
# ╟─ec41081f-e622-4842-a556-745d70d2a7a4
# ╟─ecdb0e5d-68ca-400c-be9e-66be72e4a1ba
# ╟─bb465631-3e07-4a53-8b42-9139f1f315a5
# ╠═b5148658-c15d-4d80-9f53-a55135a568a1
# ╟─e1de3112-2dca-4e94-880a-63992b959707
# ╟─e2bee96d-3123-4710-aae3-fc93fd7e2340
# ╟─1cf70dea-34b6-4608-9068-696c096b7f29
# ╟─af1a14fe-cf9c-4a7c-ae2d-10ed4aa852fa
# ╟─8e079f5f-5f87-4ef4-bf54-cd367cb420e7
# ╟─85eb5f78-c7e5-4159-9929-c09f49a5f35e
# ╟─7f524bae-a288-4488-9f48-2e675e973892
# ╟─121f490d-5a7c-41bf-8acb-d8c362cb7c7a
# ╟─6126b2c2-c3c0-4b61-a60e-ffe88bf027aa
# ╟─29678621-a791-4dc6-b19f-5a49404eaade
# ╟─a9564957-8db6-489d-87da-113b8fc3db40
# ╟─8bcba161-2dc7-4be8-80ce-9995f2495bea
# ╟─9bf574c6-99c4-49d4-a5aa-a886c3348142
# ╟─2b7c8657-1f82-4015-a434-e61dd6ec1b30
# ╟─546fc1b8-b442-41a7-914e-21bb91c9c079
# ╠═8a61f9d6-94f4-457e-bd17-a42c6da67900
# ╠═aaa0704b-1705-4722-b30d-374736ef54e3
# ╟─e1a72480-5dd8-4c57-9717-afcf7ff31e3e
# ╟─ee7cfd7c-2ef7-4425-a6c7-42eeb8f356ae
# ╟─187a5ec5-d67f-4681-bc60-d2c85bba8c44
# ╟─515a94a7-7882-444a-ab64-9cb8cf765ec3
# ╠═cdaf7fc7-c301-449d-9803-5709aafdc84f
# ╟─815c3090-2294-4d03-bbe0-1fd7509b59bf
# ╟─b699df4d-95ff-4965-8a8b-b6c7a37ac613
# ╟─60bfb18f-4e9b-40b2-b15b-0639c1e5c3b5
# ╠═f275d0a6-35ff-4396-9c4d-414a00a6cea0
# ╠═b9816868-55b1-4923-b674-555ec76a88b1
# ╠═f9010c9d-18ca-4845-8dc5-f1cbe11a32d6
# ╟─76bdddc8-f0ca-49fb-91ee-0bb815b325ef
# ╟─7a0dd37f-ab2d-46db-bbe1-263b317056d9
# ╠═00e8ad98-92b8-41d1-a59e-706d96ade34e
# ╟─0b43d963-5242-4624-80c3-089a578078bf
# ╟─222328ad-3c1b-492f-9bba-daec33bb032d
# ╠═23b1f2a0-1b03-4de9-bdaf-e1f5ff5e4496
# ╟─54384463-f7c2-4635-bb3d-ae2ecb3ffe4a
# ╟─bad4f71a-6ace-40b8-b6c7-8a4894fc6e45
# ╟─e9e717b3-1e20-4d8a-8401-14c90732a7f4
# ╟─6fa6f04f-9a30-4ae6-97e2-67cf0ea52d4d
# ╟─641a6361-85d0-4918-864e-b8821d9107e8
# ╟─8c4a1506-3775-4696-a9f6-4d643a98e5a5
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
