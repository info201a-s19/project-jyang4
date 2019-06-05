library("dplyr")
library("plotly")
library("shiny")
library("tidyr")
library("leaflet")

yelp <- read.csv("data/yelp.csv", stringsAsFactors = FALSE)

# The price ranges for Las Vegas
las_vegas <- yelp %>%
  filter(city == "Las Vegas") %>%
  group_by(Price_Range) %>%
  summarize(num_each_price = n())
filtered_las_vegas <- na.omit(las_vegas)

# The price ranges for North Las Vegas
north_las_vegas <- yelp %>%
  filter(city == "North Las Vegas") %>%
  group_by(Price_Range) %>%
  summarize(num_each_price = n())
filtered_north_las_vegas <- na.omit(north_las_vegas)

# The price ranges for Henderson
henderson <- yelp %>%
  filter(city == "Henderson") %>%
  group_by(Price_Range) %>%
  summarize(num_each_price = n())
filtered_henderson <- na.omit(henderson)

# The associated data frames of the price ranges
only_ones <- data.frame(c(
  filtered_las_vegas$num_each_price[1],
  filtered_north_las_vegas$num_each_price[1],
  filtered_henderson$num_each_price[1]
))
only_twos <- data.frame(c(
  filtered_las_vegas$num_each_price[2],
  filtered_north_las_vegas$num_each_price[2],
  filtered_henderson$num_each_price[2]
))
only_threes <- data.frame(c(
  filtered_las_vegas$num_each_price[3],
  filtered_north_las_vegas$num_each_price[3],
  filtered_henderson$num_each_price[3]
))
only_fours <- data.frame(c(
  filtered_las_vegas$num_each_price[4],
  filtered_north_las_vegas$num_each_price[4],
  filtered_henderson$num_each_price[4]
))

# The cities and associated price ranges together in a data frame
cities <- data.frame(c("Las Vegas", "North Las Vegas", "Henderson"))
city_df <- data.frame(cities, only_ones, only_twos, only_threes, only_fours)
colnames(city_df) <- c(
  "city", "$ = Under $10", "$$ = $11-30",
  "$$$ = $31- 60", "$$$$ = Over $61"
)

my_server <- function(input, output) {
  output$bar <- renderPlotly({
    # Filters down to a specific city
    one_city <- city_df %>%
      filter(city == input$City)
    # State is not needed as part of the data frame
    no_city <- one_city %>%
      select(-city)
    # Organizes the data frame such that it is race vs pop
    price_total <- gather(
      no_city,
      key = prices,
      value = total
    )
    one_city_bar_chart <- plot_ly(price_total,
      x = ~prices, y = ~total,
      color = I(input$Color), type = "bar",
      hoverinfo = "text",
      text = ~ paste(paste("Price Range:", prices),
        paste(
          "Number of Businesses:",
          total
        ),
        sep = "<br />"
      )
    ) %>%
      layout(
        title = "Number of Businesses in each Price Range in a Given City in Nevada",
        xaxis = list(title = "Price Range"),
        yaxis = list(title = "Number of Businesses"),
        showlegend = FALSE
      )
    return(one_city_bar_chart)
  })

  # Render function for the check-ins and reviews page
  output$reviews_scatterplot <- renderPlotly({
    # Filter data for Las Vegas, and filter to only use the selected number of
    # stars according to the widget
    vegas <- yelp %>%
      filter(city == "Las Vegas") %>%
      select(name, review_count, Number_of_Checkins, stars) %>%
      filter(stars == input$stars)

    scatter <- plot_ly(vegas,
      x = ~Number_of_Checkins, y = ~review_count,
      type = "scatter",
      mode = "markers",
      hoverinfo = "text",
      text = ~ paste(
        "</br> Restaurant: ", name,
        "</br> Number of Check-Ins: ", Number_of_Checkins,
        "</br> Number of Reviews: ", review_count
      )
    )

    scatter <- scatter %>%
      layout(
        title = "Correlation Between Check-Ins and Reviews",
        showlegend = FALSE
      )

    if (input$scale) {
      scatter <- scatter %>%
        layout(
          xaxis = list(title = "Number of Check-Ins"),
          yaxis = list(title = "Review Count")
        )
    } else {
      scatter <- scatter %>%
        layout(
          xaxis = list(title = "Number of Check-Ins", range = c(0, 20000)),
          yaxis = list(title = "Review Count", range = c(0, 6000))
        )
    }

    fit <- lm(review_count ~ Number_of_Checkins, data = vegas)

    # Display regressions if specified by widget
    if (input$lines) {
      scatter <- scatter %>% add_lines(
        x = ~Number_of_Checkins,
        y = fitted(fit)
      )
    }
    scatter
  })

  output$equation <- renderText({
    if (input$lines) {
      vegas <- yelp %>%
        filter(city == "Las Vegas") %>%
        select(review_count, Number_of_Checkins, stars) %>%
        filter(stars == input$stars)
      linearMod <- lm(review_count ~ Number_of_Checkins, data = vegas)
      paste0(
        "Reviews = ",
        format(round(coef(linearMod)["(Intercept)"], 2), nsmall = 2),
        " + ",
        format(round(coef(linearMod)["Number_of_Checkins"], 2),
          nsmall = 2
        ),
        " x Check-Ins"
      )
    }
  })

  output$rsquared <- renderText({
    if (input$lines) {
      vegas <- yelp %>%
        filter(city == "Las Vegas") %>%
        select(review_count, Number_of_Checkins, stars) %>%
        filter(stars == input$stars)
      linearMod <- lm(review_count ~ Number_of_Checkins, data = vegas)
      paste0(
        "R-squared: ",
        format(round(summary(linearMod)$r.squared, 2), nsmall = 2)
      )
    }
  })

  output$ratings_map <- renderLeaflet({
    vegas <- yelp %>%
      filter(city == "Las Vegas" & review_count > 10) %>%
      select(latitude, longitude, stars, Number_of_Checkins, name)

    if (!("1" %in% input$stars_group)) {
      vegas <- vegas %>% filter(round(stars) != 1)
    }
    if (!("2" %in% input$stars_group)) {
      vegas <- vegas %>% filter(round(stars) != 2)
    }
    if (!("3" %in% input$stars_group)) {
      vegas <- vegas %>% filter(round(stars) != 3)
    }
    if (!("4" %in% input$stars_group)) {
      vegas <- vegas %>% filter(round(stars) != 4)
    }
    if (!("5" %in% input$stars_group)) {
      vegas <- vegas %>% filter(round(stars) != 5)
    }

    stars_rounded <- vegas$stars %>%
      round()
    palette_fn <- colorFactor(palette = "Set1", domain = stars_rounded)
    map_of_vegas <- leaflet(data = vegas) %>%
      addProviderTiles("CartoDB.Positron") %>%
      setView(lng = -115.1767, lat = 36.11, zoom = 10.5) %>%
      addCircles(
        lat = ~ vegas$latitude,
        lng = ~ vegas$longitude,
        color = ~ palette_fn(stars_rounded),
        radius = 20,
        fillOpacity = 0.5
      ) %>%
      addLegend(
        position = "bottomright",
        title = "Star Ratings in Las Vegas",
        pal = palette_fn, # the palette to label
        values = ~stars_rounded, # the values to label
        opacity = 1
      )
    map_of_vegas
  })
}
