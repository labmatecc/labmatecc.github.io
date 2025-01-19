### A Pluto.jl notebook ###
# v0.19.46

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

# ╔═╡ 281f3f67-2fad-4c2a-a8c9-05c78f6ab69c
using PlutoUI, PlutoPlotly, Dates, CSV, HTTP, DataFrames, RDatasets

# ╔═╡ 74758ce8-6c1b-42ac-9ac5-c0a0d0abb467
PlutoUI.TableOfContents(title="Introducción al modelamiento 3D", aside=true)

# ╔═╡ 33a31e78-78df-499a-9c85-b9b2bb4e9893
md"""Este cuaderno está en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias, por favor escribir a labmatecc_bog@unal.edu.co

Tu participación es fundamental para hacer de este curso una experiencia aún mejor.

Elaborado por Juan Galvis, Francisco Gómez y Sergio Nuñez.
Usaremos las siguientes librerías:"""

# ╔═╡ b52f1bcc-aa67-442f-91c9-3fb7e5ddde11
md"""# Introducción al modelamiento 3D con Pluto Plotly
En este cuaderno continuamos con el uso de una librería que ofrece una gran libertad de observación de datos tridimensionales conocida como PlutoPlotly, con ella podemos utilizar dinámicamente los gráficos para una mayor interactividad.
"""

# ╔═╡ 54559454-9778-4d2c-a6f8-37db82b56ad8
md""" 
## Creación elemental de objetos

El primer paso es el uso de la función plot del paquete PlutoPlotly. Para ello solo basta con un conjunto de datos y se creará una malla donde se puede usar el mouse para acercar y alejar.
"""

# ╔═╡ c95240e1-f604-4dfb-9388-82fb205f51b2
plot([5,6,7,2]; line_color="red")

# ╔═╡ c83f7c7d-50f8-4010-b575-43e4f55f64e2
md""" ## Creación de puntos 3D

El gráfico `scatter3d` en **PlotlyPluto** permite representar puntos en un espacio tridimensional. Este tipo de visualización es útil para analizar la distribución de datos y su relación en tres dimensiones. A continuación, presentamos los fundamentos teóricos de este tipo de gráfico.

#### Puntos y Coordenadas
Cada punto en el gráfico se define por tres coordenadas: $x$: La posición en el eje horizontal. $y$: La posición en el eje vertical. $z$: La posición en el eje de profundidad. Matemáticamente, cada punto está en el espacio euclidiano tridimensional $\mathbb{R}^3$ y se representa como $(x, y, z)$.

#### Modos de Representación
El tipo `scatter3d` ofrece varios modos para representar los puntos:
- **Marcadores**: Los puntos se visualizan como esferas o marcas en el espacio tridimensional.
- **Líneas**: Los puntos se conectan mediante líneas, formando trayectorias.
- **Líneas + Marcadores**: Combina ambos modos, mostrando los puntos con conexiones entre ellos.

El modo se define mediante el parámetro `mode`, que puede tomar valores como `"markers"`, `"lines"`, o `"lines+markers"`.

#### Visualización y Personalización
Los gráficos `scatter3d` permiten personalizar diversos aspectos:
- **Tamaño y color de los puntos**: Se puede ajustar mediante los parámetros `marker.size` y `marker.color`.
- **Transparencia**: Se controla con `opacity`.
- **Etiquetas de puntos**: Se pueden añadir etiquetas descriptivas con `text`.
"""

# ╔═╡ 58872f21-43d2-4d51-914d-497822198835
md""" podemos hacer que se conecten por lineas usando lines+markers como opción"""

# ╔═╡ c0e77196-1eb5-4251-bbb3-4183bffb8022
# Definir los datos del gráfico
trace = scatter3d(
    x = [1, 2, 3],
    y = [4, 5, 6],
    z = [7, 8, 9],
    mode = "markers",
    marker_size = 10,
	render_mode="SVG"
)

# ╔═╡ 29fa6ff4-d5ad-4a93-ac53-f3b75bfb0ff2
# Definir el diseño
layout = Layout(
    title = "Manten presionado y mueve el mouse",
    scene_camera_eye = [1.2, 1.2, 0.8]
)

# ╔═╡ 563e6ccd-487d-4b37-bf8e-45007eaa2f1b
plot([trace], layout)

# ╔═╡ 9e20fd0e-fd2a-40af-988f-4ce01f34632c
md"""
## Creación de mallas

El gráfico `mesh3d` en **PlotlyJS** y en particular en **PlutoPlotly** se utiliza para representar mallas tridimensionales definidas por vértices y caras. Esta representación es fundamental en la visualización de geometrías complejas y superficies en tres dimensiones. A continuación, exploramos los conceptos teóricos que sustentan este tipo de gráfico.

#### Vértices y Coordenadas
La base de una malla tridimensional es un conjunto de **vértices**. Cada vértice se define por tres coordenadas: $x$: La posición en el eje horizontal. $y$: La posición en el eje vertical. $z$: La posición en el eje de profundidad. Matemáticamente, un vértice es un punto en el espacio euclidiano tridimensional $\mathbb{R}^3$, representado como $(x, y, z)$.

#### Caras y Triangulación
Las **caras** de la malla son los elementos planos que conectan los vértices. En `mesh3d`, cada cara se define mediante índices que apuntan a tres vértices específicos. Estos índices se agrupan en tres listas: $i$: Índices del primer vértice de cada triángulo. $j$: Índices del segundo vértice. $k$: Índices del tercer vértice. Cada tripleta $(i, j, k)$ define un triángulo en el espacio tridimensional, que es la unidad básica para construir superficies más complejas. Este proceso se llama **triangulación**.

#### Ejemplo Conceptual
A continuación se explica de forma teórica el rol de cada parámetro y cómo se utiliza para crear la visualización.

##### 1. **Vértices (`x`, `y`, `z`)**
- Los vértices son los puntos en el espacio tridimensional que definen la estructura de la malla.
- Se especifican mediante sus coordenadas en las listas:
  -  `x = [1, 2, 3, 4]`
  -  `y = [0, 1, 0, 1]`
  -  `z = [2, 0, 1, 1]`
- Estos vértices representan los nodos de la malla.

##### 2. **Índices para las caras (`i`, `j`, `k`)**
- Cada tripleta `(i[n], j[n], k[n])` define un triángulo (cara) conectando tres vértices.
- Los índices hacen referencia a la posición de los vértices en las listas `x`, `y` y `z`.
- Ejemplo:
  - La primera cara conecta los vértices en las posiciones `i[1] = 0`, `j[1] = 1` y `k[1] = 2`, formando un triángulo.

##### 3. **Coloración (`intensity`, `colorscale`)**
-  **`intensity`:**
  - Lista que asigna un valor de intensidad a cada vértice.
  - Los valores de intensidad se interpolan entre los vértices para colorear las caras del triángulo.
  - En este ejemplo: `intensity = [0, 0.33, 0.66, 1]`.
-  **`colorscale`:**
  - Define los colores asociados a los valores de intensidad.
  - La escala se define como una lista de pares `[valor, color]`, donde:
    -  `0` se asocia con "gold".
    -  `0.5` se asocia con "mediumturquoise".
    -  `1` se asocia con "magenta".

##### 4. **`colorbar_title`**
- Especifica el título de la barra de colores (colorbar) que aparece junto al gráfico. Este título indica qué representa la intensidad.

#### Resultado del Código
El código genera un **tetraedro 3D** en el que cada cara está coloreada según una interpolación de las intensidades de sus vértices. Los colores cambian gradualmente de acuerdo con la escala de colores definida.
"""



# ╔═╡ 6e77ebce-16bb-42a7-9200-3f327c7d3c47
PlutoPlotly.plot(
    mesh3d(
        # Coordenadas de los vértices en el espacio 3D
        x = [1, 2, 3, 4],  # Coordenadas en el eje X
        y = [0, 1, 0, 1],  # Coordenadas en el eje Y
        z = [2, 0, 1, 1],  # Coordenadas en el eje Z
        
        # Índices que definen las caras triangulares
        # Cada tripleta (i[n], j[n], k[n]) representa un triángulo
        i = [0, 0, 0, 1],  # Primer vértice de cada triángulo
        j = [1, 2, 3, 2],  # Segundo vértice de cada triángulo
        k = [2, 3, 0, 3],  # Tercer vértice de cada triángulo
        
        # Configuración de color
        colorbar_title = "z",  # Título de la barra de colores
        colorscale = [         # Escala de colores
            [0, "gold"],        # Color para intensidad 0
            [0.5, "mediumturquoise"],  # Color para intensidad 0.5
            [1, "magenta"]      # Color para intensidad 1
        ],
        
        # Intensidad asociada a cada vértice
        # Estos valores serán interpolados para colorear las caras
        intensity = [0, 0.33, 0.66, 1]
    )
)

# ╔═╡ b939ee9c-4536-42c0-84e8-144339c64be8
md"""
#### Alpha-null

El parámetro **`alphahull`** se utiliza para definir el tipo de malla que se genera a partir de un conjunto de puntos en el espacio tridimensional. Este concepto está basado en la construcción de **envolventes alfa** (*alpha shapes*), una generalización de las envolventes convexas.

- **`alphahull`** controla cómo se conectan los puntos del espacio para formar una malla:
  - Un valor **pequeño** de `alphahull` genera una malla más ajustada, capturando detalles finos de la distribución de puntos (forma más cercana a la concavidad).
  - Un valor **grande** de `alphahull` aproxima una envolvente convexa (forma más redondeada y menos detallada).
  - Si `alphahull` es **negativo**, se genera una malla convexa estándar.

- Matemáticamente, las **envolventes alfa** determinan qué puntos deben conectarse para formar las caras de una malla, utilizando un parámetro de radio que define las conexiones entre puntos.
"""


