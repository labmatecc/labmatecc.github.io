### A Pluto.jl notebook ###
# v0.19.39

using Markdown
using InteractiveUtils

# ╔═╡ 8495d410-af20-11ee-0e03-59f8e6fcbbca
using PlutoUI

# ╔═╡ 4bdbd2b9-1e4f-41cd-b29b-391d4e3f7b34
begin
	using LinearAlgebra
	using Plots
	using Statistics
	using Distances
	using Clustering
end

# ╔═╡ 30a70338-df77-4c05-bc25-ec4e463f700e
begin
	using CSV
	using ExcelFiles
end

# ╔═╡ 319ac194-3e32-4c9d-ac1a-198b9fcc234f
PlutoUI.TableOfContents(title="Clustering", aside=true)

# ╔═╡ 061014c9-ac70-4007-bf5a-1829939d3833
md"""Este cuaderno esta en construcción y puede ser modificado en el futuro para mejorar su contenido. En caso de comentarios o sugerencias por favor escribir a jcgalvisa@unal.edu.co

Tu participación es fundamental para hacer de este curso una experiencia aún mejor."""

# ╔═╡ e42bf648-7797-4fb8-a871-ec8953384813
md"""Elaborado por Juan Galvis, Francisco Gómez y Yessica Trujillo."""

# ╔═╡ 99e2cc16-b2b7-436c-a1c1-9d26776c31aa
md"""Usaremos las siguientes librerías:"""

# ╔═╡ 7bd37955-2bfc-428b-b94a-e11f299842fb
md"""# Introducción"""

# ╔═╡ 488b679d-deff-42c9-b533-be70bfe5e732
md"""El clustering, dentro del campo del machine learning, es una técnica de aprendizaje no supervisado que se centra en la identificación y agrupación de patrones similares dentro de un conjunto de datos. A diferencia de los métodos supervisados que requieren etiquetas predefinidas, el clustering busca descubrir estructuras y relaciones en los datos sin la necesidad de guía externa.


El objetivo principal del clustering es dividir el conjunto de datos en clústeres o grupos, donde las muestras dentro de un mismo clúster comparten similitudes entre sí, mientras que son distintas de las muestras en otros clústeres. Este enfoque permite identificar patrones subyacentes, facilitando la exploración y comprensión de la variabilidad presente en los datos.Las medidas de similitud, como la distancia euclidiana, son fundamentales para determinar la proximidad entre puntos de datos.

Recordemos como calcular la distancia euclidiana, la distancia euclidiana entre dos puntos $P(x_1, y_1)$ y $Q(x_2, y_2)$ en un espacio bidimensional se define de la siguiente forma

$d(P,Q) = \sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2}$

Más generalmente, en un espacio de $n$-dimensiones con puntos $P(p_1, p_2, \ldots, p_n)$ y $Q(q_1, q_2, \ldots, q_n)$, la distancia euclidiana se calcula como

$d(P,Q) = \sqrt{\sum_{i=1}^{n}(q_i - p_i)^2}$

Esta fórmula representa la longitud de la línea recta que conecta los dos puntos en el espacio euclidiano.
"""

# ╔═╡ 0a336d8a-9b57-470c-aa88-341c47d98662
md"""En el ámbito del clustering, la tarea de agrupar datos similares es esencial para descubrir patrones y estructuras inherentes en conjuntos de datos. Sin embargo, evaluar la calidad de los clusters resultantes es fundamental para comprender la eficacia de los algoritmos de agrupamiento. En este contexto, la siguiente función se presenta como una herramienta valiosa para medir la dispersión o error cuadrático medio entre los puntos de datos y sus representantes de clúster asignados."""

# ╔═╡ 85b618fa-b4fa-4d8a-823d-ecafa54e5cfb
Jclust(x,reps,assignment) = mean([norm(x[i]-reps[assignment[i]])^2 for i=1:length(x)] )

