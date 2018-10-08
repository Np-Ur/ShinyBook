library(shiny)
library(shinycssloaders)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        withSpinner(plotOutput("distPlot"), type = 1, color.background = "white")
        #下記記法でも可 
        #plotOutput("distPlot") %>%
        #    withSpinner(type=3,color.background = "white")
      )
   )
)

server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     withProgress(message = "実行中です", value=0, {
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      for(i in 1:6){
        incProgress(1/6)
        Sys.sleep(1.0)
      }
      
      hist(x, breaks = bins, col = 'darkgray', border = 'blue')
     })
   })
}

shinyApp(ui = ui, server = server)

