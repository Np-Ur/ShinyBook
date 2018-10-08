library(shiny)

shinyServer(function(input, output) {
  data <- reactive({
    iris[, c(input$input_data_for_scatter_plotX, input$input_data_for_scatter_plotY)]
  })
  
  output$scatter_plot <- renderPlot({
    input$trigger_scatter_plot
    plot(isolate(data()))
  })
  
  output$plot_brush_info <- renderPrint({
    cat("ダブルクリックした箇所の情報:\n")
    str(input$plot_brush)
  })
  
  output$plot_brushedpoints <- DT::renderDataTable({
    res <-  brushedPoints(iris, input$plot_brush, 
                          xvar = input$input_data_for_scatter_plotX,
                          yvar = input$input_data_for_scatter_plotY)
    
    if (nrow(res) == 0)
      return()
    res
  })
})