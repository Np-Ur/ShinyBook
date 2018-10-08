library(shiny)

shinyUI(
  fluidPage(
    titlePanel("タイトル"),
    
    sidebarLayout(
      sidebarPanel(
        sliderInput("bins",
                    "Number of bins:",
                    min = 1, max = 50, value = 30)
      ),
      
      mainPanel(
        tabsetPanel(type = "tabs",
                    tabPanel("Plot", plotOutput("distPlot")),
                    tabPanel("Table", tableOutput("table"))
        )
      )
    )
  )
)