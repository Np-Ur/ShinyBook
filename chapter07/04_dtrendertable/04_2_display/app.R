library(shiny)
library(DT)

ui <- fluidPage(
  titlePanel("DT::renderDataTable"),
  DT::dataTableOutput("table")
)

server <- function(input, output) {
  output$table <- DT::renderDataTable(
    iris,
    options = list(lengthMenu = c(5, 10, 20), pageLength = 5))
}

shinyApp(ui = ui, server = server)