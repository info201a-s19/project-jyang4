library("shiny")

# First page with the interactive bar chart with color changes.
bar_chart_page <- tabPanel(
  "Price Range",
  titlePanel("How does the Price Range of Businesses in Las Vegas Compare to Other Cities in Nevada?"),
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
      )
    ),
    mainPanel(
      plotlyOutput("bar")
    )
  )
)

# Title of the navigation bar page.
my_ui <- navbarPage(
  "Visual Interpretation of the United States Midwest",
  bar_chart_page
)