# ╔═╡ aeb76509-87ed-4400-a4e3-77b59f5e8654
md"""La función $\texttt{Jclust}$ toma como entrada tres parámetros cruciales: el conjunto de datos $\texttt{x}$ representado como una lista de vectores, los representantes de clúster $\texttt{reps}$, y las asignaciones de clúster $\texttt{assignment}$ para cada punto en $\texttt{x}$. Su objetivo principal es calcular una medida cuantitativa que indique qué tan bien los puntos se ajustan a sus respectivos clusters.

La lógica subyacente implica calcular la distancia cuadrática entre cada punto y su representante de clúster asignado, ponderando estos valores por las asignaciones específicas. Posteriormente, se calcula un promedio de estas distancias cuadráticas, proporcionando una métrica cuantitativa de la coherencia y proximidad de los puntos dentro de sus clusters.

Esta función no solo es útil para la evaluación de la calidad de los clusters, sino que también puede desempeñar un papel crucial en la optimización de parámetros y ajuste de modelos de clustering. A través de la comprensión de cómo $\texttt{Jclust}$ responde a diferentes asignaciones y configuraciones de representantes, los practicantes de clustering pueden tomar decisiones informadas para mejorar la eficacia y precisión de sus análisis.

Consideremos:
"""

# ╔═╡ e1a2e484-76f2-4291-94b7-9a94664a05b3
begin
	x = [ [0,1], [1,0], [-1,1] ]
	reps = [ [1,1], [0,0] ]
	assignment₁ = [1,2,1]
end

# ╔═╡ 1fa48bf7-ad98-4aea-84e5-e75e351474ab
md"""Se obtiene como resultado:"""

# ╔═╡ 9c53f844-6d0c-4a40-898d-ed264ffe4bb9
Jclust(x,reps,assignment₁)

# ╔═╡ d8d3019f-6e7a-4955-8766-5db54223a143
md"""O si consideramos"""

# ╔═╡ 6fb695f6-00d9-41ce-904c-b92e6a1ff51b
assignment₂ = [1,1,2];

# ╔═╡ 81515c5d-664f-44e4-9cb9-75f9887b28d9
md"""De la función se obtiene:"""

# ╔═╡ d3aabbc1-5c51-418a-be92-c25152a339b4
Jclust(x,reps,assignment₂)

# ╔═╡ e3af430e-c5f4-4a91-941d-5f0720522aae
md"""# Algoritmo de Clustering"""

# ╔═╡ 6e7b812c-d63b-4624-9a8d-77408e1f9aba
md"""El análisis de clustering ofrece diversas herramientas para revelar patrones intrínsecos y agrupar datos de manera significativa. En esta sección, mostraremos un  algoritmo de clustering destacados: K-Means."""

# ╔═╡ 1b36505e-79dc-45de-a654-1c2f5053410c
md"""## K-Means"""

# ╔═╡ 19f37699-3a2e-4932-9aec-8969165e8fcf
md"""El término K-means describe un algoritmo, el cual asigna cada elemento al clúster que tiene el centroide (media) más cercano. En su forma más sencilla, el proceso consta de estos tres pasos:

1. Particionar los elementos en K clústeres iniciales.
2. Recorrer la lista de elementos, asignando cada elemento al clúster cuyo centroide (media) esté más cercano. La distancia se calcula generalmente utilizando la distancia euclidiana con observaciones estandarizadas o no estandarizadas. Recalcular el centroide para el clúster que recibe el nuevo elemento y para el clúster que pierde el elemento.
3. Repetir el Paso 2 hasta que no haya más reasignaciones.

En lugar de comenzar con una partición de todos los elementos en K grupos preliminares en el Paso 1, podríamos especificar K centroides iniciales (puntos semilla) y luego proceder al Paso 2.

La asignación final de elementos a clústeres dependerá, en cierta medida, de la partición inicial o de la selección inicial de puntos semilla. La experiencia sugiere que la mayoría de los cambios importantes en la asignación ocurren con el primer paso de reasignación real.

Creemos así la función kmeans, donde es posible ingresar los elementos, el número de clústers iniciales, el número máximo de iteraciones y la tolerancia, respectivamente.
"""

# ╔═╡ 326edf33-fe12-4815-a128-cb33f59c0281
function kmeans(x, k; maxiters = 100, tol = 1e-5)
    N = length(x) #longitud de x
    n = length(x[1])
    distances = zeros(N)  # se utiliza para almacenar la distancia de cada punto al representante más cercano.
    reps = [zeros(n) for j=1:k]  # se utiliza para almacenar a los representantes.

    # 'assignment' es un array de N enteros entre 1 y k. La asignación inicial se elige al azar.
    assignment = [rand(1:k) for i in 1:N]

    Jprevious = Inf  # utilizado en la condición de parada
    for iter = 1:maxiters

        # El representante del clúster j es el promedio de los puntos en el clúster j.
        for j = 1:k
            group = [i for i=1:N if assignment[i] == j]
            reps[j] = sum(x[group]) / length(group)
        end

        # Para cada x[i], encontrar la distancia al representante más cercano
        # y su índice de grupo.
        for i = 1:N
            (distances[i], assignment[i]) = findmin([norm(x[i] - reps[j]) for j = 1:k])
        end

        # Calcular medida objetiva del redimiento del clustering
        J = norm(distances)^2 / N

        # Mostrar progreso y terminar si J deja de disminuir.
        if Jprevious - J < tol
            break
        end
        Jprevious = J
    end
    return assignment, reps
