### A Pluto.jl notebook ###
# v0.19.39

using Markdown
using InteractiveUtils

# ╔═╡ b763cd10-d1e7-4613-b738-9fb1c1cfa1e5
using PlutoUI

# ╔═╡ e2feba71-69cb-4f39-92d1-d1f4daefb4ec
begin
	using LinearAlgebra, SpecialMatrices
	using MAT, HTTP, SparseArrays
end

# ╔═╡ a7d3298e-0138-4149-a189-0b5a92cfa0e7
PlutoUI.TableOfContents(title="Ecuaciones Lineales", aside=true)

# ╔═╡ 5d0d4c4e-b432-437e-9b8e-2f81c79f907e
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a **labmatecc_bog@unal.edu.co**

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ c08f6550-5278-436d-96ec-408570476631
md"""**Este cuaderno está basado en actividades del curso Análisis numérico I de la Universidad Nacional de Colombia, sede Bogotá, dictado por el profesor Juan Galvis en 2022-2.**

Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo. 
"""

# ╔═╡ 7b84db99-9375-4dc5-8a3e-414bc176648a
md"""Usaremos las siguientes librerías:"""

# ╔═╡ b7655028-28be-49bb-87b2-ee35adeeb9a4
md"""# Introducción"""

# ╔═╡ 39622889-6658-4938-8127-f16105b331e2
md"""xd"""

# ╔═╡ 35ffa09a-14a7-47fb-85b1-fe977607f406


# ╔═╡ 4c98459c-1bd6-423c-8539-a85b104b6221
md"""
Los comandos para calcular normas de vectores y de matrices son presentados a continuación. 
En Julia se distingen las normas subordinadas como normas de operadores. """

# ╔═╡ d3a307af-ee47-42cd-a6e5-49105c9bed09
begin
	x=[1,2,3,-4]
println(x)
nx=norm(x,1)
for i=1:5:15
    nx=norm(x,i)
    println("La norma ",i," de x es ",nx)
end
nx=norm(x,Inf)
println("\nLa norma ",Inf," de x es ",nx)
end

# ╔═╡ 0e8ae2e3-933b-4cb9-87d2-49de76407e29
md""" # Factorización $A=PLU$
Presentamos algunos comandos relacionados con la solución de sistemas lineales por métodos directos. 
Calculemos la factorización $A=PLU$ de una matriz $4\times 4$."""

# ╔═╡ 7123f4ea-87d7-4549-9b4f-56547eb38bc5
A =[2  5  8  7 ; 5  2  2  8 ; 7  5  6  6; 5 4 4 8]

# ╔═╡ 69daeb44-c973-4b48-a646-d83fd7faf00d
begin
	A1=[0 0 1; -1  2  0; 1 2  1]
println(A)
println("La norma  2 de la matrix extendida a vector  es = ", norm(A)) #máximo valor singular
println("La norma de Frobenious es = ",norm(A,2)) # Frobeniusln
println("La norma subordinada 1 es = ",opnorm(A,1))
println("La norma subordinada Inf es = ", opnorm(A,Inf))
end

# ╔═╡ 6aef40cd-26e2-47f6-94c8-c6702709056f
luA= lu(A);

# ╔═╡ e2373181-d738-4b5c-9974-d85849e44a77
md"""Las matrices $L$, $U$ y $P$ pueden ser desplegadas como sigue,  """

# ╔═╡ b9a2366f-afb1-40ab-a9d0-96886782c43f
begin
	display(luA.U)
display(luA.L)
display(luA.P)
end

# ╔═╡ e837f218-1099-4bc4-b8a9-cd9a2ef3d014
md""" Podemos calcular la norma del residuo de la factorización: $ ||| PA-LU|||$,"""

# ╔═╡ f4d510f5-0995-48c9-8940-1ab8e1eca805
opnorm(luA.P*A-luA.L*luA.U)

# ╔═╡ 74b36cc9-c28e-420c-bfe2-9e2b353d3cd5
md"""Con el paquete SpecialMatrices podemos generar la matriz de Hilbert. """

# ╔═╡ 4af21bbb-87a7-4b7d-b21d-e26782fc04fe
md"""Ahora calculemos la factorización para la matriz de Hilbert y el respectivo residuo. """

# ╔═╡ f5cb28ec-1504-46fe-977a-5b11bd3ac0ea
H₁=Hilbert{Rational{Int64}}(5,5)

# ╔═╡ da020f53-0110-43b8-8ecc-1413a9de776b
H₂=Hilbert{Float64}(5,5)

