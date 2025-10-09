### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ a530c361-6a99-45c3-9efa-ed85e9ff2535
using PlutoUI

# ╔═╡ ba6f0c68-e06b-4f33-82e0-66ff452d3763
begin
	using Plots,Colors,ColorVectorSpace,ImageShow,FileIO,ImageIO
	using HypertextLiteral
	using Images, ImageShow 
	using Statistics,  Distributions, LinearAlgebra
	using StatsBase, StatsPlots
end

# ╔═╡ 7ac3f245-ac45-49a0-938d-87978123674b
using TestImages

# ╔═╡ 6fdb4745-b175-4ed8-938e-87774afecaa6
PlutoUI.TableOfContents(title="Aplicaciones de Funciones Elementales", aside=true)

# ╔═╡ ba3dacf5-b37e-42c0-a762-efbda963d14d
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**.

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ 51ff090b-3527-4ee1-a325-4f6f65621ada
md"""**Este cuaderno está basado en actividades del seminario Procesamiento de Imágenes de la Universidad Nacional de Colombia, sede Bogotá, dirigido por el profesor Jorge Mauricio Ruíz en 2024-2.**

Elaborado por Juan Galvis, Carlos Nosa, Jorge Mauricio Ruíz y Yessica Trujillo."""

# ╔═╡ 5ece519c-9988-4ef9-acdd-a099712f0a51
md"""Vamos a usar las siguientes librerías:"""

# ╔═╡ 19e85962-868f-41fb-9103-d9d7868b5137
md"""Funciones auxiliares:"""

# ╔═╡ c4a5ee43-3e5e-4dc1-a529-6c9ed0aa08f4
begin
	function clip_pixel(pixel::RGB{Float64}) #función para ajustar los valores de la imagen entre 0 y 1
	    r_clipped = clamp(pixel.r, 0.0, 1.0)
	    g_clipped = clamp(pixel.g, 0.0, 1.0)
	    b_clipped = clamp(pixel.b, 0.0, 1.0)
	    return RGB{N0f8}.(RGB{Float64}(r_clipped, g_clipped, b_clipped))
	end
	
	function Hist(image) #Histograma de la imagen
		A = Float64.(channelview(image))
		if length(size(A)) == 2
			image_values = 255*A
			hist = fit(Histogram, vec(image_values), 0:255).weights
			P1=plot(hist, c="black", fill=(0, "black"), fillalpha=0.1, label="Canal Gray", title="Histograma de la Figura")
			return P1
		else
			P1 = plot(title="Histograma de la imagen en RGB")
			for comp in (red, green, blue)
			    hist = fit(Histogram, reinterpret.(comp.(vec(RGB.(image)))), 0:256).weights
			    P1 = plot!(hist, c="$comp",fill=(0,"$comp"), fillalpha=0.1,label="Canal $comp", title="Histograma de la imagen en RGB")
			end
			return P1
		end
	end
end;

# ╔═╡ 440b9745-1001-4e8c-be5f-8d4c570a8732
md"""# Motivación"""

# ╔═╡ 933134ff-401a-433e-875f-c39aff425fa9
md"""En el procesamiento de imágenes digitales, ajustar la iluminación y el contraste de las imágenes es fundamental para mejorar su calidad y resaltar detalles importantes. Este tipo de ajustes es particularmente útil en fotografías que están sobreexpuestas o subexpuestas, donde los detalles se pierden debido a un rango limitado de valores de los píxeles.

Las transformaciones de potencia y exponenciales se han utilizado ampliamente para este propósito, ya que permiten manipular de manera eficiente los niveles de brillo y contraste en las imágenes. En este cuaderno se va a implementar dichas técnicas de transformación para aclarar u oscurecer imágenes, utilizando tanto imágenes en escala de grises como en color."""

# ╔═╡ 34f0f949-c54c-432d-86b4-20e31c20097a
md"""A continuación se presenta una fotografía subexpuesta y una sobreexpuesta, ver Figura 1 y Figura 2, respectivamente."""

# ╔═╡ a7e3d085-c944-48ae-9a75-b8f729b471f2
begin
	url₁ = "https://images.unsplash.com/photo-1534181502406-20b3295371d7?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
	fname₁ = download(url₁)
	image₁ = Gray.(load(fname₁))
end

# ╔═╡ e54426fd-6d96-4eef-ad61-5a7c2f81ecef
md"""$\texttt{Figura 1. Flores. Imagen tomada de Unsplash [5].}$"""

# ╔═╡ 4582d97e-8240-4b6e-b18f-b340f05dd634
image₂ = Gray.(testimage("lighthouse.png")*1.5)

# ╔═╡ 2c4aa3f0-89c8-40e3-8f30-830c769c22be
md"""$\texttt{Figura 2. Faro. Imagen tomada de TestImages [4].}$"""

# ╔═╡ 3eb3a378-d1f0-4418-a49b-125f2da66a8d
md"""A continuación se muestran los histrogramas de cada imagen, ver Figura 3. Se puede observar que el histograma de la fotografía subexpuesta presenta un sesgo a la derecha, y, el histograma de la fotografía sobreexpuesta presenta un sesgo a la izquierda."""

# ╔═╡ 0590cc78-3de9-4a2e-a17d-00918a3d5b43
plot(Hist(image₁), Hist(image₂), layout = (1, 2))

# ╔═╡ 703ef9d6-9a82-4cd2-a8d6-469fe4dd5d81
md"""$\texttt{Figura 3. Histogramas de las Figuras 1 y 2, respectivamente.}$"""

# ╔═╡ 881406e6-8dd5-46a0-9568-e7e728c0ac14
md"""# Transformación potencial"""

# ╔═╡ 2ac2be6e-7401-4b6f-9487-bd32f6c098c7
md"""La corrección de gamma es una técnica utilizada en procesamiento de imágenes para ajustar el brillo o la luminosidad de una imagen de acuerdo con una función no lineal. Esta técnica es especialmente útil cuando las imágenes están mal expuestas (ya sea demasiado oscuras o demasiado brillantes) y necesitas ajustar los detalles en las zonas oscuras o claras sin afectar el resto de la imagen. Las funciones de potencia son esenciales para esto."""

# ╔═╡ a7cdb4c2-1e85-4550-8a33-28ca8b17f186
md"""En la figura 4 se puede evidenciar algunas funciones potenciales en el intervalo $[0,1]$."""

# ╔═╡ 42931db9-0349-4264-acc7-be9c7074e4e7
@bind a Slider(0.01:.01:1, show_value=true, default=0.75)

# ╔═╡ 649706e7-2dc2-49fa-9537-9c0d6ac1c505
begin
	f1(x) = x^2
	f2(x) = x^(1/2)
	f3(x) = x^a
	
	x = 0:0.01:1
	
	plot(x, f1.(x), label="x^2", lw=2)
	plot!(x, f2.(x), label="x^(1/2)", lw=2)
	plot!(x, f3.(x), label="x^$a", lw=2)
	
	xlabel!("x")
	ylabel!("f(x)")
	title!("Funciones Potenciales en el Intervalo [0,1]")
