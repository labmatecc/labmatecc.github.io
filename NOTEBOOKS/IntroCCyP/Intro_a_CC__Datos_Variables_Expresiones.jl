### A Pluto.jl notebook ###
# v0.20.24

using Markdown
using InteractiveUtils

# ╔═╡ fe645621-907d-4da9-b113-6147d4c7401d
using PlutoUI

# ╔═╡ 5d4af6f7-24c3-459b-b4bf-f3efb1ab134b
PlutoUI.TableOfContents(title="Datos, variables y Expresiones", aside=true)

# ╔═╡ 113bb570-ad1c-11ef-345b-b95f4fe49a50
md"""
# ¡Bienvenido a la Introducción a Datos, Variables y Expresiones!

En este cuaderno aprenderemos conceptos fundamentales de programación usando ejemplos claros y visuales.


Desliza hacia abajo para comenzar.
"""

# ╔═╡ d7b90537-d268-46c6-a481-314b0e0d96d4
md"""
# Datos

En programación, **datos** se refieren a la información que usamos. Los tipos de datos básicos incluyen:

- **Números**: enteros (1, 2, -5) y decimales (3.14).
- **Texto**: cadenas de caracteres o strings ("Hola, mundo!"). Se coloca entre comillas " "
- **Booleanos**: verdadero (true) o falso (false).

Veamos algunos ejemplos:
- Un número entero: 42
- Un número decimal: 3.14
- Una cadena: "Hola, Pluto!"
- Un booleano: true

¡Intentemos declararlos en la siguiente celda!
"""

# ╔═╡ 1d4fbf34-f61d-49ca-9d8c-7d9f4e022456
begin
	# Ejemplos de datos
	numero = 42
	texto = "Hola, Pluto!"
	booleano = true
end

# ╔═╡ b21d3926-bb90-4201-b948-2d9c0010c419
md"""Podemos revisar su valor solo escribiendolos en una celda, o imprimiendolos:"""

# ╔═╡ b82f8677-75fb-46dc-a6dd-bd6cbdd82325
numero

# ╔═╡ 310fe5ae-c340-4292-a437-423cb5271e14
println(numero)

# ╔═╡ 1a857227-5f65-4f9f-a20d-d7746e91c046
md""" Declara algunos: """

# ╔═╡ 437ed6bf-300b-4bf0-9f08-f7e02324ef98
begin
	# Escribe aquí algunos datos


	
end

# ╔═╡ 888af425-1c47-4e4f-ac8f-5945958cde18
md"""
# Variables

Una **variable** es un lugar donde almacenamos datos para usarlos más adelante. Puedes imaginarlo como una caja con una etiqueta.

Ejemplo:
- Declaremos una variable que almacene nuestro número favorito.

```julia
mi_numero_favorito = 7
```

Esto significa que hemos guardado el número 7 en una "caja" llamada `mi_numero_favorito`.
¡Ahora tú puedes intentarlo!
"""

# ╔═╡ 1827909e-1e24-4312-ad48-bf54f31e84c1
# Declaración de variable
otra_variable = "Me gusta aprender Julia"

# ╔═╡ dc821047-6905-436b-b24e-a139aa8fdb3c
md"""
 # Expresiones

Las **expresiones** son combinaciones de valores y operadores para producir un nuevo valor.

Por ejemplo, podemos sumar dos números:

```julia
resultado = 4 + 5
```

Podemos también concatenar cadenas de texto:

```julia
mensaje = "Hola, " * "Mundo!"
```

¡Puedes ver cómo las variables se pueden combinar para crear nuevos resultados!
"""

# ╔═╡ 261a965a-dabb-47f3-8861-06e6773f0f22
begin
	# Ejemplos de expresiones
	suma = 5 + 3
	concatenacion = "¡Hola" * " Pluto!"
end

# ╔═╡ cbb7331c-8b94-4b1a-af23-324adcfabfa1
md"""
# Teoría Básica: Declaración de Variables
Las variables son espacios en la memoria que se usan para almacenar datos. En Julia, no se necesita especificar el tipo de dato al declarar una variable. Puedes simplemente asignar un valor a un nombre.

### Comandos Básicos
- `=`: Se usa para asignar un valor a una variable.
- `println()`: Imprime un valor en la consola.

```julia
# Ejercicio 1: Declaración de variables
println("Ejercicio 1: Declaración de variables")
x = 10
nombre = "Juan"
altura = 1.75
println("Valor de x: \$x")
println("Nombre: \$nombre")
println("Altura: \$altura m")
println("---------------------------")
```
"""

