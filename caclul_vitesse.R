<<<<<<< HEAD
library(geosphere)
library(sf)
setwd("C:/Users/22200332/Desktop/Exercice 3 explorer-20231122")

library(sf)
library(dplyr)
# Lecture des données
gps_data <- st_read("17ok.gpkg")
"C:/Users/user/Desktop/GPS COLIN LE S-20231127T174455Z-001/GPS COLIN LE S/caclul_vitesse.R"

coords <- st_coordinates(gps_data)

# Ajoutez ces coordonnées à votre dataframe
gps_data$longitude <- coords[, 'X']
gps_data$latitude <- coords[, 'Y']
nnn
# Supposons que vos données sont dans un dataframe nommé 'data'

# Convertir les chaînes de caractères en dates/heures
gps_data$Heure <- as.POSIXct(gps_data$Heure, format = "%H:%M:%S")

# Calculer la différence de temps entre les lignes
# en soustrayant la valeur précédente de la valeur actuelle
gps_data$difference_temps <- c(NA, diff(gps_data$Heure))

## Assurer que les données sont ordonnées par temps
gps_data <- gps_data[order(gps_data$Heure), ]

gps_data <- st_transform(gps_data, 2154)

# Calculer les distances entre points consécutifs
distances <- st_distance(gps_data)

# Assurez-vous que gps_data est dans un système de coordonnées approprié
# Par exemple, transformer en Lambert-93 si ce n'est pas déjà le cas
# gps_data <- st_transform(gps_data, crs = 2154)  # 2154 est le code EPSG pour Lambert-93

# Calculer les distances entre points consécutifs
distances <- st_distance(gps_data)

# Extraire les distances numériques
distances_num <- as.numeric(distances[cbind(1:(nrow(distances) - 1), 2:nrow(distances))])

# Ajouter les distances à gps_data
gps_data$distance_to_next <- c(distances_num, NA)  # Ajouter NA pour la dernière ligne

