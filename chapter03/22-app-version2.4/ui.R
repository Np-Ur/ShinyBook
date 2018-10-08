library(shiny)
library(shinythemes)
library(DT)

shinyUI(
  navbarPage("Shinyサンプルアプリケーション",
             tabPanel("Home",
                      h1("『RとShinyで作るWebアプリケーション』のサンプルアプリケーション"),
                      h2("アプリケーション概要"),
                      p("オープンソースデータを用いて可視化と分析を行えるShinyアプリです。"),
                      helpText("サンプルなので、うまく動かない可能性もあるのでご注意ください。")),
             
             tabPanel("Shinyとは?",
                      h1("Shinyでは以下のようなアプリケーションが作成できます。"),
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("bins_shiny",
                                      "Number of bins:",
                                      min = 1,
                                      max = 50,
                                      value = 30)
                        ),
                        mainPanel(
                          plotOutput("distPlot_shiny")
                        )
                      )
             ),
             
             tabPanel("可視化", sidebarLayout(
               sidebarPanel(
                 selectInput("selected_data_for_plot", label = h3("データセットを選択してください。"),
                             choices = c("アヤメのデータ" = "iris",
                                         "不妊症の比較データ" = "infert",
                                         "ボストン近郊の不動産価格データ" = "Boston",
                                         "スパムと正常メールのデータ" = "spam",
                                         "ニューヨークの大気状態データ" = "airquality",
                                         "タイタニックの乗客データ" = "titanic"),
                             selected = "iris"),
                 selectInput("select_input_data_for_hist",
                             "ヒストグラムを表示する列番号",
                             choices = colnames(iris)),
                 sliderInput("slider_input_data",
                             "Number of bins:",
                             min = 1,
                             max = 50,
                             value = 30),
                 actionButton("trigger_histogram", "ヒストグラムを出力"),
                 
                 h3("散布図を表示する列を指定"),
                 selectInput("input_data_for_scatter_plotX",
                             "x軸",
                             choices = colnames(iris), selected = colnames(iris)[1]),
                 selectInput("input_data_for_scatter_plotY",
                             "y軸",
                             choices = colnames(iris), selected = colnames(iris)[1]),
                 actionButton("trigger_scatter_plot", "散布図を出力")
               ),
               mainPanel(
                 tabsetPanel(type = "tabs",
                             tabPanel("Table",
                                      DT::dataTableOutput("table_for_plot")),
                             tabPanel("ヒストグラム", plotOutput("histgram")),
                             tabPanel("散布図", plotOutput("scatter_plot", brush = brushOpts(id="plot_brush")),
                                      DT::dataTableOutput("plot_brushedPoints")),
                             tabPanel("みたいに他にも図を表示する")
                 )
               )
             )),
             
             tabPanel("回帰", sidebarLayout(
               sidebarPanel(),
               mainPanel(
                 tabsetPanel(type = "tabs",
                             tabPanel("回帰結果"),
                             tabPanel("プロットで結果を確認")
                 )
               )
             )),
             
             tabPanel("分類", sidebarLayout(
               sidebarPanel(),
               mainPanel(
                 tabsetPanel(type = "tabs",
                             tabPanel("分類結果"),
                             tabPanel("プロットで結果を確認")
                 )
               )
             )),
             
             tabPanel("クラスタリング", sidebarLayout(
               sidebarPanel(),
               mainPanel(
                 tabsetPanel(type = "tabs",
                             tabPanel("クラスタリング結果"),
                             tabPanel("プロットで結果を確認")
                 )
               )
             )),
             
             navbarMenu("その他",
                        tabPanel("About",
                                 h2("私の名前はNp-Urです。")),
                        tabPanel("ソースコード",
                                 a(href="https://github.com/Np-Ur/ShinyBook", 
                                   p("https://github.com/Np-Ur/ShinyBook"))
                        )
             )
  )
)