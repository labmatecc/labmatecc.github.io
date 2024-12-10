### A Pluto.jl notebook ###
# v0.20.0

using Markdown
using InteractiveUtils

# ╔═╡ 3885aed6-7596-471c-87e4-b246dadbe898
using PlutoUI

# ╔═╡ 87509cb1-de05-41f2-b30e-ad065ccde690
begin
	using Plots,Colors,ColorVectorSpace,ImageShow,FileIO,ImageIO
	using HypertextLiteral
	using Images, ImageShow 
	using Statistics,  Distributions, LinearAlgebra
	using StatsBase, StatsPlots
end

# ╔═╡ 450ce71e-2fcb-4c32-ae96-bba24b7584b1
using Interpolations

# ╔═╡ 855fbf64-5944-460c-a0d4-523066030e4e
PlutoUI.TableOfContents(title="Matrices y transformaciones lineales", aside=true)

# ╔═╡ 00fbe8cf-cd1e-451c-9a30-b83223fe3c10
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**.

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ ecbeadd0-14ba-47ae-826a-d97f0695ef1e
md"""**Este cuaderno está basado en actividades del seminario Procesamiento de Imágenes de la Universidad Nacional de Colombia, sede Bogotá, dirigido por el profesor Jorge Mauricio Ruiz en 2024-2.**

Elaborado por Juan Galvis, Carlos Nosa, Jorge Mauricio Ruíz y Yessica Trujillo."""

# ╔═╡ 3981068a-8063-4f30-bb4b-c954f1780090
md"""Vamos a usar las siguientes librerías:"""

# ╔═╡ 21d43d86-b0cd-43ec-a434-ecb564971d24
md"""
# Introducción
"""

# ╔═╡ 8992f9b8-3660-490e-aed3-8be32742183d
md"""
En este cuaderno se descubrirá que diversas transformaciones de imágenes, como el mezclado, el enmascarado, la rotación y el cambio de perspectiva, pueden realizarse mediante el uso de aritmética matricial, transformaciones lineales y coordenadas homogéneas.
"""

# ╔═╡ 7806626e-81e1-4b48-9756-b8277213d268
md"""
# Operaciones básicas con matrices
"""

# ╔═╡ 98b24728-d29c-4d14-ba92-4e51fdbc7b10
md"""##   $\cdot$ Negativo de una imagen"""

# ╔═╡ dcea8986-c1ed-4dab-976b-b9f4931f051f
md"""Como ya vimos en cuadernos anteriores, las imágenes en escala de grises son matrices de valores de píxeles entre 0 y 255. Así, para generar el negativo de una imagen, debemos "invertir" el brillo de cada píxel. Esto se realiza de la siguiente manera, consideremos $A$ la matriz que representa la imagen y $B$ una matriz del mismo tamaño, es decir, ambas matrices son de tamaño $m\times n$:

$A = 
\begin{bmatrix} 
a_{11} & a_{12} & \cdots & a_{1n} \\ 
a_{21} & a_{22} & \cdots & a_{2n} \\ 
\vdots & \vdots & \ddots & \vdots \\ 
a_{m1} & a_{m2} & \cdots & a_{mn} 
\end{bmatrix}
\quad \text{y} \quad 
B = 
\begin{bmatrix} 
255 & 255 & \cdots & 255 \\ 
255 & 255 & \cdots & 255 \\ 
\vdots & \vdots & \ddots & \vdots \\ 
255 & 255 & \cdots & 255 
\end{bmatrix}$
luego la imagen en negativo es la siguiente:

$B - A = 
\begin{bmatrix} 
255 - a_{11} & 255 - a_{12} & \cdots & 255 - a_{1n} \\ 
255 - a_{21} & 255 - a_{22} & \cdots & 255 - a_{2n} \\ 
\vdots & \vdots & \ddots & \vdots \\ 
255 - a_{m1} & 255 - a_{m2} & \cdots & 255 - a_{mn} 
\end{bmatrix}.$
"""

# ╔═╡ c035d077-763e-46e8-9807-08be974ddf61
md"""La siguiente función halla el negativo de una imagen."""

# ╔═╡ 552aab87-728c-4ec0-b9ee-a41c8a38f51a
function Negativo(image)
	A = Float64.(channelview(image))
	if length(size(A)) == 2
		return Gray.(ones(size(A))-A)
	else
		Ones_Matrix = ones(size(A[1, :, :]))
		return colorview(RGB, permutedims(cat(dims=3, Ones_Matrix-A[1, :, :], Ones_Matrix-A[2, :, :], Ones_Matrix-A[3, :, :]), [3, 1, 2]))
	end
end

# ╔═╡ 8dd43a29-7e88-4b0e-86bc-afd70a5fb04d
md"""A contiuación en la Figura 1 se muestra un tablero de ajedrez con su posición inicial y su negativo."""

# ╔═╡ bf509d53-b239-4514-bdb2-30d5f52219e8
begin
	url="https://upload.wikimedia.org/wikipedia/commons/7/76/Latex_chessboard_4.png"
	fname = download(url)
	imag = Gray.(load(fname))
	[imag Gray.(ones(size(imag)[1], 100)) Negativo(imag)]
end

# ╔═╡ 7ff384fb-e482-4bf9-a70f-34bdd4fa840a
md"""$\texttt{Figura 1. Tablero de Ajedrez. Imagen tomada de Wikipedia.}$"""

# ╔═╡ 0fdf5d20-9fcc-4404-b364-8bdb16237eea
md"""En la Figura 2 se puede evidenciar un conejo en escala RGB y su negativo."""

# ╔═╡ 5886e131-99cf-4ed6-a06c-2b281d710ef6
md"""$\texttt{Figura 2. Conejo. Imagen tomada de Wikipedia.}$"""

# ╔═╡ 6ab9ceda-5fb9-429d-a3f5-e9fd098fe619
md"""##   $\cdot$ Transpuesta de una imagen"""

# ╔═╡ 065a2edb-82b6-428a-9c33-7af11ec75ae1
md"""Ahora si deseamos reflejar una imagen y rotarla 90° en sentido antihorario, todo en un solo paso podemos usar la transposición de la matriz. Formalmente, sea $A$ $(n\times m)$ la matriz asociada a la imagen  

$A = 
\begin{bmatrix} 
a_{11} & a_{12} & \cdots & a_{1n} \\ 
a_{21} & a_{22} & \cdots & a_{2n} \\ 
\vdots & \vdots & \ddots & \vdots \\ 
a_{m1} & a_{m2} & \cdots & a_{mn} 
\end{bmatrix},$
su transpuesta es $A^T ( m \times n)$ definida como:  

$A^T = 
\begin{bmatrix} 
a_{11} & a_{21} & \cdots & a_{m1} \\ 
a_{12} & a_{22} & \cdots & a_{m2} \\ 
\vdots & \vdots & \ddots & \vdots \\ 
a_{1n} & a_{2n} & \cdots & a_{mn} 
\end{bmatrix}.$"""

# ╔═╡ 214d8d87-347c-47ac-8e0f-139f86c68b85
md"""La siguiente función halla la transpuesta de una imagen."""

# ╔═╡ fc100c97-e447-4a7a-b42f-4adb9729bfda
function Transpuesta(image)
	Trans = transpose(channelview(image))
	return Gray.(Trans)
end

# ╔═╡ 5ab89eea-6d7b-490f-96f7-8b4d36249722
md"""A contiuación en la Figura 3 se muestra un conejo y su reflejo y rotación de 90°."""

# ╔═╡ a5c73baf-5367-470d-8e82-2874d5f90fd6
begin
	url1="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Oryctolagus_cuniculus_Rcdo.jpg/640px-Oryctolagus_cuniculus_Rcdo.jpg"
	fname1 = download(url1)
	imag1 = Gray.(load(fname1))[101:700,40:639]
	[imag1 Gray.(ones(size(imag1)[1], 100)) Transpuesta(imag1)]
end

# ╔═╡ cb534937-101c-439d-b515-e0d99212894f
begin
	Imag1 = load(fname1)[101:700,40:639]
	[Imag1 RGB.(ones(size(Imag1)[1], 100)) Negativo(Imag1)]
