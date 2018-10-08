library(shiny)

shinyServer(function(input, output) {
  
  time_interval <- reactiveTimer(1000)
  
  output$plot <- renderPlot({
    time_interval()
    hist(rnorm(isolate(input$n)), col = rgb(runif(1), runif(1), runif(1)))
  })
})
