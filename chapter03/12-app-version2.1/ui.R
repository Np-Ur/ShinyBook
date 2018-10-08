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
                             selected = "iris")
               ),
               mainPanel(
                 tabsetPanel(type = "tabs",
                             tabPanel("Table",
                                      DT::dataTableOutput("table_for_plot")),
                             tabPanel("ヒストグラム"),
                             tabPanel("散布図"),
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