end

# ╔═╡ d3abb069-8a6b-4253-a489-3cd56ddc89b5
md"""Veamos un ejemplo de esto, consideremos los siguientes datos:"""

# ╔═╡ aa09bbf6-7ef6-4359-8181-a8272a498cce
begin
X = vcat( [ 0.3*randn(2) for i = 1:100 ],
[ [1,1] + 0.3*randn(2) for i = 1:100 ],
[ [1,-1] + 0.3*randn(2) for i = 1:100 ] )
scatter([x[1] for x in X], [x[2] for x in X])
plot!(legend = false, grid = false, size = (500,500), xlims = (-1.5,2.5), ylims = (-2,2))
end

# ╔═╡ acd5ba29-4e13-4ce9-98d3-7a62de7754b4
md"""Aplicando el algoritmo anterior a los datos, para $k=3$ se obtiene lo siguiente"""

# ╔═╡ f40a0030-1830-4543-8259-a039e70a76ea
begin
k₁ = 3
assignment₃, reps₃ = kmeans(X, k₁)
end

# ╔═╡ 50f9f855-1daf-41d8-aeb2-195fe02f5dae
begin
N = length(X)
grps = [[X[i] for i=1:N if assignment₃[i] == j] for j=1:k₁]
scatter([c[1] for c in grps[1]], [c[2] for c in grps[1]])
scatter!([c[1] for c in grps[2]], [c[2] for c in grps[2]])
scatter!([c[1] for c in grps[3]], [c[2] for c in grps[3]])
plot!(legend = false, grid = false, size = (500,500), xlims = (-1.5,2.5), ylims = (-2,2))
end

# ╔═╡ 97f5fdff-4e5c-40d1-a4d4-6887d6ffd7fd
md"""# Preprocesamiento de datos"""

# ╔═╡ 340273d2-bb12-469d-bf55-a77b03144799
md"""En Julia, se puede cargar datos de diversas maneras, por ejemplo archivos CSV o archivo de Excel, esto se puede realizar con las siguientes librerías."""

# ╔═╡ 46bf3629-1c97-41ca-9d43-a1f80efe1401
md"""O como ya sabemos, podemos generar datos aleatorios."""

# ╔═╡ 0bc7542e-750a-443a-a737-3f596f64d086
md"""## Normalización/Estandarización"""

# ╔═╡ be347a4e-50a8-4b98-ad57-eb4bbba8de23
md"""La normalización y estandarización son técnicas comunes de preprocesamiento de datos que ayudan a poner todas las características en una escala común. Esto puede ser crucial para algoritmos sensibles a la escala, como K-Means, y puede mejorar la convergencia y el rendimiento del modelo."""

# ╔═╡ 17b8ed28-a579-4fab-ad48-5bad655b2463
md"""### Min-Máx"""

# ╔═╡ 27d00db4-a3e7-4a8a-adcd-84371da8ad6e
md"""La normalización Min-Max es un método de preprocesamiento de datos que ajusta los valores de las características de un conjunto de datos para que estén dentro de un rango específico, generalmente entre 0 y 1. El propósito de esta normalización es asegurar que todas las características tengan la misma escala, lo que puede ser importante para ciertos algoritmos que son sensibles a la magnitud de las características.

La fórmula general para la normalización Min-Max es la siguiente:

$X_{\text{normalized}} = \frac{X - X_{\text{min}}}{X_{\text{max}} - X_{\text{min}}}$

Donde:

$\begin{align*}
X & \text{ es el valor original de la característica.} \\
X_{\text{min}} & \text{ es el valor mínimo de la característica en el conjunto de datos.} \\
X_{\text{max}} & \text{ es el valor máximo de la característica en el conjunto de datos.}
\end{align*}$

Esta fórmula ajusta cada valor de la característica para que esté en una escala relativa al rango completo de la característica en el conjunto de datos."""

