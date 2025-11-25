## README – Data Challenge: Airbnb en CDMX
**1. Resumen del contenido del repositorio**  
Este repositorio contiene todo el código, datos procesados y material utilizado para elaborar el informe ejecutivo del Data Challenge de Microeconometría Aplicada (ITAM). El objetivo del proyecto es identificar las tres colonias de la Ciudad de México con mejor rendimiento potencial para invertir en propiedades tipo Airbnb, utilizando análisis estadístico, herramientas econométricas y bases de datos externas.  

**2.Estructura del repositorio**

El repositorio incluye:  

**Código (/code/)**   
Scripts en R que realizan:
- Carga y limpieza de los datos de Inside Airbnb
- Conversión de coordenadas y análisis espacial con sf
- Mapa de distribución de propiedades
- Unión espacial a colonias
- Construcción y uso de la base externa de sitios turísticos
- Regresión con efectos fijos por colonia (fixest)
- Cálculo de distancias usando geosphere
- Ranking de colonias según efecto fijo
- Estadísticas descriptivas del Top 3

**Datos (/data/)**  

Datos originales de Inside Airbnb:  

- listings.csv  
- listings_scraped.csv  
- neighbourhoods.geojson

Bases limpias y datos intermedios generados por el código:  

- sitios_turisticos_cdmx.csv (base externa creada por el equipo)

Bases externas utilizadas en el proyecto:
- colonias-cdmx.geojson

**Resultados (/output/)**  

- Gráficas, mapas y tablas generadas en el análisis.  
- Resultados finales usados en el informe.

**2. Contribución de cada integrante del equipo**  

Alexa Fernanda Hernández Monroy:  
- Limpieza inicial de bases de Inside Airbnb.  
- Construcción de métricas de rendimiento (precio esperado × tasa de ocupación).  
- Elaboración de mapas y cruces espaciales.  

Paulina Ramirez Carrillo:  
- Análisis econométrico y especificación del modelo.  
- Integración de la base externa.  
- Redacción del apartado metodológico.   

Jeronimo Cuevas Aguilar Alvarez:  
- Visualizaciones (gráficas finales, tablas comparativas).  
- Ajustes finales del PDF.  

Jose Luis Cortina:  
- Visualizaciones (gráficas finales, tablas comparativas).  
- Redacción del resumen ejecutivo y conclusiones.  
  

**3. Uso de IA en el proyecto**  

El equipo empleó IA de forma responsable y complementaria, respetando las políticas del curso. En particular:  
Se utilizó ChatGPT para:  
- Resolver dudas puntuales sobre errores en R.  
- Obtener sugerencias de buenas prácticas para limpieza y manejo de datos espaciales.  
- Mejorar la redacción de algunos párrafos del informe (sin delegar la redacción completa).
- Explicar conceptos econométricos y decidir qué modelos eran adecuados.  
- Generar versiones preliminares de texto técnico que fueron luego editadas por el equipo.  
