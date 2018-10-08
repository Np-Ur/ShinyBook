library(shiny)
library(MASS)
library(kernlab)
data(spam)

shinyServer(function(input, output) {
  output$distPlot_shiny <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins_shiny + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  
  data_for_plot <- reactive({
    switch(input$selected_data_for_plot,
           "iris" = iris,
           "infert" = infert,
           "Boston" = Boston,
           "spam" = spam,
           "airquality" = airquality,
           "titanic" = data.frame(lapply(data.frame(Titanic), 
                                 function(i){rep(i, data.frame(Titanic)[, 5])}))
    )
  })
  
  output$table_for_plot <- renderTable({
    data_for_plot()
  })
})