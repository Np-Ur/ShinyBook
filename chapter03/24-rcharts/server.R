library(rCharts)
library(shiny)

shinyServer(function(input, output) {
  output$my_chart <- renderChart({
    names(iris) = gsub("\\.", "", names(iris))
    
    p1 <- nPlot(x = input$x, y = input$y, data = iris, type = 'scatterChart', group = "Species")
    
    p1$addParams(dom = 'my_chart')
    return(p1)
  })
})