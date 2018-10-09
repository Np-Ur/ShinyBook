library(shiny)
library(DT)
library(ReporteRs)
library(rJava)
library(ggplot2)

shinyServer(function(input, output, session) {
  
  output_plot_fun <- reactive({
    data <- data.frame(x = iris[, input$select], y = iris$Sepal.Length)
    ggplot(data, aes(x = x, y = y)) + geom_point(colour = input$color)
  })
  
  output$plot <- renderPlot({
    print(output_plot_fun())
  })
  
  output$downloadData <- downloadHandler(filename = "testfile.pptx", 
                                         content <- function(file) {
                                           doc <- pptx()
                                           
                                           # Slide 1
                                           doc <- addSlide(doc, "Title Slide")
                                           doc <- addTitle(doc, "Rから作ったパワポです")
                                           doc <- addSubtitle(doc, "皆さん使ってください")
                                           
                                           # Slide 2
                                           doc <- addSlide(doc, "Title and Content")
                                           doc <- addTitle(doc, "2ページ目")
                                           doc <- addPlot(doc, fun = print, 
                                                          x = output_plot_fun())
                                           writeDoc(doc, file)
                                         })
})