# ╔═╡ 1563995e-df5d-4d41-ab77-d91063829e00
# Slider para ajustar el parámetro alphahull
@bind alphanull Slider(1:10, show_value=true, default=6)

# ╔═╡ f19a25bc-51c4-4ec4-85a5-f4d0c82d6fbe
function malla_con_alphanull(alphahull_slider = 6)
    # Leer datos desde un archivo remoto
    df = CSV.File( HTTP.get("https://raw.githubusercontent.com/plotly/datasets/master/mesh_dataset.txt").body;  # Descargar archivo CSV
        delim=" ",      # Especificar que los datos están delimitados por espacios
        header=false 	# Indicar que el archivo no tiene encabezados
    ) |> DataFrame      # Convertir los datos descargados en un DataFrame

    # Crear la gráfica 3D interactiva
    return plot(
        df,             			# Utilizar los puntos en el DataFrame como datos
        x=:Column1, 
		y=:Column2, 
		z=:Column3,  				# Asignar las columnas a las coordenadas X, Y, Z
        kind="mesh3d",              # Especificar que queremos una malla 3D
        alphahull=alphahull_slider, # Controlar la forma de la malla con el slider
        opacity=0.4                 # Ajustar la opacidad de la malla (40%)
    )
end

# ╔═╡ e34f502e-89bf-49d1-bcf6-90105581b00b
malla_con_alphanull(alphanull)

# ╔═╡ f653842f-9116-4d5c-b329-cfb5afb473b5
md""" # PlutoPlotly 3D Avanzado

"""

# ╔═╡ 0ae1bdf5-3ec5-4664-89ba-c5e838771a0a
md" ## Ejes 3D

Veremos cómo podemos ajustar los distintos parámetros de los ejes, se usaran imagenes para observar el resultado de las funciones pero cada función puede ser ejecutada para visualizar cada cambio"

# ╔═╡ 599d6fd9-80de-43a4-9f4b-8d9aa44b9f40
md"""
Los elementos presentes en la función se describen por:

1. **Generación del diseño (`Layout`)**:  
   El diseño del gráfico se define con el comando `Layout`, que organiza la disposición del gráfico en 3D. Dentro del atributo `scene`, se configuran los ejes tridimensionales:  
   - `xaxis`, `yaxis`, y `zaxis`: Permiten ajustar el rango de los ejes con el atributo `range` y definir el número de divisiones principales en cada eje mediante `nticks`.  
   Además, se especifican los márgenes del gráfico con el atributo `margin`, y el ancho total del gráfico con `width` para controlar su apariencia.

2. **Generación de datos tridimensionales**:  
   Las coordenadas de los puntos se crean utilizando distribuciones normales aleatorias escaladas por diferentes factores:  
   - `x = 70 .* randn(N)` genera datos aleatorios para el eje X con una dispersión controlada por el factor 70.  
   - `y = 55 .* randn(N)` y `z = 40 .* randn(N)` siguen un esquema similar para los ejes Y y Z, pero con diferentes escalas.

3. **Visualización de datos (`mesh3d`)**:  
   El comando `mesh3d` toma los datos generados (`x`, `y`, `z`) y los utiliza para crear una malla tridimensional. El atributo `color` define el color de los puntos en formato RGBA, lo que permite añadir transparencia.
"""



# ╔═╡ c3e9aa33-1f6b-4eda-aa5c-72ea374dc51f
function Rango_de_ejes()
    # Número de puntos a generar
    N = 70

    # Configuración del diseño del gráfico 3D
    layout = Layout(
        scene=attr(  # Atributos de la escena 3D
            xaxis=attr(  # Configuración del eje X
                nticks=4,      # Número de marcas en el eje X
                range=[-100,100]  # Rango del eje X
            ),
            yaxis=attr(  # Configuración del eje Y
                nticks=4,      # Número de marcas en el eje Y
                range=[-50,100]  # Rango del eje Y
            ),
            zaxis=attr(  # Configuración del eje Z
                nticks=4,      # Número de marcas en el eje Z
                range=[-100,100]  # Rango del eje Z
            ),
        ),
        width=700,  # Ancho del gráfico
        margin=attr(  # Márgenes del gráfico
            r=20,  # Margen derecho
            l=10,  # Margen izquierdo
            b=10,  # Margen inferior
            t=10   # Margen superior
        ),
    )

    # Generación del gráfico 3D
    return plot(
        mesh3d(  # Crear una malla 3D
            x=(70 .* randn(N)),  # Coordenadas X, valores aleatorios escalados
            y=(55 .* randn(N)),  # Coordenadas Y, valores aleatorios escalados
            z=(40 .* randn(N)),  # Coordenadas Z, valores aleatorios escalados
            color="rgba(244,22,100,0.6)"  # Color de la malla con transparencia
        ),
        layout,  # Aplicar el diseño configurado
    )
end

# ╔═╡ 59ca341a-9815-4b6d-941f-d776c629e8c5
md"""
1. **Estructura de subgráficos (`make_subplots`)**:  
   La cuadrícula de subgráficos se genera con `make_subplots`, donde se especifica que cada celda contendrá una escena tridimensional (`Spec(kind="scene")`). La función `fill` asegura que todas las celdas tengan el mismo tipo de contenido.

2. **Ajustes de los ejes en las escenas (`relayout!`)**:  
   - **`scene_aspectmode="cube"`**: En la primera escena, las proporciones de los ejes se fijan para formar un cubo.  
   - **`scene2`**: Se configura manualmente la relación entre los ejes, forzando al eje Z a ser el doble del tamaño de los otros dos mediante `aspectratio`.  
   - **`scene3_aspectmode="data"`**: Los ejes se dibujan en proporción a sus rangos respectivos.  
   - **`scene4_aspectmode="auto"`**: La proporción de los ejes se ajusta automáticamente para lograr una visualización equilibrada.

3. **Generación y visualización de datos (`add_trace!`)**:  
   Para cada subgráfico, se añaden datos tridimensionales generados aleatoriamente con `mesh3d`. Los atributos de los datos incluyen:  
   - Coordenadas `x`, `y`, `z` generadas con distribuciones normales escaladas.  
   - `opacity`: Controla la transparencia de los puntos para mejorar la percepción espacial.
"""


# ╔═╡ d4957469-65ae-4099-bfc5-6d76f44bcd98
function Ejes_de_Relación_fija()
    # Define la cantidad de puntos que se generarán para cada traza
    N = 50

    # Crea un gráfico con 4 subgráficos organizados en una cuadrícula de 2x2
    # 'make_subplots' se usa para crear esta disposición, y cada subplot tiene especificaciones de "scene"
    fig = make_subplots(rows=2, cols=2, specs=fill(Spec(kind="scene"), 2, 2))

    # Ajusta las configuraciones de los subgráficos para establecer relaciones fijas entre los ejes
    relayout!(
        fig,
        # Configura el primer subplot para que mantenga una relación cúbica entre sus ejes
        scene_aspectmode="cube",
        # Configura el segundo subplot para que el eje z sea el doble de grande que los ejes x e y
        scene2=attr(aspectmode="manual", aspectratio=attr(x=1, y=1, z=2)),
        # Configura el tercer subplot para que los ejes estén en proporción a los rangos de sus datos
        scene3_aspectmode="data",
        # Configura el cuarto subplot para que determine automáticamente una proporción bien ajustada
        scene4_aspectmode="auto",
    )

    # Agrega las trazas a cada subplot
    for i in 1:2, j in 1:2
        # Crea una traza tridimensional con datos aleatorios generados por 'randn'
        # Cada traza tiene diferentes rangos en los ejes x, y, z
        add_trace!(
            fig,
            mesh3d(
                x=(60 .* randn(N)),  # Coordenadas x
                y=(25 .* randn(N)),  # Coordenadas y
                z=(40 .* randn(N)),  # Coordenadas z
                opacity=0.5,         # Configura la opacidad del mesh
            ),
            row=i, col=j           # Especifica en qué subplot se agrega la traza
        )
    end

    # Devuelve el gráfico final con las configuraciones y trazas
    fig
end

# ╔═╡ f23636ed-97d3-4904-b5bd-5035161d31ee
md"""
Este código crea un gráfico tridimensional con dos superficies aleatorias y configura títulos personalizados para los ejes. A continuación, se describen los elementos principales:

1. **Superficies tridimensionales (`mesh3d`)**:  
   Se generan dos conjuntos de datos tridimensionales (`trace1` y `trace2`) con distribuciones normales escaladas. Cada superficie tiene atributos específicos:  
   - `x`, `y`, `z`: Coordenadas tridimensionales.  
   - `opacity`: Controla la transparencia de las superficies.  
   - `color`: Define el color de cada conjunto de datos (amarillo y rosa en este caso).  

2. **Configuración del diseño (`Layout`)**:  
   El diseño incluye títulos personalizados para cada eje mediante los atributos `xaxis_title`, `yaxis_title` y `zaxis_title`. También ajusta el ancho del gráfico (`width`) y los márgenes (`margin`) para asegurar una visualización clara y equilibrada.

3. **Visualización del gráfico (`plot`)**:  
   Se combinan las dos superficies (`trace1` y `trace2`) con el diseño configurado para renderizar el gráfico final.

"""


