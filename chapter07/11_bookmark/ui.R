function(request) {
  fluidPage(
    titlePanel("ブックマーク機能"),
    
    sidebarLayout(
      sidebarPanel(
        sliderInput("bins",
                    "Number of bins:",
                    min = 1, max = 50, value = 30),
        bookmarkButton()
      ),
      
      mainPanel(
        plotOutput("distPlot")
      )
    )
  )
}
