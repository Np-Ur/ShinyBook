library(shiny)
library(DT)

ui <- fluidPage(
  titlePanel("DT::renderDataTable"),
  DT::dataTableOutput("table")
)

server <- function(input, output) {
  output$table <- DT::renderDataTable(
    iris,
    extensions = c('Buttons'),
    options = list(lengthMenu = c(5, 10, 20),
                   dom = 'Blfrtip',
                   pageLength = 5,
                   buttons = c('csv', 'excel', 'pdf'))
  )
}

shinyApp(ui = ui, server = server)