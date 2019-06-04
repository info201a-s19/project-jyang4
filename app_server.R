library(dplyr)
library(plotly)
library(ggplot2)

my_server <- function(input, output) {
  yelp <- read.csv("data/yelp.csv", stringsAsFactors = FALSE)
  
  # Render function for the check-ins and reviews page
  output$reviews_scatterplot <- renderPlotly({
    # Filter data for Las Vegas, and filter to only use the selected number of 
    # stars according to the widget
    vegas <- yelp %>% filter(city == "Las Vegas") %>% 
      select(name, review_count, Number_of_Checkins, stars) %>% 
      filter(stars == input$stars)
    
    scatter <- plot_ly(vegas, x = ~Number_of_Checkins, y = ~review_count, 
            type = 'scatter', 
            mode = 'markers',
            hoverinfo = 'text',
            text = ~paste('</br> Restaurant: ', name,
                          '</br> Number of Check-Ins: ', Number_of_Checkins,
                          '</br> Number of Reviews: ', review_count)) %>%
      layout(title = 'Correlation Between Check-Ins and Reviews',
           xaxis = list(title = 'Number of Check-Ins'),
           yaxis = list(title = 'Review Count'),
           showlegend = FALSE)
    
    fit <- lm(review_count ~ Number_of_Checkins, data=vegas)
    
    # Display regressions if specified by widget
    if(input$lines) {
      scatter <- scatter %>% add_lines(x = ~Number_of_Checkins, 
                                       y = fitted(fit))
    }
    scatter
  })
  
  output$equation <- renderText({
    if(input$lines) {
      vegas <- yelp %>% filter(city == "Las Vegas") %>% 
        select(review_count, Number_of_Checkins, stars) %>% 
        filter(stars == input$stars)
      linearMod <- lm(review_count ~ Number_of_Checkins, data=vegas)
      paste0("Reviews = ", 
             format(round(coef(linearMod)["(Intercept)"], 2), nsmall = 2),
             " + ", 
             format(round(coef(linearMod)["Number_of_Checkins"], 2), 
                    nsmall = 2),
             "*Check-Ins"
      )
    }
  })
  
  output$rsquared <- renderText({
    if(input$lines) {
      vegas <- yelp %>% filter(city == "Las Vegas") %>% 
        select(review_count, Number_of_Checkins, stars) %>% 
        filter(stars == input$stars)
      linearMod <- lm(review_count ~ Number_of_Checkins, data=vegas)
      paste0("R-squared: ", 
             format(round(summary(linearMod)$r.squared, 2), nsmall = 2)
      )
    }
  })
}

