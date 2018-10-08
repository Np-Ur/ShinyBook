library(shiny)

shinyServer(function(input, output) {
  
  output$plot <- renderPlot({
    x <- iris[, input$numericInput_data]
    bins <- seq(min(x), max(x), length.out = input$sliderInput_data + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
})
