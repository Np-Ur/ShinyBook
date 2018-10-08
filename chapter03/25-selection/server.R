library(shiny)
library(DT)

shinyServer(function(input, output) {
  output$data1 <- DT::renderDataTable(
    iris, selection = list(target = 'row')
  )
  
  output$data2 <- DT::renderDataTable(
    iris, selection = list(target = 'column')
  )
  
  output$data3 <- DT::renderDataTable(
    iris, selection = list(target = 'cell')
  )
  
  output$rows_selected <- renderPrint(
    input$data1_rows_selected
  )
  
  output$columns_selected <- renderPrint(
    input$data2_columns_selected
  )
  
  output$cells_selected <- renderPrint(
    input$data3_cells_selected
  )
})