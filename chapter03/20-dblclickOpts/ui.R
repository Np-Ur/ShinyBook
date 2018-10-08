library(shiny)

shinyUI(fluidPage(
  
  titlePanel("scatter plot"),
  
  sidebarLayout(
    sidebarPanel(
      h4("散布図を表示する列を指定"),
      selectInput("input_data_for_scatter_plotX",
                  "x軸",
                  choices = colnames(iris), selected = colnames(iris)[1]),
      selectInput("input_data_for_scatter_plotY",
                  "y軸",
                  choices = colnames(iris), selected = colnames(iris)[1]),
      actionButton("trigger_scatter_plot", "散布図を出力")
    ),
    mainPanel(
      plotOutput("scatter_plot", dblclick = dblclickOpts(id = "plot_dbl_click")),
      verbatimTextOutput("plot_dbl_click_info"),
      DT::dataTableOutput("plot_clickedpoints")
    )
  )
))