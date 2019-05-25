library("dplyr")
library("leaflet")


Business_with_1000_map <- function(df){
  Vegas_Data_1000 <- df %>%
    filter(city == "Las Vegas" & review_count > 1000) %>%
    select(latitude, longitude, stars, Number_of_Checkins, name)
  content <- paste(paste("Name: ", Vegas_Data_1000$name),
                   paste("Stars: ", Vegas_Data_1000$stars),
                   paste("Number of Check Ins: ",
                         Vegas_Data_1000$Number_of_Checkins),
                   sep = "<br />")
  most_popular_map <-  leaflet(data = Vegas_Data_1000) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(lng = -115.1767, lat = 36.11, zoom = 10.5) %>%
    addMarkers(
      lat = ~Vegas_Data_1000$latitude,
      lng = ~Vegas_Data_1000$longitude,
      popup = content
    )
  return(most_popular_map)
}
