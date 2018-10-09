# headerの設定
header <- dashboardHeader(title = "地図アプリ")

# sidebarの設定
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard",
             tabName = "tab_dashboard", icon = icon("dashboard")),
    menuItem("leafletの基本機能", icon = icon("th"),
             tabName = "leaflet_basic",
             menuSubItem("Basic", tabName = "tab_basic", icon = icon("envira")),
             menuSubItem("Distance App", tabName = "tab_distance", icon = icon("map-marker"))),
    menuItem("Prefectures", icon = icon("th"), tabName = "prefectures",
             menuSubItem("Table", tabName = "tab_table", icon = icon("table")),
             menuSubItem("Product", "tab_product", icon = icon("search")),
             menuSubItem("Clustering", tabName = "tab_clustering", icon = icon("line-chart"))
    )
  )
)

# bodyの設定
body <- dashboardBody(
  tabItems(
    tabItem("tab_dashboard", titlePanel("Shiny で作成した地図アプリです。"),
            h3("shinydashboardライブラリを使用しています。")),
    tabItem("tab_basic",
            box(leaflet() %>%
                  addTiles() %>%
                  addMarkers(lng = 139.7, lat = 35.7)),
            box(leaflet() %>%
                  addTiles() %>%
                  addMarkers(lng = 139.7, lat = 35.7) %>%
                  addCircles(lng = 139, lat = 35, radius = 5000))),
    tabItem("tab_distance",
            titlePanel("距離を図る"),
            sidebarLayout(
              sidebarPanel(
                textInput("search_word1", "ワード1", value="東京"),
                textInput("search_word2", "ワード2", value="千葉"),
                
                h4("実行に数秒時間がかかります。"),
                h4("APIがエラーを返す場合があるので、その際は時間を置いてお試しください。"),
                actionButton("submit_dist", "地図を描写")
              ),
              mainPanel(
                leafletOutput("plot_dist", width="100%", height = "900px")
              )
            )
    ),
    tabItem("tab_table",
            DT::dataTableOutput("attribute_table")),
    tabItem("tab_product",
            fluidRow(
              tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
              box(width = 12, collapsible = TRUE,
                  leafletOutput("plot_product", height = 700)
              ),
              absolutePanel(id = "absolute-panel",
                            draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                            width = 350, height = "auto",
                            
                            h2("menu"),
                            
                            selectInput("category", "カテゴリー", choices = categories),
                            hr(),
                            uiOutput("choices_for_plot"),
                            selectInput("plot_type", "Plot Choice", choices = plot_choices),
                            uiOutput("circle_size_ui"),
                            selectInput("color", "Color Scheme", choices = colors)
              )
            )
    ),
    #以下変更箇所
    tabItem("tab_clustering",
            fluidRow(
              box(width = 3, background = 'blue',
                  h2("都道府県をクラスタリング"),
                  hr(),
                  
                  selectInput("data_for_clustering", h3("クラスタリングに用いるデータ列を選択"),
                              colnames(attribute_data)[2:ncol(attribute_data)],
                              multiple = TRUE, selected = colnames(attribute_data)[2:4]),
                  selectInput("clustering_method", "クラスタリングの種類",
                              c("階層的（complete）" = "hclust", "非階層的（k-means）" = "k-means")),
                  numericInput("number_of_cluster", "何個のクラスターに分類？", 1,
                               min = 1, max = 10),
                  actionButton("get_clustering", "クラスタリング実行"),
                  
                  h3("散布図プロットするデータを選択"),
                  selectInput("plot_x", "x軸方向", colnames(attribute_data)[2:ncol(attribute_data)]),
                  selectInput("plot_y", "x軸方向", colnames(attribute_data)[2:ncol(attribute_data)]),
                  
                  actionButton("get_plot", "プロット")
              ),
              tabBox(width = 9,
                     tabPanel("table", tableOutput('table_with_cluster')),
                     tabPanel("Plot",
                              plotOutput("plot_with_cluster", brush = "plot_brush"),
                              verbatimTextOutput("info")
                     ),
                     tabPanel("mapping", leafletOutput("map_with_cluster"))
              )
            )
    )
  )
)

dashboardPage(
  header,
  sidebar,
  body
)