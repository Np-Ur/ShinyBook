shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    x = faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(faithful[, 2], breaks = bins, col = input$color, border = 'white')
  })
})