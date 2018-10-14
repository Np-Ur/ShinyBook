library(shiny)
library(shinydashboard)
library(ggmap)
library(leaflet)
# 以下追加部分
library(rgdal)

map <- readOGR(dsn = "./data", layer = "sample", encoding = "UTF-8", 
               stringsAsFactors = FALSE)
attribute_data <- read.csv("./data/attribute.csv")
# library(readr)
# attribute_data <- read_csv("./data/attribute.csv")