end

# ╔═╡ cd1e19bd-190d-4d29-9223-485318476099
md"""$\texttt{Figura 3. Rotación de la Figura 2.}$"""

# ╔═╡ 14df04a2-8d3e-4b85-a7a2-e2e455f31e73
md"""##   $\cdot$ Sobreposición de imágenes"""

# ╔═╡ 0709425c-688d-40c3-9c80-eac32426d1b5
md"""Ahora, si deseamos sobreponer una imagen sobre otra, podemos sumar las matrices que representa cada imagen, es decir, sean $A$ y $B$ las matrices que asociadas a dos imágenes, su sobreposición estará dado por: 

$A + B = 
\begin{bmatrix} 
a_{11} + b_{11} & a_{12} + b_{12} & \cdots & a_{1n} + b_{1n} \\ 
a_{21} + b_{21} & a_{22} + b_{22} & \cdots & a_{2n} + b_{2n} \\ 
\vdots & \vdots & \ddots & \vdots \\ 
a_{m1} + b_{m1} & a_{m2} + b_{m2} & \cdots & a_{mn} + b_{mn} 
\end{bmatrix}.$
**Nota:** Para realizar la suma, primero debemos asegurarnos de que las imágenes tengan el mismo tamaño, recortando o extendiendo la más pequeña según sea necesario."""

# ╔═╡ fb3c5fd5-bdd1-4ffb-882b-dffa70c4ab30
md"""La siguiente función halla la sobreposición de dos imágenes."""

# ╔═╡ 80431850-0e2d-4ca8-9589-abd9117382b3
function Sobreposicion(image1, image2)
	A = channelview(image1)
	B = channelview(image2)
	n = min(size(A)[1], size(B)[1])
	m = min(size(A)[2], size(B)[2])
	#Sum = A[1:n,1:m] + B[1:n,1:m]
	#Image_sobre = (Sum .- minimum(Sum))/(maximum(Sum)-minimum(Sum))
	Image_sobre = 0.5*A[1:n,1:m] + 0.5*B[1:n,1:m]
	return Gray.(Image_sobre)
end

# ╔═╡ 7726e89f-04b1-4664-89d8-bcdba5ec4129
md"""Sobrepongamos la Figura 4 la figura 5."""

# ╔═╡ f1af8a95-3d4f-4f7e-bb66-b61b0a19d57d
begin
	url2 = "https://images.unsplash.com/photo-1518877593221-1f28583780b4?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
	fname2 = download(url2)
	imag2 = Gray.(load(fname2))
end

# ╔═╡ 971750a7-dfef-4c44-a703-1ce02dedbe81
md"""$\texttt{Figura 4. Ballena. Imagen recuperada de Unsplash [5].}$"""

# ╔═╡ 895c92f0-6124-446f-a4dd-5a51316a5ed3
begin
	url3 = "https://plus.unsplash.com/premium_photo-1700182582594-ad98628ebc76?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
	fname3 = download(url3)
	imag3 = Gray.(load(fname3))
end

# ╔═╡ 89faf96d-0af9-462d-a84f-6f3505f9a604
md"""$\texttt{Figura 5. Cola de ballena. Imagen recuperada de Unsplash [5].}$"""

# ╔═╡ 005fb905-a248-4bbf-8ceb-0271a1824deb
md"""A continuación en la Figura 6, se muestra la sobreposición de las imágenes."""

# ╔═╡ 5e1b7cfc-ff30-4b45-ad99-89a198dcd5d9
Sobreposicion(imag2, imag3)

# ╔═╡ c1d4d03b-2694-46a0-9a6d-e4b4d67e1bb2
md"""$\texttt{Figura 6. Sobreposición de la Figura 4 y la Figura 5.}$"""

# ╔═╡ aeca23b3-8494-4f1d-b4fb-09e523e3f78a
md"""Consideremos otro ejemplo."""

# ╔═╡ 1eb0c378-4b6e-4da8-94ee-3f56c89e3c99
begin
	url4 = "https://github.com/ytrujillol/Procesamiento-de-imagenes/blob/main/Images/Oso1.png?raw=true"
	fname4 = download(url4)
	imag4 = Gray.(load(fname4))
	
	url5="https://github.com/ytrujillol/Procesamiento-de-imagenes/blob/main/Images/Oso2.png?raw=true"
	fname5 = download(url5)
	imag5 = Gray.(load(fname5))
	
	[imag4 imag5 Sobreposicion(imag4, imag5)]
end

# ╔═╡ 2ffa3e3c-67ad-4ee2-88ad-306a1986e2f0
md"""$\texttt{Figura 7. Sobreposición de los peluches. Imágenes tomadas de [1].}$"""

# ╔═╡ 90b15d0a-748a-4d0b-ad20-800b35fdb9be
md"""##   $\cdot$ Producto de imágenes"""

# ╔═╡ 23f61001-cc7e-4ebc-9cac-474e217538f7
md""" Recordemos la multiplicación de matrices, dadas dos matrices $A$ de tamaño $m \times p$ y $B$ de tamaño $p \times n$, el producto $C = A \cdot B$ es otra matriz $m \times n$ donde cada elemento $c_{ij}$ se obtiene sumando el producto de los elementos correspondientes de la fila $i$ de $A$ y la columna $j$ de $B$: $c_{ij} = \sum_{k=1}^{p} a_{ik} \cdot b_{kj}$. De la siguiente forma:

$\begin{align}A\cdot B &= \begin{bmatrix}
a_{11} & a_{12} & \ldots & a_{1p} \\
a_{21} & a_{22} & \ldots & a_{2p} \\
\vdots & \vdots & \ddots & \vdots \\
a_{m1} & a_{m2} & \ldots & a_{mp}
\end{bmatrix}\cdot\begin{bmatrix}
b_{11} & b_{12} & \ldots & b_{1n} \\
b_{21} & b_{22} & \ldots & b_{2n} \\
\vdots & \vdots & \ddots & \vdots \\
b_{p1} & b_{p2} & \ldots & b_{pn}
\end{bmatrix}\\

&= \begin{bmatrix}
a_{11} \cdot b_{11} + a_{12} \cdot b_{21} + \ldots + a_{1p} \cdot b_{p1} & \ldots & a_{i1} \cdot b_{1n} + a_{12} \cdot b_{2n} + \ldots + a_{1p} \cdot b_{pn} \\
a_{21} \cdot b_{11} + a_{22} \cdot b_{21} + \ldots + a_{2p} \cdot b_{p1} & \ldots & a_{21} \cdot b_{1n} + a_{22} \cdot b_{2n} + \ldots + a_{2p} \cdot b_{pn} \\
\vdots & \ddots & \vdots \\
a_{m1} \cdot b_{11} + a_{m2} \cdot b_{21} + \ldots + a_{mp} \cdot b_{p1} & \ldots & a_{m1} \cdot b_{1n} + a_{m2} \cdot b_{2n} + \ldots + a_{mp} \cdot b_{pn}
\end{bmatrix}\\

&=\begin{bmatrix}
c_{11} & c_{12} & \ldots & c_{1n} \\
c_{21} & c_{22} & \ldots & c_{2n} \\
\vdots & \vdots & \ddots & \vdots \\
c_{m1} & c_{m2} & \ldots & c_{mn}
\end{bmatrix}\\

&=C\end{align}$
"""

# ╔═╡ b955394f-4bac-4e1c-8620-a4403cfd3d35
md"""A continuación mostraremos algunos ejemplos del uso de la multiplicación de matrices en el procesamiento de imágenes. Por ejemplo, multiplicar una imagen a la izquierda por la matriz  

$H = 
\begin{bmatrix}
1/2 & 1/2 & 0 & 0 & \cdots & 0 & 0 \\ 
0 & 0 & 1/2  & 1/2 & \cdots & 0 & 0 \\ 
\vdots & \vdots & \vdots & \vdots & \ddots & \vdots & \vdots \\ 
0 & 0 & 0 & 0 & \cdots & 1/2 & 1/2
\end{bmatrix}$
comprime verticalmente la imagen por un factor de 2. Multiplicarla a la izquierda por  

$G = 
\begin{bmatrix}
-1/2 & 1/2 & 0 & 0 & \cdots & 0 & 0 \\ 
0 & 0 & -1/2  & 1/2 & \cdots & 0 & 0 \\ 
\vdots & \vdots & \vdots & \vdots & \ddots & \vdots & \vdots \\ 
0 & 0 & 0 & 0 & \cdots & -1/2 & 1/2
\end{bmatrix}$
resalta los bordes horizontales de la imagen.  
Multiplicar a la derecha por $H^T$ comprime horizontalmente la imagen, y por $G^T$ resalta los bordes verticales. El efecto combinado de ambas multiplicaciones afecta columnas y filas."""

