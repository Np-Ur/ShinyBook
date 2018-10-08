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
  
  data_for_regression <- reactive({
    data <- switch(input$data_for_regressionX,
                  "iris" = iris,
                  "infert" = infert,
                  "Boston" = Boston,
                  "spam" = spam,
                  "airquality" = airquality,
                  "titanic" = data.frame(lapply(data.frame(Titanic), 
                                         function(i){rep(i, data.frame(Titanic)[, 5])}))
    )
    updateSelectInput(session, "data_for_regressionY", choices = colnames(data), 
                      selected = colnames(data)[1])
    
    return(data)
  })
  
  output$data_table_for_regression <- DT::renderDataTable(
    t(data_for_regression()[1:10, ]), selection = list(target = 'row')
  )
  
  output$rows_selected <- renderPrint(
    input$data_table_for_regression_rows_selected
  )
  
  data_train_and_test <- reactiveValues()
  
  regression_summary <-  reactive({
    input$regression_button
    
    y <- data_for_regression()[, isolate(input$data_for_regressionY)]
    x <- data_for_regression()[, isolate(input$data_table_for_regression_rows_selected)]
    
    tmp_data <- cbind(na.omit(x), na.omit(y))
    colnames(tmp_data) <- c(colnames(x), "dependent_variable")
    train_index <- createDataPartition(tmp_data$"dependent_variable", p = .7,
                                       list = FALSE,
                                       times = 1)
    data_train_and_test$train <- tmp_data[train_index, ]
    data_train_and_test$test <- tmp_data[-train_index, ]
    
    return(train(dependent_variable ~.,
                 data = data_train_and_test$train,
                 method = isolate(input$regression_type),
                 tuneLength = 4,
                 preProcess = c('center', 'scale'),
                 trControl = trainControl(method = "cv"),
                 linout = TRUE))
  })
  
  output$summary_regression <- renderPrint({
    predict_result_residual <- predict(regression_summary(), data_train_and_test$test) - 
                                      data_train_and_test$test$"dependent_variable"
    cat("MSE（平均二乗誤差）")
    print(sqrt(sum(predict_result_residual ^ 2) / nrow(data_train_and_test$test)))
    summary(regression_summary())
  })
  
  output$plot_regression <- renderPlot({
    plot(predict(regression_summary(), data_train_and_test$test),
         data_train_and_test$test$"dependent_variable", 
         xlab="prediction", ylab="real")
    abline(a=0, b=1, col="red", lwd=2)
  })
})