# ╔═╡ 07044147-0ae5-4ee9-afb3-43905a17e518
md""" Escribe lo anterior para probarlo:"""

# ╔═╡ dadaeb78-5d93-494c-938a-c0b1e58ddfe5
begin
	# Ejercicio 1: Declaración de variables
	println("Ejercicio 1: Declaración de variables")
	x = 10
	nombre = "Juan"
	altura = 1.75
	println("Valor de x: \$x")
	println("Nombre: \$nombre")
	println("Altura: \$altura m")
	println("---------------------------")
end

# ╔═╡ fe6f4e8f-9896-4602-bcff-b8d86eb672a2
md"""
# Teoría Básica: Operaciones Aritméticas
Las operaciones aritméticas básicas incluyen la suma, resta, multiplicación y división. Julia permite trabajar fácilmente con estos operadores en variables numéricas.

### Comandos Básicos
- `+`: Suma.
- `-`: Resta.
- `*`: Multiplicación.
- `/`: División.

```julia
# Ejercicio 2: Operaciones Aritméticas
println("Ejercicio 2: Operaciones Aritméticas")
a = 5
b = 3
suma = a + b
resta = a - b
producto = a * b
division = a / b
println("Suma: \$suma")
println("Resta: \$resta")
println("Producto: \$producto")
println("División: \$division")
println("---------------------------")
```
"""

# ╔═╡ 45cbb579-a198-4486-bab1-6195977a068e
md""" Escribe lo anterior para probarlo:"""

# ╔═╡ b80c0792-69f5-4e10-87c9-50dc682023a5
begin
	# Escribe aquí

	
end

# ╔═╡ 156352cf-4fa3-42b7-a5bf-6dae79b58b90
md"""
# Teoría Básica: Cadenas de Texto
Las cadenas de texto se utilizan para almacenar secuencias de caracteres. En Julia, las cadenas se pueden concatenar usando el operador `*`.

### Comandos Básicos
- `*`: Operador para concatenar cadenas.
- `length()`: Devuelve la longitud de una cadena.

```julia
# Ejercicio 3: Trabajando con cadenas de texto
println("Ejercicio 3: Trabajando con cadenas de texto")
str1 = "Hola"
str2 = "Mundo"
concatenacion = str1 * " " * str2
println("Concatenación: \$concatenacion")

# Longitud de una cadena
println("Longitud de la cadena concatenada: \$(length(concatenacion))")
println("---------------------------")
```
"""

# ╔═╡ 10cc6f75-63ed-4847-955c-fa6adcfe04f7
md""" Escribe lo anterior para probarlo:"""

# ╔═╡ 93b68859-f110-43a0-a526-c2055572c13f
begin
	# Escribe aquí

	
end

# ╔═╡ 985ccb74-9f24-45f7-96b9-24119e1b454f
md"""
# Teoría Básica: Tipos de Datos
En Julia, cada valor tiene un tipo de dato asociado. Estos incluyen `Int` para enteros, `Float64` para números decimales y `Bool` para valores booleanos.

### Comandos Básicos
- `typeof()`: Devuelve el tipo de dato de una variable.

```julia
# Ejercicio 4: Tipos de datos
println("Ejercicio 4: Tipos de datos")
edad = 25
pi = 3.14159
es_estudiante = true
println("Tipo de edad: \$(typeof(edad))")
println("Tipo de pi: \$(typeof(pi))")
println("Tipo de es_estudiante: \$(typeof(es_estudiante))")
println("---------------------------")
```
"""

# ╔═╡ 446b851c-da3e-42a6-bac0-b6852945c9d2
md""" Escribe lo anterior para probarlo:"""

# ╔═╡ bcae630a-b6f4-49fb-be1b-e0a444247283
begin
	# Escribe aquí

	
end

# ╔═╡ 57ee8dd6-7874-4a45-af18-00be1de5ce93
md"""
# Teoría Básica: Entrada del Usuario
En Julia, `readline()` se puede usar para leer la entrada del usuario desde la consola.

### Comandos Básicos
- `readline()`: Lee una línea de la entrada estándar.

```julia
# Ejercicio 5: Entrada del usuario
println("Ejercicio 5: Entrada del usuario")
# Descomenta las siguientes líneas para permitir la entrada del usuario
# nombre_usuario = readline("Ingresa tu nombre: ")
# println("Hola, \$nombre_usuario! Bienvenido a Julia.")
println("---------------------------")
```
"""

# ╔═╡ ae567dde-ed2a-4ca7-a3b6-f3ec4a7504a8
md""" Escribe lo anterior para probarlo:"""

# ╔═╡ 008216ad-bce6-4641-b812-385e4220b57a
begin
	# Escribe aquí