# ╔═╡ db613b98-f00f-4028-a7df-0b5309243021
function H(m, n)
    H = zeros(m, n)
    for i in 1:m
        col = 2 * (i - 1) + 1 
        if col <= n
            H[i, col] = 1/2
        end
        if col + 1 <= n
            H[i, col + 1] = 1/2
        end
    end
    return H
end

# ╔═╡ a36bc04e-b611-4244-9e86-81c4dfd01a1d
function G(m, n)
    G = zeros(m, n)
    for i in 1:m
        col = 2 * (i - 1) + 1
        if col <= n
            G[i, col] = -1/2
        end
        if col + 1 <= n
            G[i, col + 1] = 1/2
        end
    end
    return G
end

# ╔═╡ c0b80aea-e931-4aa0-82cf-1ecc600fc7fe
md"""Veamos un ejemplo cómo aplicar la matriz H."""

# ╔═╡ fc506b2d-3295-49b4-b81a-04a922242f24
[imag Gray.(ones(size(imag)[1], 80)) Gray.(H(size(imag)[1], size(imag)[1])*channelview(imag))
Gray.(ones(80, 2*size(imag)[2]+ 80))
Gray.(channelview(imag)*Transpose(H(size(imag)[2], size(imag)[2]))) Gray.(ones(size(imag)[1], 80))  Gray.(H(size(imag)[1], size(imag)[1])*channelview(imag)*Transpose(H(size(imag)[2], size(imag)[2])))]

# ╔═╡ 710d89b9-13d8-4501-aed3-2befbdc36c10
md"""$\texttt{Figura 8. Aplicación de la matriz H al tablero de ajedrez.}$"""

# ╔═╡ 18ae06c3-d765-4b60-ae3c-4d55217b437d
md"""La Figura 9 muestra el resultado de aplicar la matriz $G$ a la izquierda y $G^T$ a la derecha a la imagen del tablero de ajedrez."""

# ╔═╡ 480d1d73-bd2e-488e-b936-4749956e45b7
[Gray.(G(size(imag)[1], size(imag)[1])*channelview(imag)) Gray.(ones(size(imag)[1], 80)) Gray.(channelview(imag)*Transpose(G(size(imag)[2], size(imag)[2])))]

# ╔═╡ 3b8543e3-42ef-4bfa-ad34-9dc3a0a072df
md"""$\texttt{Figura 9. Aplicación de la matriz G al tablero de ajedrez.}$"""

# ╔═╡ 9a431f74-107d-4db1-859e-bb4ca74f07cb
md"""Este método se aplica también a la segmentación de partes específicas de una imagen, como bandas horizontales, verticales o rectángulos. Por ejemplo, para extraer la mitad horizontal central de una imagen $A$, se multiplica a la izquierda por una matriz con una identidad en el centro y ceros alrededor.

Por ejemplo, para extraer la mitad horizontal central de una imagen $(A)$ de tamaño $m\times n$, se debe multiplicar $A$ a la izquierda por 

$K =
\begin{bmatrix}
Z_{m/4} & Z_{m/2} & Z_{m/4} \\ 
Z_{m/2} & I_{m/2} & Z_{m/2} \\ 
Z_{m/4} & Z_{m/2} & Z_{m/4}
\end{bmatrix},$

donde $I_{m/2}$ es la matriz identidad de tamaño $m/2$ y $Z_{m/4}$ es la matriz nula de tamaño $m/4$.

Alternativamente, si se desea mostrar la parte central vertical de la imagen, se debe multiplicar $A$ a la derecha por la matriz:  

$V =
\begin{bmatrix}
Z_{n/4} & Z_{n/2} & Z_{n/4} \\ 
Z_{n/2} & I_{n/2} & Z_{n/2} \\ 
Z_{n/4} & Z_{n/2} & Z_{n/4}
\end{bmatrix}.$

Para extraer un rectángulo central en la imagen, se pueden realizar ambas operaciones en sucesión, descritas formalmente como:  

$A \to K \cdot A \cdot V.$"""

# ╔═╡ db4128bc-fffd-4928-a2f5-d26e64582039
md"""Con la siguiente función podemos crear la matriz $K$ o $V$."""

# ╔═╡ 1f286685-9bd8-4da2-9187-f62416077814
function Matrix(n)
	M = Int(4*floor(n/4))
    M4 = M÷4
	M2 = M÷2
    Z_M4 = zeros(M4, M4)
	ZM2 = [zeros(M4, M4) zeros(M4, M4)]
    I_M2 = I(M2)
    matrix = [Z_M4       ZM2       Z_M4;
        	ZM2'       I_M2      ZM2';
        	Z_M4       ZM2       Z_M4]
	# Tamaño de la matriz base
    k = size(matrix, 1)

    # Crear matriz ampliada con ceros
    new_matrix = zeros(n, n)
    new_matrix[1:k, 1:k] .= matrix  # Copiar valores en la nueva matriz
    return new_matrix
end

# ╔═╡ 6a0ad91f-5047-4fc4-92f6-24f0ea5ff1f3
md"""Consideremos nuevamente la Figura 3 y mostremos algunos resultados de la aplicación mencionada. Ver Figura 10."""

# ╔═╡ 834e4649-2624-45f5-b98a-1dda03a914ff
[imag1 Gray.(ones(size(imag1)[1], 80)) Gray.(Matrix(size(imag1)[1])*channelview(imag1))
Gray.(ones(80, 2*size(imag1)[2]+ 80))
Gray.(channelview(imag1)*Matrix(size(imag1)[2])) Gray.(ones(size(imag1)[1], 80)) Gray.(Matrix(size(imag1)[1])*channelview(imag1)*Matrix(size(imag1)[2]))]

# ╔═╡ 77fdb7f1-cef6-437b-a793-3443d1f6ad6f
md"""$\texttt{Figura 10. Segmentación de la Figura 3.}$"""

# ╔═╡ 2ea0c762-0377-4db9-b891-002f189a3ada
md"""
# Transformaciones Lineales

Una función $T: \mathbb{R}^n \to \mathbb{R}^m$ se llama **transformación lineal** si:  

$T(u + v) = T(u) + T(v),$
y  

$T(\alpha v) = \alpha T(v)$
para todo $u, v \in \mathbb{R}^n$ y todos los escalares $\alpha$."""

# ╔═╡ ad2006cb-0f8a-400b-b352-3228d7383fc9
md"""**La matriz estándar de una transformación lineal**  

Cualquier transformación lineal $T : \mathbb{R}^n \to \mathbb{R}^m$ es de la forma:  

$T(x) = Ax,$
donde $A$ es la matriz estándar de la transformación, la cual se define como:  

$A = \begin{bmatrix} 
T(e_1) & T(e_2) & \cdots & T(e_n) 
\end{bmatrix}.$"""

# ╔═╡ d341cf66-93ea-4857-b8f8-3518760259df
md"""
## Cambio de coordenadas
"""

# ╔═╡ c63131b0-fc8a-4fc5-991b-25eff5950aef
function circulo(n)
	img = fill(0,n,n)
	for i in 1:n, j in 1:n
		if abs(i-n/2)^(1/2) + abs(j-n/2)^(1/2) <= (n/3)^(1/2)
			img[i,j] = 1
		end
	end
	return Gray.(img)
end