end

# ╔═╡ 7e2260d8-62d1-4aaa-a0e8-1d3446ee3dde
md"""$\texttt{Figura 4. Funciones potenciales en el intervalo [0,1].}$"""

# ╔═╡ 69f70ddb-7a39-4d4f-8d44-8a1c37d06600
md"""La corrección gamma se implementa mediante la transformación de los valores de los píxeles de una imagen usando una función de potencia de la forma:

$B(m,n)=A(m,n)^{\gamma},$ 
donde $A(m,n)$ es la matriz que representa la imagen original, $B(m,n)$ es la matriz de la imagen corregida y $\gamma$ es un parámetro que determina el nivel de corrección (si $\gamma<1$, aclara la imagen, y si $\gamma>1$, la oscurece)."""

# ╔═╡ d01ae1a4-a3e1-4523-a0d2-dacb26b22b7e
md"""Consideremos el siguiente valor de $\gamma$:"""

# ╔═╡ 56aa8d2b-2ac5-4686-a421-709e36efcd4f
@bind γ₁ Slider(0:.001:1, show_value=true, default=0.63) #Parametro γ

# ╔═╡ 5132c39f-6130-4889-85cf-99d4cb449850
md"""Aplicando la transformación a la Figura 1, dado que es una fotografía subexpuesta es conveniente que el valor de $\gamma$ este entre $0$ y $1$, así obtenemos la siguiente imagen: """

# ╔═╡ 77edea14-74ab-4c91-a407-0f8a513e5d06
begin
	A₁ = float.(channelview(image₁))
	B₁ = A₁ .^ γ₁
	image₃ = Gray.(B₁)
end

# ╔═╡ 29928480-9448-42d0-b4af-ec48d86e4e6e
md"""$\texttt{Figura 5. Resultado de la transformación potencial en la Figura 1.}$"""

# ╔═╡ f8b8575d-06d4-452f-a47a-3148a256d60f
md"""A continuación se presenta el histograma de la Figura 5."""

# ╔═╡ 53327535-b3bd-4e83-872a-46879159a159
Hist(image₃)

# ╔═╡ 7ebbc9a5-48c9-472e-b0c8-a664dc5eea1d
md"""$\texttt{Figura 6. Histograma de la Figura 5.}$"""

# ╔═╡ 5d612f37-223a-429f-bb41-dc98a60c0611
md"""Ahora, apliquemos la corrección Gamma a la Figura 2, dado que es una fotografía sobreexpuesta es conveniente que $\gamma > 1$, así obtenemos la siguiente imagen:"""

# ╔═╡ f575e59a-d17c-40fb-9059-76db8ded0196
@bind γ₂ Slider(1:.001:5, show_value=true, default=2)

# ╔═╡ 093f23cb-14aa-4a52-81c8-e0ec7748ea13
begin
	A₂ = float.(channelview(image₂))
	B₂ = A₂ .^ γ₂
	image₄ = Gray.(B₂)
end

# ╔═╡ 88784714-3fb9-43b2-8c40-b076c8ecef20
md"""$\texttt{Figura 7. Resultado de la transformación potencial en la Figura 2.}$"""

# ╔═╡ 187cf483-228d-4bcb-ab76-776a78ee58e7
md"""A continuación, se presenta el histograna de la Figura 7."""

# ╔═╡ b2fa5afa-ba4d-42f7-9009-3cd7429eedee
Hist(image₄)

# ╔═╡ 95af7bfc-3490-4d34-8d5a-2666de3c870f
md"""$\texttt{Figura 8. Histograma de la Figura 7.}$"""

# ╔═╡ ae5eeb4f-d4ef-48d6-b237-22c03c7416d2
md"""Definamos funciones que nos permitan tranformar imágenes del formato RGB al formato YCbCr, y viceversa."""

# ╔═╡ 7c908704-fdea-40ab-8849-4923fbe0d93d
begin
	# Función para convertir toda un pixel de RGB a YCbCr
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

	# Función para mostrar imagen de RGB a YCbCr
	function YCBCR(image)
		A = Float64.(channelview(image)) 
		image_rgb = zeros(size(A[1, :, :])[1], size(A[1, :, :])[2], 3)
		image_rgb[:,:,1] = A[1, :, :] *256
		image_rgb[:,:,2] = A[2, :, :] *256
		image_rgb[:,:,3] = A[3, :, :] *256
	
		image_ycbcr = image_to_ycbcr(image_rgb)/256;
		
		new_imagen_YCbCr = permutedims(cat(dims=3, image_ycbcr[:,:,1], image_ycbcr[:,:,2], image_ycbcr[:,:,3]), [3, 1, 2]);
		return colorview(RGB, new_imagen_YCbCr)
	end	
end;

# ╔═╡ b4f216c5-243f-422d-a1fa-e7a3ff816a8c
begin
	# Función para convertir toda un pixel de YCbCr a RGB
	function ycbcr_to_rgb(Y, Cb, Cr)
		R = Y + 1.402 * (Cr - 128)
		G = Y - 0.344136 * (Cb - 128) - 0.714136 * (Cr - 128)
		B = Y + 1.772 * (Cb - 128)
		return R, G, B
	end

	# Función para convertir toda una imagen de YCbCr a RGB
	function image_to_rgb(image_ycbcr)
		RBG_image = similar(image_ycbcr) 
		for i in 1:size(image_ycbcr, 1), j in 1:size(image_ycbcr, 2)
			Y, Cb, Cr = image_ycbcr[i, j, :]
			RBG_image[i, j, :] .= ycbcr_to_rgb(Y, Cb, Cr)
		end
		return RBG_image
	end

	# Función para mostrar imagen de YCbCr a RGB
	function function_RBG(image)
		A = Float64.(channelview(image)) 
		image_ycbcr = zeros(size(A[1, :, :])[1], size(A[1, :, :])[2], 3)
		image_ycbcr[:,:,1] = A[1, :, :] *256
		image_ycbcr[:,:,2] = A[2, :, :] *256
		image_ycbcr[:,:,3] = A[3, :, :] *256
	
		image_rgb = image_to_rgb(image_ycbcr)/256;
		
		new_imagen_RGB = permutedims(cat(dims=3, image_rgb[:,:,1], image_rgb[:,:,2], image_rgb[:,:,3]), [3, 1, 2]);
		return colorview(RGB, new_imagen_RGB)
	end
end;

# ╔═╡ bb489988-b03f-4a4b-b6e9-c9e96e1ea886
md"""Ahora, escribamos una función que aclare (u oscurezca) una imagen para un valor de $\gamma$ dado. La función tendrá como entradas la imagen y el valor de $\gamma$. Idealmente, va a funcionar con cualquier imagen en escala de grises y con cualquier imagen en color. En este último caso, la imagen se va a convertir al espacio de color YCbCr, y la transformación será aplicada al canal Y."""