# ╔═╡ ecd9abc9-f2da-4655-80e4-3bca05424f6f
begin
	H₃=Hilbert{Float64}(50,50)
luH= lu(H₃)
res=luH.P*H₃-luH.L*luH.U
#println("pA-LU=",res)
println("La norma Inf del residuo es ",opnorm(res,Inf))
println("La norma 2 del residuo es ", opnorm(res,2))
end

# ╔═╡ 50fdd35a-de2a-4a75-acbc-5c337626d772
md"""Calculemos la permutación de la factorización $A=PLU$ para una matriz diagonal dominante. """

# ╔═╡ abd66ffe-97bf-44b9-8713-16a4041463b4
A₂ =[5 -1 2 -1; -1 5 0 1; 0 -1 4 2; 1 1 1 5]

# ╔═╡ 38605809-7063-48fe-9749-f70dbb141d2e
luA₂=lu(A₂)

# ╔═╡ 6264dbf0-0450-426b-9c99-2a9f5349eba9
luA₂.P

# ╔═╡ 8e0575a3-966b-4de5-b83e-bea79430cbfa
md"""Observe que eneste caso la matriz de permutación es la matriz identidad.  """

# ╔═╡ 36dc58de-640a-4328-8ed8-08c5485ea749
md"""# Cholesky"""

# ╔═╡ d1107046-daa6-4b03-8020-670ac69d0194
md"""Calculemos ahora la factorización de Cholesky de una matri de la forma $A^TA$ con $A$ aleatoria. """

# ╔═╡ b89e46e6-63f7-4f84-b7b9-958c3781a3e3
begin
	B=1.0.+randn(4,4)
	A₃=B'B
end

# ╔═╡ 6ac7297a-28bf-47d4-92bd-39085471ab8d
begin
	cholA=cholesky(A₃)
	display(cholA.L)
	display(cholA.U)
end

# ╔═╡ 64237d6d-ffff-454d-876c-5363c4a165e0
typeof(cholA)

# ╔═╡ 340d2511-6df3-4ef7-a3d0-6d98d675dc92
typeof(cholA.L)

# ╔═╡ da1ccf05-3e51-4750-8adf-2ca2be616115
md""" # Sistemas lineales"""

# ╔═╡ 0f0c2889-6e79-4496-aceb-d1f0b156f9a1
md""" Resolver un sistema lineal general usando "backslash" (notación de MatLab), """

# ╔═╡ dcb2dc6e-9e4e-4493-945a-b797a0e346b8
begin
	A₄ =[3  2  0 ; 1 -1 0; 0 5 1]
	b₄ = [2; 4; -1]
	x₄=A₄\b₄
end

# ╔═╡ 27021196-5b97-41b6-b215-27889073aa23
md""" Podemos calcular el vector residuo y su norma, """

# ╔═╡ 0a81b3ea-8457-4d4e-809e-6c182557abef
begin
	res₄=b₄-A₄*x₄
println("res=",norm(res₄))
end

# ╔═╡ 19745c50-19c5-4af9-b70c-7f4c72b92148
md""" Intentemos ahora con la matriz de Hilbert."""

# ╔═╡ 79edfba2-fc76-40b0-8e6c-537a1951a9ec
begin
n=25
H₅=Hilbert{Float64}(n,n)
b₅=fill(1,n,1)
x₅=H₅\b₅
res₅=b₅-H₅*x₅
println("La norma del residuo es ",norm(res₅))
end

# ╔═╡ babd81de-8495-4bcf-9d14-a875ad2fdaf6
md"""Recuerden que debemos mirar el número de de cóndición de la matriz, el comando *cond(H,p)* aproxima la condición de la matriz con $p=1,2,\infty$ """

# ╔═╡ 9043e1a4-3833-4244-a282-77ac7cdb5e1c
cond(H₅,Inf)

# ╔═╡ 0ef517b6-c948-4d6e-a5cd-afcbba786d33
md""" ## Iteraciones"""

# ╔═╡ 1dba2908-0fbc-4e2e-9dcc-a91956f03178
A₆=rand(2,2)

# ╔═╡ 5dec7367-8bd9-4831-b455-c3d077786504
Diagonal(diag(A₆))

# ╔═╡ 3ffad7cd-0663-4c5c-96cf-efc18ea4908f
begin
function jacobisolver(A,b,tol,Maxiter,x)
    D=Diagonal(diag(A))
    for i=1:Maxiter
        r=b-A*x
        nr=norm(r)
        println("norm(r(",i,"))=",nr)
        if nr<tol
            break
        end
        delta=D\r
        x = x+delta

    end
    return x
end
end