end

# ╔═╡ e5717e93-1b8e-4584-b941-ac1d9096be08
md"""
# Teoría Básica: Operadores Lógicos
Los operadores lógicos se utilizan para comparar valores. En Julia, `>` y `<=` se usan para comparar dos valores.

### Comandos Básicos
- `>`: Mayor que.
- `<=`: Menor o igual que.

```julia
# Ejercicio 6: Operadores lógicos
println("Ejercicio 6: Operadores lógicos")
x = 7
y = 10
es_mayor = x > y
es_menor_igual = x <= y
println("¿x es mayor que y?: \$es_mayor")
println("¿x es menor o igual que y?: \$es_menor_igual")
println("---------------------------")
```
"""

# ╔═╡ c8565bb3-e57a-4d54-b8e5-a370077f25d2
md""" Escribe lo anterior para probarlo:"""

# ╔═╡ a3fe35de-e143-4789-b413-558763cc7b32
begin
	# Escribe aquí

	
end

# ╔═╡ 5a104158-7b61-4668-8f48-34bbaea180b2

md"""
# Teoría Básica: Cálculo de Área de un Círculo
El área de un círculo se puede calcular usando la fórmula `A = π * r^2`. En Julia, la constante `pi` se usa para representar el valor de π.

### Comandos Básicos
- `^`: Operador de potencia.
- `pi`: Constante que representa π.

```julia
# Ejercicio 7: Cálculo de área de un círculo
println("Ejercicio 7: Cálculo de área de un círculo")
radio = 4.0
area = pi * radio^2
println("El área de un círculo con radio \$radio es: \$area")
println("---------------------------")
```
"""

# ╔═╡ de8c2b34-b4d8-4502-a0f8-2d0d87ebb9ad
md""" Escribe lo anterior para probarlo:"""

# ╔═╡ d8985a39-d409-436f-bc22-77cc69269d94
begin
	# Escribe aquí

end

# ╔═╡ 9f30f353-3dc1-4c10-9ee0-de64c2080794

md"""
# Teoría Básica: Conversión de Tipos
En Julia, `parse()` y `round()` se pueden usar para convertir entre diferentes tipos de datos, como de cadena a entero o de flotante a entero.

### Comandos Básicos
- `parse()`: Convierte una cadena en un tipo numérico.
- `round()`: Redondea un número flotante al entero más cercano.

```julia
# Ejercicio 8: Conversión de tipos
println("Ejercicio 8: Conversión de tipos")
num_str = "123"
num = parse(Int, num_str)
println("Convertido de cadena a entero: \$num")
float_num = 3.7
entero = round(Int, float_num)
println("Convertido de flotante a entero: \$entero")
println("---------------------------")
```
"""

# ╔═╡ 3612c26d-de76-4942-976a-3cf26dcce25b
md""" Escribe lo anterior para probarlo:"""

# ╔═╡ 8452c9db-2116-4246-964b-678eadcfe54d
begin
	# Escribe aquí
	
end

# ╔═╡ 3938a6a3-5f3e-4332-a8dc-33be25198050
md"""
# Teoría Básica: Uso de Expresiones Condicionales
Las expresiones condicionales se usan para tomar decisiones. En Julia, se usa `if ... else` para ejecutar diferentes bloques de código dependiendo de una condición.

### Comandos Básicos
- `if ... else ... end`: Estructura para controlar el flujo condicional.
- `%`: Operador módulo que devuelve el residuo de una división.

```julia
# Ejercicio 9: Uso de expresiones
println("Ejercicio 9: Uso de expresiones")
valor = 8
resultado = if valor % 2 == 0
    "El número es par"
else
    "El número es impar"
end
println(resultado)
println("---------------------------")
```
"""

# ╔═╡ 613eb37c-a805-433f-8f70-056f2d0d118a
md""" Escribe lo anterior para probarlo:"""

# ╔═╡ 01ae3edd-d854-4e39-8c14-4cbaf67bbca3
begin
	# Escribe aquí

	
end

# ╔═╡ 4d2e3546-b559-4e0a-9d6b-1b3f47e83df5
md"""
# Teoría Básica: Definición de Constantes
En Julia, las constantes se definen usando la palabra clave `const`. Las constantes son variables cuyo valor no debería cambiar a lo largo del programa.

### Comandos Básicos
- `const`: Define una constante.

```julia
# Ejercicio 10: Definición de constantes
println("Ejercicio 10: Definición de constantes")
const GRAVEDAD = 9.81
println("El valor de la gravedad en la Tierra es: \$GRAVEDAD m/s^2")
println("---------------------------")
```
"""

