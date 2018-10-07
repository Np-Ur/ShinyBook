library(shiny)
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    # uiから受け取ったbins情報をもとに階級幅の生成
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # ヒストグラムの生成
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
})