# ╔═╡ c9bc8f0a-b9f0-40f7-8e26-58a0478503d6
begin
A₇ =[2.0 1.0; 5.0 7.0]
b₇ = [11.0;13.0]
x0₇ =[1.0 ; 1.0]

x₇ = jacobisolver(A₇,b₇,1e-10,100,x0₇)
end

# ╔═╡ 926c3986-6991-4c15-aaaf-b5230d922ab5
res₇=b₇-A₇*x₇

# ╔═╡ 8294b725-58cc-447e-8496-a41f48462cba
md""" ## Sparse"""

# ╔═╡ 12a543ce-27ce-45de-804d-010f0e501a94
md""" Consideremos un ejemplo de una matriz dispersa en https://suitesparse-collection-website.herokuapp.com/. En particular la matriz correspondiente a: *HB/1138_bus
S ADMITTANCE MATRIX 1138 BUS POWER SYSTEM, D.J.TYLAVSKY, JULY 1985.*
"""

# ╔═╡ ceab82c1-1adc-4be5-a4c7-52d0587c5515
url = "https://suitesparse-collection-website.herokuapp.com/mat/HB/494_bus.mat"

# ╔═╡ 9a105022-3995-42ca-abee-e05665eff936
r = HTTP.request("GET", url)

# ╔═╡ 0c1e6291-aa8a-401b-a92f-44019a22ba32
Body=String(r.body)

# ╔═╡ f52ccc9e-7ba6-4bf5-90da-786cb761f9da
md""" Ahora escribimos en un archivo, """

# ╔═╡ 0fc5eafe-e674-463b-851d-32204d79319c
begin
	io = open("out.mat", "w")
write(io,Body)
close(io);
end

# ╔═╡ ea549e65-148e-4ee9-aa7d-089269e6040f
md""" Y usamos el paquete MAT para leer el archivo .mat"""

# ╔═╡ 74f6b1ba-bb93-4bbb-997a-4dbd50b7f302
vars = matread("out.mat")

# ╔═╡ 33670717-ea48-44e5-bc58-5e27106b97bd
md"""Note que la variable del archivo .mat es un dicctionary. Para recuperar la matriz usamos las claves apropiadas del diccionario vars """

# ╔═╡ d29f63bf-6733-40d0-89c4-3d00b0320b3a
sparsA=vars["Problem"]["A"]

# ╔═╡ 4ad284bd-5544-4e76-b3e3-425dab6aea7a
md""" Observamos que es un SparseArray con 166 entradas y nos muestra el patron de dispersion de la matriz. """

# ╔═╡ b702876a-59e5-4b39-b39e-407230d008f2
md"""Notamos que las matrices dispersas (o ralas) necesitan tratamiento especial. Por ejemplo si calculamos la factorización LU de una matriz rala como si fuera una matriz densa, entonces se produce el fenomeno de fill-in, es decir, los factores L y U son densos.  """

# ╔═╡ 0b40430f-3239-4d4f-ad06-a7d7f8e90348
begin
luA1=lu(Array{Float64}(sparsA))
sparse(luA1.L)
end

# ╔═╡ 84658bb2-be90-417f-b1d3-581f05181f1e
md"""# Referencias """

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
MAT = "23992714-dd62-5051-b70f-ba57cb901cac"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
SpecialMatrices = "928aab9d-ef52-54ac-8ca1-acd7ca42c160"

[compat]
HTTP = "~1.10.8"
MAT = "~0.10.7"
PlutoUI = "~0.7.58"
SpecialMatrices = "~3.0.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "00a79e91d9d2ced06c751612c3c2b33762707e3f"

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

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.BufferedStreams]]
git-tree-sha1 = "4ae47f9a4b1dc19897d3743ff13685925c5202ec"
uuid = "e1450e63-4bb3-523b-b2a4-4ffa8c0fd77d"
version = "1.2.1"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "59939d8a997469ee05c4b4944560a820f9ba0d73"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.4"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "b1c55339b7c6c350ee89f2c1604299660525b248"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.15.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "6cbbd4d241d7e6579ab354737f4dd95ca43946e1"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.HDF5]]
deps = ["Compat", "HDF5_jll", "Libdl", "MPIPreferences", "Mmap", "Preferences", "Printf", "Random", "Requires", "UUIDs"]
git-tree-sha1 = "e856eef26cf5bf2b0f95f8f4fc37553c72c8641c"
uuid = "f67ccb44-e63f-5c2f-98bd-6dc0ccc4ba2f"
version = "0.17.2"

    [deps.HDF5.extensions]
    MPIExt = "MPI"

    [deps.HDF5.weakdeps]
    MPI = "da04e1cc-30fd-572f-bb4f-1f8673147195"