# ╔═╡ 9a7c1190-c5fc-4ee1-b756-2828ff18727b
function Transformacion_potencial(image, gamma)
	A = Float64.(channelview(image))
	if length(size(A)) == 2
		B = A .^ gamma
		new_image = Gray.(B)
		return new_image
	else 
		image_rgb = zeros(size(A[1, :, :])[1], size(A[1, :, :])[2], 3)
		image_rgb[:,:,1] = A[1, :, :] *256
		image_rgb[:,:,2] = A[2, :, :] *256
		image_rgb[:,:,3] = A[3, :, :] *256
	
		image_ycbcr = image_to_ycbcr(image_rgb)/256;
		
		new_imagen_YCbCr = permutedims(cat(dims=3, image_ycbcr[:,:,1] .^ gamma, image_ycbcr[:,:,2], image_ycbcr[:,:,3]), [3, 1, 2]);
		return colorview(RGB, new_imagen_YCbCr)
	end
end;

# ╔═╡ 98157209-d9dd-49ce-867b-a6c4506b138e
md"""Consideremos la siguiente imagen, ver Figura 9."""

# ╔═╡ 367f3c9a-fd15-4146-a18e-8e8e009ded3d
Image₃ = Gray.(testimage("walkbridge.tif")*0.5)

# ╔═╡ 5880cdde-295f-4b4f-94c8-8811998718ea
md"""$\texttt{Figura 9. Fotografía de un puente. Imagen tomada de TestImages [4].}$"""

# ╔═╡ 8d19488a-8025-4718-8a3f-5b3ad87ecdc4
md"""Escogemos el valor de $\gamma$ y aplicamos la transformación."""

# ╔═╡ f654a489-aeb3-4a5f-bf9e-5f44a6968fb8
@bind γ₃ Slider(0:.001:2, show_value=true, default=0.7)

# ╔═╡ e8453abe-6bff-47ab-b031-b4a3586bd05e
Transformacion_potencial(Image₃, γ₃)

# ╔═╡ 27ee7adc-b07b-41a5-94ad-a93053bec610
md"""$\texttt{Figura 10. Resultado de la transformación potencial en la Figura 9.}$"""

# ╔═╡ 2bd8a54f-87c9-42ea-9504-2f57c654f563
md"""Ahora, consideremos la siguiente fotografía"""

# ╔═╡ ee079e18-7f53-4f59-8f9d-92e777557e3e
image1 = RGB.(testimage("monarch_color.png")*1.95)

# ╔═╡ 969d1a66-d860-4d50-bec8-8b26a93afee8
md"""$\texttt{Figura 11. Fotografía de una mariposa. Imagen tomada de TestImages [4].}$"""

# ╔═╡ d49e8aeb-1ae7-46da-b6c1-dd0821dffb63
md"""Escogemos el valor de $\gamma$ y aplicamos la tranformación."""

# ╔═╡ da9aaf33-0b21-406b-8f83-e40cdbf0ff20
@bind γ₄ Slider(0:.001:5, show_value=true, default=2.3)

# ╔═╡ 3d81527f-eedd-424d-93ba-d473aad093fb
Transformacion_potencial(image1, γ₄)

# ╔═╡ b2557e6d-9d83-4c90-a92d-6d6c42b787de
md"""$\texttt{Figura 12. Resultado de la transformación potencial en la Figura 11}$
$\texttt{en formato YCbCr.}$"""

# ╔═╡ cd98b718-1175-4c86-b0b0-889dcc5c9de7
md"""Note que la Figura 12 está en formato YCbCr. Ahora, visualicémosla en formato RGB, ver Figura 13."""

# ╔═╡ 03e8996d-a802-4364-ba47-a7aabfabe782
function_RBG(Transformacion_potencial(image1, γ₄))

# ╔═╡ 388e800c-26c8-4e21-a8a9-c14941b4bf09
md"""$\texttt{Figura 13. Resultado de la transformación potencial en la Figura 11}$
$\texttt{en formato RGB.}$"""

# ╔═╡ f00e05d3-984b-42c8-ad13-0c109cbcc457
md""" Ahora, creemos una función que nos permita visualizar tanto la imagen modificada como su histograma. """

# ╔═╡ ae7a4ed5-c551-4015-8502-83a6d38480f1
function Transformacion_potencial_mejorada(image, gamma)
	A = Float64.(channelview(image))
	if length(size(A)) == 2
		new_image = Transformacion_potencial(image, gamma)
		return Hist(new_image), new_image
	else
		new_image = clip_pixel.(function_RBG(Transformacion_potencial(image, gamma)))
		return Hist(new_image), new_image
	end
end

# ╔═╡ 642b4cd9-b297-4cc6-8e5b-84addad4937b
T = Transformacion_potencial_mejorada(Image₃, 0.7)

# ╔═╡ 908f9615-5c0b-4370-ba2f-6c6eec20b7d3
md"""Para ver esto más grande, podemos acceder de la siguiente manera:"""

# ╔═╡ c77864b5-934b-471e-b7ee-585d561a49be
T[2]

# ╔═╡ d8bd77c4-d3e3-4b37-98bd-1f6d478a940d
md"""$\texttt{Figura 14. Resultado de la transformación potencial mejorada}$
$\texttt{ en la Figura 9.}$"""

# ╔═╡ 039bbc45-5d1f-4ed2-8689-3b6d3a4bb7fc
T[1]

# ╔═╡ 209cd772-cbca-4e99-8e09-efbd8628860b
md"""$\texttt{Figura 15. Histograma de la Figura 14.}$"""

# ╔═╡ 91672cee-48cc-4378-a21d-9138cf360b6f
md"""# Transformación exponencial"""

# ╔═╡ b3b5c934-9e16-4d97-ae54-b2fe95bce7f1
md"""Las funciones exponenciales también se utilizan en el procesamiento de imágenes, especialmente para corregir imágenes sobreexpuestas, donde la mayoría de los píxeles tienen valores altos. Las funciones exponenciales, al igual que las de potencia, permiten modificar los valores de brillo de una imagen, pero son más adecuadas cuando el rango de los valores de los píxeles está concentrado cerca del valor máximo."""

# ╔═╡ afc2569f-8cd2-4daf-9303-2ac5ee407325
md"""También nos gustaría que nuestra función mapee el intervalo $[0, 1]$ en el intervalo $[0, 1]$. Combinando todos nuestros deseos, nos gustaría tener una función descrita por la fórmula general:

$f(x) = c(b^x − 1)$

que satisfaga las condiciones:

$f(0) = 0 \text{ y } f(1) = 1.$
Esto implica que la constante c debe ser igual a:

$c = \frac{1}{b − 1}$"""

# ╔═╡ d4a13434-7b11-4440-8738-30c072c3ea16
md"""En la figura 16 se puede evidenciar algunas funciones exponenciales en el intervalo $[0,1]$."""

