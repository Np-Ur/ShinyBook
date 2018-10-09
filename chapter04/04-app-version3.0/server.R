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
  
  # 以下追加箇所
  output$attribute_table <- DT::renderDataTable({
    attribute_data
  })
}