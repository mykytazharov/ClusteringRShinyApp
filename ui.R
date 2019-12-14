#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
# Define UI for application that draws a result of K-means clustering
shinyUI(fluidPage(
    theme = shinytheme("spacelab"),
    
    
    # Application title
    titlePanel("Solving clustering problem for the iris data set"),
    
    # Application description
    p("This application performs different clustering algorithms for the iris data set.
    The data set consists of 50 samples from each of three species of Iris
    (Iris setosa, Iris virginica and Iris versicolor). Four features were measured from each sample:
    the length and the width of the sepals and petals, in centimeters.
      You can choose the number of clusters using a slider, pick variables and select a clustering method in a dropdown menus. 
      The results of clustering are then visualised."),

    # Sidebar with a slider input for number of clusters
    sidebarLayout(
        sidebarPanel(
            selectInput('method', 'Method', c("K-means Clustering", "Model-based clustering", "K-medoids clustering (PAM)"),
                        selected="K-means Clustering"),
            sliderInput("clusters_num",
                        " Select number of clusters:",
                        min = 1,
                        max = 10,
                        value = 3),
            selectInput('xcol', 'X Variable', names(iris)[1:4]),
            selectInput('ycol', 'Y Variable', names(iris)[1:4],
                        selected=names(iris)[[2]]),
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("clustPlot")
        )
    )
))
