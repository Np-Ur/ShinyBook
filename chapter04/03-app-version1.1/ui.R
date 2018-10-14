library(shiny)
library(shinydashboard)

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
             menuSubItem("Distance App", tabName = "tab_distance", 
                         icon = icon("map-marker"))),
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
    tabItem("tab_basic"),
    tabItem("tab_distance"),
    tabItem("tab_table"),
    tabItem("tab_product"),
    tabItem("tab_clustering")
  )
)

dashboardPage(
  header,
  sidebar,
  body
)