library(shiny)
library(MASS)
library(kernlab)
library(DT)
data(spam)

shinyServer(function(input, output, session) {
  output$distPlot_shiny <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins_shiny + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  
  data_for_plot <- reactive({
    data <- switch(input$selected_data_for_plot,
                   "iris" = iris,
                   "infert" = infert,
                   "Boston" = Boston,
                   "spam" = spam,
                   "airquality" = airquality,
                   "titanic" = data.frame(lapply(data.frame(Titanic), 
                                         function(i){rep(i, data.frame(Titanic)[, 5])}))
    )
    updateSelectInput(session, "select_input_data_for_hist", choices = colnames(data))
    updateSelectInput(session, "input_data_for_scatter_plotX", 
                      choices = colnames(data), selected = colnames(data)[1])
    updateSelectInput(session, "input_data_for_scatter_plotY", 
                      choices = colnames(data), selected = colnames(data)[1])
    
    return(data)
  })
  
  output$histgram <- renderPlot({
    input$trigger_histogram
    
    tmpData <- data_for_plot()[, isolate(input$select_input_data_for_hist)]
    x <- na.omit(tmpData)
    bins <- seq(min(x), max(x), length.out = isolate(input$slider_input_data) + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  
  output$table_for_plot <- DT::renderDataTable({
    data_for_plot()
  })
  
  
  output$scatter_plot <- renderPlot({
    input$trigger_scatter_plot
    plot(isolate(data_for_plot()[, c(input$input_data_for_scatter_plotX, 
                                     input$input_data_for_scatter_plotY)]))
  })
  
  output$plot_brushedPoints <- DT::renderDataTable({
    res <- brushedPoints(data_for_plot(), input$plot_brush, 
                         xvar = input$input_data_for_scatter_plotX,
                         yvar = input$input_data_for_scatter_plotY)
    
    if (nrow(res) == 0)
      return()
    res
  })
})