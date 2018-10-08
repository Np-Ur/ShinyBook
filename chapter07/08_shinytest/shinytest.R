library(devtools)
install_github("rstudio/shinytest")
shinytest::installDependencies()


library(shinytest)
recordTest("./sample")