# ╔═╡ 2ea9eacf-58f0-4993-b689-d7e8935f628b
md"""La siguiente función normaliza los datos usando "min-máx". """

# ╔═╡ 1faf0cff-2991-47d4-b84d-5ed0cc227733
function minmax_normalize(data)
    min_vals = minimum(data, dims=1)
    max_vals = maximum(data, dims=1)

    normalized_data = (data .- min_vals) ./ (max_vals - min_vals)[1]
    return normalized_data
end

# ╔═╡ c5196e31-5095-4259-9a61-89afbfc8f808
md"""Por ejemplo, consideremos el siguiente conjunto de datos"""

# ╔═╡ bcc9197f-4d21-43fa-b2d5-40f567d15ab0
x₁=1.5*rand(100)

# ╔═╡ 51462f44-1829-4e9c-88dc-c9f09db4124b
md"""Visualizándolos"""

# ╔═╡ 55f987bf-e708-45b8-a0f8-bc5840d4e119
plot(scatter(x=1:100, x₁))

# ╔═╡ d400446c-6d89-418d-830f-3f0fefebfcb6
md"""Normalizando estos datos con la función anterior, se obtiene lo siguiente:"""

# ╔═╡ fc4cec7d-546a-47b8-8271-7322f57b9888
minmax_normalize(x₁)

# ╔═╡ cd47b25a-cfe7-41e7-bc6f-15f3d5098cd7
md"""Los podemos visualizar de la siguiente forma"""

# ╔═╡ 22ae57f4-002c-4314-a2d8-9b47b0d01386
plot(scatter(x=1:100, minmax_normalize(x₁)))

# ╔═╡ 1d5261ce-2f45-4e88-b6b9-462ea6c1897a
md"""Note que la distribución de los datos no se ve alterada."""

# ╔═╡ ed64ca57-26f3-420b-aae0-2c605340b072
md"""### $Z$-Score"""

# ╔═╡ 81502e8e-ee6a-4abd-b822-cdaddfbd81f8
md"""La estandarización ($Z$-Score) es otro método común de preprocesamiento de datos que transforma las características de un conjunto de datos para que tengan una media de cero y una desviación estándar de uno. Este proceso es útil para algoritmos que asumen normalidad en los datos y para aquellos que son sensibles a la magnitud de las características.

La fórmula general para la estandarización (Z-Score) es la siguiente:

$Z = \frac{X - \mu}{\sigma}$

Donde:

$\begin{align*}
X & \text{ es el valor original de la característica.} \\
\mu & \text{ es la media del conjunto de datos.} \\
\sigma & \text{ es la desviación estándar del conjunto de datos.}
\end{align*}$

El resultado $Z$ indica cuántas desviaciones estándar el valor $X$ está por encima o por debajo de la media. Un $Z$-score positivo indica que el valor está por encima de la media, mientras que un $Z$-score negativo indica que está por debajo.
"""

# ╔═╡ 2eef15d2-b351-4af1-aa50-50efe3a439ee
md"""La siguiente función normaliza los datos usando la estandarización. """

# ╔═╡ 2227f54a-56be-4105-91b5-aa4e0ef907d7
function zscore_standardize(data)
    mean_vals = mean(data, dims=1)
    std_vals = std(data, dims=1)

    standardized_data = (data .- mean_vals) ./ std_vals
    return standardized_data
end

# ╔═╡ c78301fa-7bbe-4abc-b1e6-f9f32a652fa9
md"""Para los mismos datos anteriores se tiene:"""

# ╔═╡ 660d640c-910b-4ab8-940b-daa15cda9721
zscore_standardize(x₁)

# ╔═╡ 4384266e-f8f7-4f42-bdc0-58c3c8761194
plot(scatter(x=1:100, zscore_standardize(x₁)))

# ╔═╡ 90f3f183-bbc6-4c07-b270-fe980527012e
md"""Al igual que con min-máx la distribución de los datos no se ve alterada, esta es una de las ventajas de normalizar los datos."""

# ╔═╡ 2d5bf322-f095-4e93-bee3-5374e899362c
md"""# Visualización"""

# ╔═╡ 71201a55-47c4-4a74-b54f-11a70c3d2cd0
md"""Consideremos el siguiente conjunto de datos:"""

# ╔═╡ 5758c5dc-f6a6-4da5-ba71-6404f8001d27
a = vcat(1.7*randn(500), 0.3*randn(500))