# ╔═╡ 15b9a3db-e5cc-4304-a7bd-ac4d43e6e478
function Titulo_de_ejes()
    # Define la cantidad de puntos que se generarán para cada conjunto tridimensional
    N = 50

    # Define el primer conjunto de puntos tridimensionales con una distribución aleatoria
    trace1 = mesh3d(
        x=(60 .* randn(N)),    # Coordenadas x, escaladas por un factor de 60
        y=(25 .* randn(N)),    # Coordenadas y, escaladas por un factor de 25
        z=(40 .* randn(N)),    # Coordenadas z, escaladas por un factor de 40
        opacity=0.5,           # Establece la opacidad al 50%
        color="yellow"         # Color del mesh: amarillo
    )

    # Define el segundo conjunto de puntos tridimensionales con otra distribución aleatoria
    trace2 = mesh3d(
        x=(70 .* randn(N)),    # Coordenadas x, escaladas por un factor de 70
        y=(55 .* randn(N)),    # Coordenadas y, escaladas por un factor de 55
        z=(30 .* randn(N)),    # Coordenadas z, escaladas por un factor de 30
        opacity=0.5,           # Establece la opacidad al 50%
        color="pink"           # Color del mesh: rosado
    )

    # Configura el diseño del gráfico, incluyendo títulos de ejes y dimensiones
    layout = Layout(
        scene=attr(
            xaxis_title="X AXIS TITLE",  # Título para el eje X
            yaxis_title="Y AXIS TITLE",  # Título para el eje Y
            zaxis_title="Z AXIS TITLE"   # Título para el eje Z
        ),
        width=700,                       # Ancho del gráfico en píxeles
        margin=attr(r=20, b=10, l=10, t=10) # Configura márgenes: derecha, abajo, izquierda, arriba
    )

    # Combina las dos trazas y el diseño en un solo gráfico
    plot([trace1, trace2], layout)
end

# ╔═╡ 95ae8278-2ab9-4c88-81ac-fdd6a933220a
md"""
Se genera un gráfico tridimensional con una malla de puntos y se personaliza la apariencia de las marcas en los ejes, utilizando configuraciones avanzadas para los *ticks*.

1. **Personalización de las marcas en los ejes (`ticktext`, `tickvals`, `nticks`)**:  
   - **Eje X (`xaxis`)**:  
     - `ticktext`: Define etiquetas personalizadas para las marcas (`TICKS`, `MESH`, `PLOTLY`, `JULIA`).  
     - `tickvals`: Especifica las posiciones numéricas donde se colocarán las marcas.  
   - **Eje Y (`yaxis`)**:  
     - `nticks`: Ajusta el número total de marcas visibles en el eje.  
     - `tickfont`: Cambia el estilo de las etiquetas, especificando color (`green`), tamaño (`12`) y fuente (`Old Standard TT, serif`).  
     - `ticksuffix`: Añade un sufijo (`#`) a cada etiqueta de marca.  
   - **Eje Z (`zaxis`)**:  
     - `nticks`: Define el número de marcas visibles.  
     - `ticks`: Configura las marcas para que estén en el exterior del eje.  
     - `tick0`: Establece la posición inicial de las marcas.  
     - `tickwidth`: Ajusta el grosor de las marcas.
"""


# ╔═╡ 1018567b-0f79-49e4-805e-74c556e1f443
function apariencia_de_las_marcas_en_los_ejes()
    # Define la cantidad de puntos que se generarán para el conjunto tridimensional
    N = 50

    # Crea un conjunto de puntos tridimensionales aleatorios
    trace = mesh3d(
        x=(60 .* randn(N)), 	# Coordenadas x, escaladas por un factor de 60
        y=(25 .* randn(N)),     # Coordenadas y, escaladas por un factor de 25
        z=(40 .* randn(N)),     # Coordenadas z, escaladas por un factor de 40
        opacity=0.5,            # Opacidad del mesh, establecida al 50%
        color="rgba(100,22,200,0.5)"  # Color del mesh en formato RGBA
    )

    # Configura el diseño del gráfico, personalizando las marcas (ticks) en cada eje
    layout = Layout(
        scene=attr(
            # Configuración personalizada para el eje X
            xaxis=attr(
                ticktext=["TICKS", "MESH", "PLOTLY", "JULIA"],  # Etiquetas personalizadas para las marcas
                tickvals=[0, 50, 75, -50] # Valores correspondientes en el eje X
            ),
            # Configuración personalizada para el eje Y
            yaxis=attr(
                nticks=5,          # Define un total de 5 marcas en el eje
                tickfont=attr(     # Personalización del estilo de la fuente
                    color="green", # Color verde para las marcas
                    size=12,       # Tamaño de la fuente
                    family="Old Standard TT, serif" # Familia tipográfica
                ),
                ticksuffix="#"     # Agrega el sufijo "#" a las marcas
            ),
            # Configuración personalizada para el eje Z
            zaxis=attr(
                nticks=4,          # Define un total de 4 marcas en el eje
                ticks="outside",   # Las marcas aparecen hacia afuera del eje
                tick0=0,           # Marca inicial en el valor 0
                tickwidth=4        # Ancho de las marcas
            )
        ),
        width=700,                 # Ancho total del gráfico en píxeles
        margin=attr(r=10, l=10, b=10, t=10) # Configuración de márgenes: derecha, izquierda, abajo, arriba
    )

    # Genera el gráfico tridimensional con las configuraciones definidas
    plot(trace, layout)
end


# ╔═╡ d7955048-1829-47e2-ac76-fb0afa738b6a
md"""
Se crea un gráfico tridimensional con una malla de puntos y se personalizan los colores de fondo y la apariencia de la malla en los ejes.

1. **Personalización de los ejes (`xaxis`, `yaxis`, `zaxis`)**:  
   Cada eje tiene configuraciones específicas que afectan su apariencia:  
   - `backgroundcolor`: Define el color de fondo de cada eje. Los colores asignados son tonalidades distintas para diferenciar los planos X, Y, y Z.  
   - `gridcolor`: Ajusta el color de las líneas de la cuadrícula en el fondo (blanco en este caso).  
   - `showbackground`: Activa la visualización del fondo del plano asociado al eje.  
   - `zerolinecolor`: Establece el color de la línea cero en cada eje (blanco).  
"""


# ╔═╡ 515d754e-b481-4b4d-9a78-e76a0e729db8
function colores_de_fondo_y_malla()
    # Define la cantidad de puntos que se generarán para el conjunto tridimensional
    N = 50

    # Crea un conjunto de puntos tridimensionales aleatorios
    trace = mesh3d(
        x=(30 .* randn(N)),       # Coordenadas x, escaladas por un factor de 30
        y=(25 .* randn(N)),       # Coordenadas y, escaladas por un factor de 25
        z=(30 .* randn(N)),       # Coordenadas z, escaladas por un factor de 30
        opacity=0.5               # Opacidad del mesh, establecida al 50%
    )

    # Configura el diseño del gráfico, ajustando colores de fondo y malla en los ejes
    layout = Layout(
        scene=attr(
            # Configuración personalizada para el eje X
            xaxis=attr(
                backgroundcolor="rgb(200, 200, 230)", # Color de fondo del eje X
                gridcolor="white",    # Color de las líneas de la malla: blanco
                showbackground=true,  # Habilita el fondo del eje X
                zerolinecolor="white" # Color de la línea cero: blanco
            ),
            # Configuración personalizada para el eje Y
            yaxis=attr(
                backgroundcolor="rgb(230, 200, 230)", # Color de fondo del eje Y
                gridcolor="white",    # Color de las líneas de la malla: blanco
                showbackground=true,  # Habilita el fondo del eje Y
                zerolinecolor="white" # Color de la línea cero: blanco
            ),
            # Configuración personalizada para el eje Z
            zaxis=attr(
                backgroundcolor="rgb(230, 230, 200)", # Color de fondo del eje Z
                gridcolor="white",    # Color de las líneas de la malla: blanco
                showbackground=true,  # Habilita el fondo del eje Z
                zerolinecolor="white" # Color de la línea cero: blanco
            )
        ),
        width=700,                    # Ancho total del gráfico en píxeles
        margin=attr(
            r=10, l=10,               # Margen derecho e izquierdo
            b=10, t=10                # Margen inferior y superior
        )
    )

    # Genera el gráfico tridimensional con las configuraciones definidas
    plot(trace, layout)
end


# ╔═╡ c23135c6-be9e-4784-855a-78058a19e326
md"""
Este código genera un gráfico tridimensional donde se desactivan las líneas guía que normalmente aparecen al pasar el mouse sobre los puntos.

1. **Configuración para desactivar las líneas guía (`xaxis_showspikes` y `yaxis_showspikes`)**:  
   - `xaxis_showspikes=false` y `yaxis_showspikes=false`: Estas opciones desactivan las líneas guía interactivas que aparecen por defecto en los ejes al mover el mouse sobre los datos.

2. **Configuración del diseño (`Layout`)**:  
   La configuración incluye únicamente los ajustes necesarios para desactivar las líneas guía en los ejes X e Y.

"""


# ╔═╡ 33e19f54-15d3-48f8-8ec8-9ebfe5a20f5d
function desactivar_lineas_guias()
	#Cuando pases el mouse ya no aparecen las lineas de cada coordenada
	N = 50
	trace = mesh3d(x=(30 .* randn(N)),
	                   y=(25 .* randn(N)),
	                   z=(30 .* randn(N)),
	                   opacity=0.5)
	layout = Layout(scene=attr( xaxis_showspikes=false,
	                        	yaxis_showspikes=false))
	
	plot(trace, layout)

end

# ╔═╡ bb1cc23d-e78a-47a9-8fdf-c9c27b360eb4
md" ## Diagramas de dispersión 3D"

# ╔═╡ cbf2482d-a9e5-461b-9b90-c8f7264db066
md""" Utilizaremos el siguiente Dataset para trabajar los diagramas de dispersión"""

