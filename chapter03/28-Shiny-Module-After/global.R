# uiロジック部分をモジュール化
histPlotUI <- function(id, label){
  ns <- NS(id)
  
  tagList(
    sliderInput(ns("bins"),
                paste("Number of bins (",  label, "):"),
                min = 1, max = 50, value = 30),
    plotOutput(ns("plot"))
  )
}

# serverロジック部分をモジュール化
histPlot <- function(input, output, session, color){
  output$plot <- renderPlot({
    
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = color, border = 'white')
  })
}