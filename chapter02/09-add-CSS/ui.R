library(shiny)

shinyUI(fluidPage(
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")), # ここを追加
  titlePanel("Old Faithful Geyser Data"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      img(src="sample.jpg", height = 70, width = 90)
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
))