# ╔═╡ 397c003b-443c-496a-ab26-8205fa9810d8
RDatasets.datasets()

# ╔═╡ f3aacfd9-5619-44c5-9d22-29f614e30c44
md"""
Este gráfico permite explorar las relaciones tridimensionales entre las variables, mientras utiliza tamaños y colores para proporcionar información adicional y destacar patrones en los datos.

1. **Datos (`RDatasets.dataset`)**:  
   Se utiliza el conjunto de datos `iris`, que contiene información sobre características de flores, como longitud y anchura del sépalo y pétalo, además de su especie.

2. **Visualización del gráfico (`plot`)**:  
   - **Ejes:**  
     - `x`: Representa la longitud del sépalo (`SepalLength`).  
     - `y`: Representa la anchura del sépalo (`SepalWidth`).  
     - `z`: Representa la anchura del pétalo (`PetalWidth`).  
   - **Color (`color`)**: Los puntos se colorean según la especie de la flor (`Species`).  
   - **Tipo (`type`)**: Se especifica como `scatter3d` para crear un diagrama de dispersión en tres dimensiones.  
   - **Modo (`mode`)**: Establecido en `markers`, representa los datos como puntos.  
   - **Tamaño del marcador (`marker_size`)**: El tamaño de los marcadores varía en función de la longitud del pétalo (`PetalLength`).  
   - **Referencia del tamaño (`marker_sizeref`)**: Controla la escala de los marcadores, ajustando su tamaño con un factor de referencia (`0.3`).

3. **Configuración del diseño (`Layout`)**:  
   - **Márgenes (`margin`)**: Se configuran para eliminar márgenes en los bordes del gráfico, creando una visualización más limpia.
"""


# ╔═╡ 7ae8115d-ee63-4bfb-b5c7-0158fe9bdcbd
function estilos_de_dispersion()
	df = RDatasets.dataset("datasets", "iris")
	plot(
	    df, Layout(margin=attr(l=0, r=0, b=0, t=0)),
	    x=:SepalLength, y=:SepalWidth, z=:PetalWidth, color=:Species,
	    type="scatter3d", mode="markers",
	    marker_size=:PetalLength, marker_sizeref=0.3, render_mode="SVG"
	)
end

# ╔═╡ 9709ada1-6988-4dac-bdde-3e5ff51a637d
estilos_de_dispersion()

# ╔═╡ 61e579c7-ad7a-4e1b-816f-01aed41b435b
md"""
generamos un gráfico tridimensional de una hélice utilizando una escala de colores para representar el valor de una variable.

1. **Ecuación de la hélice:**  
   Se define una serie de puntos en una hélice mediante las siguientes ecuaciones paramétricas:  
   - `x = cos(t)`  
   - `y = sin(t)`  
   - `z = t`  
   Aquí, `t` es un rango que varía de 0 a 20, dividido en 100 puntos.

2. **Visualización (`scatter`)**:  
   - **Coordenadas:**  
     - `x`, `y`, `z` corresponden a las posiciones tridimensionales de los puntos en la hélice.  
   - **Estilo de los marcadores (`marker`)**:  
     - `size`: Tamaño de los puntos, establecido en 12.  
     - `color`: El color de los puntos se basa en los valores de `t`.  
     - `colorscale`: La escala de colores utilizada es `Viridis`, que pasa gradualmente de colores oscuros a claros, representando variaciones en el valor de `t`.  
     - `opacity`: Los puntos tienen una transparencia del 80% para una mejor visualización.
"""


# ╔═╡ a4e2f5dd-84b6-4a7e-847e-dfdbfc95e7fd
function escalas_de_color()

	# Helix equation
	t = range(0, stop=20, length=100)
	
	plot(scatter(
	    x=cos.(t),
	    y=sin.(t),
	    z=t,
	    mode="markers",
	    marker=attr(
	        size=12,
	        color=t,                # set color to an array/list of desired values
	        colorscale="Viridis",   # choose a colorscale
	        opacity=0.8
	    ),
	    type="scatter3d", render_mode="SVG",
	), Layout(margin=attr(l=0, r=0, b=0, t=0)))
end

# ╔═╡ bccfd0e8-b733-46cc-98cf-5b4496475bc3
escalas_de_color()

# ╔═╡ 5bd05184-674e-44f0-b9fc-326767f9fed9
md" ## Graficos de superficie 3D "

# ╔═╡ 0edd3565-77b7-44a6-8019-6589e2ae0eab
md"""
Este código genera una visualización tridimensional de una superficie topográfica utilizando datos de elevación.

1. **Carga de datos (`CSV.File` y `DataFrame`)**:  
   - Los datos se obtienen desde un archivo CSV alojado en un repositorio en línea. Este archivo contiene una matriz de valores de elevación de una región específica.  
   - Se convierte el archivo en un `DataFrame` y luego en una matriz de tipo `Float64` para facilitar su uso como datos de la superficie.

2. **Superficie 3D (`surface`)**:  
   - El comando `surface` utiliza la matriz de elevación (`z_data`) para generar una superficie tridimensional.  
   - Los valores de la matriz se interpretan como las alturas en el eje $z$, mientras que los índices de fila y columna de la matriz definen las coordenadas $x$ y $y$.

3. **Configuración del diseño (`Layout`)**:  
   - **Tamaño fijo (`autosize=false`)**: El tamaño del gráfico se define manualmente mediante `width` y `height`.  
"""


# ╔═╡ 1fa3f48a-7691-4588-aefa-311b60ef2284
function superficie_topografica_3D()
	# Leer los datos de un archivo CSV
	df = CSV.File(
	    HTTP.get("https://raw.githubusercontent.com/plotly/datasets/master/api_docs/mt_bruno_elevation.csv").body
	) |> DataFrame
	# Escribir los datos del eje Z
	z_data = Matrix{Float64}(df)

	# Diseño
	layout = Layout(
	    title="Mt Bruno Elevation",
	    autosize=false,
	    width=500,
	    height=500,
	    margin=attr(l=65, r=50, b=65, t=90)
	)
	plot(surface(z=z_data), layout)
end

# ╔═╡ fb8cbed0-aae3-43d2-aca5-c65d1ebc0370
superficie_topografica_3D()

# ╔═╡ 26d2837b-7af2-408e-a4a6-c1f458117c61
md"""
Este código combina un gráfico tridimensional de superficie con un contorno proyectado en el eje $z$, permitiendo una visualización detallada de los datos topográficos.

1. **Carga de datos (`CSV.File` y `DataFrame`)**:  
   - Los datos de elevación se obtienen desde un archivo CSV en línea.  
   - Estos datos se convierten en una matriz de tipo `Float64` (`z_data`) para ser usados en la visualización.

2. **Superficie tridimensional con contornos (`surface` y `contours_z`)**:  
   - El comando `surface` genera una superficie tridimensional basada en los valores de $z_{data}$.  
   - Se habilitan contornos en el eje $z$ mediante el atributo `contours_z`, que incluye:  
     - `show=true`: Activa la visualización de los contornos.  
     - `usecolormap=true`: Aplica el mapa de colores de la superficie a los contornos.  
     - `highlightcolor="limegreen"`: Resalta los contornos con color verde lima.  
     - `project_z=true`: Proyecta los contornos sobre el plano del eje $z$, facilitando la lectura de las variaciones de altura.

3. **Configuración del diseño (`Layout`)**:  
   - **Título (`title`)**: "Mt Bruno Elevation".  
   - **Cámara (`scene_camera_eye`)**: Define la posición de la cámara para una vista personalizada, con coordenadas en $x$, $y$ y $z$.  
   - **Tamaño (`autosize=false`)**: Se configura manualmente el ancho y alto del gráfico.  
   - **Márgenes (`margin`)**: Ajustados para optimizar la visualización.

"""


# ╔═╡ 834737d1-7a11-46fb-ace9-c00fefc1bd74
function grafico_de_contorno_con_superficie()
    # Leer datos desde un archivo CSV alojado en un repositorio en línea
    df = CSV.File(
        HTTP.get("https://raw.githubusercontent.com/plotly/datasets/master/api_docs/mt_bruno_elevation.csv").body
    ) |> DataFrame  # Convierte los datos descargados en un DataFrame

    # Transforma los datos en una matriz y transpónela para ajustarse a las necesidades del gráfico
    z_data = Matrix{Float64}(df)'

    # Configura el diseño del gráfico
    layout = Layout(
        title="Mt Bruno Elevation",  # Título del gráfico
        autosize=false,              # Desactiva el ajuste automático del tamaño
        scene_camera_eye=attr(       # Define la posición de la cámara para la vista 3D
            x=1.87, y=0.88, z=-0.64  # Coordenadas de la cámara
        ),
        width=500, height=500,       # Tamaño del gráfico en píxeles
        margin=attr(                 # Configuración de márgenes
            l=65, r=50, b=65, t=90   # Izquierda, derecha, abajo, arriba
        )
    )

    # Genera el gráfico de superficie con líneas de contorno en el eje Z
    plot(
        surface(
            z=z_data,               # Datos para la superficie (matriz z)
            contours_z=attr(        # Configuración de los contornos en el eje Z
                show=true,          # Muestra las líneas de contorno
                usecolormap=true,   # Usa el mismo mapa de colores que la superficie
                highlightcolor="limegreen",  # Color para resaltar las líneas de contorno
                project_z=true      # Proyecta las líneas de contorno en el plano Z
            )
        ),
        layout                      # Aplica el diseño definido
    )
end


# ╔═╡ b8486cd0-e7d2-47e5-9545-7457e1ca2dde
grafico_de_contorno_con_superficie()

