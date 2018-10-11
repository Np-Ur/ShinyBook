server = function(input, output, session) {
  observeEvent(input$mydata, {
    name = names(input$mydata)
    csv_file = reactive(read.csv(text=input$mydata[[name]]))
    output$table = renderTable(csv_file())
  })
}