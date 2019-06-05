library("shiny")
library("plotly")

bar_chart_page <- tabPanel(
  "Price Range",
  titlePanel("How does the Price Range of Businesses in Las Vegas Compare
             to Other Cities in Nevada?"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "City",
        label = "City",
        choice = c("Las Vegas", "North Las Vegas", "Henderson")
      ),
      selectInput(
        inputId = "Color",
        label = "Color",
        choice = c("Blue", "Green", "Orange", "Pink", "Brown")
      ),
      p(
        "This interactive bar chart with the ability to change color visuals
        is used to analyze the price range of businesses in the different
        cities in Nevada, particularily the more populated ones: Las Vegas,
        North Las Vegas, and Henderson. Business owners seeking to start a
        business in Nevada can select different cities and see the most
        common type of price ranges businesses fall into. The bar chart reveals
        that Las Vegas has a bigger proportion of businesses above the $31
        range seen from the greater height of the bin compared to North Las
        Vegas and Henderson, demonstrating that most businesses appeal to
        customers toward the upper middle class status. North Las Vegas has
        227 companies under $10, and 234 companies between $11-30, showing
        how most businesses appeal towards the lower middle class status.
        Meanwhile, the bar chart reveals that most companies are in the
        $11-30 in Henderson, revealing how the general area is mostly filled
        with companies targeting the middle class consumers."
      )
    ),
    mainPanel(
      plotlyOutput("bar")
    )
  )
)

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
  scatterplot_page,
  bar_chart_page
)