# ╔═╡ 8a9438fc-4754-4ece-8601-d3f075681db1
function rotate_image_no_interp(image, angle)
    θ = deg2rad(angle)
    M, N = size(image)
    A = [cos(θ) -sin(θ); sin(θ) cos(θ)]
    rotated_image = zeros(eltype(image), M, N)
   
    for m in 1:M, n in 1:N
        x = n - N / 2
        y = M / 2 - m
        new_coords = A * [x; y]
        x_p = M / 2 - new_coords[2]
        y_p = new_coords[1] + N / 2
        
        x_p = round(Int, x_p)
        y_p = round(Int, y_p)
        if x_p >= 1 && x_p <= N && y_p >= 1 && y_p <= M
            rotated_image[m, n] = image[x_p, y_p]
        end
    end
    return rotated_image
end

# ╔═╡ df624514-b98c-4f4d-8348-96577a54167e
L = Gray.([0 0 0 0 0 0 0 0 0 0; 
	0 0 0 0 0 0 0 0 0 0;
	0 0 0 0 0 0 0 0 0 0;
	0 0 0 1 1 1 1 1 1 1;
	0 0 0 1 1 1 1 1 1 1;
	0 0 0 1 1 1 1 1 1 1;
	0 0 0 1 1 1 1 1 1 1;
	0 0 0 1 1 1 1 1 1 1;
	0 0 0 1 1 1 1 1 1 1;
	0 0 0 1 1 1 1 1 1 1])

# ╔═╡ 0de7918c-fa71-4523-a314-653e1e190288
rotate_image_no_interp(L, 90)

# ╔═╡ 225bbc0a-205f-4221-b945-ebc0aeaeae63
rotate_image_no_interp(L, -90)

# ╔═╡ 0307bca1-6358-4181-92b4-6d7fbeb50bf5
[circulo(100) rotate_image_no_interp(circulo(100), 20)]

# ╔═╡ eb9116f9-2aa8-4f55-9c4f-f27891f46e30
[imag1 rotate_image_no_interp(imag1, 90) rotate_image_no_interp(imag1, -90)]

# ╔═╡ 4c39f6db-6d97-431e-97cf-1a7e400b71de


# ╔═╡ 809054ff-58bd-46eb-bbe1-65fe353da582
function rotate_image(image, angle)
    θ = deg2rad(angle)
    M, N = size(image)
    cx = N / 2
    cy = M / 2
    A = [cos(θ) -sin(θ); sin(θ) cos(θ)]
    rotated_image = zeros(eltype(image), M, N)

    for m in 1:M, n in 1:N
        x = n - cx
        y = cy - m
		new_coords = A * [x; y]
		x_p = new_coords[1]
		y_p = new_coords[2]
        x = x_p + cx
        y = cy - y_p
        if x >= 1 && x <= N && y >= 1 && y <= M
            interp = interpolate(image, BSpline(Linear()))
            rotated_image[m, n] = interp(y, x)
        end
    end
    return rotated_image
end

# ╔═╡ 4756613f-dec2-4145-ab57-de24776ab9e4
[imag1 rotate_image(imag1, 90)]

# ╔═╡ 225ea01f-243a-49fe-a22f-a85fc5c78a9b
rotate_image(imag1, 180)

# ╔═╡ 6e02907a-678c-4d4f-a3f7-92eddc878baf
rotate_image(imag1, 01)

# ╔═╡ 44bac7a6-5e6c-4e8d-a221-90d6c1173f38
md"""
A continuación encontramos transformaciones lineales que hacen otros tipos de efectos sobre una imagen.
"""

# ╔═╡ 80e3c274-0dcc-448d-a380-aa28462ab5e9
md"""
**Estiramiento/compresión** por un factor $a$ en la dirección del eje $x$.
"""

# ╔═╡ ed773753-e3f4-4d70-9718-183ace0f7d5a
function dilatation_x(image, a)
    M, N = size(image)
    cx = N / 2
    cy = M / 2
    A = [1/a 0; 0 1]
    new_image = zeros(eltype(image), M, N)

    for m in 1:M, n in 1:N
        x = n - cx
        y = cy - m
        new_coords = A * [x; y]
        x_p = new_coords[1] + cx
        y_p = cy - new_coords[2]
        
        x_p = round(Int, x_p)
        y_p = round(Int, y_p)
        if x_p >= 1 && x_p <= N && y_p >= 1 && y_p <= M
            new_image[m, n] = image[y_p, x_p]
        end
    end
    return new_image
end

# ╔═╡ 4f7059b3-41ce-4e43-a14e-f64de7f6e514
[imag1 dilatation_x(imag1, 0.5)]

# ╔═╡ 2e45b58f-fcde-4de4-a485-72940d7da6ac
md"""
**Estiramiento/compresión** por un factor $b$ en la dirección del eje $y$.
"""

# ╔═╡ 4409e7cb-3cb7-4bfd-a1ec-cc36354f757b
function dilatation_y(image, b)
    M, N = size(image)
    cx = N / 2
    cy = M / 2
    A = [1 0; 0 1/b]
    new_image = zeros(eltype(image), M, N)

    for m in 1:M, n in 1:N
        x = n - cx
        y = cy - m
        new_coords = A * [x; y]
        x_p = new_coords[1] + cx
        y_p = cy - new_coords[2]
        
        x_p = round(Int, x_p)
        y_p = round(Int, y_p)
        if x_p >= 1 && x_p <= N && y_p >= 1 && y_p <= M
            new_image[m, n] = image[y_p, x_p]
        end
    end
    return new_image
end

# ╔═╡ f72a702d-af26-4876-8d64-77582825fcc9
[imag1 dilatation_y(imag1, 0.5)]

# ╔═╡ 6c97e63b-9ab5-4966-ae37-d1c5dcb2ab52
md"""
**Cizalladura horizontal** que deja el punto $(1, 0)$ sin cambios y mapea el punto $(0, 1)$ en $(a, 1)$.
"""

# ╔═╡ b25c28f0-0f3a-48b5-be7b-af59a68439ea
function dilatation_ch(image, a)
    M, N = size(image)
    cx = N / 2
    cy = M / 2
    A = [1 a; 0 1]
    new_image = zeros(eltype(image), M, N)

    for m in 1:M, n in 1:N
        x = n - cx
        y = cy - m
        new_coords = A * [x; y]
        x_p = new_coords[1] + cx
        y_p = cy - new_coords[2]
        
        x_p = round(Int, x_p)
        y_p = round(Int, y_p)
        if x_p >= 1 && x_p <= N && y_p >= 1 && y_p <= M
            new_image[m, n] = image[y_p, x_p]
        end
    end
    return new_image
end

# ╔═╡ 29b2fdae-6a13-4057-a75c-412a5a3c17ad
[imag1 dilatation_ch(imag1, 0.5)]

# ╔═╡ 0356097c-9c73-432c-b94f-d1143fcdfc34
md"""
**Cizalladura vertical** que deja el punto $(0, 1)$ sin cambios y mapea el punto $(1, 0)$ en $(1, b)$.  
"""

# ╔═╡ ae98d703-76ca-44f9-9c98-2c5648d9ce80
function dilatation_cv(image, b)
    M, N = size(image)
    cx = N / 2
    cy = M / 2
    A = [1 0; b 1]
    new_image = zeros(eltype(image), M, N)

    for m in 1:M, n in 1:N
        x = n - cx
        y = cy - m
        new_coords = A * [x; y]
        x_p = new_coords[1] + cx
        y_p = cy - new_coords[2]
        
        x_p = round(Int, x_p)
        y_p = round(Int, y_p)
        if x_p >= 1 && x_p <= N && y_p >= 1 && y_p <= M
            new_image[m, n] = image[y_p, x_p]
        end
    end
    return new_image
end

# ╔═╡ 8cd9c33b-079e-4984-ac3f-a73fc6fa1178
[imag1 dilatation_cv(imag1, 0.5)]

# ╔═╡ 304b82b3-cfa1-4c94-a2c8-b4e8e2d3d6e7
md"""
**Reflexión** a través del eje $x$. 
"""

