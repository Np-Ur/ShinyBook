library(shiny)
ui <- fluidPage(
 withMathJax(helpText("ベイズの定理　$$p(Y|X)=\\frac{p(X|Y)p(Y)}{p(X)}$$")),
 numericInput("value", "Value", min = 0, max = 10, value = 2),
 uiOutput("test")

)
server <- function(input, output) {
 output$test <- renderUI({
 withMathJax(paste0("\\(k_",input$value ,"\\)"))
 })

}
shinyApp(ui = ui, server = server)