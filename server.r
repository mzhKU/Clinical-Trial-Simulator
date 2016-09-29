#!/usr/bin/RScript

library(shiny)
library(ggplot2)

source("./run.r")

shinyServer(
    function(input, output) {

        v <- reactiveValues(data=NULL)

        observeEvent(input$run_simulation, {
            v$trial <- runtrial(e0, ed50, emax, input$n_patients,
                                treatDoses, genParMean)
        })
        
        observeEvent(input$reset, {
            v$trial <- NULL
        })

        output$plot <- renderPlot({
            r <- read.csv("./ReplicateData/replicate0001.csv", header=T)
            g <- ggplot(r, aes(RESP, fill=as.factor(DOSE))) +
                 geom_density(alpha=0.2) +
                 theme(legend.position="bottom")
            if(is.null(v$trial)) {
                return()
            }
            print(g)
        })
    }
)
