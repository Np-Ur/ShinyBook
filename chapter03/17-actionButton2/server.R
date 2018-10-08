library(shiny)

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    input$do
    
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = isolate(input$bins) + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
})