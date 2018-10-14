library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Old Faithful Geyser Data"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30), # カンマを追加
      img(src = "sample.jpg", height = 70, width = 90) # ここを一行追加
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
))