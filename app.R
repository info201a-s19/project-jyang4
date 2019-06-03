# Executes the respective files
source("app_ui.R")
source("app_server.R")

# Creates a new shinyApp using the loaded ui and server variables
shinyApp(ui = my_ui, server = my_server)
