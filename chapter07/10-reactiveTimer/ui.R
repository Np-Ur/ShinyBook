library(shiny)

shinyUI(fluidPage(
  titlePanel("1秒間隔で色を更新"),
  
  sliderInput("n", "生成するデータの個数", 2, 1000, 500),
  plotOutput("plot")
))