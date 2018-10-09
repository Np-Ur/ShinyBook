server <- function(input, output) {
  values <- reactiveValues(geocodes = rbind(c(139.6917, 35.68949),
                                            c(140.1233, 35.60506)))
  
  observeEvent(input$submit_dist, {
    geo1 <- geocode(input$search_word1)
    geo2 <- geocode(input$search_word2)
    
    # modalダイアログの表示
    if (is.na(geo1[1, 1]) || is.na(geo2[1, 1])) {
      showModal(modalDialog(title = "エラー", "検索条件に該当するデータがありません",
                            easyClose = TRUE, footer = modalButton("OK")))
    }
    # geo1 geo2どちらかがnullであれば、これ以降の動作を止める
    req(geo1[1, 1])
    req(geo2[1, 1])
    
    values$geocodes <- rbind(geo1, geo2)
  })
  
  output$plot_dist <- renderLeaflet({
    geo1_lng <- values$geocodes[1, 1]
    geo1_lat <- values$geocodes[1, 2]
    geo2_lng <- values$geocodes[2, 1]
    geo2_lat <- values$geocodes[2, 2]
    
    leaflet() %>% addTiles() %>%
      setView(lng = (geo1_lng + geo2_lng)/2, lat = (geo1_lat + geo2_lat)/2, zoom = 5) %>%
      addMarkers(lng = geo1_lng, lat = geo1_lat, label = input$search_word1) %>%
      addMarkers(lng = geo2_lng, lat = geo2_lat, label = input$search_word2) %>%
      addMeasure(position = "topright", primaryLengthUnit = "meters")
  })
  
  output$attribute_table <- DT::renderDataTable({
    attribute_data
  })
  
  # 以下追加箇所
  output$choices_for_plot <- renderUI({
    if (is.null(input$category))
      return()
    
    switch(input$category,
           "vegetables" = radioButtons("dynamic", "野菜生産量", choices = vegetables_choices),
           "fruit" = radioButtons("dynamic", "果物生産量", choices = fruit_choices),
           "population" = radioButtons("dynamic", "人口", choices = population_choices)
    )
  })
  
  output$circle_size_ui <- renderUI({
    if (input$plot_type == "circle"){
      sliderInput("size_slider", "Circle Size", min = 1, max = 100000, value = 1000)
    }
  })
  
  output$plot_product <- renderLeaflet({
    selected_attribute <- attribute_data[, input$dynamic]
    pal <- colorNumeric(input$color, domain = selected_attribute)
    
    if (input$plot_type == "circle") {
      leaflet(attribute_data) %>% addTiles() %>%
        setView(lat = 39, lng = 139, zoom = 5) %>%
        addCircles(lng = ~lon, lat = ~lat,
                   radius = sqrt(as.numeric(selected_attribute) * input$size_slider),
                   fillOpacity = 0.5, weight = 1, color = "#777777", fillColor = pal(selected_attribute),
                   popup = ~paste(prefecture, selected_attribute, sep = ": "))
    } else {
      leaflet(map) %>% addTiles() %>%
        setView(lat = 39, lng = 139, zoom = 5) %>%
        addPolygons(fillOpacity = 0.5, weight = 1, fillColor = pal(selected_attribute),
                    popup = ~paste(prefecture)) %>%
        addLegend("bottomright", pal = pal, values = selected_attribute, title = input$dynamic)
    }
  })
}