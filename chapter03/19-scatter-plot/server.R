library(shiny)

shinyServer(function(input, output) {
  data <- reactive({
    iris[, c(input$input_data_for_scatter_plotX, input$input_data_for_scatter_plotY)]
  })
  
  output$scatter_plot <- renderPlot({
    input$trigger_scatter_plot
    plot(isolate(data()))
  })
})