# ╔═╡ 6e030f56-c4c1-4725-b32f-644ca69b1855
md"""
Este código genera un gráfico tridimensional que combina una superficie con contornos personalizados en los ejes $x$ y $z$, utilizando configuraciones detalladas para ajustar su apariencia y perspectiva.

1. **Superficie tridimensional (`surface`)**:  
   - **Datos ($z$):** Se utiliza una matriz de valores de 5x5 que alternan entre 0 y 1, formando un patrón de tablero de ajedrez.  
   - **Ejes $x$ y $y$:** Representados por los rangos `1:5`.  

2. **Configuración de contornos (`contours`)**:  
   - **Eje $x$:**  
     - `show=true`: Activa los contornos en el eje $x$.  
     - `start=1.5`: Define el valor inicial de los contornos.  
     - `size=0.04`: Especifica el espaciado entre los contornos.  
     - `color="white"`: Establece el color de los contornos como blanco.  
     - `x_end=2`: Define el límite superior de los contornos en el eje $x$.  
   - **Eje $z$:**  
     - `show=true`: Activa los contornos en el eje $z$.  
     - `start=0.5`: Define el valor inicial de los contornos.  
     - `size=0.05`: Establece el espaciado entre los contornos.  
     - `z_end=0.8`: Define el límite superior de los contornos en el eje $z$.

3. **Configuración del diseño (`Layout`)**:  
   - **Ejes:**  
     - `xaxis_nticks=20`: Incrementa el número de divisiones visibles en el eje $x$.  
     - `zaxis_nticks=4`: Reduce el número de divisiones en el eje $z$ para simplificar la visualización.  
   - **Cámara (`camera_eye`)**: Establece la posición de la cámara en $(x=0, y=-1, z=0.5)$, ofreciendo una vista ligeramente inclinada.  
   - **Relación de aspecto (`aspectratio`)**: Ajusta las proporciones entre los ejes $x$, $y$ y $z$, donde $z$ es comprimido a un 20% de las dimensiones de $x$ y $y$.
"""


# ╔═╡ 45528953-c028-4a15-a447-bf35cf0e75f1
function configurar_grafico_contorno_con_superficie()
    plot(
        # Configura la superficie con contornos personalizados
        surface(
            contours=attr(
                # Configuración de contornos en el eje X
                x=attr(
                    show=true,     # Muestra los contornos en el eje X
                    start=1.5,     # Valor inicial de los contornos en el eje X
                    size=0.04,     # Espaciado entre los contornos en el eje X
                    color="white"  # Color de las líneas de contorno en el eje X
                ),
                x_end=2,           # Valor final de los contornos en el eje X
                # Configuración de contornos en el eje Z
                z=attr(
                    show=true,     # Muestra los contornos en el eje Z
                    start=0.5,     # Valor inicial de los contornos en el eje Z
                    size=0.05      # Espaciado entre los contornos en el eje Z
                ),
                z_end=0.8          # Valor final de los contornos en el eje Z
            ),
            # Coordenadas de la superficie
            x=1:5,                 # Rango de valores para el eje X
            y=1:5,                 # Rango de valores para el eje Y
            z=[                    # Matriz de valores para el eje Z
                [0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0]
            ]
        ),
        # Configura el diseño del gráfico
        Layout(
            scene=attr(
                xaxis_nticks=20,         # Número de marcas en el eje X
                zaxis_nticks=4,          # Número de marcas en el eje Z
                camera_eye=attr(         # Configuración de la posición de la cámara
                    x=0, y=-1, z=0.5     # Coordenadas de la cámara
                ),
                aspectratio=attr(        # Relación de aspecto de la gráfica
                    x=1, y=1, z=0.2      # Proporción entre los ejes
                )
            )
        )
    )
end


# ╔═╡ d4afb800-050d-4811-8a4a-7a6ad6a98ed5
configurar_grafico_contorno_con_superficie()

# ╔═╡ 4d1b6a34-663c-4a7e-b2b2-94301ce8324c
md"""
Este código genera una visualización tridimensional que superpone múltiples superficies para mostrar variaciones en los datos de altura.

1. **Datos de la superficie ($z1$):**  
   - La matriz $z1$ contiene valores de elevación, que se utilizan para definir la primera superficie ($trace1$).  

2. **Superficies adicionales ($trace2$ y $trace3$):**  
   - **$trace2$:**  
     - Se crea restando 1 a cada elemento de $z1$, desplazando la superficie hacia abajo.  
     - `showscale=false`: Oculta la barra de escala de colores para esta superficie.  
     - `opacity=0.9`: Ajusta la transparencia de la superficie.  
   - **$trace3$:**  
     - Se crea sumando 1 a cada elemento de $z1$, desplazando la superficie hacia arriba.  
     - Similar a $trace2$, no muestra escala de colores y tiene transparencia ajustada.  

3. **Visualización combinada (`plot`)**:  
   - Las tres superficies ($trace1$, $trace2$, $trace3$) se superponen en un mismo gráfico tridimensional para comparar sus posiciones relativas.  
   - La transparencia permite ver las superficies superpuestas sin obstrucciones visuales.
"""


# ╔═╡ bca92e01-66df-490d-b848-e07f2c02c094
function multiples_superficies()
	z1 = [
	    [8.83,8.89,8.81,8.87,8.9,8.87],
	    [8.89,8.94,8.85,8.94,8.96,8.92],
	    [8.84,8.9,8.82,8.92,8.93,8.91],
	    [8.79,8.85,8.79,8.9,8.94,8.92],
	    [8.79,8.88,8.81,8.9,8.95,8.92],
	    [8.8,8.82,8.78,8.91,8.94,8.92],
	    [8.75,8.78,8.77,8.91,8.95,8.92],
	    [8.8,8.8,8.77,8.91,8.95,8.94],
	    [8.74,8.81,8.76,8.93,8.98,8.99],
	    [8.89,8.99,8.92,9.1,9.13,9.11],
	    [8.97,8.97,8.91,9.09,9.11,9.11],
	    [9.04,9.08,9.05,9.25,9.28,9.27],
	    [9,9.01,9,9.2,9.23,9.2],
	    [8.99,8.99,8.98,9.18,9.2,9.19],
	    [8.93,8.97,8.97,9.18,9.2,9.18]
	]
	
	trace1 = surface(z=z1)
	trace2 = surface(z=map(z -> z .- 1, z1), showscale=false, opacity=0.9)
	trace3 = surface(z=map(z -> z .+ 1, z1), showscale=false, opacity=0.9)
	
	plot([trace1, trace2, trace3])
end

# ╔═╡ 75d9cb12-5a5e-4890-af6e-c2b0c00ab072
multiples_superficies()

# ╔═╡ c5913ad9-15a6-489e-8ab2-28b5384f07d7
md"""
Este código genera una visualización tridimensional de una ciclide de anillo (ring cyclide) con dos superficies en subgráficos que utilizan diferentes criterios para asignar colores.

1. **Definición de la ciclide de anillo ($x$, $y$, $z$):**  
   - La ciclide se define mediante ecuaciones paramétricas dependientes de los parámetros $u$ y $v$, generados a partir del rango $[0, 2\pi]$.  
   - Las variables $x$, $y$, $z$ son calculadas utilizando las constantes $a$, $b$, $c$, y $d$, que controlan la forma de la ciclide.

2. **Subgráficos (`make_subplots`):**  
   - Se crean dos subgráficos tridimensionales en una fila y dos columnas.  
   - Cada subgráfico es un `scene`, configurado para mostrar una superficie con criterios diferentes de coloración.

3. **Superficies y coloración (`surface`):**  
   - **Subgráfico 1:**  
     - El color de la superficie corresponde directamente a los valores de $z$.  
     - Incluye una barra de colores ajustada en la posición $x=-0.07$.  
   - **Subgráfico 2:**  
     - El color se asigna en función de la distancia al origen, calculada como $x^2 + y^2 + z^2$ para cada punto de la superficie.  

4. **Configuración del diseño (`relayout!`):**  
   - Se establece un título general para el gráfico: "Ring cyclide".  
   - Los subgráficos reciben títulos individuales para describir el criterio de coloración:  
     - "Color corresponds to z".  
     - "Color corresponds to distance to origin".
"""


# ╔═╡ fe67789b-6aca-4519-a4dc-e0718487ab39
function ajuste_de_color_de_superficie()
	a, b, d = 1.32, 1., 0.8
	c = a^2 - b^2
	dom = range(0, stop=2π, length=100)
	u = dom' .* ones(100)
	v = ones(100)' .* dom
	
	x = @. (d * (c - a * cos(u) * cos(v)) + b^2 * cos(u)) / (a - c * cos(u) * cos(v))
	y = @. b * sin(u) * (a - d*cos(v)) / (a - c * cos(u) * cos(v))
	z = @. b * sin(v) * (c*cos(u) - d) / (a - c * cos(u) * cos(v))
	
	p = make_subplots(
	    rows=1, cols=2,
	    specs=[Spec(kind="scene") Spec(kind="scene")],
	    subplot_titles=["Color correspondiente a z"  "Color correspondiente a la distancia al origen"]
	)
	add_trace!(p, surface(x=x, y=y, z=z, colorbar_x=-0.07), row=1, col=1)
	add_trace!(p, surface(x=x, y=y, z=z, surfacecolor=@. x^2 + y^2 + z^2), row=1, col=2)
	relayout!(p, title_text="Anillo ciclide")
	p
end

# ╔═╡ 8cf22eaa-1093-428a-902d-2a73c72bc9ee
ajuste_de_color_de_superficie()

# ╔═╡ f89f985a-814d-4dfb-a369-b07104cc64fe
md" ## Graficos de burbuja en 3D "