# ╔═╡ 970bf9e2-1466-42da-b202-c6b9f454eacb
function reflexion_x(image)
    M, N = size(image)
    cx = N / 2
    cy = M / 2
    A = [-1 0; 0 1]
    new_image = zeros(eltype(image), M, N)

    for m in 1:M, n in 1:N
        x = n - cx
        y = cy - m
        new_coords = A * [x; y]
        x_p = new_coords[1] + cx
        y_p = cy - new_coords[2]
        
        x_p = round(Int, x_p)
        y_p = round(Int, y_p)
        if x_p >= 1 && x_p <= N && y_p >= 1 && y_p <= M
            new_image[m, n] = image[y_p, x_p]
        end
    end
    return new_image
end

# ╔═╡ 36cc24eb-c6bb-4fcd-ac9d-befddac22da8
[imag1 reflexion_x(imag1)]

# ╔═╡ 3ba6dfae-931a-48d6-b90c-8bc612c4076e
md"""
**Reflexión** a través del eje $y$.
"""

# ╔═╡ ac2d9cee-d5b7-4a67-8454-0ca988ac4d6e
function reflexion_y(image)
    M, N = size(image)
    cx = N / 2
    cy = M / 2
    A = [1 0; 0 -1]
    new_image = zeros(eltype(image), M, N)

    for m in 1:M, n in 1:N
        x = n - cx
        y = cy - m
        new_coords = A * [x; y]
        x_p = new_coords[1] + cx
        y_p = cy - new_coords[2]
        
        x_p = round(Int, x_p)
        y_p = round(Int, y_p)
        if x_p >= 1 && x_p <= N && y_p >= 1 && y_p <= M
            new_image[m, n] = image[y_p, x_p]
        end
    end
    return new_image
end

# ╔═╡ 9f9497d0-f42d-45f6-a250-b5f1f49952d0
[imag1 reflexion_y(imag1)]

# ╔═╡ fb92541f-4fa9-4329-a8ac-d22d8389ff4b
md"""
**Reflexión** a través de la línea $y = x$. 
"""

# ╔═╡ 94aa56d5-9076-4271-a51d-c21a1524aad5
function reflexion_y_x(image)
    M, N = size(image)
    cx = N / 2
    cy = M / 2
    A = [0 1; 1 0]
    new_image = zeros(eltype(image), M, N)

    for m in 1:M, n in 1:N
        x = n - cx
        y = cy - m
        new_coords = A * [x; y]
        x_p = new_coords[1] + cx
        y_p = cy - new_coords[2]
        
        x_p = round(Int, x_p)
        y_p = round(Int, y_p)
        if x_p >= 1 && x_p <= N && y_p >= 1 && y_p <= M
            new_image[m, n] = image[y_p, x_p]
        end
    end
    return new_image
end

# ╔═╡ a43d7c96-120b-4894-a454-e517551cf84a
[imag1 reflexion_y_x(imag1)]

# ╔═╡ a79b0ccd-5b9f-41c3-b277-b554403b5002
md"""
**Reflexión** a través de la línea $y = -x$.  
"""

# ╔═╡ e1d84093-ef75-4e49-a91b-f9b2d8e73deb
function reflexion_y_minus_x(image)
    M, N = size(image)
    cx = N / 2
    cy = M / 2
    A = [0 -1; -1 0]
    new_image = zeros(eltype(image), M, N)

    for m in 1:M, n in 1:N
        x = n - cx
        y = cy - m
        new_coords = A * [x; y]
        x_p = new_coords[1] + cx
        y_p = cy - new_coords[2]
        
        x_p = round(Int, x_p)
        y_p = round(Int, y_p)
        if x_p >= 1 && x_p <= N && y_p >= 1 && y_p <= M
            new_image[m, n] = image[y_p, x_p]
        end
    end
    return new_image
end

# ╔═╡ f41ea8ef-045d-4a3d-b095-8d9514d09d24
[imag1 reflexion_y_minus_x(imag1)]

# ╔═╡ 871510fa-dfce-43d4-b063-fb036e907458
md"""
**Reflexión** a través del origen. 
"""

# ╔═╡ c04fc6be-50ab-4f8d-8df0-f043936f5b8f
function reflexion_origin(image)
    M, N = size(image)
    cx = N / 2
    cy = M / 2
    A = [-1 0; 0 -1]
    new_image = zeros(eltype(image), M, N)

    for m in 1:M, n in 1:N
        x = n - cx
        y = cy - m
        new_coords = A * [x; y]
        x_p = new_coords[1] + cx
        y_p = cy - new_coords[2]
        
        x_p = round(Int, x_p)
        y_p = round(Int, y_p)
        if x_p >= 1 && x_p <= N && y_p >= 1 && y_p <= M
            new_image[m, n] = image[y_p, x_p]
        end
    end
    return new_image
end

# ╔═╡ 5218f6e3-51d2-46e8-9afa-e52598e02175
[imag1 reflexion_origin(imag1)]

# ╔═╡ db9272d9-aad3-4819-b518-997e00fbfb5f
md"""
# Coordenadas homogéneas y transformaciones proyectivas
"""

# ╔═╡ f6bd2f0e-46ba-48ac-87c4-514640aa39d6
md"""
Si recordamos, la dificultad de combinar los tres primeros pasos del procedimiento de rotación de imágenes en un solo paso radica en el molesto hecho de que la traslación no es una transformación lineal. Entonces, ¿qué dimensión adicional podemos introducir para hacerla lineal?

Resulta que lo único que debemos hacer es mover el origen del sistema de coordenadas lejos del centro de la imagen y colocarlo donde estamos, a una unidad de distancia de la pantalla de la computadora. De esta manera, cualquier punto con coordenadas $(x, y)$ se asignará a las coordenadas $(x, y, 1)$, conocidas como coordenadas homogéneas.
"""

# ╔═╡ 60f7d827-3afb-4cb8-a004-597a72b3aa93
md"""
Por ejemplo, supongamos que la imagen mostrada a continuación proviene de nuestra cámara de seguridad, y nos gustaría obtener una buena vista frontal de la placa delantera en el parachoques del vehículo. ¿Cómo podemos "girar" digitalmente la imagen para obtener una vista desde un punto de vista diferente? ¿Pueden las coordenadas homogéneas ayudarnos en esto?
"""

# ╔═╡ 4607bb45-1b1e-4727-8e66-b729edb717fa
begin
	urlp="https://github.com/ytrujillol/Procesamiento-de-imagenes/blob/main/Images/Placa_coordenadas_homo.png?raw=true"
	fnamep = download(urlp)
	imagplaca = Gray.(load(fnamep))
end

# ╔═╡ 461a4468-eb0e-440e-a8e6-5b4a9583d338
md"""$\texttt{Figura x.}$"""

# ╔═╡ fed4b0f2-2e58-4f0f-9d18-fcf2756e990e
size(imagplaca)

# ╔═╡ 8a8838ec-92a7-4663-8a2b-592f9376d20b
imagplaca[50:200,100:200]

# ╔═╡ 2952a243-dcce-41d6-900b-3ced15e97194
imagplaca[50:150,100:200]

# ╔═╡ 90bec4f5-f77f-4184-a274-e5b93e968a70
md"""
-  $M = 238$
-  $N = 330$


-  $(m_1,n_1)=(50,100)$
-  $(m_2,n_2)=(50,200)$
-  $(m_3,n_3)=(200,100)$
-  $(m_4,n_4)=(150,200)$


-  $(x_1,y_1)=(-65,69)$
-  $(x_2,y_2)=(35,69)$
-  $(x_3,y_3)=(-65,35)$
-  $(x_4,y_4)=(35,-31)$


-  $(m'_1,n'_1)=(1,1)$
-  $(m'_2,n'_2)=(1,330)$
-  $(m'_3,n'_3)=(238,1)$
-  $(m'_4,n'_4)=(238,330)$


-  $(x'_1,y'_1)=(-164,118)$
-  $(x'_2,y'_2)=(165,118)$
-  $(x'_3,y'_3)=(-164,-119)$
-  $(x'_4,y'_4)=(165,-119)$
"""

# ╔═╡ 07507b03-ce49-40e0-9ba6-ecc209ab9ada
[0 1; -1 0]*[1 1 238 238; 1 330 1 330].+[-165; 119]

