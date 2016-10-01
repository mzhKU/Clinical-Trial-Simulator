#!/usr/bin/RScript

source("./00_run.r")

library(ggplot2)

shinyServer(
    function(input, output) {

        v <- reactiveValues(data=NULL)

        observeEvent(input$run_simulation, {
            v$patients <- runtrial(input$n_patients)
            v$plot     <- getPlot()
        })
        
        output$plot <- renderPlot({
            v$plot
        })

        observeEvent(input$reset, {
            v <- NULL
        })
    }
)
