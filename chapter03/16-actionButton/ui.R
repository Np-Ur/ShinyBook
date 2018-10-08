library(shiny)

shinyUI(fluidPage(
  
  titlePanel("actionButton"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1, max = 50, value = 30),
      actionButton("do", "プロットを実行")
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
))