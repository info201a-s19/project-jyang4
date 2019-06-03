library("dplyr")
library("ggplot2")

scatter_plot <- function(df){
  # Filter data for Las Vegas and filtering out outliers for proper scale
  vegas_data <- df %>%
    filter(city == "Las Vegas") %>%
    select(review_count, Number_of_Checkins, stars) %>%
    filter(Number_of_Checkins < 20000)
  ggplot(data = vegas_data) +
    geom_point(
      mapping = aes(x = Number_of_Checkins,
                    y = review_count,
                    color = stars),
      alpha = .3
    ) +
    labs(
      title = "Correlation Between Check-Ins and Reviews",
      x = "Number of Check-Ins",
      y = "Number of Reviews",
      color = "Stars"
    )
}
