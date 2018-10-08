library(shiny)

shinyServer(function(input, output) {
  data <- reactive({
    iris[, c(input$input_data_for_scatter_plotX, input$input_data_for_scatter_plotY)]
  })
  
  output$scatter_plot <- renderPlot({
    input$trigger_scatter_plot
    plot(isolate(data()))
  })
  
  output$plot_dbl_click_info <- renderPrint({
    cat("ダブルクリックした箇所の情報:\n")
    str(input$plot_dbl_click)
  })
  
  output$plot_clickedpoints <- DT::renderDataTable({
    res <- nearPoints(iris, input$plot_dbl_click, xvar = input$input_data_for_scatter_plotX,
                      yvar = input$input_data_for_scatter_plotY,
                      threshold = 5, maxpoints = 10)
    
    if (nrow(res) == 0)
      return()
    res
  })
})