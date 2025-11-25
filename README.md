## README – Data Challenge: Airbnb en CDMX
**1. Resumen del contenido del repositorio**  
Este repositorio contiene todo el código, datos procesados y material utilizado para elaborar el informe ejecutivo del Data Challenge de Microeconometría Aplicada (ITAM).
El **objetivo del proyecto** es identificar las tres colonias de la Ciudad de México con mejor rendimiento potencial para invertir en propiedades tipo Airbnb, utilizando análisis estadístico, herramientas econométricas y bases de datos externas.  

**2. Estructura del repositorio**
**CÓDIGOS**
- BaseDataChallenge_Alcaldías.R -> Este código contiene el modelo de efectos fijos para el análisis a nivel alcaldía.
- BaseDataChallenge_Colonias.R -> Este código contiene el modelo de efectos fijos para el análisis a nivel colonia.
- BaseTurismo.R -> Este código genera la base de datos sitios_turisticos_cdmx.csv con los 15 sitios turísticos más visitados en la CDMX y sus coordenadas.

**Scripts en R realizan:**
- Carga y limpieza de los datos de Inside Airbnb
- Conversión de coordenadas y análisis espacial
- Mapa de distribución de propiedades (a nivel alcaldía y colonia)
- Construcción y uso de la base externa de sitios turísticos
- Modelo de Regresión con efectos fijos por colonia (fixest)
- Ranking de alcaldías y colonias
- Estadísticas descriptivas del Top 3
  
**BASES DE DATOS**
- listings_scraped.csv -> Esta es la base principal, de aquí salen las variables principales con las que trabajamos el modelo y los Efectos Fijos. 
- neighbourhoods.geojson -> Las coordenadas contenidas dentro de este archivo nos sirvieron para mapear los Airbnbs en las alcaldías.
- colonias-cdmx.geojson -> Las coordenadas contenidas dentro de este archivo nos sirvieron para mapear los Airbnbs por colonia.
- sitios_turisticos_cdmx.csv -> Base externa creada por el equipo mediante BaseTurismo.R.

**RESULTADOS**  
- Gráficas, mapas y tablas generadas en el análisis.  
- Resultados finales usados en el informe.

**3. Contribución de cada integrante del equipo**  
Alexa Fernanda Hernández Monroy:
- Limpieza inicial de bases de Inside Airbnb.  
- Elaboración de mapas con las coordenadas espaciales.
- Planteamiento del modelo.

Ma. Paulina Ramírez Carrillo:  
- Planteamiento del modelo.  
- Programación del modelo y análisis econométrico.  
- Integración de la base externa.

Jerónimo Cuevas Aguilar Álvarez:  
- Búsqueda de bases externas y de información relevante.
- Planteamiento del modelo.  
- Ajustes al resumen ejecutivo.  

José Luis Cortina: 
- Visualizaciones (gráficas finales, tablas comparativas).  
- Redacción del resumen ejecutivo y conclusiones.
- Planteamiento del modelo.  
  
**4. Uso de IA en el proyecto**  
El equipo empleó IA de forma responsable y complementaria, respetando las políticas del curso. En particular:  
Se utilizó ChatGPT y Claude AI para:  
- Resolver dudas puntuales sobre errores en R.  
- Obtener sugerencias de buenas prácticas manejo de datos espaciales.  
- Mejorar la redacción de algunos párrafos del informe (sin delegar la redacción completa).
- Explicar conceptos econométricos y decidir qué metodología/modelo era adecuado.

En especial, se utilizó IA para elaborar la base de datos de los 15 sitios turísticos más visitados en la CDMX y sus coordenadas.
Nos ayudó con varias fuentes para determinar cuáles sitios eran más visitados, y con las coordenadas de cada sitio turístico que sacó de Google Maps.
