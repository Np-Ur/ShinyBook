library(shiny)

shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs_1))
  })
})
