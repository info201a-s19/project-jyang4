library("dplyr")
library("leaflet")


map_chart <- function(df){
  
  Vegas_Data <- df %>% 
    filter(city == "Las Vegas" & review_count > 10) %>%
    select(latitude, longitude, stars, Number_of_Checkins, name)
  
  Stars_rounded <- df$stars %>%
    round(digits = 0)
 
   palette_fn <- colorFactor(palette = "Set1", domain = Stars_rounded)
   
   map_of_vegas <- leaflet(data = df) %>%
     addProviderTiles("CartoDB.Positron") %>%
     setView(lng = -115.1767, lat = 36.11, zoom = 10.5) %>%
     addCircles(
       lat = ~df$latitude,
       lng = ~df$longitude,
       color = ~palette_fn(Stars_rounded),
       radius = 20,
       fillOpacity = 0.5
     ) %>%
     addLegend(
       position = "bottomright",
       title = "Start Ratings in Las Vegas",
       pal = palette_fn, # the palette to label
       values = ~Stars_rounded, # the values to label
       opacity = 1
     )
   
  
}


