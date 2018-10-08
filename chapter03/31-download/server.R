library(shiny)

shinyServer(function(input, output) {
  
  output$plot <- renderPlot({
    plot(iris[, c(1, 2)])
  })
  
  data_brushed <- reactive({
    return(brushedPoints(iris, input$brush, xvar = "Sepal.Length", yvar = "Sepal.Width"))
  })
  
  output$brushed_point <- DT::renderDataTable({
    data_brushed()
  })
  
  output$download_data = downloadHandler(
    filename = "iris_brushed.csv",
    content = function(file) {
      write.csv(data_brushed(), file)
    }
  )
})