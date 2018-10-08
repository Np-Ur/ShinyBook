library(shiny)

shinyServer(function(input, output, session) {
  observeEvent(input$file, {
    
    csv_file <- reactive(read.csv(input$file$datapath))
    output$table <- renderTable(csv_file())
  })
})