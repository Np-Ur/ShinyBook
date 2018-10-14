shinyUI(
  navbarPage("Shiny - Google アナリティクス API",
             tabPanel("Google アカウント連携", tabName = "setup", icon = icon("cogs"),
                      h1("Setup"),
                      googleAuthUI("Google_login"),
                      authDropdownUI("viewId_select")),
             
             tabPanel("メトリクスとディメンション", tabName = "calc_metrics", 
                      icon = icon("bar-chart-o"),
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
                      actionButton("get_data", "データを取得！", icon = icon("download"), 
                                   class = "btn-success"),
                      hr(),
                      DT::dataTableOutput("data_table"),
                      
                      h2("グラフ出力"),
                      br(),
                      fluidRow(
                        column(width = 6,
                               selectInput("graph_type", 
                                           label = "出力したいグラフの種類を選んでください。",
                                           choices = c("円グラフ", "棒グラフ1", "棒グラフ2", 
                                                       "折れ線グラフ", "散布図", "面グラフ"),
                                           selected = "円グラフ")),
                        column(width = 6,
                               selectInput("color_type", 
                                           label = "出力する色のタイプを選んでください。",
                                           choices = color_choise))
                      ),
                      actionButton("get_plot", "グラフを出力", icon = icon("area-chart"), 
                                   class = "btn-success"),
                      plotOutput("plot"),
                      
                      # 以下追加箇所
                      textInput("graph_title", label = "グラフのタイトルを入力", value = "グラフ1"),
                      h2("パワーポイントダウンロード"),
                      downloadButton('download_data', 'Download')
             )
  )
)