yelp_df <- read.csv("data/yelp.csv", stringsAsFactors = FALSE)

las_vegas <- yelp_df %>%
  filter(city == "Las Vegas") %>%
  group_by(Price_Range) %>%
  summarize(num_each_price = n())
filtered_las_vegas <- na.omit(las_vegas)

north_las_vegas <- yelp_df %>%
  filter(city == "North Las Vegas") %>%
  group_by(Price_Range) %>%
  summarize(num_each_price = n())
filtered_north_las_vegas <- na.omit(north_las_vegas)

henderson <- yelp_df %>%
  filter(city == "Henderson") %>%
  group_by(Price_Range) %>%
  summarize(num_each_price = n())
filtered_henderson <- na.omit(henderson)

only_ones <- data.frame(c(filtered_las_vegas$num_each_price[1], filtered_north_las_vegas$num_each_price[1], filtered_henderson$num_each_price[1]))
only_twos <- data.frame(c(filtered_las_vegas$num_each_price[2], filtered_north_las_vegas$num_each_price[2], filtered_henderson$num_each_price[2]))
only_threes <- data.frame(c(filtered_las_vegas$num_each_price[3], filtered_north_las_vegas$num_each_price[3], filtered_henderson$num_each_price[3]))
only_fours <- data.frame(c(filtered_las_vegas$num_each_price[4], filtered_north_las_vegas$num_each_price[4], filtered_henderson$num_each_price[4]))

cities <- data.frame(c("Las Vegas", "North Las Vegas", "Henderson"))

city_df <- data.frame(cities, only_ones, only_twos, only_threes, only_fours)
colnames(city_df) <- c("city", "$ = Under $10", "$$ = $11-30", "$$$ = $31- 60", "$$$$ = Over $61")

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
    one_city_bar_chart <- plot_ly(price_total, x = ~prices, y = ~total, color = I(input$Color),
                                  type = 'bar', text = ~paste(paste("Price Range:", prices),
                                                              paste("Number of Businesses:", total),
                                                              sep = "<br />")) %>%
      layout(title = "Number of Businesses in each Price Range in a Given City in Nevada",
             xaxis = list(title = "Price Range"),
             yaxis = list(title = "Number of Businesses"))
    return(one_city_bar_chart)
  })
}

one_city <- city_df %>%
  filter(city == "Las Vegas")
# State is not needed as part of the data frame
no_city <- one_city %>%
  select(-city)
# Organizes the data frame such that it is race vs pop
price_total <- gather(
  no_city,
  key = prices,
  value = total
)
one_city_bar_chart <- plot_ly(price_total, x = ~prices, y = ~total,
                              type = "bar", text = ~paste(paste("Price Range: ", prices),
                                                          paste("Number of Businesses: ", total),
                                                          sep = "<br />"), hoverinfo = "text") %>%
  layout(title = "Number of Businesses in each Price Range in a Given City in Nevada",
         xaxis = list(title = "Price Range"),
         yaxis = list(title = "Number of Businesses"))
