### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ bb7794fa-89c8-4e26-887f-cff9d9b64aee
using PlutoUI

# ╔═╡ 7377bab8-6639-47e2-b9fa-5d7a69dec920
PlutoUI.TableOfContents(title="Listas, Arreglos y Secuencias", aside=true)

# ╔═╡ 76e62111-2a7e-4634-ab44-9014c009988c
md"""
# ¡Bienvenido a la Introducción a la introducción de Listas, Arreglos y Secuencias!
En Julia, las estructuras de datos como listas, arreglos y secuencias permiten almacenar y manipular conjuntos de valores. En este conjunto de ejercicios, exploraremos cómo crear, manipular y aplicar operaciones sobre estas estructuras, así como conceptos intermedios y avanzados relacionados con ellas.

### Listas
Una lista en Julia se refiere típicamente a un vector o arreglo unidimensional que almacena una colección de elementos. Estos elementos pueden ser de diferentes tipos, y las listas permiten añadir, eliminar y modificar elementos de manera dinámica.

- **Creación de Listas**: Se pueden crear listas con corchetes `[]` y los elementos se separan por comas.
  ```julia
  lista = [1, 2, 3, 4, 5]
  ```

- **Acceso a Elementos**: Los elementos se acceden usando índices que comienzan desde 1.
  ```julia
  primer_elemento = lista[1]  # Devuelve el valor 1
  ```

- **Modificar Elementos**: Podemos asignar un valor a un índice específico para modificar la lista.
  ```julia
  lista[2] = 10  # Cambia el segundo elemento a 10
  ```

- **Agregar y Eliminar Elementos**:
  - `push!(lista, valor)`: Agrega un elemento al final de la lista.
  - `pop!(lista)`: Elimina y devuelve el último elemento.
# Ejercicios básicos e intermedios para aprender sobre listas, arreglos y secuencias en Julia


- **Operaciones Comunes**:
  - `length(lista)`: Devuelve la longitud de la lista (cantidad de elementos).
  - `sort(lista)`: Ordena los elementos de la lista.
  - `reverse(lista)`: Invierte el orden de los elementos en la lista.

### Arreglos Multidimensionales
Los arreglos multidimensionales en Julia se utilizan para almacenar datos en más de una dimensión. Los arreglos pueden tener dos dimensiones (matrices) o más.

- **Creación de Arreglos**:
  - Un arreglo multidimensional puede ser creado usando `reshape()` o directamente especificando los elementos y dimensiones.
  ```julia
  matriz = [1 2 3; 4 5 6]  # Crea una matriz de 2x3
  ```

- **Acceso a Elementos**: Los elementos se acceden con índices para cada dimensión.
  ```julia
  valor = matriz[1, 2]  # Accede al valor en la fila 1, columna 2
  ```
- **Operaciones Comunes**:
  - `size(matriz)`: Devuelve las dimensiones del arreglo.
  - `sum(matriz)`: Calcula la suma de todos los elementos.
  - `transpose(matriz)`: Calcula la transposición de la matriz.

### Secuencias
Las secuencias en Julia son una manera conveniente de representar un rango de números. Utilizan el operador `:` y permiten especificar rangos con incrementos específicos.

- **Creación de Secuencias**:
  ```julia
  secuencia = 1:5  # Crea una secuencia que va del 1 al 5
  secuencia_pares = 2:2:10  # Crea una secuencia de números pares del 2 al 10
  ```

- **Operaciones con Secuencias**:
  - `collect(secuencia)`: Convierte la secuencia en un arreglo para poder manipular sus elementos.
  - `map(funcion, secuencia)`: Aplica una función a cada elemento de la secuencia.
  - `filter(condicion, secuencia)`: Filtra los elementos que cumplen la condición.

### Comandos Esenciales y Avanzados
- `push!()`: Agrega un elemento al final de un arreglo.
- `pop!()`: Elimina y devuelve el último elemento de un arreglo.
- `append!()`: Añade los elementos de una colección al final de un arreglo.
- `length()`: Devuelve la cantidad de elementos de una lista o arreglo.
- `sort()`: Ordena los elementos de una lista o arreglo.
- `unique()`: Devuelve una lista con los elementos únicos de la colección.
- `reverse()`: Invierte el orden de los elementos en una lista.
- `filter()`: Filtra elementos de una colección según una condición.
- `map()`: Aplica una función a cada elemento de una colección.
- `reduce()`: Aplica una función de reducción a los elementos de una colección, útil para operaciones acumulativas.
- `reshape()`: Cambia la forma de un arreglo sin modificar sus datos.
- `collect()`: Convierte un rango o secuencia en un arreglo.
- `pushfirst!()`, `popfirst!()`: Agrega o elimina un elemento al inicio de un arreglo.
- `hcat()`, `vcat()`: Concatenan arreglos horizontal o verticalmente.
```julia
# Ejercicio 1: Creación y manipulación de listas
println("Ejercicio 1: Creación y manipulación de listas")
lista = [3, 1, 4, 1, 5, 9]
println("Lista original: \$lista")

# Agregar elementos
push!(lista, 2)
println("Lista después de agregar 2: \$lista")

# Eliminar el último elemento
pop!(lista)
println("Lista después de eliminar el último elemento: \$lista")

# Ordenar la lista
lista_ordenada = sort(lista)
println("Lista ordenada: \$lista_ordenada")
println("---------------------------")
```
"""

