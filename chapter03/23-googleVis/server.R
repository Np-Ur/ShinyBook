library(shiny)
library(googleVis)

# インデックス番号付きのデータ生成
iris_with_index <- iris
iris_with_index$index <- c(1:150)

# 各品種の平均値を計算
iris_summary <- data.frame(species=unique(iris$Species),
                         SepalLength=c(mean(iris$Sepal.Length[1:50]), 
                                       mean(iris$Sepal.Length[51:100]), 
                                       mean(iris$Sepal.Length[101:150])),
                         SepalWidth=c(mean(iris$Sepal.Width[1:50]), 
                                      mean(iris$Sepal.Width[51:100]), 
                                      mean(iris$Sepal.Width[101:150])))

shinyServer(function(input, output) {
  data <- reactive({
    iris[, c(input$input_data_for_scatter_plotX, input$input_data_for_scatter_plotY)]
  })
  
  output$scatter_plot <- renderGvis({
    input$trigger_scatter_plot
    gvisScatterChart(isolate(data()))
  })
  
  output$line_plot <- renderGvis({
    gvisLineChart(iris_summary)
  })
  
  output$bar_plot <- renderGvis({
    gvisBarChart(iris_summary)
  })
  
  output$column_plot <- renderGvis({
    gvisColumnChart(iris_summary)
  })
  
  output$bubble_chart <- renderGvis({
    gvisBubbleChart(iris_with_index, idvar = "index", xvar="Sepal.Length", 
                    yvar="Sepal.Width", colorvar="Species", sizevar="Petal.Length")
  })
})