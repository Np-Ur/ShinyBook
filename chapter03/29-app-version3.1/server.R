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
    data <- callModule(dataSelect, "plot")
    
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
  
  # -------------------------
  # regressionに関する処理
  # -------------------------
  
  data_for_regression <- reactive({
    data <- callModule(dataSelect, "regression")
    updateSelectInput(session, "data_for_regressionY", choices = colnames(data), 
                      selected = colnames(data)[1])
    
    return(na.omit(data))
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
    
    tmp_data_list <- get_train_and_test_data(data_for_regression(),
                                             isolate(input$data_for_regressionY),
                                             isolate(input$data_table_for_regression_rows_selected))
    
    data_train_and_test$train <- tmp_data_list[[1]]
    data_train_and_test$test <- tmp_data_list[[2]]
    
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
  
  # -------------------------
  # classificationに関する処理
  # -------------------------
  
  data_for_classification <- reactive({
    data <- callModule(dataSelect, "classification")
    updateSelectInput(session, "data_for_classificationY", 
                      choices = colnames(data), selected = colnames(data)[1])
    return(na.omit(data))
  })
  
  output$data_table_for_classification <- DT::renderDataTable(
    t(data_for_classification()[1:10, ]), selection = list(target = 'row')
  )
  
  output$rows_selected_classification <- renderPrint(
    input$data_table_for_classification_rows_selected
  )
  
  data_train_and_test_classification <- reactiveValues()
  
  classification_summary <-  reactive({
    input$classification_button
    
    tmp_data_list <- get_train_and_test_data(data_for_classification(),
                                             isolate(input$data_for_classificationY),
                                             isolate(input$data_table_for_classification_rows_selected))
    data_train_and_test_classification$train <- tmp_data_list[[1]]
    data_train_and_test_classification$test <- tmp_data_list[[2]]
    
    return(train(dependent_variable ~.,
                 data = data_train_and_test_classification$train,
                 method = isolate(input$classification_type),
                 tuneLength = 4,
                 preProcess = c('center', 'scale'),
                 trControl = trainControl(method = "cv"),
                 linout = FALSE))
  })
  
  output$summary_classification <- renderPrint({
    cat("サマリー）")
    print(confusionMatrix(data = predict(classification_summary(), 
                                         data_train_and_test_classification$test),
                          data_train_and_test_classification$test$"dependent_variable"))
    summary(classification_summary())
  })
  
  # -------------------------
  # clusteringに関する処理
  # -------------------------
  
  data_for_clustering <- reactive({
    data <- callModule(dataSelect, "clustering")
    return(na.omit(data))
  })
  
  output$data_table_for_clustering <- DT::renderDataTable(
    t(data_for_clustering()[1:10, ]), selection = list(target = 'row')
  )
  
  output$rows_selected_clustering <- renderPrint(
    input$data_table_for_clustering_rows_selected
  )
  
  clustering_summary <-  reactive({
    input$clustering_button
    
    clusters <- kmeans(isolate(data_for_clustering()[, 
                          input$data_table_for_clustering_rows_selected]),
                       centers = isolate(input$cluster_number))
    return(clusters$cluster)
  })
  
  output$data_with_clustering_result <- DT::renderDataTable({
    cbind(clustering_summary(), data_for_clustering())
  })
})