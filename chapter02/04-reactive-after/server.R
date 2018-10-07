shinyServer(function(input, output) {
  
  bins <- reactive({
    x = faithful[, 2]
    return (seq(min(x), max(x), length.out = input$bins + 1))
  })
  
  output$distPlot <- renderPlot({
    hist(faithful[, 2], breaks = bins(), col = input$color, border = 'white')
  })
})