[[deps.HDF5_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LazyArtifacts", "LibCURL_jll", "Libdl", "MPICH_jll", "MPIPreferences", "MPItrampoline_jll", "MicrosoftMPI_jll", "OpenMPI_jll", "OpenSSL_jll", "TOML", "Zlib_jll", "libaec_jll"]
git-tree-sha1 = "82a471768b513dc39e471540fdadc84ff80ff997"
uuid = "0234f1f7-429e-5d53-9886-15a909be8d59"
version = "1.14.3+3"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "d1d712be3164d61d1fb98e7ce9bcbc6cc06b45ed"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.8"

[[deps.Hwloc_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1d334207121865ac8c1c97eb7f42d0339e4635bf"
uuid = "e33a78d0-f292-5ffc-b300-72abe9b543c8"
version = "2.11.0+0"

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

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

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

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

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

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

[[deps.MAT]]
deps = ["BufferedStreams", "CodecZlib", "HDF5", "SparseArrays"]
git-tree-sha1 = "1d2dd9b186742b0f317f2530ddcbf00eebb18e96"
uuid = "23992714-dd62-5051-b70f-ba57cb901cac"
version = "0.10.7"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MPICH_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Hwloc_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "MPIPreferences", "TOML"]
git-tree-sha1 = "4099bb6809ac109bfc17d521dad33763bcf026b7"
uuid = "7cb0a576-ebde-5e09-9194-50597f1243b4"
version = "4.2.1+1"

[[deps.MPIPreferences]]
deps = ["Libdl", "Preferences"]
git-tree-sha1 = "c105fe467859e7f6e9a852cb15cb4301126fac07"
uuid = "3da0fdf6-3ccc-4f1b-acd9-58baa6c99267"
version = "0.1.11"

[[deps.MPItrampoline_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "MPIPreferences", "TOML"]
git-tree-sha1 = "8c35d5420193841b2f367e658540e8d9e0601ed0"
uuid = "f1f71cc9-e9ae-5b93-9b94-4fe0e1ad3748"
version = "5.4.0+0"

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

[[deps.MicrosoftMPI_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f12a29c4400ba812841c6ace3f4efbb6dbb3ba01"
uuid = "9237b28f-5490-5468-be7b-bb81f5f5e6cf"
version = "10.1.4+2"

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

[[deps.OpenMPI_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "MPIPreferences", "TOML"]
git-tree-sha1 = "e25c1778a98e34219a00455d6e4384e017ea9762"
uuid = "fe0851c0-eecd-5654-98d4-656369965a5c"
version = "4.1.6+0"

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

[[deps.Polynomials]]
deps = ["LinearAlgebra", "RecipesBase"]
git-tree-sha1 = "3aa2bb4982e575acd7583f01531f241af077b163"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "3.2.13"

    [deps.Polynomials.extensions]
    PolynomialsChainRulesCoreExt = "ChainRulesCore"
    PolynomialsMakieCoreExt = "MakieCore"
    PolynomialsMutableArithmeticsExt = "MutableArithmetics"

    [deps.Polynomials.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
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

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.SpecialMatrices]]
deps = ["LinearAlgebra", "Polynomials"]
git-tree-sha1 = "8fd75ee3d16a83468a96fd29a1913fb170d2d2fd"
uuid = "928aab9d-ef52-54ac-8ca1-acd7ca42c160"
version = "3.0.0"

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

[[deps.TranscodingStreams]]
git-tree-sha1 = "d73336d81cafdc277ff45558bb7eaa2b04a8e472"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.10"
weakdeps = ["Random", "Test"]

    [deps.TranscodingStreams.extensions]
    TestExt = ["Test", "Random"]

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

[[deps.libaec_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "46bf7be2917b59b761247be3f317ddf75e50e997"
uuid = "477f73a3-ac25-53e9-8cc3-50b2fa2566f0"
version = "1.1.2+0"

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
# ╟─b763cd10-d1e7-4613-b738-9fb1c1cfa1e5
# ╟─a7d3298e-0138-4149-a189-0b5a92cfa0e7
# ╟─5d0d4c4e-b432-437e-9b8e-2f81c79f907e
# ╟─c08f6550-5278-436d-96ec-408570476631
# ╟─7b84db99-9375-4dc5-8a3e-414bc176648a
# ╠═e2feba71-69cb-4f39-92d1-d1f4daefb4ec
# ╟─b7655028-28be-49bb-87b2-ee35adeeb9a4
# ╠═39622889-6658-4938-8127-f16105b331e2
# ╠═35ffa09a-14a7-47fb-85b1-fe977607f406
# ╟─4c98459c-1bd6-423c-8539-a85b104b6221
# ╠═d3a307af-ee47-42cd-a6e5-49105c9bed09
# ╠═69daeb44-c973-4b48-a646-d83fd7faf00d
# ╟─0e8ae2e3-933b-4cb9-87d2-49de76407e29
# ╠═7123f4ea-87d7-4549-9b4f-56547eb38bc5
# ╠═6aef40cd-26e2-47f6-94c8-c6702709056f
# ╟─e2373181-d738-4b5c-9974-d85849e44a77
# ╠═b9a2366f-afb1-40ab-a9d0-96886782c43f
# ╟─e837f218-1099-4bc4-b8a9-cd9a2ef3d014
# ╠═f4d510f5-0995-48c9-8940-1ab8e1eca805
# ╟─74b36cc9-c28e-420c-bfe2-9e2b353d3cd5
# ╟─4af21bbb-87a7-4b7d-b21d-e26782fc04fe
# ╠═f5cb28ec-1504-46fe-977a-5b11bd3ac0ea
# ╠═da020f53-0110-43b8-8ecc-1413a9de776b
# ╠═ecd9abc9-f2da-4655-80e4-3bca05424f6f
# ╟─50fdd35a-de2a-4a75-acbc-5c337626d772
# ╠═abd66ffe-97bf-44b9-8713-16a4041463b4
# ╠═38605809-7063-48fe-9749-f70dbb141d2e
# ╠═6264dbf0-0450-426b-9c99-2a9f5349eba9
# ╟─8e0575a3-966b-4de5-b83e-bea79430cbfa
# ╟─36dc58de-640a-4328-8ed8-08c5485ea749
# ╟─d1107046-daa6-4b03-8020-670ac69d0194
# ╠═b89e46e6-63f7-4f84-b7b9-958c3781a3e3
# ╠═6ac7297a-28bf-47d4-92bd-39085471ab8d
# ╠═64237d6d-ffff-454d-876c-5363c4a165e0
# ╠═340d2511-6df3-4ef7-a3d0-6d98d675dc92
# ╟─da1ccf05-3e51-4750-8adf-2ca2be616115
# ╟─0f0c2889-6e79-4496-aceb-d1f0b156f9a1
# ╠═dcb2dc6e-9e4e-4493-945a-b797a0e346b8
# ╟─27021196-5b97-41b6-b215-27889073aa23
# ╠═0a81b3ea-8457-4d4e-809e-6c182557abef
# ╟─19745c50-19c5-4af9-b70c-7f4c72b92148
# ╠═79edfba2-fc76-40b0-8e6c-537a1951a9ec
# ╟─babd81de-8495-4bcf-9d14-a875ad2fdaf6
# ╠═9043e1a4-3833-4244-a282-77ac7cdb5e1c
# ╟─0ef517b6-c948-4d6e-a5cd-afcbba786d33
# ╠═1dba2908-0fbc-4e2e-9dcc-a91956f03178
# ╠═5dec7367-8bd9-4831-b455-c3d077786504
# ╠═3ffad7cd-0663-4c5c-96cf-efc18ea4908f
# ╠═c9bc8f0a-b9f0-40f7-8e26-58a0478503d6
# ╠═926c3986-6991-4c15-aaaf-b5230d922ab5
# ╟─8294b725-58cc-447e-8496-a41f48462cba
# ╟─12a543ce-27ce-45de-804d-010f0e501a94
# ╠═ceab82c1-1adc-4be5-a4c7-52d0587c5515
# ╠═9a105022-3995-42ca-abee-e05665eff936
# ╠═0c1e6291-aa8a-401b-a92f-44019a22ba32
# ╟─f52ccc9e-7ba6-4bf5-90da-786cb761f9da
# ╠═0fc5eafe-e674-463b-851d-32204d79319c
# ╟─ea549e65-148e-4ee9-aa7d-089269e6040f
# ╠═74f6b1ba-bb93-4bbb-997a-4dbd50b7f302
# ╟─33670717-ea48-44e5-bc58-5e27106b97bd
# ╠═d29f63bf-6733-40d0-89c4-3d00b0320b3a
# ╟─4ad284bd-5544-4e76-b3e3-425dab6aea7a
# ╟─b702876a-59e5-4b39-b39e-407230d008f2
# ╠═0b40430f-3239-4d4f-ad06-a7d7f8e90348
# ╟─84658bb2-be90-417f-b1d3-581f05181f1e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
