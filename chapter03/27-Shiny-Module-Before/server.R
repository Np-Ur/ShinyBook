library(shiny)

shinyServer(function(input, output) {
  
  output$plot1 <- renderPlot({
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins1 + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  
  output$plot2 <- renderPlot({
    
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins2 + 1)
    
    hist(x, breaks = bins, col = 'black', border = 'white')
  })
})