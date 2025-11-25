# BASE DE DATOS: 15 Sitios Turísticos Principales de CDMX
# Fuentes: Secretaría de Turismo CDMX, TripAdvisor, Google Maps
# Sitios más visitados en 2024

sitios_turisticos <- data.frame(
  sitio = c(
    "Zócalo",
    "Palacio de Bellas Artes",
    "Catedral Metropolitana",
    "Templo Mayor",
    "Bosque de Chapultepec",
    "Castillo de Chapultepec",
    "Museo Nacional de Antropología",
    "Basílica de Guadalupe",
    "Xochimilco",
    "Coyoacán Centro",
    "Ángel de la Independencia",
    "Museo Soumaya",
    "Torre Latinoamericana",
    "San Ángel",
    "Polanco"
  ),
  latitud = c(
    19.4326,   # Zócalo
    19.4352,   # Bellas Artes
    19.4342,   # Catedral
    19.4353,   # Templo Mayor
    19.4204,   # Chapultepec Bosque
    19.4205,   # Castillo Chapultepec
    19.4261,   # Museo Antropología
    19.4847,   # Basílica Guadalupe
    19.2577,   # Xochimilco
    19.3467,   # Coyoacán
    19.4270,   # Ángel Independencia
    19.4404,   # Soumaya
    19.4338,   # Torre Latino
    19.3481,   # San Ángel
    19.4365    # Polanco
  ),
  longitud = c(
    -99.1332,  # Zócalo
    -99.1412,  # Bellas Artes
    -99.1332,  # Catedral
    -99.1318,  # Templo Mayor
    -99.1919,  # Chapultepec Bosque
    -99.1815,  # Castillo Chapultepec
    -99.1861,  # Museo Antropología
    -99.1173,  # Basílica Guadalupe
    -99.1035,  # Xochimilco
    -99.1631,  # Coyoacán
    -99.1677,  # Ángel Independencia
    -99.2062,  # Soumaya
    -99.1377,  # Torre Latino
    -99.1875,  # San Ángel
    -99.1950   # Polanco
  ),
  alcaldia = c(
    "Cuauhtémoc",
    "Cuauhtémoc",
    "Cuauhtémoc",
    "Cuauhtémoc",
    "Miguel Hidalgo",
    "Miguel Hidalgo",
    "Miguel Hidalgo",
    "Gustavo A. Madero",
    "Xochimilco",
    "Coyoacán",
    "Cuauhtémoc",
    "Miguel Hidalgo",
    "Cuauhtémoc",
    "Álvaro Obregón",
    "Miguel Hidalgo"
  ),
  tipo = c(
    "Plaza Histórica",
    "Museo/Teatro",
    "Monumento Religioso",
    "Zona Arqueológica",
    "Parque",
    "Museo/Castillo",
    "Museo",
    "Basílica",
    "Canales/Ecoturismo",
    "Barrio Histórico",
    "Monumento",
    "Museo",
    "Mirador",
    "Barrio Histórico",
    "Zona Comercial/Gastronómica"
  )
)

# Guardar el archivo CSV
write.csv(sitios_turisticos, "sitios_turisticos_cdmx.csv", row.names = FALSE)

# Ver la tabla
print(sitios_turisticos)

