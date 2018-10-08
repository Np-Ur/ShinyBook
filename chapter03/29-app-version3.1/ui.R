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
                 dataSelectUI("plot"),
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
               sidebarPanel(
                 dataSelectUI("regression"),
                 h3("回帰を出力"),
                 selectInput("data_for_regressionY",
                             "目的変数を選択",
                             choices = colnames(iris), selected = colnames(iris)[1]),
                 h3("選択された説明変数はこちら"),
                 verbatimTextOutput("rows_selected"),
                 selectInput("regression_type",
                             "回帰の手法を選択",
                             choices = c("重回帰分析" = "lm",
                                         "ランダムフォレスト" = "rf",
                                         "3層ニューラルネット" = "nnet")),
                 actionButton("regression_button", "回帰")
               ),
               mainPanel(
                 tabsetPanel(type = "tabs",
                             tabPanel("Table", h3("説明変数を選択してください。"),
                                      DT::dataTableOutput("data_table_for_regression")),
                             tabPanel("回帰結果", verbatimTextOutput("summary_regression")),
                             tabPanel("プロットで結果を確認", plotOutput("plot_regression"))
                 )
               )
             )),
             
             tabPanel("分類", sidebarLayout(
               sidebarPanel(
                 dataSelectUI("classification"),
                 h3("分類を出力"),
                 selectInput("data_for_classificationY",
                             "目的変数を選択",
                             choices = colnames(iris), selected = colnames(iris)[1]),
                 h3("選択された説明変数はこちら"),
                 verbatimTextOutput("rows_selected_classification"),
                 selectInput("classification_type",
                             "分類の手法を選択",
                             choices = c("ランダムフォレスト" = "rf",
                                         "3層ニューラルネット" = "nnet")),
                 actionButton("classification_button", "分類")
               ),
               mainPanel(
                 tabsetPanel(type = "tabs",
                             tabPanel("Table", h3("説明変数を選択してください。"), 
                                      DT::dataTableOutput("data_table_for_classification")),
                             tabPanel("分類結果", verbatimTextOutput("summary_classification"))
                 )
               )
             )),
             
             tabPanel("クラスタリング", sidebarLayout(
               sidebarPanel(
                 dataSelectUI("clustering"),
                 h3("選択された変数はこちら"),
                 verbatimTextOutput("rows_selected_clustering"),
                 numericInput("cluster_number", "クラスタ数を指定",
                              min = 1, max = 5, value = 1),
                 actionButton("clustering_button", "クラスタリング")
               ),
               mainPanel(
                 tabsetPanel(type = "tabs",
                             tabPanel("Table", h3("説明変数を選択してください。"),
                                      DT::dataTableOutput("data_table_for_clustering")),
                             tabPanel("クラスタリング結果", 
                                      h3("左端にクラスタ番号が入っています。"),
                                      DT::dataTableOutput("data_with_clustering_result"))
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