# ╔═╡ eb0150c0-eec9-4b5f-8e9d-2353702784a6
b = vcat(1.7*randn(150), -3.3*randn(175), 0.5*randn(325), -0.1*randn(350))

# ╔═╡ 1e32425b-4078-49d2-a502-7cb591a5669a
plot(scatter(a,b))

# ╔═╡ cae655c3-8e89-4b08-b83a-e7ea578b5723
datos=[vcat(a[i],b[i]) for i=1:1000]

# ╔═╡ a094e975-08ec-4f98-be86-6feac5f472b7
md"""Vamos a normalizar los datos con Min-Máx"""

# ╔═╡ f415835f-1587-4019-8eca-a5c2f37222c5
datos_norm=[vcat(minmax_normalize(a)[i],minmax_normalize(b)[i]) for i=1:1000]

# ╔═╡ 1ff000f0-a9a6-4f29-82c5-1b22cfb5f387
plot(scatter([x[1] for x in datos_norm], [x[2] for x in datos_norm]))

# ╔═╡ fbcd4e16-d49d-47a0-9805-ea41bad1ba3f
md"""Aplicando el algoritmo K-Means para $k=5$, se obtiene lo siguiente"""

# ╔═╡ f0efd8b5-74d0-4490-bc5c-5ef40a2aea31
begin
k₂ = 5
assignment₄, reps₄ = kmeans(datos_norm, k₂)
end

# ╔═╡ 26a4fe64-ab46-4f10-8037-c0427f50322c
md"""A continuación se muestran los datos con el color de su respectivo grupo"""

# ╔═╡ 4093a818-cebb-40b1-b934-43a124dc1ca2
begin
N1 = length(datos_norm)
grps1 = [[datos_norm[i] for i=1:N1 if assignment₄[i] == j] for j=1:k₂]
scatter([c[1] for c in grps1[1]], [c[2] for c in grps1[1]])
scatter!([c[1] for c in grps1[2]], [c[2] for c in grps1[2]])
scatter!([c[1] for c in grps1[3]], [c[2] for c in grps1[3]])
scatter!([c[1] for c in grps1[4]], [c[2] for c in grps1[4]])
scatter!([c[1] for c in grps1[5]], [c[2] for c in grps1[5]])
plot!(legend = false, grid = false, size = (500,500))
end

# ╔═╡ f415ea7b-d19c-4714-bfdc-bf52e0bac815
md"""# Referencias"""

# ╔═╡ 0635b3a0-652c-40ae-af64-3b4ad75836a8
md"""[1] Johnson, R. A., & Wichern, D. (2007). Applied Multivariate Statistical Analysis. Pearson Prentice Hall.

[3] Boyd, S., & Vandenberghe, L. (2018). Introduction to Applied Linear Algebra: Vectors, Matrices, and Least Squares. Cambridge University Press.

[2] Bartlett, V. (2018). VMLS Julia, Ch.04 Clustering. VMLS Companions. https://github.com/vbartle/VMLS-Companions/blob/master/VMLS%20Julia%20Companion/VMLS%20Julia%2C%20Ch.04%20Clustering.ipynb"""