# ╔═╡ 7733f7fb-4bec-4645-9b78-e5748a4db74a
@bind β Slider(0.01:.01:10, show_value=true, default=0.5)

# ╔═╡ f32e07f2-8b8c-4554-a541-b750550317d6
begin
	g1(x) = (1/(2-1))*((2^x)- 1)
	g2(x) = (1/(4-1))*((4^x)- 1)
	g3(x) = (1/(β-1))*((β^x)- 1)
	
	x_v = 0:0.01:1
	
	plot(x_v, g1.(x), label="2^x-1", lw=2)
	plot!(x_v, g2.(x), label="(1/3)(4^x-1)", lw=2)
	plot!(x_v, g3.(x), label="(1/($β-1))(($β^x)- 1)", lw=2)
	
	xlabel!("x")
	ylabel!("f(x)")
	title!("Funciones Exponenciales en el Intervalo [0,1]")
end

# ╔═╡ 424f0f04-144a-4a80-a7b5-2cbf4de1f792
md"""$\texttt{Figura 16. Funciones exponenciales en el intervalo [0,1].}$"""

# ╔═╡ c12db014-eb77-4411-adbc-3515a90995fc
md"""De lo anterior se tiene la tranformación

$B(m, n) = c(b^{A(m,n)} − 1),$
esto es

$B= \frac{1}{b − 1} (b^A-1),$
donde $A$ es imagen original (de tamaño $m\times n$), $B$ imagen mejorada y $b$ es una constante.
"""

# ╔═╡ 56aa3ef4-a178-4f02-8f0b-7bfc39cd4124
md"""Consideremos la siguiente imagen:"""

# ╔═╡ af4ec210-5aab-4a2f-9202-5466fd08d9f5
begin
	url₆ = "https://images.unsplash.com/photo-1539544913240-d50d58d97f5d?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
	fname₆ = download(url₆)
	image₆ = Gray.(load(fname₆))
end

# ╔═╡ 888fc6f9-cb7b-43e3-a8ee-174d424577ed
md"""$\texttt{Figura 17. Árbol cubierto de nieve. Imagen tomada de Unsplash [5].}$"""

# ╔═╡ b8aa4ed9-3228-4451-8615-d829c771ec06
md"""A continuación se muestra el histrograma de la Figura 17. Se puede observar que el histograma presenta un sesgo a la izquierda."""

# ╔═╡ 68951335-3c31-42af-bbab-edfa5f4e8d41
Hist(image₆)

# ╔═╡ accd044d-4cca-44e1-879b-9707ac0505fb
md"""$\texttt{Figura 18. Histograma de la Figura 17.}$"""

# ╔═╡ a302cbae-0c28-4ac9-bb44-0edf44ed7942
md"""Mejoremos la imagen, para esto consideremos el siguiente valor de $b$:"""

# ╔═╡ 9928a2c7-e2d1-44c5-8ecc-f07cf508fc94
b = @bind b Slider(0:1:1000, show_value=true, default=500)

# ╔═╡ e3de90ed-9b83-4d0b-89cd-ee162fc1a6b5
md"""Al aplicar la tranformación con el parámetro $b$ a la Figura 17 se obtiene la Figura 19."""

# ╔═╡ 6f8e11b8-ea1f-4bb3-a259-ae2847afa4d9
begin
	A₃ = float.(channelview(image₆))
	B₃ = (1/(b-1))*((b .^ A₃) .- 1)
	image₅ = Gray.(B₃)
end

# ╔═╡ 739a5500-030d-4337-87ba-a11fe64a3472
md"""$\texttt{Figura 19. Resultado de la transformación exponencial en la Figura 17.}$"""

# ╔═╡ 0c086519-a135-41ec-b9d2-f1c9878e79cb
md"""A continuación, se presenta el histograma de la Figura 19."""

# ╔═╡ b877fb2b-a1be-4671-bb20-f4311ff98c4a
Hist(image₅)

# ╔═╡ 17f1553f-e488-4d9a-a213-a81e5c8bb420
md"""$\texttt{Figura 20. Histograma de la Figura 19.}$"""

# ╔═╡ bd654ca0-7fe7-4cda-9c3f-ac9c5cbbde74
md"""Al comparar las imágenes, observamos una mejora notable en la claridad y definición de los árboles."""

# ╔═╡ b70a2ae9-f16a-45bd-bbd8-61c1fce3d6a2
[image₆ image₅]

# ╔═╡ 7c7a9fd0-d8ff-4aab-9160-5d11b345fc2e
md"""$\texttt{Figura 21. Comparación de la Figuras 17 y la Figuras 19.}$"""

# ╔═╡ df7c8857-3535-4074-b5b8-64500ec002a0
md"""A continuación, vamos a crear una función que permita aclarar u oscurecer una imagen utilizando un valor dado de la base $b$. La función recibirá como parámetros la imagen y la base $b$. Funcionará tanto para imágenes en escala de grises como para imágenes en color. En este último caso, la imagen se convertirá al espacio de color YCbCr, aplicando la transformación solo al canal Y."""

# ╔═╡ da6fd446-233b-482c-98aa-12b7366d332c
function Transformacion_exponencial(image, b)
	A = Float64.(channelview(image))
	if length(size(A)) == 2
		B = (1/(b-1))*((b .^ A) .- 1)
		new_image = Gray.(B)
		return new_image
	else 
		image_rgb = zeros(size(A[1, :, :])[1], size(A[1, :, :])[2], 3)
		image_rgb[:,:,1] = A[1, :, :] *256
		image_rgb[:,:,2] = A[2, :, :] *256
		image_rgb[:,:,3] = A[3, :, :] *256
	
		image_ycbcr = image_to_ycbcr(image_rgb)/256;
		
		new_imagen_YCbCr = permutedims(cat(dims=3, (1/(b-1))*((b .^ image_ycbcr[:,:,1]) .- 1), image_ycbcr[:,:,2], image_ycbcr[:,:,3]), [3, 1, 2]);
		return colorview(RGB, new_imagen_YCbCr)
	end
end;

# ╔═╡ 1a359987-3d20-4a3a-919d-ae2bfd59f910
md"""Consideremos la siguiente imagen, ver Figura 22."""

# ╔═╡ 2b1c1420-0819-4cde-9496-6d1665ae9c15
begin
	URL3 = "https://images.unsplash.com/photo-1598670985520-b4a35c779dc2?q=80&w=1472&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
	fname3 = download(URL3)
	image3 = load(fname3)
end

# ╔═╡ 1f76b216-b997-42ee-86de-2998e44cc460
md"""$\texttt{Figura 22. Señal de entrada. Imagen tomada de Unsplash [5].}$"""

# ╔═╡ 2b4f4a46-8aee-4a15-9051-7d7bdee7824f
md"""Escogemos el valor de $b$ y aplicamos la tranformación."""

