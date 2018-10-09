shinyUI(
  navbarPage("Shiny - Google アナリティクス API",
             
             tabPanel("Google アカウント連携", tabName = "setup", icon = icon("cogs"),
                      h1("Setup"),
                      googleAuthUI("Google_login"),
                      authDropdownUI("viewId_select")),
             
             tabPanel("メトリクスとディメンション", tabName = "calc_metrics", 
                      icon = icon("bar-chart-o"),
                      # 以下追加部分
                      h1("データを取得"),
                      fluidRow(
                        column(width = 6,
                               multi_selectUI("metrics", "メトリクスを選択")
                        ),
                        column(width = 6,
                               multi_selectUI("dimensions", "ディメンションを選択")
                        )
                      ),
                      fluidRow(
                        column(width = 6,
                               dateRangeInput("date_range", "日付を選択")
                        ),
                        column(width = 6, br())
                      ),
                      
                      h2("表出力"),
                      actionButton("get_data", "データを取得！", icon = icon("download"), class = "btn-success"),
                      hr(),
                      DT::dataTableOutput("data_table")
             )
  )
)