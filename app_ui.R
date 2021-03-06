library("shiny")
library("plotly")
library("leaflet")

intro_page <- tabPanel(
  "Introduction of Project",
  img(src = "Yelp.png", class = "center"),
  includeCSS("styles/intro.css"),
  h1(class = "center", "What's Our Goal?"),
  h4(class = "center_text", "In our current day and age, having an effective
  digital presence on the internet can be vital to the success of a business.
  Yelp is a social platform that boasts 178 million monthly users. It provides
  businesses with a way to connect with their customers as well as for
  potential customers to look and gather more information into businesses.
  However, Yelp is a platform that has extensive data that can be
  overwhelming. Our project takes a look at how businesses can use Yelp
  data to become more competitive in their region against other businesses.
  This problem requires us to take a look at what other businesses are
  around the area, the average star rating, and the average price range."),
  h1(class = "center", "What Data Are We Using?"),
  h4(class = "center_text", "In order to answer this question, we will be using
     the Yelp and the Yelp API Data based in R. The Yelp Data Set gave us all
     the information that Yelp collects from their members. Through the data,
     we will be creating interactive graphs and visualizations that would
     benefit new and current business owners. Since the Yelp Data Set is
     particularly large and spans across the continental United States, we
     thought it would beneficial to focus on a small area to show the biggest
     impact. For this project, we decided to focus in the region of Las Vegas,
     Nevada."),
  h3(class = "center", "In this report, you will see three charts"),
  tags$li(class = "center_text", "Scatter Plot Between Yelp Check-Ins and
          Reviews"),
  tags$li(class = "center_text", "Bar Graph of Price Ranges"),
  tags$li(class = "center_text", "Map of Restaurants and Ratings"),
  h3(class = "center", "Created by"),
  tags$li(class = "center_text", "Johnny Yang"),
  tags$li(class = "center_text", "David Chiang"),
  tags$li(class = "center_text", "Justin Bao"),
  tags$li(class = "center_text", "Siddharth Jayadev")
)

scatterplot_page <- tabPanel(
  "Check-Ins and Reviews",
  includeCSS("styles/scatter_style.css"),
  titlePanel("Check-Ins and Reviews - Is There a Trend?"),

  sidebarLayout(
    sidebarPanel(
      id = "sidebar_scatter",
      sliderInput(
        "stars",
        label = h3("Number of Stars"),
        min = 1,
        max = 5,
        value = 3,
        step = 0.5
      ),
      checkboxInput("lines", "Include Regression Lines", value = FALSE),
      checkboxInput("scale", "Adjust Scale According to Plot", value = FALSE)
    ),
    mainPanel(
      id = "main_scatter",
      br(),
      plotlyOutput("reviews_scatterplot"),
      br(),
      textOutput("equation"),
      textOutput("rsquared"),
      br(),
      p("This scatter plot analyzes the correlation between the number of
        check-ins and the number of reviews on Yelp for restaurants in the
        Las Vegas area. Restaurants are grouped by star rating using the widget
        on the left, and linear regression lines can be toggled along with the
        corresponding intercept, coefficient, and R-squared values to analyze
        the strength of the regression. By observing the relationship between
        these metrics, restaurants can achieve a better understanding of how to
        market Yelp ratings in their restaurant to obtain more reviews and
        better reviews.")
    )
  )
)

bar_chart_page <- tabPanel(
  "Price Range",
  includeCSS("styles/bar_style.css"),
  titlePanel("Price Range of Businesses in the Las Vegas Area"),
  sidebarLayout(
    sidebarPanel(
      id = "sidebar_bar",
      selectInput(
        inputId = "City",
        label = "City",
        choice = c("Las Vegas", "North Las Vegas", "Henderson")
      ),
      selectInput(
        inputId = "Color",
        label = "Color",
        choice = c("Blue", "Green", "Orange", "Pink", "Brown")
      )
    ),
    mainPanel(
      id = "main_bar",
      br(),
      plotlyOutput("bar"),
      br(),
      p(
        "This interactive bar chart with the ability to change color visuals
        is used to analyze the price range of businesses in the different
        cities in Nevada, particularly the more populated ones: Las Vegas,
        North Las Vegas, and Henderson. The chart can be used to select
        among the three different cities and see the corresponding number
        of businesses in each price range. It seeks to answer any questions
        potential business owners might have about which price range do
        most businesses in a certain city fall into. This chart will allow
        business owners to make a more concrete decision on where to locate
        their business and the socioeconomic class of customers they will be
        encountering."
      )
    )
  )
)

map_page <- tabPanel(
  "Map of Ratings",
  includeCSS("styles/map_style.css"),
  titlePanel("Geographic Distribution of Different Rated Restaurants"),

  sidebarLayout(
    sidebarPanel(
      id = "sidebar_map",
      checkboxGroupInput(
        "stars_group",
        label = h3("Number of Stars"),
        choices = list(1, 2, 3, 4, 5),
        selected = list(1, 2, 3, 4, 5)
      )
    ),
    mainPanel(
      id = "main_map",
      br(),
      leafletOutput("ratings_map"),
      br(),
      p("This interactive map allows us to view the geographic distribution of
        restaurants in the Las Vegas area. The color-coded legend and the
        widget on the left allow us to sort the points on the map by Yelp rating
        for a visual representation of the best (and worst) rated restaurants
        and what areas tend to have certain ratings.")
    )
  )
)

conclusion_page <- tabPanel(
  "Summary",
  includeCSS("styles/conclusion_style.css"),
  titlePanel("Summary Takeaways"),

  h3("The Relationship Between Check-Ins and Reviews and What That Means for
     Marketing"),
  p("When we observe the correlation between check-ins and reviews for
    different restaurants, we can see a generally consistent trend that wavers
    depending on the rating of the restaurant. While there isn't much of a
    connection for lower ratings, with 1-star restaurants having an R-squared
    as low as 0.02, the correlation is still somewhat consistent with R-squared
    values of 0.6 or higher. It's clear that the trend is positive in all cases,
    with more check-ins correlating to more reviews, but the magnitude of these
    trends vary according to the ratings. More average ratings, tending
    towards the ranges of 2-4 stars, have a typically higher coefficient in the
    correlation whereas the outer ratings have less of an effect. Thus, unless
    a restaurant has either unanimously awful or amazing ratings, it should try
    to invest heavily into its marketing, specifically word-of-mouth advertising
    through Yelp, in order to
    increase its amount of visitors in order to attain more reviews and gain
    traction on Yelp and in the reviewing sphere in general. However, once a
    business has attracted enough visitors, the ratings become more steady."),

  h3("Using Price Ranges to Select a Location"),
  p("The bar chart reveals that Las Vegas has a bigger proportion of businesses
    above the $31 range seen from the greater height of the bin compared to
    North Las Vegas and Henderson, demonstrating that most businesses appeal to
    customers toward the upper middle-class status. North Las Vegas has
    227 companies under $10, and 234 companies between $11-30, showing how most
    businesses appeal towards the lower middle-class status. Meanwhile, the bar
    chart reveals that most companies are in the $11-30 in Henderson, revealing
    how the general area is mostly filled with companies targeting the
    middle-class consumers. Through analyzing the different cities and price
    ranges, businesses that sell more luxurious items should open in Las Vegas
    to reach their target upper middle class consumers. Businesses that have
    products with a price range affordable to the average working class should
    open in Henderson. Finally, businesses whose products can be affordable and
    accessible to people with lower income should open a store in North Las
    Vegas, reaching the lower middle class consumers."),

  h3("Finding the Optimal Locations for Best Ratings"),
  p("When we observe the 4- and 5-star rated restaurants in the Las Vegas area,
    we'll notice that the majority of highest-rated restaurants are located in
    the hotspots of the city, namely the Strip. Meanwhile, lower rated
    restaurants, specifically those with 1-star ratings, were more scattered
    around the area. Thus, for a new business, location is extremely important,
    with more traffic and popular, reputable sites typically leading to higher
    ratings in general.")
)

my_ui <- navbarPage(
  "How Yelp Can Support a New Business",
  intro_page,
  scatterplot_page,
  bar_chart_page,
  map_page,
  conclusion_page
)
