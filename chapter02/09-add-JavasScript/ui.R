library(shiny)

shinyUI(fluidPage(
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
            tags$script(src = "color_change.js")), # 追加
  titlePanel("Old Faithful Geyser Data"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      img(src="sample.jpg", height = 70, width = 90),
      # 以下追加
      a(href = "javascript:changeBG('red')", "赤"),
      a(href = "javascript:changeBG('blue')", "青"),
      a(href = "javascript:changeBG('green')", "緑"),
      a(href = "javascript:changeBG('#b0c4de')", "リセット")
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
))