# ╔═╡ 3989d5f6-cb52-4d33-8eac-2e94322cf24a
md"""
Geométricamente, el problema se reduce a diseñar la transformación $T$ que mapea las cuatro esquinas (en $(x_1, y_1)$, $(x_2, y_2)$, $(x_3, y_3)$ y $(x_4, y_4)$) de la placa a las cuatro esquinas $(x'_1, y'_1)$, $(x'_2, y'_2)$, $(x'_3, y'_3)$ y $(x'_4, y'_4)$ del rectángulo deseado. Algebraicamente, necesitamos diseñar la matriz:

$A =
\begin{bmatrix}
a_{11} & a_{12} & a_{13} \\
a_{21} & a_{22} & a_{23} \\
a_{31} & a_{32} & a_{33}
\end{bmatrix}$

para la transformación $T$, de forma que se pueda expresar como:

$\lambda 
\begin{bmatrix}
x'_1 & x'_2 & x'_3 & x'_4 \\
y'_1 & y'_2 & y'_3 & y'_4 \\
1 & 1 & 1 & 1
\end{bmatrix}
=
\begin{bmatrix}
a_{11} & a_{12} & a_{13} \\
a_{21} & a_{22} & a_{23} \\
a_{31} & a_{32} & a_{33}
\end{bmatrix}
\begin{bmatrix}
x_1 & x_2 & x_3 & x_4 \\
y_1 & y_2 & y_3 & y_4 \\
1 & 1 & 1 & 1
\end{bmatrix}$

Antes de proceder, es necesario explicar la razón para introducir el múltiplo escalar $\lambda$. Es fácil ver que las coordenadas homogéneas $(x, y, 1)$ del punto $(x, y)$ pueden ser identificadas con la recta $L$ que pasa a través del origen y el punto $(x, y, 1)$. Como tanto $(x, y, 1)$ como $(\lambda x, \lambda y, \lambda)$ están en $L$, representan el mismo punto $(x, y)$.
"""

# ╔═╡ a3ef0853-0751-44b1-82de-6c66bea67503
md"""
¿Cómo determinamos las entradas desconocidas de la matriz de transformación $A$? No es fácil, pero perseveraremos. Para cada par $(x_k, y_k)$ y $(x'_k, y'_k)$ de puntos correspondientes, la ecuación anterior implica:

$\lambda x'_k = a_{11} x_k + a_{12} y_k + a_{13}$

$\lambda y'_k = a_{21} x_k + a_{22} y_k + a_{23}$

$\lambda = a_{31} x_k + a_{32} y_k + a_{33}.$


Sustituyendo el valor del factor de escala $\lambda$ en las primeras dos ecuaciones, obtenemos el sistema:

$(a_{31}x_k + a_{32}y_k + a_{33}) x'_k = a_{11}x_k + a_{12}y_k + a_{13}$

$(a_{31}x_k + a_{32}y_k + a_{33}) y'_k = a_{21}x_k + a_{22}y_k + a_{23}.$

Lo cual, después de reorganizar los términos, se convierte en:

$-a_{11}x_k - a_{12}y_k - a_{13} + a_{31}x_kx'_k + a_{32}y_kx'_k + a_{33}x'_k = 0$

$-a_{21}x_k - a_{22}y_k - a_{23} + a_{31}x_ky'_k + a_{32}y_ky'_k + a_{33}y'_k = 0.$

El problema de determinar las entradas de la matriz de transformación $A$ se reduce, por tanto, al de resolver el sistema lineal homogéneo:

$H a = 0,$

donde

$H =
\begin{bmatrix}
-x_1 & -y_1 & -1 & 0 & 0 & 0 & x'_1x_1 & y_1 x'_1 & x'_1 \\
\vdots &  &  & \vdots &  & \vdots &  &  & \vdots \\
-x_4 & -y_4 & -1 & 0 & 0 & 0 & x'_4x_4 & y_4 x'_4 & x'_4 \\
0 & 0 & 0 & -x_1 & -y_1 & -1 & x_1 y'_1 & y_1 y'_1 & y'_1\\
\vdots &  &  & \vdots &  & \vdots &  &  & \vdots \\
0 & 0 & 0 & -x_4 & -y_4 & -1 & x_4 y'_4 & y_4 y'_4 & y'_4\\
\end{bmatrix},$

y

$a =
\begin{bmatrix}
a_{11} &
a_{12} &
a_{13} &
a_{21} &
a_{22} &
a_{23} &
a_{31} &
a_{32} &
a_{33}
\end{bmatrix}^{T}.$
"""

# ╔═╡ fb6ecdb4-2686-4dad-8cec-965d30208cda
pixeles = [50 50 200 150 1 200 1 200; 100 200 100 200 1 1 200 200]