# ╔═╡ 55502b23-40a7-481c-8a96-82b5d20818aa
@bind b₁ Slider(0:.01:20, show_value=true, default=15)

# ╔═╡ e73ffdf3-34f4-4056-bbc3-1b44943ae224
Transformacion_exponencial(image3, b₁)

# ╔═╡ cbf60fab-b8eb-4bc1-89d9-8ece73804842
md"""$\texttt{Figura 23. Resultado de la transformación exponencial en la Figura 22}$
$\texttt{en formato YCbCr.}$"""

# ╔═╡ ff92eeae-a456-4b44-87cc-a532602e75c8
md"""Note que la imagen anterior está en formato YCbCr. Ahora, visualicémosla en formato RGB. """

# ╔═╡ 11717f36-6d98-4212-b978-21f89db4a42e
function_RBG(Transformacion_exponencial(image3, b₁))

# ╔═╡ 36138bc1-8278-4955-a796-e8cb49d59250
md"""$\texttt{Figura 24. Resultado de la transformación exponencial en la Figura 22}$
$\texttt{en formato RGB.}$"""

# ╔═╡ 315c17c6-2234-42c8-9f30-a873c782da3b
md""" Ahora, creemos una función que nos permita visualizar tanto la imagen modificada como su histograma. """

# ╔═╡ 666436c0-377c-4175-b95d-dd3e09481364
function Transformacion_exponencial_mejorada(image, gamma)
	A = Float64.(channelview(image))
	if length(size(A)) == 2
		new_image = Transformacion_exponencial(image, gamma)
		return Hist(new_image), new_image
	else
		new_image = clip_pixel.(function_RBG(Transformacion_exponencial(image, gamma)))
		return Hist(new_image), new_image
	end
end

# ╔═╡ bc81f0bd-3d26-43c1-a8a8-3cb20552f75a
md"""Consideremos la siguiente imagen y apliquemos la transformación exponencial,"""

# ╔═╡ d5313e2d-35bc-40fd-95cd-261d07ff850f
begin
	URL4 = "https://images.unsplash.com/photo-1660270773573-111fbfeeb90c?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
	fname4 = download(URL4)
	image4 = RGB.(load(fname4))
end

# ╔═╡ fb30a480-b151-4ecc-96c6-541b2fb9507f
md"""$\texttt{Figura 25. Lago. Imagen recuperada de Unsplash [5].}$"""

# ╔═╡ a2ca75c4-c3f8-420c-a57d-5d7bf37590dd
T2 = Transformacion_exponencial_mejorada(image4, 0.005)

# ╔═╡ 307e8dc1-32a9-4ce0-80b8-f20faa08f848
md"""Para ver esto más grande, podemos acceder de la siguiente manera:"""

# ╔═╡ 229ea4e5-ae30-4f4d-aeb7-257e2fb2b6c6
T2[2]

# ╔═╡ fcc3aeb7-101e-473d-9eeb-fafdbcc0a900
md"""$\texttt{Figura 26. Resultado de la transformación exponencial mejorada }$
$\texttt{en la Figura 25 en formato RGB.}$"""

# ╔═╡ 0b35f76a-d4ce-4ba2-b2da-d2e71aa11b67
T2[1]

# ╔═╡ 4ea1b82a-b067-46e2-8e5d-8265f6fb2742
md"""$\texttt{Figura 27. Histograma de la Figura 26.}$"""

# ╔═╡ 6633b847-fd7b-4e30-9b46-8228cc76e1c8
md"""# Transformación logarítmica"""

# ╔═╡ 2e4952e1-8c0e-47b1-b079-76dd72ff1caf
md"""Las funciones logarítmicas también son usadas en el procesamiento de imágenes, ya que permiten mejorar el contraste y la visualización de detalles en imágenes con rangos dinámicos amplios. Al aplicar una transformación logarítmica a los valores de píxeles, se puede expandir la gama de intensidades en las áreas más oscuras, haciendo que los detalles sutiles sean más visibles. Además, las funciones logarítmicas ayudan a reducir la influencia de los valores "atípicos" en el procesamiento de imágenes, permitiendo una representación más equilibrada de los datos visuales.
"""

# ╔═╡ b49e19fe-9637-4227-8b5d-c4c7d2dcf5a9
md"""

Teniendo en cuenta la anterior transformación, se puede recordar que las funciones logarítmicas y exponenciales son inversas entre sí. Se propone utilizar la inversa de la función $f(x) = c(b^x - 1)$ como candidata para la transformación logarítmica. La inversa se determina como $f^{-1}(x) = \log_b(x/c + 1)$.

Por lo tanto, se sugiere construir una función adecuada para la transformación logarítmica en la forma:

$g(x) = \log_b(\sigma x + 1)$

donde el parámetro $\sigma$ satisface la condición $\sigma = b - 1$, esto es,

$g(x) = \log_b((b-1) x + 1).$

Cabe destacar que esta familia de funciones satisfacen que $g(0)=0$ y $g(1)=1$.
"""

# ╔═╡ 7931309c-e718-497c-adbe-3fe61e76814c
md"""En la figura 28 se puede evidenciar algunas funciones logarítmicas en el intervalo $[0,1]$."""

# ╔═╡ 2ce7c115-331f-48a4-bee0-a6bd0b6bf7ae
@bind bₗ Slider(0.01:.01:10, show_value=true, default=0.5)

# ╔═╡ d4cc7271-d36a-4e7a-a2ae-4ce9d6260265
begin
	g01(x) = log((7-1)*x+1) / log(7)
	g02(x) = log((0.1-1)*x+1) / log(0.1)
	g03(x) = log((bₗ-1)*x+1) / log(bₗ)
	
	plot(x_v, g01.(x), label="log((7-1)x+1)/log(7)", lw=2)
	plot!(x_v, g02.(x), label="log((0.1-1)x+1)/log(0.1)", lw=2)
	plot!(x_v, g03.(x), label="log(($bₗ-1)x+1)/log($bₗ)", lw=2)
	
	xlabel!("x")
	ylabel!("g(x)")
	title!("Funciones Logaritmicas en el Intervalo [0,1]")
end

# ╔═╡ b1d724fe-5750-442b-b380-5eb2469f681a
md"""$\texttt{Figura 28. Funciones logarítmicas en el intervalo [0,1].}$"""

# ╔═╡ d0e0399a-79ec-40a2-8ed3-d8ccfd93811a
md"""De lo anterior se obtiene la siguiente transformación

$B(m, n) = log_{b}((b-1){A(m,n)} + 1),$

donde $A$ es imagen original (de tamaño $m\times n$), $B$ imagen mejorada, y $b$ es una constante.
"""

# ╔═╡ bcb21393-d1ac-4895-9776-618f90eb6d29
md"""
Consideremos la Figura 1 que muestra una imagen subexpuesta. La imagen y su histograma se muestra de nuevo a continuación.
"""

# ╔═╡ bfec8740-1725-4807-8e9a-f02bd3f3181b
image₁

