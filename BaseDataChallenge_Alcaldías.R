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

#Base externa
turisticos <- read_csv("sitios_turisticos_cdmx.csv") 

#View(listings)
#View(listscrap)
#View(reviews)
#View(geodata_alcaldia)

nrow(listings)
nrow(listscrap)

names(listings)
names(listscrap)

# MAPAS DE AIRBNBs POR ALCALDÍA
# Mapa de alcaldías con coordenadas
ggplot(geodata_alcaldia) + 
  geom_sf(fill="plum", color="white")
theme_void()

# Coordenadas de airbnbs en mapa
# El orden es c("longitud", "latitud") -> (X, Y)
airbnb_sf <- st_as_sf(listscrap,
                      coords = c("longitude", "latitude"), 
                      crs = 4326) # 4326 es el código estándar para coordenadas GPS (WGS84)

# Verificar que ambos archivos tengan el mismo Sistema de Coordenadas (CRS)
if (st_crs(airbnb_sf) != st_crs(geodata_alcaldia)) {
  geodata_alcaldia <- st_transform(geodata_alcaldia, st_crs(airbnb_sf))
}

# Apagar el motor esférico
sf_use_s2(FALSE)

# Hacer el join espacial (asignar cada AirBnB a su delegación)
datos_unidos <- st_join(airbnb_sf, geodata_alcaldia, join = st_within)
head(datos_unidos)

# VISUALIZACIÓN INTERACTIVA con mapview (mapa con puntos rojos)
mapview(geodata_alcaldia, alpha.regions = 0, color = "black", legend = FALSE) +
  mapview(airbnb_sf, col.regions = "red", cex = 3, legend = FALSE)

# FORMA DE VARIABLES
sapply(listscrap[c("price", "estimated_revenue_l365d", "estimated_occupancy_l365d", 
                   "host_is_superhost", "bedrooms", "bathrooms", "beds", 
                   "review_scores_location")], class)

#-------------------------CÓDIGO CON REGRESIÓN ---------------------------------
library(tidyverse)
library(fixest)
library(geosphere)
install.packages('geosphere')

# 1. LIMPIEZA DE VARIABLES
listscrap_clean <- listscrap %>%
  mutate(
    price_clean = as.numeric(gsub("[\\$,]", "", price)),
    revenue_clean = estimated_revenue_l365d,
    occupancy_clean = estimated_occupancy_l365d,
    superhost_numeric = as.numeric(host_is_superhost),
    log_revenue = log(revenue_clean)
  ) %>%
  filter(
    !is.na(revenue_clean), 
    revenue_clean > 0,
    !is.na(neighbourhood_cleansed),
    !is.na(bedrooms),
    !is.na(bathrooms),
    !is.na(latitude),
    !is.na(longitude)
  )

# 2. CALCULAR DISTANCIA MÍNIMA A SITIOS TURÍSTICOS
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

# 3. REGRESIÓN CON EFECTOS FIJOS
top_ABnB <- feols(log_revenue ~ bedrooms + bathrooms + beds + 
                    review_scores_location + superhost_numeric + 
                    dist_min_km | 
                    neighbourhood_cleansed,
                  data = listscrap_geo)

summary(top_ABnB)

# 4. EXTRAER EFECTOS FIJOS
fe_colonias <- fixef(top_ABnB)$neighbourhood_cleansed
fe_df <- data.frame(
  colonia = names(fe_colonias),
  efecto_fijo = as.numeric(fe_colonias)
) %>%
  arrange(desc(efecto_fijo))

# TOP 10 y TOP 3
head(fe_df, 10)
head(fe_df, 3)

# 5. INFORMACIÓN DEL TOP 3
stats_top3 <- listscrap_geo %>%
  filter(neighbourhood_cleansed %in% head(fe_df$colonia, 3)) %>%
  group_by(neighbourhood_cleansed) %>%
  summarise(
    n_propiedades = n(),
    revenue_promedio = mean(revenue_clean, na.rm = TRUE),
    precio_noche = mean(price_clean, na.rm = TRUE),
    ocupacion = mean(occupancy_clean, na.rm = TRUE),
    dist_turismo = mean(dist_min_km, na.rm = TRUE)
  )

print(stats_top3)




