# Femathcc - Repositorio de Tesis & Proyectos de Investigación

Catálogo web interactivo para la visualización, filtrado y exploración de trabajos de grado, tesis (pregrado, maestría, doctorado), artículos científicos, código fuente y simulaciones computacionales interactivas.

---

## 🚀 Cómo correr el proyecto en local

El proyecto está desarrollado con tecnologías web estándar (**HTML5**, **CSS3** y **JavaScript Vanilla**) y carga los datos de las publicaciones dinámicamente desde el archivo `data/publicaciones.json` mediante la API `fetch()`.

### Opción 1: Con Python (Recomendada)
Si tienes Python instalado en tu sistema, abre una terminal en la raíz del proyecto y ejecuta:

```bash
# En Python 3
python3 -m http.server 8000

# O en Windows / Python estándar
python -m http.server 8000
```
Luego abre tu navegador en: [http://localhost:8000](http://localhost:8000)

---

### Opción 2: Con Visual Studio Code (Live Server)
1. Instala la extensión **Live Server** de Ritwick Dey en VS Code.
2. Abre la carpeta del proyecto en VS Code.
3. Haz clic derecho sobre `index.html` y selecciona **"Open with Live Server"** (o usa el botón *Go Live* en la barra inferior).

---

### Opción 3: Con Node.js (`npx`)
Si tienes Node.js instalado, puedes usar cualquiera de estos comandos sin instalar nada globalmente:

```bash
npx serve .
# o también:
npx http-server .
```

---

### Opción 4: Con PHP
Si tienes PHP instalado:

```bash
php -S localhost:8000
```
Luego abre tu navegador en: [http://localhost:8000](http://localhost:8000)

---

## 📁 Estructura del Proyecto

```text
femathcc.github.io/
├── css/
│   └── styles.css             # Estilos globales y temas (claro/oscuro)
├── data/
│   └── publicaciones.json     # Base de datos JSON de publicaciones y tesis
├── js/
│   └── app.js                 # Lógica de la aplicación, filtros, canvas y KaTeX
├── index.html                 # Página principal
└── README.md                  # Documentación del proyecto
```

---

## 📄 Formato del archivo `data/publicaciones.json`

Las publicaciones se almacenan en el archivo `data/publicaciones.json` como un arreglo (`array`) de objetos JSON. Cada objeto representa un trabajo de investigación, tesis o publicación.

### 📋 Campos del objeto de publicación

| Campo | Tipo | Requerido | Descripción | Ejemplo |
| :--- | :--- | :---: | :--- | :--- |
| `id` | `string` | **Sí** | Identificador único del proyecto. | `"001"` |
| `title` | `string` | **Sí** | Título completo de la tesis o publicación. | `"Similaridad de los espacios..."` |
| `subtitle` | `string` | No | Subtítulo breve o descripción corta (si no se especifica, toma el `abstract`). | `"Estudio de representaciones..."` |
| `authors` | `array` \| `string` | **Sí** | Lista de nombres de los autores o autor individual. | `["Eduards Alexis Mendez", "Juan Carlos Galvis"]` |
| `university` | `string` | **Sí** | Universidad o institución de procedencia. | `"Universidad Nacional de Colombia"` |
| `faculty` | `string` | No | Facultad o departamento. | `"Facultad de Ciencias"` |
| `degree` | `string` | No | Programa académico o grado obtenido. | `"Ciencias de la Computación"` |
| `category` | `string` | **Sí** | Área temática para categorización y filtrado en la barra superior. | `"Inteligencia Artificial"` |
| `year` | `number` | **Sí** | Año de sustentación o publicación (utilizado para ordenamiento). | `2025` |
| `date` | `string` | No | Fecha en formato `AAAA-MM-DD`. | `"2025-06-15"` |
| `tags` | `array` | No | Palabras clave / etiquetas relacionadas. | `["Deep Learning", "Continual Learning"]` |
| `mediaType` | `string` | No | Tipo de vista multimedia interactiva (ver tipos abajo) o imagen. | `"canvas-nn"` |
| `mediaImage` | `string` | No | URL de la imagen de portada (se usa si no hay animación canvas). | `"https://images.unsplash.com/..."` |
| `mathSnippet` | `string` | No | Fórmula matemática en formato LaTeX (renderizada con KaTeX). | `"\\mathcal{L}_{total} = \\mathcal{L}_{0} + \\alpha R"` |
| `pdfUrl` | `string` | No | Enlace directo al archivo PDF de la tesis o paper. | `"https://ejemplo.com/tesis.pdf"` |
| `codeUrl` | `string` | No | Enlace al repositorio de código fuente (e.g., GitHub, GitLab). | `"https://github.com/usuario/repo"` |
| `doi` | `string` | No | Identificador Digital de Objeto (DOI). | `"10.5281/zenodo.8492011"` |
| `views` | `number` | No | Contador inicial de visualizaciones. | `1420` |
| `citations` | `number` | No | Contador de citas bibliográficas. | `22` |
| `abstract` | `string` | **Sí** | Resumen completo del trabajo de grado. | `"El aprendizaje continuo plantea..."` |

---

### 🎨 Tipos de `mediaType` soportados

Si deseas que la tarjeta del proyecto incluya una simulación visual animada en Canvas 2D en lugar de una imagen estática, puedes asignar uno de los siguientes valores a `mediaType`:

* `"canvas-nn"`: Animación de red neuronal con conexiones dinámicas.
* `"canvas-wave"`: Simulación de ondas sinusoidales superpuestas.
* `"canvas-quantum"`: Simulación orbital / esfera cuántica con vector de estado rotatorio.
* `"canvas-bacteria"`: Simulación de propagación / crecimiento biológico.
* *Cualquier otro valor o sin definir*: Mostrará la imagen configurada en `mediaImage`.

---

### 🔣 Fórmulas Matemáticas (`mathSnippet`)

Puedes incluir ecuaciones en formato LaTeX estándar dentro de `mathSnippet`. La aplicación las renderizará automáticamente usando **KaTeX**.

> [!TIP]
> Recuerda escapar las barras invertidas en JSON (por ejemplo, usa `\\sum` o `\\mathcal{L}` en lugar de `\sum` o `\mathcal{L}`).

---

### 💡 Ejemplo completo de una entrada en `data/publicaciones.json`

```json
[
  {
    "id": "001",
    "title": "Similaridad de los espacios de características generados por una red neuronal en Continual Learning",
    "subtitle": "Análisis geométrico de representaciones en aprendizaje continuo con ResNet-18",
    "authors": [
      "Eduards Alexis Mendez Chipatecua",
      "Juan Carlos Galvis Arrieta"
    ],
    "university": "Universidad Nacional de Colombia",
    "faculty": "Facultad de Ciencias",
    "degree": "Ciencias de la Computación",
    "category": "Inteligencia Artificial",
    "year": 2025,
    "date": "2025-06-15",
    "tags": ["Deep Learning", "Continual Learning", "Representations"],
    "mediaType": "canvas-nn",
    "mediaImage": "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&auto=format&fit=crop&q=80",
    "mathSnippet": "\\min_{\\theta} \\mathbb{E}_{(x, y) \\sim \\mathcal{D}} [\\mathcal{L}(f_\\theta(x), y)] + \\lambda \\Omega(\\theta)",
    "pdfUrl": "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
    "codeUrl": "https://github.com/grupo-investigacion/retinopatia-ia-mobile",
    "doi": "10.5281/zenodo.8492011",
    "views": 1420,
    "citations": 22,
    "abstract": "El aprendizaje continuo plantea el reto de incorporar información nueva sin sacrificar el conocimiento adquirido, fenómeno conocido como olvido catastrófico. En este trabajo exploramos cómo evolucionan los espacios de características internos de una red neuronal profunda a lo largo de varias etapas de entrenamiento y bajo diferentes estrategias de mitigación del olvido. Para ello, empleamos una arquitectura ResNet-18 entrenada secuencialmente sobre CIFAR-10, comparando dos enfoques: fine-tuning puro y replay con buffer de ejemplos. Medimos la similaridad de subespacios de activaciones mediante ángulos principales tras aplicar PCA en cada capa. Nuestros resultados revelan que las capas más próximas a la entrada mantienen subespacios casi invariantes, mientras que las capas profundas sufren cambios sustanciales tras cada nueva tarea."
  }
]
```

---

## ✍️ Cómo agregar una nueva publicación

1. Abre el archivo [`data/publicaciones.json`](data/publicaciones.json).
2. Añade un nuevo objeto JSON dentro del arreglo principal respetando la estructura descrita arriba.
3. Guarda el archivo y recarga el navegador. La nueva publicación aparecerá automáticamente con sus filtros y opciones de citado (APA, IEEE y BibTeX).
