library(shiny)

shinyServer(function(input, output) {
  x <- faithful[, 2]
  
  
  bins <- eventReactive(input$do, {
    seq(min(x), max(x), length.out = input$bins + 1)
  })
  
  output$distPlot <- renderPlot({
    hist(x, breaks = bins(), col = 'darkgray', border = 'white')
  })
})