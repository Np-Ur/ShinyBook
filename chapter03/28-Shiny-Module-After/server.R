library(shiny)

shinyServer(function(input, output) {
  callModule(histPlot, "bins1", "darkgray")
  callModule(histPlot, "bins2", "black")
})