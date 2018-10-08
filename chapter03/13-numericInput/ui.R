library(shiny)

shinyUI(fluidPage(
  
  titlePanel("numericInput"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("numericInput_data",
                   "irisデータでヒストグラムを表示する列番号",
                   min = 1,
                   max = 5,
                   value = 1),
      sliderInput("sliderInput_data",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    mainPanel(
      plotOutput("plot")
    )
  )
))