# ╔═╡ d18cc0d1-3655-4052-aa4c-941af0a69992
md""" Escribe lo anterior para probarlo:"""

# ╔═╡ 8938db21-30d6-4def-a73a-8c7e0cf3c0ab
begin
	# Escribe aquí

	
end

# ╔═╡ 867b4fa7-6e5a-44cf-aff5-9ab9a480b74c
md"""

### ¡Sigue practicando!
Explora más con datos y visualizaciones para reforzar lo aprendido.
¡La práctica hace al maestro!
¡Gracias por acompañarme en este viaje a través de los conceptos básicos de programación! 🎉
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.23"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.6"
manifest_format = "2.0"
project_hash = "9a38ea2a7647ef8107794f1f94ff9c7ddda19134"

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

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

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

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

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

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.11.4"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.12.1"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "5152abbdab6488d5eec6a01029ca6697dff4ec8f"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.23"

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

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

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
version = "1.3.1+2"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.7.0+0"
"""

# ╔═╡ Cell order:
# ╟─fe645621-907d-4da9-b113-6147d4c7401d
# ╟─5d4af6f7-24c3-459b-b4bf-f3efb1ab134b
# ╟─113bb570-ad1c-11ef-345b-b95f4fe49a50
# ╟─d7b90537-d268-46c6-a481-314b0e0d96d4
# ╠═1d4fbf34-f61d-49ca-9d8c-7d9f4e022456
# ╟─b21d3926-bb90-4201-b948-2d9c0010c419
# ╠═b82f8677-75fb-46dc-a6dd-bd6cbdd82325
# ╠═310fe5ae-c340-4292-a437-423cb5271e14
# ╟─1a857227-5f65-4f9f-a20d-d7746e91c046
# ╠═437ed6bf-300b-4bf0-9f08-f7e02324ef98
# ╟─888af425-1c47-4e4f-ac8f-5945958cde18
# ╠═1827909e-1e24-4312-ad48-bf54f31e84c1
# ╟─dc821047-6905-436b-b24e-a139aa8fdb3c
# ╠═261a965a-dabb-47f3-8861-06e6773f0f22
# ╟─cbb7331c-8b94-4b1a-af23-324adcfabfa1
# ╟─07044147-0ae5-4ee9-afb3-43905a17e518
# ╠═dadaeb78-5d93-494c-938a-c0b1e58ddfe5
# ╟─fe6f4e8f-9896-4602-bcff-b8d86eb672a2
# ╟─45cbb579-a198-4486-bab1-6195977a068e
# ╠═b80c0792-69f5-4e10-87c9-50dc682023a5
# ╟─156352cf-4fa3-42b7-a5bf-6dae79b58b90
# ╟─10cc6f75-63ed-4847-955c-fa6adcfe04f7
# ╠═93b68859-f110-43a0-a526-c2055572c13f
# ╟─985ccb74-9f24-45f7-96b9-24119e1b454f
# ╟─446b851c-da3e-42a6-bac0-b6852945c9d2
# ╠═bcae630a-b6f4-49fb-be1b-e0a444247283
# ╟─57ee8dd6-7874-4a45-af18-00be1de5ce93
# ╟─ae567dde-ed2a-4ca7-a3b6-f3ec4a7504a8
# ╠═008216ad-bce6-4641-b812-385e4220b57a
# ╟─e5717e93-1b8e-4584-b941-ac1d9096be08
# ╟─c8565bb3-e57a-4d54-b8e5-a370077f25d2
# ╠═a3fe35de-e143-4789-b413-558763cc7b32
# ╟─5a104158-7b61-4668-8f48-34bbaea180b2
# ╟─de8c2b34-b4d8-4502-a0f8-2d0d87ebb9ad
# ╠═d8985a39-d409-436f-bc22-77cc69269d94
# ╟─9f30f353-3dc1-4c10-9ee0-de64c2080794
# ╟─3612c26d-de76-4942-976a-3cf26dcce25b
# ╠═8452c9db-2116-4246-964b-678eadcfe54d
# ╟─3938a6a3-5f3e-4332-a8dc-33be25198050
# ╟─613eb37c-a805-433f-8f70-056f2d0d118a
# ╠═01ae3edd-d854-4e39-8c14-4cbaf67bbca3
# ╟─4d2e3546-b559-4e0a-9d6b-1b3f47e83df5
# ╟─d18cc0d1-3655-4052-aa4c-941af0a69992
# ╠═8938db21-30d6-4def-a73a-8c7e0cf3c0ab
# ╟─867b4fa7-6e5a-44cf-aff5-9ab9a480b74c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
