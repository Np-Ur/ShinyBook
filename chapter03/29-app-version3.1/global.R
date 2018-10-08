library(shiny)
library(DT)
library(caret)
library(MASS)
library(kernlab)
data(spam)

# ui modules
dataSelectUI <- function(id){
  ns <- NS(id)
  
  tagList(
    selectInput(ns("selected_data"), label = h3("データセットを選択してください。"),
                choices = c("アヤメのデータ" = "iris",
                            "不妊症の比較データ" = "infert",
                            "ボストン近郊の不動産価格データ" = "Boston",
                            "スパムと正常メールのデータ" = "spam",
                            "ニューヨークの大気状態データ" = "airquality",
                            "タイタニックの乗客データ" = "titanic"),
                selected = "iris")
  )
}

# server modules
dataSelect <- function(input, output, session, type){
  data <- switch(input$selected_data,
                "iris" = iris,
                "infert" = infert,
                "Boston" = Boston,
                "spam" = spam,
                "airquality" = airquality,
                "titanic" = data.frame(lapply(data.frame(Titanic), 
                                       function(i){rep(i, data.frame(Titanic)[, 5])}))
  )
  return(data)
}

# etc
get_train_and_test_data <- function(data, dependent_variable, independent_variable){
  y <- data[, dependent_variable]
  x <- data[, independent_variable]
  
  tmp_data <- cbind(x, y)
  colnames(tmp_data) <- c(colnames(x), "dependent_variable")
  
  # 学習用データと検証データに分ける
  train_index <- createDataPartition(tmp_data$"dependent_variable", 
                                     p = .7, list = FALSE, times = 1)
  data_list <- list()
  data_list <- c(data_list, list(tmp_data[train_index, ]))
  data_list <- c(data_list, list(tmp_data[-train_index, ]))
  
  return(data_list)
}