# ╔═╡ 270869cf-3e45-4a98-9af8-eef56a77665e
function SolHa(pxs,M,N)
	coord = [0 1; -1 0]*pxs .+ [-N/2;M/2]
	A = [coord[1:2,1:4]' ones(4,1)]
	Z = zeros(4,3)
	B = A .* coord[1,5:8]
	C = A .* coord[2,5:8]
	H = [-A Z B ; Z -A C]
	return Array(reshape(nullspace(H),3,3)')
end

# ╔═╡ 247f9d2a-ba9f-4d1b-855f-fb520511c115
SolHa(pixeles,238,330)

# ╔═╡ e58a555d-0e63-4865-b74c-f56be2a6724a
function homog_coord(image, pxs)
    M, N = size(image)
    cx = N / 2
    cy = M / 2
	A = SolHa(pxs,M,N)
    new_image = zeros(eltype(image), M, N)

    for m in 1:M, n in 1:N
        x = n - cx
        y = cy - m
        new_coords = A * [x; y ; 1]
		λ = new_coords[3]
        x_p = new_coords[1]/λ + cx
        y_p = cy - new_coords[2]/λ
        
        x_p = round(Int, x_p)
        y_p = round(Int, y_p)
        if x_p >= 1 && x_p <= N && y_p >= 1 && y_p <= M
            new_image[m, n] = image[y_p, x_p]
        end
    end
    return new_image
end

# ╔═╡ f841355e-58d9-4df1-a911-30b646f5bc70
imagplaca

# ╔═╡ beb7a873-3fb1-4bfe-90ce-6d97382130b9
homog_coord(imagplaca, pixeles)

# ╔═╡ de8440de-2d38-44b8-9bcc-20c6517a80bc
homog_coord(imagplaca,[1 0 0; 0 1 0; 0 0 1])

# ╔═╡ fe95c961-f662-4d6c-a583-e39990e5e660
md"""
Este sistema tiene nueve variables pero solo ocho ecuaciones, lo cual es algo muy positivo, ya que nos gustaría que tuviera una variable libre y, por lo tanto, una solución no trivial. Debido al tamaño de la matriz, no intentamos reducirla por filas manualmente y recomendamos usar un sistema de álgebra computacional para completar el cálculo de las entradas $a_{jk}$ de la matriz de transformación $A$. El valor numérico del parámetro de escala $\lambda$ se puede obtener utilizando la fórmula.

Al igual que con la implementación de la transformación de rotación en la sección anterior, la transformación de cambio de perspectiva no es sobreyectiva (es decir, no cubre todo el rango) cuando su dominio y rango consisten en pares de números enteros (en lugar de números reales). Como resultado, es muy probable que algunos de los píxeles en la imagen transformada no reciban ningún valor mediante la transformación. Estos píxeles deben ser interpolados utilizando los píxeles vecinos que sí hayan recibido nuevos valores.

La implementación de la transformación de “cambio de perspectiva” es similar al procedimiento de la transformación de rotación discutido en la sección anterior. La describimos aquí a continuación.
"""

# ╔═╡ d3699263-5afb-423a-b30b-81c74adb286b
md"""
**Un procedimiento paso a paso para la implementación de la transformación de cambio de perspectiva (que se aplicará a cada píxel)**
"""

# ╔═╡ 3f8b32a5-91b7-48fc-8573-f34b048aea95
md"""
1. **Calcular las coordenadas cartesianas** $(x, y)$ y definir las coordenadas homogéneas $(x, y, 1)$ para el píxel con los índices $(m, n)$ utilizando las fórmulas de conversión:

$x = n - \frac{N}{2} \quad \text{y} \quad y = \frac{M}{2} - m.$

2. **Aplicar la transformación de cambio de perspectiva** para calcular las "nuevas" coordenadas homogéneas $(x'/\lambda, y'/\lambda, 1)$ a las que el píxel en $(m, n)$ necesita moverse.

3. **Convertir las "nuevas" coordenadas homogéneas** $(x'/\lambda, y'/\lambda, 1)$ en los "nuevos" índices $(m', n')$ utilizando las fórmulas de conversión (si es necesario, deberemos redondear $m'$ y $n'$ al entero más cercano):

$m' = \frac{M}{2} - \frac{y'}{\lambda} \quad \text{y} \quad n' = \frac{x'}{\lambda} + \frac{N}{2}.$



4. **Asignar el valor del píxel con los "antiguos" índices** $(m, n)$ al píxel con los "nuevos" índices $(m', n')$.



Dado que todos los cálculos se realizan en coordenadas homogéneas, todas las transformaciones involucradas en el procedimiento pueden realizarse con la ayuda de matrices y productos matriciales. De hecho, los pasos pueden combinarse y multiplicarse por una sola matriz.
"""

# ╔═╡ 4da22b7a-f145-43ef-aad6-2cad844e560b
md"""# Referencias

[1] Galperin, Y. V. (2020). An image processing tour of college mathematics. Chapman & Hall/CRC Press.

[2] JuliaImages. (s.f.). JuliaImages Documentation. Recuperado de [https://juliaimages.org/stable/](https://juliaimages.org/stable/).

[3] Labmatecc. (s.f.). Conceptos básicos. Recuperado de [https://labmatecc.github.io/Notebooks/AlgebraLineal/Conceptosbasicos/](https://labmatecc.github.io/Notebooks/AlgebraLineal/Conceptosbasicos/)

[4] JuliaImages. (s.f.). TestImages: Image data for Julia. Recuperado de [https://testimages.juliaimages.org/stable/](https://testimages.juliaimages.org/stable/)

[5] Unsplash. (n.d.). Unsplash: Fotos gratis para todos. Recuperado de [https://unsplash.com/es](https://unsplash.com/es)"""

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
Interpolations = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
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
FileIO = "~1.16.4"
HypertextLiteral = "~0.9.5"
ImageIO = "~0.6.9"
ImageShow = "~0.3.8"
Images = "~0.26.1"
Interpolations = "~0.15.1"
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
project_hash = "de64304eda430f98cc655e27bb38b1ab88026a8a"

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
git-tree-sha1 = "50c3c56a52972d78e8be9fd135bfb91c9574c140"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.1.1"
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
git-tree-sha1 = "d5140b60b87473df18cf4fe66382b7c3596df047"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.17.1"

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
git-tree-sha1 = "8873e196c2eb87962a2048b3b8e08946535864a1"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+2"

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
git-tree-sha1 = "c785dfb1b3bfddd1da557e861b919819b82bbe5b"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.27.1"

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
version = "1.11.0"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "3101c32aab536e7a27b1763c0797dba151b899ad"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.113"

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
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cc5231d52eb1771251fbd37171dbc408bcc8a1b6"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.4+0"

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
git-tree-sha1 = "2dd20384bf8c6d411b5c7370865b1e9b26cb2ea3"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.6"
weakdeps = ["HTTP"]

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

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

[[deps.Giflib_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0224cce99284d997f6880a42ef715a37c99338d1"
uuid = "59f7168a-df46-5410-90c8-f2779963d0ec"
version = "5.2.2+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "674ff0db93fffcd11a3573986e550d66cd4fd71f"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.80.5+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "a641238db938fff9b2f60d08ed9030387daf428c"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.3"

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
git-tree-sha1 = "1336e07ba2eb75614c99496501a8f4b233e9fafe"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.10"

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
git-tree-sha1 = "b1c2585431c382e3fe5805874bda6aea90a95de9"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.25"

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
git-tree-sha1 = "432ae2b430a18c58eb7eca9ef8d0f2db90bc749c"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.8"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs", "WebP"]
git-tree-sha1 = "696144904b76e1ca433b886b4e7edd067d76cbf7"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.9"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "c5c5478ae8d944c63d6de961b19e6d3324812c35"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.4.0"

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
git-tree-sha1 = "b842cbff3f44804a84fda409745cc8f04c029a20"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.6"

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
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

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
git-tree-sha1 = "8be878062e0ffa2c3f67bb58a595375eda5de80b"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.11.0+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c6ce1e19f3aec9b59186bdf06cdf3c4fc5f5f3e6"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.50.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "61dfdba58e585066d8bce214c5a51eaa0539f269"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+1"

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
git-tree-sha1 = "f02b56007b064fbfddb4c9cd60161b6dd0f40df3"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.1.0"

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
deps = ["LinearAlgebra", "OrderedCollections", "RecipesBase", "Requires", "Setfield", "SparseArrays"]
git-tree-sha1 = "adc25dbd4d13f148f3256b6d4743fe7e63a71c4a"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "4.0.12"

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
git-tree-sha1 = "52af86e35dd1b177d051b12681e1c581f53c281b"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.7.0"

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
git-tree-sha1 = "d0553ce4031a081cc42387a9b9c8441b7d99f32d"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.7"

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
git-tree-sha1 = "777657803913ffc7e8cc20f0fd04b634f871af8f"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.8"
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
git-tree-sha1 = "0248b1b2210285652fbc67fd6ced9bf0394bcfec"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.11.1"

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
git-tree-sha1 = "4ab62a49f1d8d9548a1c8d1a75e5f55cf196f64e"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.71"

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
git-tree-sha1 = "a2fccc6559132927d4c5dc183e3e01048c6dcbd6"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.5+0"

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

[[deps.libwebp_jll]]
deps = ["Artifacts", "Giflib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libglvnd_jll", "Libtiff_jll", "libpng_jll"]
git-tree-sha1 = "ccbb625a89ec6195856a50aa2b668a5c08712c94"
uuid = "c5f90fcd-3b7e-5836-afba-fc50a0988cb2"
version = "1.4.0+0"

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
# ╟─3885aed6-7596-471c-87e4-b246dadbe898
# ╟─855fbf64-5944-460c-a0d4-523066030e4e
# ╟─00fbe8cf-cd1e-451c-9a30-b83223fe3c10
# ╟─ecbeadd0-14ba-47ae-826a-d97f0695ef1e
# ╟─3981068a-8063-4f30-bb4b-c954f1780090
# ╠═87509cb1-de05-41f2-b30e-ad065ccde690
# ╟─21d43d86-b0cd-43ec-a434-ecb564971d24
# ╟─8992f9b8-3660-490e-aed3-8be32742183d
# ╟─7806626e-81e1-4b48-9756-b8277213d268
# ╟─98b24728-d29c-4d14-ba92-4e51fdbc7b10
# ╟─dcea8986-c1ed-4dab-976b-b9f4931f051f
# ╟─c035d077-763e-46e8-9807-08be974ddf61
# ╠═552aab87-728c-4ec0-b9ee-a41c8a38f51a
# ╟─8dd43a29-7e88-4b0e-86bc-afd70a5fb04d
# ╟─bf509d53-b239-4514-bdb2-30d5f52219e8
# ╟─7ff384fb-e482-4bf9-a70f-34bdd4fa840a
# ╟─0fdf5d20-9fcc-4404-b364-8bdb16237eea
# ╟─cb534937-101c-439d-b515-e0d99212894f
# ╟─5886e131-99cf-4ed6-a06c-2b281d710ef6
# ╟─6ab9ceda-5fb9-429d-a3f5-e9fd098fe619
# ╟─065a2edb-82b6-428a-9c33-7af11ec75ae1
# ╟─214d8d87-347c-47ac-8e0f-139f86c68b85
# ╠═fc100c97-e447-4a7a-b42f-4adb9729bfda
# ╟─5ab89eea-6d7b-490f-96f7-8b4d36249722
# ╟─a5c73baf-5367-470d-8e82-2874d5f90fd6
# ╟─cd1e19bd-190d-4d29-9223-485318476099
# ╟─14df04a2-8d3e-4b85-a7a2-e2e455f31e73
# ╟─0709425c-688d-40c3-9c80-eac32426d1b5
# ╟─fb3c5fd5-bdd1-4ffb-882b-dffa70c4ab30
# ╠═80431850-0e2d-4ca8-9589-abd9117382b3
# ╟─7726e89f-04b1-4664-89d8-bcdba5ec4129
# ╟─f1af8a95-3d4f-4f7e-bb66-b61b0a19d57d
# ╟─971750a7-dfef-4c44-a703-1ce02dedbe81
# ╟─895c92f0-6124-446f-a4dd-5a51316a5ed3
# ╟─89faf96d-0af9-462d-a84f-6f3505f9a604
# ╟─005fb905-a248-4bbf-8ceb-0271a1824deb
# ╟─5e1b7cfc-ff30-4b45-ad99-89a198dcd5d9
# ╟─c1d4d03b-2694-46a0-9a6d-e4b4d67e1bb2
# ╟─aeca23b3-8494-4f1d-b4fb-09e523e3f78a
# ╟─1eb0c378-4b6e-4da8-94ee-3f56c89e3c99
# ╟─2ffa3e3c-67ad-4ee2-88ad-306a1986e2f0
# ╟─90b15d0a-748a-4d0b-ad20-800b35fdb9be
# ╟─23f61001-cc7e-4ebc-9cac-474e217538f7
# ╟─b955394f-4bac-4e1c-8620-a4403cfd3d35
# ╠═db613b98-f00f-4028-a7df-0b5309243021
# ╠═a36bc04e-b611-4244-9e86-81c4dfd01a1d
# ╟─c0b80aea-e931-4aa0-82cf-1ecc600fc7fe
# ╟─fc506b2d-3295-49b4-b81a-04a922242f24
# ╟─710d89b9-13d8-4501-aed3-2befbdc36c10
# ╟─18ae06c3-d765-4b60-ae3c-4d55217b437d
# ╟─480d1d73-bd2e-488e-b936-4749956e45b7
# ╟─3b8543e3-42ef-4bfa-ad34-9dc3a0a072df
# ╟─9a431f74-107d-4db1-859e-bb4ca74f07cb
# ╟─db4128bc-fffd-4928-a2f5-d26e64582039
# ╠═1f286685-9bd8-4da2-9187-f62416077814
# ╟─6a0ad91f-5047-4fc4-92f6-24f0ea5ff1f3
# ╟─834e4649-2624-45f5-b98a-1dda03a914ff
# ╟─77fdb7f1-cef6-437b-a793-3443d1f6ad6f
# ╟─2ea0c762-0377-4db9-b891-002f189a3ada
# ╟─ad2006cb-0f8a-400b-b352-3228d7383fc9
# ╟─d341cf66-93ea-4857-b8f8-3518760259df
# ╟─c63131b0-fc8a-4fc5-991b-25eff5950aef
# ╠═8a9438fc-4754-4ece-8601-d3f075681db1
# ╠═df624514-b98c-4f4d-8348-96577a54167e
# ╠═0de7918c-fa71-4523-a314-653e1e190288
# ╠═225bbc0a-205f-4221-b945-ebc0aeaeae63
# ╠═0307bca1-6358-4181-92b4-6d7fbeb50bf5
# ╠═eb9116f9-2aa8-4f55-9c4f-f27891f46e30
# ╠═450ce71e-2fcb-4c32-ae96-bba24b7584b1
# ╠═4c39f6db-6d97-431e-97cf-1a7e400b71de
# ╠═809054ff-58bd-46eb-bbe1-65fe353da582
# ╠═4756613f-dec2-4145-ab57-de24776ab9e4
# ╠═225ea01f-243a-49fe-a22f-a85fc5c78a9b
# ╠═6e02907a-678c-4d4f-a3f7-92eddc878baf
# ╟─44bac7a6-5e6c-4e8d-a221-90d6c1173f38
# ╟─80e3c274-0dcc-448d-a380-aa28462ab5e9
# ╟─ed773753-e3f4-4d70-9718-183ace0f7d5a
# ╟─4f7059b3-41ce-4e43-a14e-f64de7f6e514
# ╟─2e45b58f-fcde-4de4-a485-72940d7da6ac
# ╟─4409e7cb-3cb7-4bfd-a1ec-cc36354f757b
# ╠═f72a702d-af26-4876-8d64-77582825fcc9
# ╟─6c97e63b-9ab5-4966-ae37-d1c5dcb2ab52
# ╟─b25c28f0-0f3a-48b5-be7b-af59a68439ea
# ╟─29b2fdae-6a13-4057-a75c-412a5a3c17ad
# ╟─0356097c-9c73-432c-b94f-d1143fcdfc34
# ╟─ae98d703-76ca-44f9-9c98-2c5648d9ce80
# ╟─8cd9c33b-079e-4984-ac3f-a73fc6fa1178
# ╟─304b82b3-cfa1-4c94-a2c8-b4e8e2d3d6e7
# ╟─970bf9e2-1466-42da-b202-c6b9f454eacb
# ╟─36cc24eb-c6bb-4fcd-ac9d-befddac22da8
# ╟─3ba6dfae-931a-48d6-b90c-8bc612c4076e
# ╟─ac2d9cee-d5b7-4a67-8454-0ca988ac4d6e
# ╟─9f9497d0-f42d-45f6-a250-b5f1f49952d0
# ╟─fb92541f-4fa9-4329-a8ac-d22d8389ff4b
# ╟─94aa56d5-9076-4271-a51d-c21a1524aad5
# ╟─a43d7c96-120b-4894-a454-e517551cf84a
# ╟─a79b0ccd-5b9f-41c3-b277-b554403b5002
# ╟─e1d84093-ef75-4e49-a91b-f9b2d8e73deb
# ╟─f41ea8ef-045d-4a3d-b095-8d9514d09d24
# ╟─871510fa-dfce-43d4-b063-fb036e907458
# ╟─c04fc6be-50ab-4f8d-8df0-f043936f5b8f
# ╟─5218f6e3-51d2-46e8-9afa-e52598e02175
# ╟─db9272d9-aad3-4819-b518-997e00fbfb5f
# ╟─f6bd2f0e-46ba-48ac-87c4-514640aa39d6
# ╟─60f7d827-3afb-4cb8-a004-597a72b3aa93
# ╟─4607bb45-1b1e-4727-8e66-b729edb717fa
# ╟─461a4468-eb0e-440e-a8e6-5b4a9583d338
# ╠═fed4b0f2-2e58-4f0f-9d18-fcf2756e990e
# ╠═8a8838ec-92a7-4663-8a2b-592f9376d20b
# ╠═2952a243-dcce-41d6-900b-3ced15e97194
# ╟─90bec4f5-f77f-4184-a274-e5b93e968a70
# ╠═07507b03-ce49-40e0-9ba6-ecc209ab9ada
# ╟─3989d5f6-cb52-4d33-8eac-2e94322cf24a
# ╟─a3ef0853-0751-44b1-82de-6c66bea67503
# ╠═fb6ecdb4-2686-4dad-8cec-965d30208cda
# ╠═270869cf-3e45-4a98-9af8-eef56a77665e
# ╠═247f9d2a-ba9f-4d1b-855f-fb520511c115
# ╠═e58a555d-0e63-4865-b74c-f56be2a6724a
# ╠═f841355e-58d9-4df1-a911-30b646f5bc70
# ╠═beb7a873-3fb1-4bfe-90ce-6d97382130b9
# ╠═de8440de-2d38-44b8-9bcc-20c6517a80bc
# ╟─fe95c961-f662-4d6c-a583-e39990e5e660
# ╟─d3699263-5afb-423a-b30b-81c74adb286b
# ╟─3f8b32a5-91b7-48fc-8573-f34b048aea95
# ╟─4da22b7a-f145-43ef-aad6-2cad844e560b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002