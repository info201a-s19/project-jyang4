# Bar chart analysis of price range and number of businesses

library(ggplot2)
library(dplyr)

# Returns a bar chart of the number of businesses in each price range
bar_chart <- function(df) {
  # Data frame of the number of businesses in each price range
  price_ranges <- df %>%
    filter(city == "Las Vegas" | city == "North Las Vegas") %>%
    group_by(Price_Range) %>%
    summarize(num_each_price = n())
  
  # Removed NA values from the price_ranges data frame
  filtered_price_ranges <- na.omit(price_ranges)
  
  chart <- ggplot(yelp_df) +
    geom_col(mapping = aes(x = "$ = Under $10",
                           y = filtered_price_ranges$num_each_price[1])) +
    geom_col(mapping = aes(x = "$$ = $11-30",
                           y = filtered_price_ranges$num_each_price[2])) +
    geom_col(mapping = aes(x = "$$$ = $31-60 ",
                           y = filtered_price_ranges$num_each_price[3])) +
    geom_col(mapping = aes(x = "$$$$ = Over $61",
                           y = filtered_price_ranges$num_each_price[4])) +
    labs(
      title = "Number of Businesses in each Price Range",
      x = "Price Range",
      y = "Number of Businesses"
    )
  return(chart)
}