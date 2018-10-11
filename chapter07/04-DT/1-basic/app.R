library(shiny)
library(DT)

ui <- fluidPage(
  titlePanel("DT::renderDataTable"),
  DT::dataTableOutput("table")
)

server <- function(input, output) {
  output$table <- DT::renderDataTable(iris)
}

shinyApp(ui = ui, server = server)
