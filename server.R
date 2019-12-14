#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(mclust)
library(cluster)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$clustPlot <- renderPlot({

        # generate cluster number based on input$cluster_num from ui.R
        k    <- input$clusters_num
    
        # perform K-means clustering for iris data set
        data<- iris[, c(input$xcol, input$ycol)]
        x <- as.name(names(data)[1]) 
        y <- as.name(names(data)[2]) 
        if (input$method=="K-means Clustering") {
            cl <- kmeans(data, centers=k)
            ggplot(data, aes_q(x=x,y=y, col=factor(cl$cluster)), environment = environment()) +  geom_point()+ labs(color='Clusters') 
        } else if (input$method=="Model-based clustering"){
            cl <-  Mclust(data, G=k)
            ggplot(data, aes_q(x=x,y=y, col=factor(cl$classification)), environment = environment()) +  geom_point()+ labs(color='Clusters') 
         }  else if (input$method=="K-medoids clustering (PAM)"){
                cl <-  pam(data, k=k, metric = "euclidean", stand = FALSE)
                ggplot(data, aes_q(x=x,y=y, col=factor(cl$clustering)), environment = environment()) +  geom_point()+ labs(color='Clusters') 
            }
        
    })
})