# ╔═╡ 7e3ff9cf-625b-4a6d-94d4-90eb9cd73b23
md"""
Este código genera un gráfico tridimensional tipo burbuja que visualiza relaciones entre variables demográficas, económicas y de esperanza de vida.

1. **Carga de datos (`CSV.File` y `DataFrame`)**:  
   - Los datos se obtienen desde un archivo CSV en línea y se convierten a un `DataFrame`.  
   - El subconjunto de datos se selecciona con el rango `start=750` y `stop=1500`.

2. **Gráfico tridimensional tipo burbuja (`scatter3d`)**:  
   - **Ejes:**  
     -  $x$: Años (`year`), representando el tiempo.  
     -  $y$: Continentes (`continent`), categorizando los datos por región.  
     -  $z$: Población (`pop`), representando la magnitud poblacional.  
   - **Texto (`text`)**: Muestra los nombres de los países (`country`) al pasar el cursor sobre los puntos.  
   - **Marcadores (`marker`)**:  
     - **Tamaño (`size`)**: Determinado por el PIB per cápita (`gdpPercap`).  
     - **Color (`color`)**: Basado en la esperanza de vida (`lifeExp`), con una escala de colores `Viridis`.  
     - **Colorbar:** Incluye una barra de colores con el título "Life<br>Expectancy".  
     - **Estilo:** Las burbujas tienen un borde de color `rgb(140,140,170)`.

3. **Configuración del diseño (`Layout`)**:  
   - **Tamaño:** El gráfico tiene un ancho y alto de 800 píxeles.  
   - **Título:** "Examining Population and Life Expectancy Over Time", indicando el propósito del gráfico.
"""


# ╔═╡ 75e90e24-a86d-4025-9631-126c6fe9ccfb
function graficos_burbuja()
	df = CSV.File(
	    HTTP.get("https://raw.githubusercontent.com/plotly/datasets/master/gapminderDataFiveYear.csv").body
	) |> DataFrame
	
	start = 750
	stop = 1500
	
	trace = scatter3d(
	    x=df[!, "year"][start:stop],
	    y=df[!, "continent"][start:stop],
	    z=df[!, "pop"][start:stop],
	    text=df[!, "country"][start:stop],
	    mode="markers",
		render_mode="SVG",
	    marker=attr(
	        sizemode="diameter",
	        sizeref=750,
	        size=df[!, "gdpPercap"][start:stop],
	        color=df[!, "lifeExp"][start:stop],
	        colorscale="Viridis",
	        colorbar_title="Life<br>Expectancy",
	        line_color="rgb(140,140,170)"
	    )
	)
	
	layout = Layout(height=800, width=800, title="Examining Population and Life Expectancy Over Time")
	
	plot(trace, layout)
end

# ╔═╡ 555958a4-082e-4bc1-a4b9-10c520156adb
graficos_burbuja()

# ╔═╡ 75f9f409-7027-4294-aa00-e89509ad1ecf
md"""
Este código genera un gráfico tridimensional tipo burbuja que visualiza las características de los planetas del sistema solar, dimensionando las burbujas según su diámetro.

1. **Datos de los planetas:**  
   - **`planets`**: Lista de nombres de los planetas, incluyendo a Plutón.  
   - **`planet_colors`**: Colores asignados a cada planeta para diferenciarlos visualmente.  
   - **`distance_from_sun`**: Distancia promedio de cada planeta al Sol (en millones de kilómetros).  
   - **`density`**: Densidad de los planetas (en kg/m³).  
   - **`gravity`**: Gravedad superficial de cada planeta (en m/s²).  
   - **`planet_diameter`**: Diámetro de los planetas (en kilómetros), utilizado para dimensionar las burbujas.

2. **Gráfico tridimensional tipo burbuja (`scatter3d`)**:  
   - **Ejes:**  
     -  $x$: Distancia del Sol (`distance_from_sun`).  
     -  $y$: Densidad (`density`).  
     -  $z$: Gravedad superficial (`gravity`).  
   - **Texto (`text`)**: Muestra el nombre de los planetas al pasar el cursor sobre las burbujas.  
   - **Marcadores (`marker`)**:  
     - **Tamaño (`size`)**: Basado en el diámetro de los planetas (`planet_diameter`).  
     - **Color (`color`)**: Asignado según `planet_colors` para identificar cada planeta.  
     - **`sizeref`**: Ajusta la escala de las burbujas para mantener una proporción visual adecuada.

3. **Configuración del diseño (`Layout`)**:  
   - **Título:** "Planets!", para indicar que el gráfico representa planetas del sistema solar.  
   - **Ejes:**  
     - Cada eje tiene un título específico:  
       -  $x$: "Distance from Sun".  
       -  $y$: "Density".  
       -  $z$: "Gravity".  
     - Los títulos tienen una fuente de color blanco para contraste.  
   - **Fondo de la escena:** Establecido en un color oscuro ("rgb(20, 24, 54)") para resaltar las burbujas.

"""


# ╔═╡ d9f14030-c3ca-4364-9974-0d8b546d7285
function graficos_burbuja_por_tamaño_en_variable()
	planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"]
	planet_colors = ["rgb(135, 135, 125)", "rgb(210, 50, 0)", "rgb(50, 90, 255)",
	                 "rgb(178, 0, 0)", "rgb(235, 235, 210)", "rgb(235, 205, 130)",
	                 "rgb(55, 255, 217)", "rgb(38, 0, 171)", "rgb(255, 255, 255)"]
	distance_from_sun = [57.9, 108.2, 149.6, 227.9, 778.6, 1433.5, 2872.5, 4495.1, 5906.4]
	density = [5427, 5243, 5514, 3933, 1326, 687, 1271, 1638, 2095]
	gravity = [3.7, 8.9, 9.8, 3.7, 23.1, 9.0, 8.7, 11.0, 0.7]
	planet_diameter = [4879, 12104, 12756, 6792, 142984, 120536, 51118, 49528, 2370]
	
	# Create trace, sizing bubbles by planet diameter
	trace = scatter3d(
	    x = distance_from_sun,
	    y = density,
	    z = gravity,
	    text = planets,
		render_mode="SVG",
	    mode = "markers",
	    marker = attr(
	        sizemode = "diameter",
	        sizeref = 750, # info on sizeref: https://plotly.com/julia/reference/scatter/#scatter-marker-sizeref
	        size = planet_diameter,
	        color = planet_colors,
	        )
	)
	
	layout = Layout(
	    width=800,
	    height=800,
	    title = "Planets!",
	    scene = attr(
	        xaxis=attr(
	            title="Distance from Sun",
	            titlefont_color="white"
	        ),
	        yaxis=attr(
	            title="Density",
	            titlefont_color="white"
	        ),
	        zaxis=attr(
	            title="Gravity",
	            titlefont_color="white"
	        ),
	        bgcolor = "rgb(20, 24, 54)"
	    )
	)
	
	plot(trace, layout)
end

# ╔═╡ 8685b784-64c6-41d0-a4cc-3a7433a89c6b
graficos_burbuja_por_tamaño_en_variable()

# ╔═╡ b26e7eed-ff03-4d96-aa3f-f3e17bb66efb
md" ## Graficos de lineas 3D "

# ╔═╡ aca12e6a-3133-4489-a02e-b9bf39ed254a
md"""
Este código genera un gráfico tridimensional de líneas múltiples que representa la evolución del PIB per cápita, la población y el tiempo para los países de Europa.

1. **Carga de datos (`CSV.File` y `DataFrame`)**:  
   - Los datos provienen del archivo Gapminder y se descargan desde un repositorio en línea.  
   - El archivo se carga como un `DataFrame` y se filtran únicamente las filas correspondientes al continente europeo utilizando `df[df.continent .== "Europe", :]`.

2. **Gráfico tridimensional de líneas (`scatter3d`)**:  
   - **Ejes:**  
     -  $x$: PIB per cápita (`gdpPercap`), que muestra el crecimiento económico.  
     -  $y$: Población (`pop`), que refleja la magnitud poblacional.  
     -  $z$: Año (`year`), que representa la dimensión temporal.  
   - **Tipo (`type`)**: Se especifica como `scatter3d` para crear un gráfico tridimensional.  
   - **Modo (`mode`)**: Establecido en `"lines"`, conecta los puntos correspondientes a cada país con líneas, mostrando tendencias a lo largo del tiempo.  
   - **Color (`color`)**: Se utiliza la columna `country` para asignar un color único a las líneas de cada país, facilitando su identificación.

3. **Configuración implícita**:  
   - El diseño y los ejes utilizan configuraciones predeterminadas.
"""


# ╔═╡ f148a185-11a2-4feb-9f3c-d762523b1ed3
function multiples_lineas()
	url = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv"

	# Descargar y cargar el archivo como DataFrame
	df = CSV.File(HTTP.get(url).body) |> DataFrame
	df_europe = df[df.continent .== "Europe", :]

	plot(df_europe, x=:gdpPercap, y=:pop, z=:year, type="scatter3d", render_mode="SVG", mode="lines", color=:country)
end

# ╔═╡ d660047c-ccc4-4d8b-912e-c1efe0f40900
multiples_lineas()

