library(dplyr)
library(plotly)
library(ggplot2)

scatterplot_page <- tabPanel(
  "Check-Ins vs. Reviews",
  titlePanel("Check-Ins and Reviews - Is There a Trend?"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        "stars",
        "Number of Stars",
        min = 1,
        max = 5,
        value = 3,
        step = 0.5
      ),
      checkboxInput("lines", "Include Regression Lines", value = FALSE)
    ),
    mainPanel(
      plotlyOutput("reviews_scatterplot"),
      textOutput("equation"),
      textOutput("rsquared")
    )
  )
)

my_ui <- navbarPage(
  "How Yelp Can Support a New Business",
  scatterplot_page
)
