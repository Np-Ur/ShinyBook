shinyServer(function(input, output) {
  
  output$table <- renderTable({
    sql <- "SELECT * FROM City WHERE ID = ?id;"
    query <- sqlInterpolate(pool, sql, id = input$id)
    dbGetQuery(pool, query)
  })
})