# ╔═╡ 37605c7a-cce3-4b21-8273-11988a5ce9b0
md"""
Este código genera un gráfico tridimensional que visualiza un movimiento browniano en dos dimensiones, representado con componentes $y$ y $z$ que evolucionan a lo largo del tiempo.

1. **Generación de datos:**  
   - **Fechas (`dates`)**: Se crea un rango de fechas desde el 1 de enero de 2012 hasta el 22 de febrero de 2013.  
   - **Parámetros del movimiento browniano:**  
     - Tiempo total ($T$): Calculado como la diferencia en años entre la fecha inicial y la final.  
     - Número de pasos ($N$): Corresponde al número de días en el rango de fechas.  
     - Precio inicial (`start_price`): Establecido en 100.  
     - Componentes $y$ y $z$: Generados usando la función `brownian_motion`, con $\sigma=0.1$ para la volatilidad y $S_0=100$ como valor inicial.

2. **Gráfico tridimensional (`scatter3d`)**:  
   - **Ejes:**  
     -  $x$: Fechas (`dates`), que representan el tiempo.  
     -  $y$: Primer componente del movimiento browniano.  
     -  $z$: Segundo componente del movimiento browniano.  
   - **Marcadores (`marker`)**:  
     -  Tamaño: Configurado en 4.  
     -  Color: Basado en los valores de $z$, con la escala de colores `Viridis`.  
   - **Línea (`line`)**:  
     -  Color: Azul oscuro (`darkblue`).  
     -  Ancho: Configurado en 2.  
   - **Modo (`mode`)**: Combina líneas y marcadores con `"lines+markers"`.

3. **Configuración del diseño (`Layout`)**:  
   -  **Dimensiones:** Ancho de 800 y alto de 700 píxeles.  
   -  **Cámara (`camera`)**:  
     -  Dirección "arriba" (`up`): Configurada en $(x=0, y=0, z=1)$.  
     -  Posición del ojo (`eye`): Establecida en $(x=0, y=1.0707, z=1)$ para una vista inclinada.  
   -  **Relación de aspecto (`aspectratio`)**: Definida manualmente como $x=1$, $y=1$, $z=0.7$.
"""


# ╔═╡ 767d67de-e17d-4a70-91d1-daffa68d184c
function brownian_motion(T=1, N=100; sigma=0.01, S0=20, mu=0.1)
    dt = float(T)/(N-1)
    t = 0:dt:T
    W = randn(N)
    W = cumsum(W) .* sqrt(dt) # standard brownian motion
    X = @. (mu-0.5*sigma^2) * t + sigma * W
    S0.*exp.(X) # geometric brownian motion
end

# ╔═╡ 5bcace46-8fae-4218-9be4-2d662838aa86
function graficar_movimiento_browniano()
	dates = Date(2012,1,1):Day(1):Date(2013,2,22)
	
	T = Dates.value((extrema(dates)[2]-extrema(dates)[1])) / 365
	N = size(dates)[1]
	start_price = 100
	y = brownian_motion(T, N, sigma=0.1, S0=start_price)
	z = brownian_motion(T, N, sigma=0.1, S0=start_price)
	
	layout = Layout(
	    width=800,
	    height=700,
	    autosize=false,
	    scene=attr(
	        camera=attr(
	            up=attr(x=0, y=0, z=1),
	            eye=attr(x=0, y=1.0707, z=1)
	        ),
	        aspectratio=attr(x=1, y=1, z=0.7),
	        aspectmode="manual",
	    )
	)
	plot(scatter(
	    x=dates,
	    y=y,
	    z=z,
	    marker=attr(size=4, color=z, colorscale="Viridis"),
	    line=attr(color="darkblue", width=2),
	    type="scatter3d",
		render_mode="SVG",
	    mode="lines+markers"
	), layout)
end

# ╔═╡ d64cf025-f79c-4444-a23c-769a09b64725
graficar_movimiento_browniano()

# ╔═╡ f754178a-95dc-4aed-b593-b8c32d1d3011
md" ## Graficos de volumen 3D "

# ╔═╡ f0fbf0c3-b7e0-4acf-85a0-d5d98b2bf5d0
md"""
Este código genera un gráfico tridimensional que representa un volumen en forma de isosuperficies basadas en los valores de una función.

1. **Creación de la malla 3D:**  
   - **`data`**: Se define un rango uniforme de valores entre $-5$ y $5$, con 40 divisiones.  
   - **`create_grid(data)`**: Genera una malla tridimensional (coordenadas $X$, $Y$, $Z$) a partir de `data`.

2. **Definición del volumen (`values`)**:  
   - **Función del volumen**:  
     $$values = X^2 + Y^2 + Z^2$$  
     - Cada punto en la malla 3D evalúa esta función, resultando en un conjunto de valores que define la densidad o magnitud del volumen.

3. **Gráfico de isosuperficies (`isosurface`)**:  
   - **Isosuperficies:**  
     - Representan superficies tridimensionales que conectan puntos con un valor constante de `values`.  
     - **`isomin=20`** y **`isomax=80`**: Determinan los valores mínimo y máximo de las isosuperficies que se mostrarán.  
   - **Transparencia:**  
     - **`opacity=0.6`**: Configura la opacidad al 60%, permitiendo observar las superficies superpuestas.  
   - **Escala de colores (`colorscale`)**:  
     - Utiliza la escala "YlOrRd" (amarillo a rojo), donde los colores indican la magnitud de los valores en las superficies.

4. **Visualización del gráfico (`plot`)**:  
   - Se genera un gráfico interactivo que permite explorar las isosuperficies dentro del volumen tridimensional.
"""

# ╔═╡ 799424c7-140a-49df-b5b3-8bb97c1eb7ac
function create_grid(data)
    # Crear la grilla 3D para X, Y, Z
    X = [x for x in data, y in data, z in data]
    Y = [y for x in data, y in data, z in data]
    Z = [z for x in data, y in data, z in data]
    return reshape(X, (length(data), length(data), length(data))),
           reshape(Y, (length(data), length(data), length(data))),
           reshape(Z, (length(data), length(data), length(data)))
end


# ╔═╡ 2817c6e0-9581-4794-ac1e-97bad048c152
begin
    # Crear un rango y una malla 3D
    data = LinRange(-5, 5, 40)
    X, Y, Z = create_grid(data)

    # Función que define el volumen
    values = X .^ 2 + Y .^ 2 + Z .^ 2

    # Graficar el volumen como isosuperficies
    plot(isosurface(
        x = X[:],
        y = Y[:],
        z = Z[:],
        value = values[:],
        isomin = 20,
        isomax = 80,
        opacity = 0.6,
        colorscale = "YlOrRd"
    ))
end