# ╔═╡ 9d531f2d-b802-4977-b436-046f3f0fe48c
md"""$\texttt{Figura 29. Nuevamente Figura 1.}$"""

# ╔═╡ 3e937224-0b97-4fb1-9a3d-9a3cd203148e
Hist(image₁)

# ╔═╡ 96917f4f-873c-4bf4-9f26-854477ade542
md"""$\texttt{Figura 30. Histograma de la Figura 29.}$"""

# ╔═╡ 1b155514-8304-4625-907f-8637b0d4b962
md"""
Como se ha hecho anteriormente, declaramos una función que haga la transformación logaritmica
"""

# ╔═╡ 678c47eb-5334-45fa-a83e-33091611e721
function Transformacion_logaritmica(image, b)
	A = Float64.(channelview(image))
	if length(size(A)) == 2
		B = log.((b-1)*A .+ 1) ./ log(b)
		new_image = Gray.(B)
		return new_image
	else 
		image_rgb = zeros(size(A[1, :, :])[1], size(A[1, :, :])[2], 3)
		image_rgb[:,:,1] = A[1, :, :] *256
		image_rgb[:,:,2] = A[2, :, :] *256
		image_rgb[:,:,3] = A[3, :, :] *256
	
		image_ycbcr = image_to_ycbcr(image_rgb)/256;
		
		new_imagen_YCbCr = permutedims(cat(dims=3, log.((b-1)*image_ycbcr[:,:,1] .+ 1) ./ log(b), image_ycbcr[:,:,2], image_ycbcr[:,:,3]), [3, 1, 2]);
		return colorview(RGB, new_imagen_YCbCr)
	end
end;

# ╔═╡ 96662f08-0bda-400d-9d77-0426a761156a
md"""
Variando el parámetro $b$ de la transformación logaritmica se cambia la imagen de partida para mejorar la subexposición.
"""

# ╔═╡ 78b6c4ad-7a99-42e1-8e8a-9ecdeebbadee
@bind bₗ₁ Slider(0.01:0.01:1000, show_value=true, default=100)

# ╔═╡ e4c9bab6-3727-4bd0-8d62-9563d0df954a
Transformacion_logaritmica(image₁, bₗ₁)

# ╔═╡ 5a766350-3ab3-4dc9-a875-cc64a5ace530
md"""$\texttt{Figura 31. Resultado de la transformación logarítmica en la Figura 29.}$"""

# ╔═╡ 8e4e6c4e-3108-4979-a634-923cf81df0f5
Hist(Transformacion_logaritmica(image₁, bₗ₁))

# ╔═╡ 7e36d866-5f72-45ce-9aa1-b89206ac1f3e
md"""$\texttt{Figura 32. Histograma de la Figura 31.}$"""

# ╔═╡ 96853ee8-053b-470b-a84f-8613b6b0b2b3
md"""
Como se puede ver en la figura 32, el histograma de la figura se desplaza hacia la derecha lo que es equivalente a que la imagen aclara y prescinde de su subexposición.


Ahora, creamos una función que realice la transformación logaritmica y a la vez grafique su respectivo histograma.
"""

# ╔═╡ f9ed49dc-7f58-4f8a-9a9d-143db3d5c043
function Transformacion_logaritmica_mejorada(image, gamma)
	A = Float64.(channelview(image))
	if length(size(A)) == 2
		new_image = Transformacion_logaritmica(image, gamma)
		return Hist(new_image), new_image
	else
		new_image = clip_pixel.(function_RBG(Transformacion_logaritmica(image, gamma)))
		return Hist(new_image), new_image
	end
end

# ╔═╡ 9f3ab1c1-f711-4c87-bca1-5608c608d203
md"""
Aplicamos la transformarción logaritmica a la figura 25 con parámetro $b=100$, obteniendo la siguiente comparación.
"""

# ╔═╡ 2d9ab4d6-6cdb-4b0a-be70-3dcf318d0b2e
[image4 function_RBG(Transformacion_logaritmica(image4, 100))]

# ╔═╡ 37c5345e-de2d-4e67-8e96-bdb93dd2a65f
md"""$\texttt{Figura 33. Comparación de la Figura 25 y su mejora}$
$\texttt{con la tranformación logarítmica.}$"""

# ╔═╡ 42499e67-7844-4e15-ac1c-65aa69a0356f
md"""
En la siguiente figura se muestra el histograma de la figura 25. Como se puede evidenciar, el histograma muestra un sesgo a la derecha indicando subexposición.
"""

# ╔═╡ f13cc879-42f4-4bba-844e-4f95b236b336
Hist(image4)

# ╔═╡ 312da3e0-4d10-4831-bf83-e6bcb7007ec7
md"""$\texttt{Figura 34. Histograma de la Figura 33.}$"""

# ╔═╡ 54d39189-d5ba-410b-a713-b3ca66491e66
md"""
En la siguiente animación se evidencia cómo cambia el histograma de la figura 25 a medida que se aplica la transformación logaritmica con parámetro $b$ variando en el intervalo $[2,100]$.
"""

# ╔═╡ f4b417db-1066-47cc-8055-be70b1a53c67
begin
	anim1 = @animate for i=2:1:100
			Transformacion_logaritmica_mejorada(image4, i)
		end
		gif(anim1,"TransLog_im4.gif",fps=3)
end

# ╔═╡ bfa7d58d-1aa0-4b38-9686-3e5d836b2a68
md"""$\texttt{Animación 1. Histograma del resultado de la transformación logarítmica}$
$\texttt{aplicada a la Figura 25.}$"""

# ╔═╡ b64bc307-1d06-4772-ade3-c4364483a0a9
md"""
Vemos que a medida que el parámetro $b$ aumenta, se pierde el sesgo a la derecha del histograma.
"""