# ╔═╡ 5483fe9c-be9a-4cda-95c0-8a413b2f3d99
md"""
# Teoría General: Arreglos Multidimensionales
Los arreglos multidimensionales permiten representar datos en más de una dimensión, como una matriz. Podemos acceder a sus elementos usando índices y manipularlos de diversas formas.

### Comandos Esenciales
- `reshape()`: Reorganiza un arreglo unidimensional en una forma multidimensional.
- `size()`: Devuelve el tamaño de cada dimensión de un arreglo.
- `sum()`: Calcula la suma de los elementos de un arreglo.
- `transpose()`: Transpone la matriz (intercambia filas por columnas).
- `diag()`: Devuelve la diagonal de una matriz.

```julia
# Ejercicio 2: Manipulación de arreglos multidimensionales
println("Ejercicio 2: Manipulación de arreglos multidimensionales")
arreglo = [1, 2, 3, 4, 5, 6]
matriz = reshape(arreglo, 2, 3)
println("Matriz 2x3:")
println(matriz)

# Acceder a un elemento específico
println("Elemento en la fila 1, columna 2: \$(matriz[1, 2])")

# Sumar todos los elementos de la matriz
suma_total = sum(matriz)
println("Suma de todos los elementos: \$suma_total")
println("---------------------------")
```
"""

# ╔═╡ dfbe6be1-d8c3-4710-a1b0-332f6c743e34
md"""
# Teoría Intermedia: Operaciones con Secuencias
Las secuencias en Julia permiten representar conjuntos ordenados de elementos. Podemos aplicar diferentes funciones sobre estas secuencias para realizar operaciones comunes como filtrar, mapear, y reducir.

### Comandos Intermedios
- `map()`: Aplica una función a cada elemento de una secuencia.
- `filter()`: Filtra los elementos de una secuencia según una condición.
- `collect()`: Convierte un iterador o una secuencia en un arreglo.
- `cumsum()`: Calcula la suma acumulativa de una secuencia.
- `maximum()`, `minimum()`: Encuentra el valor máximo o mínimo de la secuencia.

```julia
# Ejercicio 3: Uso de map y filter
println("Ejercicio 3: Uso de map y filter")
secuencia = 1:10
println("Secuencia original: \$(collect(secuencia))")

# Elevar al cuadrado cada elemento de la secuencia
cuadrados = map(x -> x^2, secuencia)
println("Cuadrados de la secuencia: \$(collect(cuadrados))")

# Filtrar los elementos pares
pares = filter(x -> x % 2 == 0, secuencia)
println("Elementos pares de la secuencia: \$(collect(pares))")
println("---------------------------")
```
"""

