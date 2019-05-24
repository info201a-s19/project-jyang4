library("dplyr")
library("leaflet.extras")
library("leaflet")


Yelp_data <- read.csv("./data/yelp.csv", stringsAsFactors = FALSE)

Vegas_Data <- Yelp_data %>% 
  filter(city == "Las Vegas" & review_count > 10) %>%
  select(latitude, longitude, stars, Number_of_Checkins, name)

Top_1000_reviews <- Yelp_data %>% 
  filter(city == "Las Vegas" & review_count > 1000) %>%
  select(latitude, longitude, stars, Number_of_Checkins, name)

Stars_rounded <- Vegas_Data$stars %>%
  round(digits = 0)

palette_fn <- colorFactor(palette = "Set1", domain = Stars_rounded)

content <- paste(paste("Name: ", Top_1000_reviews$name), 
                  paste("Stars: ", Top_1000_reviews$stars),
                  paste("Number of Check Ins: ", Top_1000_reviews$Number_of_Checkins),
                  sep = "<br />")


map_of_vegas <- leaflet(data = Vegas_Data) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -115.1767, lat = 36.11, zoom = 10.5) %>%
  addCircles(
      lat = ~Vegas_Data$latitude,
     lng = ~Vegas_Data$longitude,
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
  
 most_popular_map <-  leaflet(data = Top_1000_reviews) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(lng = -115.1767, lat = 36.11, zoom = 10.5) %>%
    addMarkers(
      lat = ~Top_1000_reviews$latitude,
      lng = ~Top_1000_reviews$longitude,
      popup = content
    ) 
  
    
