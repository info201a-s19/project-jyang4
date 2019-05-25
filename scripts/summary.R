# Load the `dplyr` package
library(dplyr)

# Load your data, making sure to not interpret strings as factors
df <- read.csv("data/yelp.csv", stringsAsFactors = F)

# Creating a data set for las vegas and north las vegas only
dff <- filter(df, city %in% c("Las Vegas", "North Las Vegas"))

# Total number of tips
total_tip_count <- sum(dff$Number_of_Tips)

# Average star rating
avg_star_rating <- mean(dff$stars)

# How many restaurants reviewed
restaurants_reviewed <- nrow(dff)

# Which restaurant was reviewed the most?
most_reviewed <- dff %>%
  filter(review_count == max(review_count)) %>%
  pull(name)

# Summary of price range
summary_range <- summary(dff$Price_Range)

# Summary Table
star_wise <- dff %>%
  group_by(stars) %>%
  summarise(checkins = sum(Number_of_Checkins), tips = sum(Number_of_Tips),
            reviews = sum(review_count))