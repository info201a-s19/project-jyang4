library(plotly)

scatterplot_page <- tabPanel(
  "Check-Ins vs. Reviews",
  includeCSS("styles/scatter_style.css"),
  titlePanel("Check-Ins and Reviews - Is There a Trend?"),
  
  sidebarLayout(
    sidebarPanel(
      id = "sidebar",
      sliderInput(
        "stars",
        label = h3("Number of Stars"),
        min = 1,
        max = 5,
        value = 3,
        step = 0.5
      ),
      checkboxInput("lines", "Include Regression Lines", value = FALSE),
      checkboxInput("scale", "Adjust Scale According to Plot", value = FALSE),
      p("This scatter plot analyzes the correlation between the number of
        check-ins and the number of reviews on Yelp for restaurants in the
        Las Vegas area. Restaurants are grouped by star rating using the widget
        on the left, and linear regression lines can be toggled along with the
        corresponding intercept, coefficient, and R-squared values to analyze
        the strength of the regression. By observing the relationship between
        these metrics, restaurants can achieve a better understanding of how to
        market Yelp ratings in their restaurant to obtain more reviews and
        better reviews.")
    ),
    mainPanel(
      id = "main",
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
