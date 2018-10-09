library(shiny)
library(ggplot2)

ui <- shinyUI(fluidPage(    
  selectInput("sel1", label = "x軸", choices = colnames(iris)[1:4]),
  selectInput("sel2", label = "y軸", choices = colnames(iris)[1:4]),
  selectInput("color", label = "色", 
              choices = c("red", "black", "blue", "green")),
  plotOutput("plot")
))

server <- shinyServer(function(input, output) {
  output$plot <- renderPlot({
    data <- data.frame(x = iris[, input$sel1], y = iris[, input$sel2])
    g <- ggplot(data, aes(x = x, y = y))
    g <- g + geom_point(colour=input$color)
    print(g)
  })   
})

shinyApp(ui = ui, server = server)