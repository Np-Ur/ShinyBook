library(shiny)

shinyUI(fluidPage(
  titlePanel("fluid row sample!"),
  fluidRow(
    column(4,
           sliderInput("obs_1",
                       "Number of observations:",
                       min = 0,
                       max = 1000,
                       value = 500)
    ),
    column(4,
           sliderInput("obs_2",
                       "Number of observations:",
                       min = 0,
                       max = 1000,
                       value = 500)
    ),
    column(4,
           mainPanel(
             plotOutput("distPlot")
           )
    )
  )
))