# ╔═╡ 4310ba2d-6d6a-4907-8033-557e758a36cd
md"""
# Teoría Avanzada: Reducción y Operaciones Agregadas
Las operaciones de reducción permiten combinar todos los elementos de una colección en un solo valor. Esto es útil para calcular sumas, productos, y otras funciones acumulativas.

### Comandos Avanzados
- `reduce()`: Aplica una función de reducción a los elementos de una colección.
- `maximum()`, `minimum()`: Devuelven el valor máximo o mínimo de una colección.
- `cumsum()`: Calcula la suma acumulativa de los elementos de una secuencia.
- `prod()`: Calcula el producto de todos los elementos en una colección.

```julia
# Ejercicio 4: Reducción y operaciones agregadas
println("Ejercicio 4: Reducción y operaciones agregadas")
arreglo = [3, 5, 7, 2, 8, 6]

# Sumar todos los elementos usando reduce
suma = reduce(+, arreglo)
println("Suma de todos los elementos: \$suma")

# Encontrar el valor máximo
maximo = maximum(arreglo)
println("Valor máximo del arreglo: \$maximo")

# Encontrar el valor mínimo
minimo = minimum(arreglo)
println("Valor mínimo del arreglo: \$minimo")
println("---------------------------")
```
"""

# ╔═╡ b97fdd0f-09ad-482d-9716-570b721d70e2
md"""
# Ejercicios Clásicos de Uso de Listas, Arreglos y Secuencias
Estos ejercicios permiten practicar el uso de listas, arreglos y secuencias aplicando lo aprendido para manipular datos de manera efectiva.

### Ejercicio Clásico 1: Invertir una Lista
Este ejercicio consiste en invertir los elementos de una lista dada.

```julia
# Ejercicio Clásico 1: Invertir una Lista
println("Ejercicio Clásico 1: Invertir una Lista")
lista = [10, 20, 30, 40, 50]
lista_invertida = reverse(lista)
println("Lista original: \$lista")
println("Lista invertida: \$lista_invertida")
println("---------------------------")
```

### Ejercicio Clásico 2: Eliminar Elementos Duplicados
Este ejercicio consiste en eliminar los elementos duplicados de una lista para dejar solo los elementos únicos.

```julia
# Ejercicio Clásico 2: Eliminar Elementos Duplicados
println("Ejercicio Clásico 2: Eliminar Elementos Duplicados")
lista_con_duplicados = [1, 2, 2, 3, 4, 4, 5]
lista_unica = unique(lista_con_duplicados)
println("Lista original: \$lista_con_duplicados")
println("Lista sin duplicados: \$lista_unica")
println("---------------------------")
```

### Ejercicio Avanzado: Rotar una Lista
Este ejercicio consiste en rotar los elementos de una lista hacia la derecha un número específico de veces.

```julia
# Ejercicio Avanzado: Rotar una Lista
println("Ejercicio Avanzado: Rotar una Lista")
lista = [1, 2, 3, 4, 5]
n = 2  # Número de posiciones a rotar
println("Lista original: \$lista")

for _ in 1:n
    elemento = pop!(lista)
    insert!(lista, 1, elemento)
end

println("Lista después de rotar \$n posiciones: \$lista")
println("---------------------------")
```

### Ejercicio Clásico 3: Suma Acumulada de una Secuencia
Este ejercicio calcula la suma acumulada de los elementos de una secuencia.

```julia
# Ejercicio Clásico 3: Suma Acumulada de una Secuencia
println("Ejercicio Clásico 3: Suma Acumulada de una Secuencia")
secuencia = 1:5
suma_acumulada = cumsum(secuencia)
println("Secuencia original: \$(collect(secuencia))")
println("Suma acumulada: \$(collect(suma_acumulada))")
println("---------------------------")
```
"""


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.60"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.0"
manifest_format = "2.0"
project_hash = "8aa109ae420d50afa1101b40d1430cf3ec96e03e"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

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
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

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

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

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

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

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
version = "1.11.0"

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

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─bb7794fa-89c8-4e26-887f-cff9d9b64aee
# ╟─7377bab8-6639-47e2-b9fa-5d7a69dec920
# ╟─76e62111-2a7e-4634-ab44-9014c009988c
# ╟─5483fe9c-be9a-4cda-95c0-8a413b2f3d99
# ╟─dfbe6be1-d8c3-4710-a1b0-332f6c743e34
# ╟─4310ba2d-6d6a-4907-8033-557e758a36cd
# ╟─b97fdd0f-09ad-482d-9716-570b721d70e2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