# ╔═╡ 57ea7045-6411-493f-93cf-810b277bb1fd
md"""# Referencias

[1] Galperin, Y. V. (2020). An image processing tour of college mathematics. Chapman & Hall/CRC Press.

[2] JuliaImages. (s.f.). JuliaImages Documentation. Recuperado de [https://juliaimages.org/stable/](https://juliaimages.org/stable/).

[3] MIT Computational Thinking. (2023). Images Abstractions. Recuperado de [https://computationalthinking.mit.edu/Fall22/images_abstractions/images/](https://computationalthinking.mit.edu/Fall22/images_abstractions/images/)

[4] JuliaImages. (s.f.). TestImages: Image data for Julia. Recuperado de [https://testimages.juliaimages.org/stable/](https://testimages.juliaimages.org/stable/)

[5] Unsplash. (n.d.). Unsplash: Fotos gratis para todos. Recuperado de [https://unsplash.com/es](https://unsplash.com/es)
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
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
StatsPlots = "f3b207a7-027a-5e70-b257-86293d7955fd"
TestImages = "5e47fb64-e119-507b-a336-dd2b206d9990"

[compat]
ColorVectorSpace = "~0.10.0"
Colors = "~0.12.11"
Distributions = "~0.25.112"
FileIO = "~1.16.4"
HypertextLiteral = "~0.9.5"
ImageIO = "~0.6.8"
ImageShow = "~0.3.8"
Images = "~0.26.1"
Plots = "~1.40.7"
PlutoUI = "~0.7.60"
Statistics = "~1.11.1"
StatsBase = "~0.34.3"
StatsPlots = "~0.15.7"
TestImages = "~1.9.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.4"
manifest_format = "2.0"
project_hash = "704acc065cbaa69339f9b724f9a4b43c6b683ead"

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
git-tree-sha1 = "d80af0733c99ea80575f612813fa6aa71022d33a"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.1.0"
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
git-tree-sha1 = "13951eb68769ad1cd460cdb2e64e5e95f1bf123d"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.27.0"

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
git-tree-sha1 = "c6ce1e19f3aec9b59186bdf06cdf3c4fc5f5f3e6"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.50.0+0"

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
version = "0.8.1+4"

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
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "650a022b2ce86c7dcfbdecf00f78afeeb20e5655"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.2"

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
git-tree-sha1 = "305becf8af67eae1dbc912ee9097f00aeeabb8d5"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.6"

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

[[deps.StringDistances]]
deps = ["Distances", "StatsAPI"]
git-tree-sha1 = "5b2ca70b099f91e54d98064d5caf5cc9b541ad06"
uuid = "88034a9c-02f8-509d-84a9-84ec65e18404"
version = "0.11.3"

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
# ╟─a530c361-6a99-45c3-9efa-ed85e9ff2535
# ╟─6fdb4745-b175-4ed8-938e-87774afecaa6
# ╟─ba3dacf5-b37e-42c0-a762-efbda963d14d
# ╟─51ff090b-3527-4ee1-a325-4f6f65621ada
# ╟─5ece519c-9988-4ef9-acdd-a099712f0a51
# ╠═ba6f0c68-e06b-4f33-82e0-66ff452d3763
# ╠═7ac3f245-ac45-49a0-938d-87978123674b
# ╟─19e85962-868f-41fb-9103-d9d7868b5137
# ╠═c4a5ee43-3e5e-4dc1-a529-6c9ed0aa08f4
# ╟─440b9745-1001-4e8c-be5f-8d4c570a8732
# ╟─933134ff-401a-433e-875f-c39aff425fa9
# ╟─34f0f949-c54c-432d-86b4-20e31c20097a
# ╟─a7e3d085-c944-48ae-9a75-b8f729b471f2
# ╟─e54426fd-6d96-4eef-ad61-5a7c2f81ecef
# ╟─4582d97e-8240-4b6e-b18f-b340f05dd634
# ╟─2c4aa3f0-89c8-40e3-8f30-830c769c22be
# ╟─3eb3a378-d1f0-4418-a49b-125f2da66a8d
# ╟─0590cc78-3de9-4a2e-a17d-00918a3d5b43
# ╟─703ef9d6-9a82-4cd2-a8d6-469fe4dd5d81
# ╟─881406e6-8dd5-46a0-9568-e7e728c0ac14
# ╟─2ac2be6e-7401-4b6f-9487-bd32f6c098c7
# ╟─a7cdb4c2-1e85-4550-8a33-28ca8b17f186
# ╟─42931db9-0349-4264-acc7-be9c7074e4e7
# ╟─649706e7-2dc2-49fa-9537-9c0d6ac1c505
# ╟─7e2260d8-62d1-4aaa-a0e8-1d3446ee3dde
# ╟─69f70ddb-7a39-4d4f-8d44-8a1c37d06600
# ╟─d01ae1a4-a3e1-4523-a0d2-dacb26b22b7e
# ╟─56aa8d2b-2ac5-4686-a421-709e36efcd4f
# ╟─5132c39f-6130-4889-85cf-99d4cb449850
# ╟─77edea14-74ab-4c91-a407-0f8a513e5d06
# ╟─29928480-9448-42d0-b4af-ec48d86e4e6e
# ╟─f8b8575d-06d4-452f-a47a-3148a256d60f
# ╟─53327535-b3bd-4e83-872a-46879159a159
# ╟─7ebbc9a5-48c9-472e-b0c8-a664dc5eea1d
# ╟─5d612f37-223a-429f-bb41-dc98a60c0611
# ╟─f575e59a-d17c-40fb-9059-76db8ded0196
# ╟─093f23cb-14aa-4a52-81c8-e0ec7748ea13
# ╟─88784714-3fb9-43b2-8c40-b076c8ecef20
# ╟─187cf483-228d-4bcb-ab76-776a78ee58e7
# ╟─b2fa5afa-ba4d-42f7-9009-3cd7429eedee
# ╟─95af7bfc-3490-4d34-8d5a-2666de3c870f
# ╟─ae5eeb4f-d4ef-48d6-b237-22c03c7416d2
# ╠═7c908704-fdea-40ab-8849-4923fbe0d93d
# ╠═b4f216c5-243f-422d-a1fa-e7a3ff816a8c
# ╟─bb489988-b03f-4a4b-b6e9-c9e96e1ea886
# ╠═9a7c1190-c5fc-4ee1-b756-2828ff18727b
# ╟─98157209-d9dd-49ce-867b-a6c4506b138e
# ╟─367f3c9a-fd15-4146-a18e-8e8e009ded3d
# ╟─5880cdde-295f-4b4f-94c8-8811998718ea
# ╟─8d19488a-8025-4718-8a3f-5b3ad87ecdc4
# ╟─f654a489-aeb3-4a5f-bf9e-5f44a6968fb8
# ╟─e8453abe-6bff-47ab-b031-b4a3586bd05e
# ╟─27ee7adc-b07b-41a5-94ad-a93053bec610
# ╟─2bd8a54f-87c9-42ea-9504-2f57c654f563
# ╟─ee079e18-7f53-4f59-8f9d-92e777557e3e
# ╟─969d1a66-d860-4d50-bec8-8b26a93afee8
# ╟─d49e8aeb-1ae7-46da-b6c1-dd0821dffb63
# ╟─da9aaf33-0b21-406b-8f83-e40cdbf0ff20
# ╟─3d81527f-eedd-424d-93ba-d473aad093fb
# ╟─b2557e6d-9d83-4c90-a92d-6d6c42b787de
# ╟─cd98b718-1175-4c86-b0b0-889dcc5c9de7
# ╟─03e8996d-a802-4364-ba47-a7aabfabe782
# ╟─388e800c-26c8-4e21-a8a9-c14941b4bf09
# ╟─f00e05d3-984b-42c8-ad13-0c109cbcc457
# ╠═ae7a4ed5-c551-4015-8502-83a6d38480f1
# ╠═642b4cd9-b297-4cc6-8e5b-84addad4937b
# ╟─908f9615-5c0b-4370-ba2f-6c6eec20b7d3
# ╟─c77864b5-934b-471e-b7ee-585d561a49be
# ╟─d8bd77c4-d3e3-4b37-98bd-1f6d478a940d
# ╟─039bbc45-5d1f-4ed2-8689-3b6d3a4bb7fc
# ╟─209cd772-cbca-4e99-8e09-efbd8628860b
# ╟─91672cee-48cc-4378-a21d-9138cf360b6f
# ╟─b3b5c934-9e16-4d97-ae54-b2fe95bce7f1
# ╟─afc2569f-8cd2-4daf-9303-2ac5ee407325
# ╟─d4a13434-7b11-4440-8738-30c072c3ea16
# ╟─7733f7fb-4bec-4645-9b78-e5748a4db74a
# ╟─f32e07f2-8b8c-4554-a541-b750550317d6
# ╟─424f0f04-144a-4a80-a7b5-2cbf4de1f792
# ╟─c12db014-eb77-4411-adbc-3515a90995fc
# ╟─56aa3ef4-a178-4f02-8f0b-7bfc39cd4124
# ╟─af4ec210-5aab-4a2f-9202-5466fd08d9f5
# ╟─888fc6f9-cb7b-43e3-a8ee-174d424577ed
# ╟─b8aa4ed9-3228-4451-8615-d829c771ec06
# ╟─68951335-3c31-42af-bbab-edfa5f4e8d41
# ╟─accd044d-4cca-44e1-879b-9707ac0505fb
# ╟─a302cbae-0c28-4ac9-bb44-0edf44ed7942
# ╟─9928a2c7-e2d1-44c5-8ecc-f07cf508fc94
# ╟─e3de90ed-9b83-4d0b-89cd-ee162fc1a6b5
# ╟─6f8e11b8-ea1f-4bb3-a259-ae2847afa4d9
# ╟─739a5500-030d-4337-87ba-a11fe64a3472
# ╟─0c086519-a135-41ec-b9d2-f1c9878e79cb
# ╟─b877fb2b-a1be-4671-bb20-f4311ff98c4a
# ╟─17f1553f-e488-4d9a-a213-a81e5c8bb420
# ╟─bd654ca0-7fe7-4cda-9c3f-ac9c5cbbde74
# ╟─b70a2ae9-f16a-45bd-bbd8-61c1fce3d6a2
# ╟─7c7a9fd0-d8ff-4aab-9160-5d11b345fc2e
# ╟─df7c8857-3535-4074-b5b8-64500ec002a0
# ╠═da6fd446-233b-482c-98aa-12b7366d332c
# ╟─1a359987-3d20-4a3a-919d-ae2bfd59f910
# ╟─2b1c1420-0819-4cde-9496-6d1665ae9c15
# ╟─1f76b216-b997-42ee-86de-2998e44cc460
# ╟─2b4f4a46-8aee-4a15-9051-7d7bdee7824f
# ╟─55502b23-40a7-481c-8a96-82b5d20818aa
# ╟─e73ffdf3-34f4-4056-bbc3-1b44943ae224
# ╟─cbf60fab-b8eb-4bc1-89d9-8ece73804842
# ╟─ff92eeae-a456-4b44-87cc-a532602e75c8
# ╟─11717f36-6d98-4212-b978-21f89db4a42e
# ╟─36138bc1-8278-4955-a796-e8cb49d59250
# ╟─315c17c6-2234-42c8-9f30-a873c782da3b
# ╠═666436c0-377c-4175-b95d-dd3e09481364
# ╟─bc81f0bd-3d26-43c1-a8a8-3cb20552f75a
# ╟─d5313e2d-35bc-40fd-95cd-261d07ff850f
# ╟─fb30a480-b151-4ecc-96c6-541b2fb9507f
# ╠═a2ca75c4-c3f8-420c-a57d-5d7bf37590dd
# ╟─307e8dc1-32a9-4ce0-80b8-f20faa08f848
# ╟─229ea4e5-ae30-4f4d-aeb7-257e2fb2b6c6
# ╟─fcc3aeb7-101e-473d-9eeb-fafdbcc0a900
# ╟─0b35f76a-d4ce-4ba2-b2da-d2e71aa11b67
# ╟─4ea1b82a-b067-46e2-8e5d-8265f6fb2742
# ╟─6633b847-fd7b-4e30-9b46-8228cc76e1c8
# ╟─2e4952e1-8c0e-47b1-b079-76dd72ff1caf
# ╟─b49e19fe-9637-4227-8b5d-c4c7d2dcf5a9
# ╟─7931309c-e718-497c-adbe-3fe61e76814c
# ╟─2ce7c115-331f-48a4-bee0-a6bd0b6bf7ae
# ╟─d4cc7271-d36a-4e7a-a2ae-4ce9d6260265
# ╟─b1d724fe-5750-442b-b380-5eb2469f681a
# ╟─d0e0399a-79ec-40a2-8ed3-d8ccfd93811a
# ╟─bcb21393-d1ac-4895-9776-618f90eb6d29
# ╟─bfec8740-1725-4807-8e9a-f02bd3f3181b
# ╟─9d531f2d-b802-4977-b436-046f3f0fe48c
# ╟─3e937224-0b97-4fb1-9a3d-9a3cd203148e
# ╟─96917f4f-873c-4bf4-9f26-854477ade542
# ╟─1b155514-8304-4625-907f-8637b0d4b962
# ╠═678c47eb-5334-45fa-a83e-33091611e721
# ╟─96662f08-0bda-400d-9d77-0426a761156a
# ╟─78b6c4ad-7a99-42e1-8e8a-9ecdeebbadee
# ╟─e4c9bab6-3727-4bd0-8d62-9563d0df954a
# ╟─5a766350-3ab3-4dc9-a875-cc64a5ace530
# ╟─8e4e6c4e-3108-4979-a634-923cf81df0f5
# ╟─7e36d866-5f72-45ce-9aa1-b89206ac1f3e
# ╟─96853ee8-053b-470b-a84f-8613b6b0b2b3
# ╠═f9ed49dc-7f58-4f8a-9a9d-143db3d5c043
# ╟─9f3ab1c1-f711-4c87-bca1-5608c608d203
# ╟─2d9ab4d6-6cdb-4b0a-be70-3dcf318d0b2e
# ╟─37c5345e-de2d-4e67-8e96-bdb93dd2a65f
# ╟─42499e67-7844-4e15-ac1c-65aa69a0356f
# ╟─f13cc879-42f4-4bba-844e-4f95b236b336
# ╟─312da3e0-4d10-4831-bf83-e6bcb7007ec7
# ╟─54d39189-d5ba-410b-a713-b3ca66491e66
# ╟─f4b417db-1066-47cc-8055-be70b1a53c67
# ╟─bfa7d58d-1aa0-4b38-9686-3e5d836b2a68
# ╟─b64bc307-1d06-4772-ade3-c4364483a0a9
# ╟─57ea7045-6411-493f-93cf-810b277bb1fd
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
