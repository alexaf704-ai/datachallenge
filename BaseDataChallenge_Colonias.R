library(readr)
library(sf)
library(jsonlite)
library(ggplot2)
library(mapview)
library(dplyr)

# REVISAMOS BASES DE DATOS (INICIALES DE ARTURO)
listings <- read_csv("listings.csv")
listscrap <- read_csv("listings_scrapped.csv")
reviews <- read_csv("reviews1.csv")

geodata_alcaldia <- st_read("neighbourhoods.geojson")
geodata_colonia <- st_read("colonias-cdmx.geojson") #Base externa

turisticos <- read_csv("sitios_turisticos_cdmx.csv") #Base externa

#View(listings)
View(listscrap)
#View(reviews)
#View(geodata_alcaldia)

nrow(listings)
nrow(listscrap)

names(listings)
names(listscrap)

# MAPAS DE AIRBNBs POR ALCALDÍA
# Mapa de alcaldías con coordenadas
ggplot(geodata_colonia) + 
  geom_sf(fill="lightblue", color="white")
theme_void()

# Coordenadas de airbnbs en mapa
# El orden es c("longitud", "latitud") -> (X, Y)
airbnb_sf <- st_as_sf(listscrap,
                      coords = c("longitude", "latitude"), 
                      crs = 4326) # 4326 es el código estándar para coordenadas GPS (WGS84)

# Verificar que ambos archivos tengan el mismo Sistema de Coordenadas (CRS)
if (st_crs(airbnb_sf) != st_crs(geodata_colonia)) {
  geodata_colonia <- st_transform(geodata_colonia, st_crs(airbnb_sf))
}

# Apagar el motor esférico
sf_use_s2(FALSE)

# Hacer el join espacial (asignar cada AirBnB a su delegación)
datos_unidos <- st_join(airbnb_sf, geodata_colonia, join = st_within)
head(datos_unidos)

# VISUALIZACIÓN INTERACTIVA con mapview (mapa con puntos rojos)
mapview(geodata_colonia, alpha.regions = 0, color = "black", legend = FALSE) +
  mapview(airbnb_sf, col.regions = "red", cex = 3, legend = FALSE)

# FORMA DE VARIABLES
sapply(listscrap[c("price", "estimated_revenue_l365d", "estimated_occupancy_l365d", 
                   "host_is_superhost", "bedrooms", "bathrooms", "beds", 
                   "review_scores_location")], class)

#-------------------------CÓDIGO CON REGRESIÓN ---------------------------------
library(readr)
library(tidyverse)
library(fixest)
library(geosphere)

# LIMPIEZA DE DATOS
listscrap_clean <- listscrap %>%
  mutate(
    price_clean = as.numeric(gsub("[\\$,]", "", price)),
    revenue_clean = estimated_revenue_l365d,
    occupancy_clean = estimated_occupancy_l365d,
    superhost_numeric = as.numeric(host_is_superhost),
    log_revenue = log(revenue_clean),
    colonia_clean = str_trim(host_neighbourhood) %>% str_to_title()
  ) %>%
  filter(
    !is.na(revenue_clean), 
    revenue_clean > 0,
    !is.na(colonia_clean),
    !is.na(bedrooms),
    !is.na(bathrooms),
    !is.na(latitude),
    !is.na(longitude)
  )

cat("Observaciones con colonia válida:", nrow(listscrap_clean), "\n")
cat("Número de colonias únicas:", n_distinct(listscrap_clean$colonia_clean), "\n\n")

# DISTANCIA A CENTROS TURÍSTICOS
cat("Calculando distancias... (puede tardar)\n")
listscrap_geo <- listscrap_clean %>%
  rowwise() %>%
  mutate(
    dist_min_km = min(
      distHaversine(
        c(longitude, latitude),
        cbind(turisticos$longitud, turisticos$latitud)
      )
    ) / 1000
  ) %>%
  ungroup()

cat("Distancias calculadas!\n\n")

# REGRESIÓN CON EFECTOS FIJOS
modelo_colonias <- feols(log_revenue ~ bedrooms + bathrooms + beds + 
                           review_scores_location + superhost_numeric + 
                           dist_min_km | 
                           colonia_clean,
                         data = listscrap_geo)

summary(modelo_colonias)

# EFECTOS FIJOS
fe_colonias <- fixef(modelo_colonias)$colonia_clean
fe_df <- data.frame(
  colonia = names(fe_colonias),
  efecto_fijo = as.numeric(fe_colonias)
) %>%
  arrange(desc(efecto_fijo))

# TOP 10 y TOP 3
print(head(fe_df, 10))
top3 <- head(fe_df, 3)
print(top3)

# ESTADÍSTICAS TOP 3
stats_top3 <- listscrap_geo %>%
  filter(colonia_clean %in% top3$colonia) %>%
  group_by(colonia_clean) %>%
  summarise(
    n_propiedades = n(),
    revenue_promedio = round(mean(revenue_clean, na.rm = TRUE), 0),
    precio_noche = round(mean(price_clean, na.rm = TRUE), 0),
    ocupacion = round(mean(occupancy_clean, na.rm = TRUE), 1),
    dist_turismo_km = round(mean(dist_min_km, na.rm = TRUE), 2),
    review_location = round(mean(review_scores_location, na.rm = TRUE), 2)
  ) %>%
  left_join(top3, by = c("colonia_clean" = "colonia")) %>%
  arrange(desc(efecto_fijo))

print(stats_top3)

# UBICACIÓN GEOGRÁFICA TOP 3
top3_contexto <- listscrap_geo %>%
  filter(colonia_clean %in% top3$colonia) %>%
  group_by(colonia_clean) %>%
  summarise(
    alcaldia = names(which.max(table(neighbourhood_cleansed)))
  )

print(top3_contexto)