# ╔═╡ Cell order:
# ╟─8495d410-af20-11ee-0e03-59f8e6fcbbca
# ╟─319ac194-3e32-4c9d-ac1a-198b9fcc234f
# ╟─061014c9-ac70-4007-bf5a-1829939d3833
# ╟─e42bf648-7797-4fb8-a871-ec8953384813
# ╟─99e2cc16-b2b7-436c-a1c1-9d26776c31aa
# ╠═4bdbd2b9-1e4f-41cd-b29b-391d4e3f7b34
# ╟─7bd37955-2bfc-428b-b94a-e11f299842fb
# ╟─488b679d-deff-42c9-b533-be70bfe5e732
# ╟─0a336d8a-9b57-470c-aa88-341c47d98662
# ╠═85b618fa-b4fa-4d8a-823d-ecafa54e5cfb
# ╟─aeb76509-87ed-4400-a4e3-77b59f5e8654
# ╠═e1a2e484-76f2-4291-94b7-9a94664a05b3
# ╟─1fa48bf7-ad98-4aea-84e5-e75e351474ab
# ╠═9c53f844-6d0c-4a40-898d-ed264ffe4bb9
# ╟─d8d3019f-6e7a-4955-8766-5db54223a143
# ╠═6fb695f6-00d9-41ce-904c-b92e6a1ff51b
# ╟─81515c5d-664f-44e4-9cb9-75f9887b28d9
# ╠═d3aabbc1-5c51-418a-be92-c25152a339b4
# ╟─e3af430e-c5f4-4a91-941d-5f0720522aae
# ╟─6e7b812c-d63b-4624-9a8d-77408e1f9aba
# ╟─1b36505e-79dc-45de-a654-1c2f5053410c
# ╟─19f37699-3a2e-4932-9aec-8969165e8fcf
# ╠═326edf33-fe12-4815-a128-cb33f59c0281
# ╟─d3abb069-8a6b-4253-a489-3cd56ddc89b5
# ╠═aa09bbf6-7ef6-4359-8181-a8272a498cce
# ╟─acd5ba29-4e13-4ce9-98d3-7a62de7754b4
# ╠═f40a0030-1830-4543-8259-a039e70a76ea
# ╠═50f9f855-1daf-41d8-aeb2-195fe02f5dae
# ╟─97f5fdff-4e5c-40d1-a4d4-6887d6ffd7fd
# ╟─340273d2-bb12-469d-bf55-a77b03144799
# ╠═30a70338-df77-4c05-bc25-ec4e463f700e
# ╟─46bf3629-1c97-41ca-9d43-a1f80efe1401
# ╟─0bc7542e-750a-443a-a737-3f596f64d086
# ╟─be347a4e-50a8-4b98-ad57-eb4bbba8de23
# ╟─17b8ed28-a579-4fab-ad48-5bad655b2463
# ╟─27d00db4-a3e7-4a8a-adcd-84371da8ad6e
# ╟─2ea9eacf-58f0-4993-b689-d7e8935f628b
# ╠═1faf0cff-2991-47d4-b84d-5ed0cc227733
# ╟─c5196e31-5095-4259-9a61-89afbfc8f808
# ╠═bcc9197f-4d21-43fa-b2d5-40f567d15ab0
# ╟─51462f44-1829-4e9c-88dc-c9f09db4124b
# ╠═55f987bf-e708-45b8-a0f8-bc5840d4e119
# ╟─d400446c-6d89-418d-830f-3f0fefebfcb6
# ╠═fc4cec7d-546a-47b8-8271-7322f57b9888
# ╟─cd47b25a-cfe7-41e7-bc6f-15f3d5098cd7
# ╠═22ae57f4-002c-4314-a2d8-9b47b0d01386
# ╟─1d5261ce-2f45-4e88-b6b9-462ea6c1897a
# ╟─ed64ca57-26f3-420b-aae0-2c605340b072
# ╟─81502e8e-ee6a-4abd-b822-cdaddfbd81f8
# ╟─2eef15d2-b351-4af1-aa50-50efe3a439ee
# ╠═2227f54a-56be-4105-91b5-aa4e0ef907d7
# ╟─c78301fa-7bbe-4abc-b1e6-f9f32a652fa9
# ╠═660d640c-910b-4ab8-940b-daa15cda9721
# ╠═4384266e-f8f7-4f42-bdc0-58c3c8761194
# ╟─90f3f183-bbc6-4c07-b270-fe980527012e
# ╟─2d5bf322-f095-4e93-bee3-5374e899362c
# ╟─71201a55-47c4-4a74-b54f-11a70c3d2cd0
# ╠═5758c5dc-f6a6-4da5-ba71-6404f8001d27
# ╠═eb0150c0-eec9-4b5f-8e9d-2353702784a6
# ╠═1e32425b-4078-49d2-a502-7cb591a5669a
# ╠═cae655c3-8e89-4b08-b83a-e7ea578b5723
# ╟─a094e975-08ec-4f98-be86-6feac5f472b7
# ╠═f415835f-1587-4019-8eca-a5c2f37222c5
# ╠═1ff000f0-a9a6-4f29-82c5-1b22cfb5f387
# ╟─fbcd4e16-d49d-47a0-9805-ea41bad1ba3f
# ╠═f0efd8b5-74d0-4490-bc5c-5ef40a2aea31
# ╟─26a4fe64-ab46-4f10-8037-c0427f50322c
# ╠═4093a818-cebb-40b1-b934-43a124dc1ca2
# ╟─f415ea7b-d19c-4714-bfdc-bf52e0bac815
# ╟─0635b3a0-652c-40ae-af64-3b4ad75836a8