# ╔═╡ 123f9573-2f40-4e48-93a4-313b7f938ae6
md""" # Referencias
- https://plotly.com/julia/3d-charts/
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
PlutoPlotly = "8e989ff0-3d88-8e9f-f020-2b208a939ff0"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
RDatasets = "ce6b1742-4840-55fa-b093-852dadbb1d8b"

[compat]
CSV = "~0.10.14"
DataFrames = "~1.7.0"
HTTP = "~1.10.15"
PlutoPlotly = "~0.6.2"
PlutoUI = "~0.7.60"
RDatasets = "~0.7.7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.0"
manifest_format = "2.0"
project_hash = "bcb5ee0430e2ae490a54720563ec776f1a79d675"

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

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "6c834533dc1fabd820c1db03c839bf97e45a3fab"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.14"

[[deps.CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "1568b28f91293458345dabba6a5ea3f183250a61"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.8"

    [deps.CategoricalArrays.extensions]
    CategoricalArraysJSONExt = "JSON"
    CategoricalArraysRecipesBaseExt = "RecipesBase"
    CategoricalArraysSentinelArraysExt = "SentinelArrays"
    CategoricalArraysStructTypesExt = "StructTypes"

    [deps.CategoricalArrays.weakdeps]
    JSON = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    SentinelArrays = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
    StructTypes = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"

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

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "362a287c3aa50601b0bc359053d5c2468f0e7ce0"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.11"

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

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "f36e5e8fdffcb5646ea5da81495a5a7566005127"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.3"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "fb61b4812c49343d7ef0b533ba982c46021938a6"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.7.0"

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

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.ExprTools]]
git-tree-sha1 = "27415f162e6028e81c72b82ef756bf321213b6ec"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.10"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "2dd20384bf8c6d411b5c7370865b1e9b26cb2ea3"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.6"
weakdeps = ["HTTP"]

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates"]
git-tree-sha1 = "7878ff7172a8e6beedd1dea14bd27c3c6340d361"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.22"
weakdeps = ["Mmap", "Test"]

    [deps.FilePathsBase.extensions]
    FilePathsBaseMmapExt = "Mmap"
    FilePathsBaseTestExt = "Test"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "c67b33b085f6e2faf8bf79a61962e7339a81129c"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.15"

[[deps.HashArrayMappedTries]]
git-tree-sha1 = "2eaa69a7cab70a52b9687c8bf950a5a93ec895ae"
uuid = "076d061b-32b6-4027-95e0-9a2c6f6d7e74"
version = "0.2.0"

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

[[deps.InlineStrings]]
git-tree-sha1 = "45521d31238e87ee9f9732561bfee12d4eebd52d"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.2"

    [deps.InlineStrings.extensions]
    ArrowTypesExt = "ArrowTypes"
    ParsersExt = "Parsers"

    [deps.InlineStrings.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"
    Parsers = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.InvertedIndices]]
git-tree-sha1 = "0dc7b50b8d436461be01300fd8cd45aa0274b038"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

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

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

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

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f02b56007b064fbfddb4c9cd60161b6dd0f40df3"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.1.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

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

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.Mocking]]
deps = ["Compat", "ExprTools"]
git-tree-sha1 = "2c140d60d7cb82badf06d8783800d0bcd1a7daa2"
uuid = "78c3b35d-d492-501b-9361-3d52fe80e533"
version = "0.8.1"

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

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "38cb508d080d21dc1128f7fb04f20387ed4c0af4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.3"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f58782a883ecbf9fb48dcd363f9ccd65f36c23a8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.15+2"

[[deps.OrderedCollections]]
git-tree-sha1 = "12f1439c4f986bb868acda6ea33ebc78e19b95ad"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.7.0"

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
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotlyBase]]
deps = ["ColorSchemes", "Dates", "DelimitedFiles", "DocStringExtensions", "JSON", "LaTeXStrings", "Logging", "Parameters", "Pkg", "REPL", "Requires", "Statistics", "UUIDs"]
git-tree-sha1 = "56baf69781fc5e61607c3e46227ab17f7040ffa2"
uuid = "a03496cd-edff-5a9b-9e67-9cda94a718b5"
version = "0.8.19"

[[deps.PlutoPlotly]]
deps = ["AbstractPlutoDingetjes", "Artifacts", "ColorSchemes", "Colors", "Dates", "Downloads", "HypertextLiteral", "InteractiveUtils", "LaTeXStrings", "Markdown", "Pkg", "PlotlyBase", "PrecompileTools", "Reexport", "ScopedValues", "Scratch", "TOML"]
git-tree-sha1 = "9ebe25fc4703d4112cc418834d5e4c9a4b29087d"
uuid = "8e989ff0-3d88-8e9f-f020-2b208a939ff0"
version = "0.6.2"

    [deps.PlutoPlotly.extensions]
    PlotlyKaleidoExt = "PlotlyKaleido"
    UnitfulExt = "Unitful"

    [deps.PlutoPlotly.weakdeps]
    PlotlyKaleido = "f2990250-8cf9-495f-b13a-cce12b45703c"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

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

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1101cd475833706e4d0e7b122218257178f48f34"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.RData]]
deps = ["CategoricalArrays", "CodecZlib", "DataFrames", "Dates", "FileIO", "Requires", "TimeZones", "Unicode"]
git-tree-sha1 = "19e47a495dfb7240eb44dc6971d660f7e4244a72"
uuid = "df47a6cb-8c03-5eed-afd8-b6050d6c41da"
version = "0.8.3"

[[deps.RDatasets]]
deps = ["CSV", "CodecZlib", "DataFrames", "FileIO", "Printf", "RData", "Reexport"]
git-tree-sha1 = "2720e6f6afb3e562ccb70a6b62f8f308ff810333"
uuid = "ce6b1742-4840-55fa-b093-852dadbb1d8b"
version = "0.7.7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

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

[[deps.ScopedValues]]
deps = ["HashArrayMappedTries", "Logging"]
git-tree-sha1 = "eef2fbac9538ee6cc60ee1489f028d2f8a1a5249"
uuid = "7e506255-f358-4e82-b7e4-beb19740aa63"
version = "1.2.1"

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

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a6b1675a536c5ad1a60e5a5153e1fee12eb146e3"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.4.0"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TZJData]]
deps = ["Artifacts"]
git-tree-sha1 = "006a327222dda856e2304959e566ff0104ac8594"
uuid = "dc5dba14-91b3-4cab-a142-028a31da12f7"
version = "1.3.1+2024b"

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

[[deps.TimeZones]]
deps = ["Artifacts", "Dates", "Downloads", "InlineStrings", "Mocking", "Printf", "Scratch", "TZJData", "Unicode", "p7zip_jll"]
git-tree-sha1 = "fcbcffdc11524d08523e92ae52214b29d90b50bb"
uuid = "f269a46b-ccf7-5d73-abea-4c690281aa53"
version = "1.20.0"

    [deps.TimeZones.extensions]
    TimeZonesRecipesBaseExt = "RecipesBase"

    [deps.TimeZones.weakdeps]
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"

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

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

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
# ╟─74758ce8-6c1b-42ac-9ac5-c0a0d0abb467
# ╟─33a31e78-78df-499a-9c85-b9b2bb4e9893
# ╠═281f3f67-2fad-4c2a-a8c9-05c78f6ab69c
# ╟─b52f1bcc-aa67-442f-91c9-3fb7e5ddde11
# ╟─54559454-9778-4d2c-a6f8-37db82b56ad8
# ╠═c95240e1-f604-4dfb-9388-82fb205f51b2
# ╟─c83f7c7d-50f8-4010-b575-43e4f55f64e2
# ╟─58872f21-43d2-4d51-914d-497822198835
# ╠═c0e77196-1eb5-4251-bbb3-4183bffb8022
# ╠═29fa6ff4-d5ad-4a93-ac53-f3b75bfb0ff2
# ╠═563e6ccd-487d-4b37-bf8e-45007eaa2f1b
# ╟─9e20fd0e-fd2a-40af-988f-4ce01f34632c
# ╠═6e77ebce-16bb-42a7-9200-3f327c7d3c47
# ╟─b939ee9c-4536-42c0-84e8-144339c64be8
# ╠═1563995e-df5d-4d41-ab77-d91063829e00
# ╠═e34f502e-89bf-49d1-bcf6-90105581b00b
# ╠═f19a25bc-51c4-4ec4-85a5-f4d0c82d6fbe
# ╟─f653842f-9116-4d5c-b329-cfb5afb473b5
# ╟─0ae1bdf5-3ec5-4664-89ba-c5e838771a0a
# ╟─599d6fd9-80de-43a4-9f4b-8d9aa44b9f40
# ╠═c3e9aa33-1f6b-4eda-aa5c-72ea374dc51f
# ╟─59ca341a-9815-4b6d-941f-d776c629e8c5
# ╠═d4957469-65ae-4099-bfc5-6d76f44bcd98
# ╟─f23636ed-97d3-4904-b5bd-5035161d31ee
# ╠═15b9a3db-e5cc-4304-a7bd-ac4d43e6e478
# ╟─95ae8278-2ab9-4c88-81ac-fdd6a933220a
# ╠═1018567b-0f79-49e4-805e-74c556e1f443
# ╟─d7955048-1829-47e2-ac76-fb0afa738b6a
# ╠═515d754e-b481-4b4d-9a78-e76a0e729db8
# ╟─c23135c6-be9e-4784-855a-78058a19e326
# ╠═33e19f54-15d3-48f8-8ec8-9ebfe5a20f5d
# ╟─bb1cc23d-e78a-47a9-8fdf-c9c27b360eb4
# ╟─cbf2482d-a9e5-461b-9b90-c8f7264db066
# ╠═397c003b-443c-496a-ab26-8205fa9810d8
# ╟─f3aacfd9-5619-44c5-9d22-29f614e30c44
# ╠═7ae8115d-ee63-4bfb-b5c7-0158fe9bdcbd
# ╠═9709ada1-6988-4dac-bdde-3e5ff51a637d
# ╟─61e579c7-ad7a-4e1b-816f-01aed41b435b
# ╠═a4e2f5dd-84b6-4a7e-847e-dfdbfc95e7fd
# ╠═bccfd0e8-b733-46cc-98cf-5b4496475bc3
# ╟─5bd05184-674e-44f0-b9fc-326767f9fed9
# ╟─0edd3565-77b7-44a6-8019-6589e2ae0eab
# ╠═1fa3f48a-7691-4588-aefa-311b60ef2284
# ╠═fb8cbed0-aae3-43d2-aca5-c65d1ebc0370
# ╟─26d2837b-7af2-408e-a4a6-c1f458117c61
# ╠═834737d1-7a11-46fb-ace9-c00fefc1bd74
# ╠═b8486cd0-e7d2-47e5-9545-7457e1ca2dde
# ╟─6e030f56-c4c1-4725-b32f-644ca69b1855
# ╠═45528953-c028-4a15-a447-bf35cf0e75f1
# ╠═d4afb800-050d-4811-8a4a-7a6ad6a98ed5
# ╟─4d1b6a34-663c-4a7e-b2b2-94301ce8324c
# ╠═bca92e01-66df-490d-b848-e07f2c02c094
# ╠═75d9cb12-5a5e-4890-af6e-c2b0c00ab072
# ╟─c5913ad9-15a6-489e-8ab2-28b5384f07d7
# ╠═fe67789b-6aca-4519-a4dc-e0718487ab39
# ╠═8cf22eaa-1093-428a-902d-2a73c72bc9ee
# ╟─f89f985a-814d-4dfb-a369-b07104cc64fe
# ╟─7e3ff9cf-625b-4a6d-94d4-90eb9cd73b23
# ╠═75e90e24-a86d-4025-9631-126c6fe9ccfb
# ╠═555958a4-082e-4bc1-a4b9-10c520156adb
# ╟─75f9f409-7027-4294-aa00-e89509ad1ecf
# ╠═d9f14030-c3ca-4364-9974-0d8b546d7285
# ╠═8685b784-64c6-41d0-a4cc-3a7433a89c6b
# ╟─b26e7eed-ff03-4d96-aa3f-f3e17bb66efb
# ╟─aca12e6a-3133-4489-a02e-b9bf39ed254a
# ╠═f148a185-11a2-4feb-9f3c-d762523b1ed3
# ╠═d660047c-ccc4-4d8b-912e-c1efe0f40900
# ╟─37605c7a-cce3-4b21-8273-11988a5ce9b0
# ╠═767d67de-e17d-4a70-91d1-daffa68d184c
# ╠═5bcace46-8fae-4218-9be4-2d662838aa86
# ╠═d64cf025-f79c-4444-a23c-769a09b64725
# ╟─f754178a-95dc-4aed-b593-b8c32d1d3011
# ╟─f0fbf0c3-b7e0-4acf-85a0-d5d98b2bf5d0
# ╠═799424c7-140a-49df-b5b3-8bb97c1eb7ac
# ╠═2817c6e0-9581-4794-ac1e-97bad048c152
# ╟─123f9573-2f40-4e48-93a4-313b7f938ae6
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
