library("shiny")
library("plotly")

intro_page <- tabPanel(
  "Introduction of Project",
  img(src = "/Yelp.png"),
  includeCSS("styles/intro.css"),
  h1(class = "center", "What's Our Goal?"),
  h4(class = "center_text", "In our current day and age,having a effective digital
     presence on the internet can be vital to the success of a business. Yelp
     is a social platform that boasts 178 million monthly users. It provides
     businesses with a way to connect with their customers as well as for 
     potential customers to look and gather more information into businesses. 
     However, Yelp is a platform that has extensive data that can be 
     overwhleming. Our project takes a look at how businesses can use Yelp 
     data to become more competitive in their region against other businesses. 
     This problem requires us to take a look at what other businesses are
     around the area, the average star rating, and the average price range.
     "),
  h1(class = "center", "What Data Are We Using?"),
  h4(class = "center_text", "In order to answer this question, we will be using
     the Yelp
     and the Yelp API Data based in R. The Yelp Data Set gave us all the 
     information that Yelp collects from their members. Through the data, we
     will be creating interactive graphs and visualizations that would benefit
     new and current business owners.Since the Yelp Data Set is particularly large and
     spans across the continental United States, we thought it would 
     benefical to focus on a small area to show the biggest impact. For
     this project, we decided to focus in the region of Las Vegas, Nevada."),
  h3(class = "center", "In this report, you will see three charts"),
  tags$li(class = "center_text", "Scatter Plot"),
  tags$li(class = "center_text", "Insert Title Name"),
  tags$li(class = "center_text", "Gender difference in Occupations"),
  h3(class = "center", "Created by"),
  tags$li(class = "center_text", "Johnny Yang"),
  tags$li(class = "center_text", "David Chiang"),
  tags$li(class = "center_text", "Justin Bao"),
  tags$li(class = "center_text", "Siddharth Jayadev")
  
  )

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
      checkboxInput("scale", "Adjust Scale According to Plot", value = FALSE)
    ),
    mainPanel(
      id = "main",
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

conclusion_page <- tabPanel(
  "Summary",
  includeCSS("styles/conclusion_style.css"),
  titlePanel("Summary Takeaways"),
  
  h3("The Relationship Between Check-Ins and Reviews"),
  p("When we observe the correlation between check-ins and reviews for
    different restaurants, we can see a generally consistent trend that wavers
    depending on the rating of the restaurant.")
)

my_ui <- navbarPage(
  "How Yelp Can Support a New Business",
  intro_page,
  scatterplot_page,
  bar_chart_page,
  conclusion_page
)