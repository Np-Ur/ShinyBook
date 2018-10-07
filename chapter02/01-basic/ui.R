library(shiny)

shinyUI(fluidPage(
  
  # アプリのタイトル
  titlePanel("Old Faithful Geyser Data"),
  
  # スライダーの設定
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # ヒストグラムの表示の部分
    mainPanel(
      plotOutput("distPlot")
    )
  )
))