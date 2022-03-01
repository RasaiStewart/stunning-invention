# Leaflet map to view UK Crime Data.

library(leaflet) # For producing maps
library(colortools) # For producing colours
crimeData<- read.csv(file.choose(), header = TRUE, stringsAsFactors =
                       FALSE) # Choose your file
crimeData<- crimeData[!is.na(crimeData$Longitude) | !is.na(crimeData$
                                                             Latitude), ] # Remove invalid locations
crimeData$Crime.type<-as.factor(crimeData$Crime.type)
# Treat Crime type as a factor
pal <- colorFactor(wheel("tomato",
                         num = length(unique(crimeData$Crime.type))), # Create colours
                   domain = unique(crimeData$Crime.type))
m <- leaflet(crimeData) %>% # Use Leaflet to create a map
  setView(lng = mean(crimeData$Longitude), lat = mean(crimeData$Latitude),
          zoom = 13)%>%
  addTiles() %>% # Add default OpenStreetMap map tiles
  addCircleMarkers(lng=~Longitude, lat=~Latitude,
                   # Add circles for crime locations
                   popup=~Crime.type, # Add popup for crime type
                   label =~ Crime.type, # Add label for crime type
                   radius=7, # Circle properties
                   color = ~pal(Crime.type), # Add colour for crime type
                   stroke = FALSE, fillOpacity = 1)
m # Print the map
