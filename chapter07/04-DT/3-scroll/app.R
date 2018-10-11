library(shiny)
library(DT)

ui <- fluidPage(
  titlePanel("DT::renderDataTable"),
  DT::dataTableOutput("table")
)

server <- function(input, output) {
  
  output$table <- DT::renderDataTable(
    iris,
    options = list(lengthMenu = c(20, 50, 80),
                   pageLength = 20,
                   scrollY = "200px",
                   scrollCollapse = TRUE))
}

shinyApp(ui = ui, server = server)